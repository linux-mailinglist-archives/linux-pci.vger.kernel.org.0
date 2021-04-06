Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D954355430
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 14:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243235AbhDFMsq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 08:48:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15923 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243186AbhDFMsp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 08:48:45 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FF6jP0c9lzkhq8;
        Tue,  6 Apr 2021 20:46:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 20:48:28 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <gregkh@linuxfoundation.org>,
        <jonathan.cameron@huawei.com>, <song.bao.hua@hisilicon.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH 2/4] hwtracing: Add tune function support for HiSilicon PCIe Tune and Trace device
Date:   Tue, 6 Apr 2021 20:45:52 +0800
Message-ID: <1617713154-35533-3-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617713154-35533-1-git-send-email-yangyicong@hisilicon.com>
References: <1617713154-35533-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add tune function for the HiSilicon Tune and Trace device. The interface
of tune is also exposed through debugfs.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/hwtracing/hisilicon/hisi_ptt.c | 187 +++++++++++++++++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/drivers/hwtracing/hisilicon/hisi_ptt.c b/drivers/hwtracing/hisilicon/hisi_ptt.c
index a1feece..2e3631b 100644
--- a/drivers/hwtracing/hisilicon/hisi_ptt.c
+++ b/drivers/hwtracing/hisilicon/hisi_ptt.c
@@ -72,6 +72,7 @@ struct hisi_ptt_debugfs_file_desc {
 	struct hisi_ptt *hisi_ptt;
 	const char *name;
 	const struct file_operations *fops;
+	struct hisi_ptt_tune_event_desc *private;
 };
 
 #define PTT_FILE_INIT(__name, __fops)	\
@@ -85,6 +86,15 @@ struct hisi_ptt_trace_event_desc {
 #define PTT_TRACE_EVENT_INIT(__name, __event_code) \
 	{ .name = __name, .event_code = __event_code }
 
+struct hisi_ptt_tune_event_desc {
+	const char *name;
+	u32 event_code;
+	int (*set)(struct hisi_ptt *hisi_ptt, void *data);
+	int (*get)(struct hisi_ptt *hisi_ptt, void *data);
+};
+#define PTT_TUNE_EVENT_INIT(__name, __event_code, __set, __get)	\
+	{ .name = __name, .event_code = __event_code, .set = __set, .get = __get }
+
 enum hisi_ptt_trace_rxtx {
 	HISI_PTT_TRACE_RX = 0,
 	HISI_PTT_TRACE_TX,
@@ -217,6 +227,8 @@ struct hisi_ptt {
 		bool is_port;
 		u16 val;
 	} cur_filter;
+
+	u32 tune_event;
 };
 
 static int hisi_ptt_write_to_buffer(void *buf, size_t len, loff_t *pos,
@@ -234,6 +246,131 @@ static int hisi_ptt_write_to_buffer(void *buf, size_t len, loff_t *pos,
 	return 0;
 }
 
+static int hisi_ptt_wait_tuning_finish(struct hisi_ptt *hisi_ptt)
+{
+	u32 val;
+
+	return readl_poll_timeout(hisi_ptt->iobase + HISI_PTT_TUNING_INT_STAT,
+				  val, !(val & HISI_PTT_TUNING_INT_STAT_MASK),
+				  HISI_PTT_WAIT_POLL_INTERVAL_US,
+				  HISI_PTT_WAIT_TIMEOUT_US);
+}
+
+static int hisi_ptt_tune_data_get(struct hisi_ptt *hisi_ptt, void *data)
+{
+	u32 *val = data, reg;
+
+	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
+	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
+	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
+			  hisi_ptt->tune_event);
+	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
+	/* Write all 1 to indicates it's the read process */
+	writel(HISI_PTT_TUNING_DATA_VAL_MASK,
+	       hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
+
+	if (hisi_ptt_wait_tuning_finish(hisi_ptt)) {
+		pci_err(hisi_ptt->pdev, "failed to read tune data, device timeout.\n");
+		return -ETIMEDOUT;
+	}
+
+	*val = readl(hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
+	*val &= HISI_PTT_TUNING_DATA_VAL_MASK;
+
+	return 0;
+}
+
+static int hisi_ptt_tune_data_set(struct hisi_ptt *hisi_ptt, void *data)
+{
+	u32 *val = data, reg;
+
+	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
+	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
+	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
+			  hisi_ptt->tune_event);
+	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
+	*val &= HISI_PTT_TUNING_DATA_VAL_MASK;
+	writel(*val, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
+
+	if (hisi_ptt_wait_tuning_finish(hisi_ptt)) {
+		pci_err(hisi_ptt->pdev, "failed to write tune data, device timeout.\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static ssize_t hisi_ptt_tune_common_read(struct file *filp, char __user *buf,
+					 size_t count, loff_t *pos)
+{
+	struct hisi_ptt_debugfs_file_desc *desc = filp->private_data;
+	struct hisi_ptt *hisi_ptt = desc->hisi_ptt;
+	struct hisi_ptt_tune_event_desc *e_desc = desc->private;
+	char tbuf[HISI_PTT_CTRL_STR_LEN];
+	int len, ret;
+	u32 val;
+
+	if (!mutex_trylock(&hisi_ptt->mutex))
+		return -EBUSY;
+
+	hisi_ptt->tune_event = e_desc->event_code;
+	ret = e_desc->get(hisi_ptt, &val);
+	mutex_unlock(&hisi_ptt->mutex);
+	if (ret)
+		return ret;
+
+	len = snprintf(tbuf, HISI_PTT_CTRL_STR_LEN, "%d\n", val);
+
+	return simple_read_from_buffer(buf, count, pos, tbuf, len);
+}
+
+static ssize_t hisi_ptt_tune_common_write(struct file *filp,
+					  const char __user *buf,
+					  size_t count, loff_t *pos)
+{
+	struct hisi_ptt_debugfs_file_desc *desc = filp->private_data;
+	struct hisi_ptt *hisi_ptt = desc->hisi_ptt;
+	struct hisi_ptt_tune_event_desc *e_desc = desc->private;
+	char tbuf[HISI_PTT_CTRL_STR_LEN];
+	int ret;
+	u16 val;
+
+	if (hisi_ptt_write_to_buffer(tbuf, HISI_PTT_CTRL_STR_LEN - 1,
+				     pos, buf, count))
+		return -EINVAL;
+
+	if (kstrtou16(tbuf, 0, &val))
+		return -EINVAL;
+
+	if (!mutex_trylock(&hisi_ptt->mutex))
+		return -EBUSY;
+
+	hisi_ptt->tune_event = e_desc->event_code;
+	ret = e_desc->set(hisi_ptt, &val);
+
+	mutex_unlock(&hisi_ptt->mutex);
+	return ret ? ret : count;
+}
+
+static const struct file_operations tune_common_fops = {
+	.owner		= THIS_MODULE,
+	.open		= simple_open,
+	.read		= hisi_ptt_tune_common_read,
+	.write		= hisi_ptt_tune_common_write,
+	.llseek		= no_llseek,
+};
+
+#define PTT_SIMPLE_TUNE_EVENTS(__name, __event_code)	\
+	PTT_TUNE_EVENT_INIT(__name, __event_code, hisi_ptt_tune_data_set, hisi_ptt_tune_data_get)
+
+static struct hisi_ptt_tune_event_desc tune_events[] = {
+	PTT_SIMPLE_TUNE_EVENTS("qos_tx_cpl",			(0x4 | (3 << 16))),
+	PTT_SIMPLE_TUNE_EVENTS("qos_tx_np",			(0x4 | (4 << 16))),
+	PTT_SIMPLE_TUNE_EVENTS("qos_tx_p",			(0x4 | (5 << 16))),
+	PTT_SIMPLE_TUNE_EVENTS("tx_path_rx_req_alloc_buf_level",	(0x5 | (6 << 16))),
+	PTT_SIMPLE_TUNE_EVENTS("tx_path_tx_req_alloc_buf_level",	(0x5 | (7 << 16))),
+};
+
 static u16 hisi_ptt_get_filter_val(struct pci_dev *pdev)
 {
 	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
@@ -1241,6 +1378,49 @@ static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
 	hisi_ptt->trace_ctrl.tr_event = HISI_PTT_TRACE_DEFAULT_EVENT.event_code;
 }
 
+static int hisi_ptt_create_tune_entries(struct hisi_ptt *hisi_ptt)
+{
+	struct hisi_ptt_debugfs_file_desc *tune_files;
+	struct dentry *dir;
+	int i, ret = 0;
+
+	dir = debugfs_create_dir("tune", hisi_ptt->debugfs_dir);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	tune_files = devm_kcalloc(&hisi_ptt->pdev->dev, ARRAY_SIZE(tune_events),
+				  sizeof(struct hisi_ptt_debugfs_file_desc),
+				  GFP_KERNEL);
+	if (IS_ERR(tune_files)) {
+		ret = PTR_ERR(tune_files);
+		goto err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tune_events); ++i) {
+		struct dentry *file;
+
+		tune_files[i].hisi_ptt = hisi_ptt;
+
+		/* We use tune event string as control file name. */
+		tune_files[i].name = tune_events[i].name;
+		tune_files[i].fops = &tune_common_fops;
+		tune_files[i].private = &tune_events[i];
+		file = debugfs_create_file(tune_files[i].name, 0600,
+					   dir, &tune_files[i],
+					   &tune_common_fops);
+		if (IS_ERR(file)) {
+			ret = PTR_ERR(file);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	debugfs_remove_recursive(dir);
+	return ret;
+}
+
 static int hisi_ptt_create_trace_entries(struct hisi_ptt *hisi_ptt)
 {
 	struct hisi_ptt_debugfs_file_desc *trace_files;
@@ -1294,6 +1474,13 @@ static int hisi_ptt_create_debugfs_entries(struct hisi_ptt *hisi_ptt)
 		return ret;
 	}
 
+	ret = hisi_ptt_create_tune_entries(hisi_ptt);
+	if (ret) {
+		pci_err(hisi_ptt->pdev, "failed to create tune entries.\n");
+		debugfs_remove_recursive(hisi_ptt->debugfs_dir);
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.8.1

