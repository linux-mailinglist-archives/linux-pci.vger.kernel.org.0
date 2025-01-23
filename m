Return-Path: <linux-pci+bounces-20264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A606A19E3D
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 06:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EB3188C7E6
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 05:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13D01BD504;
	Thu, 23 Jan 2025 05:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Q5zc2V49"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F006F1C3BE3;
	Thu, 23 Jan 2025 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737611574; cv=none; b=fpWw2+cJ/UN2a8l4jLvbeEIJh0yMfQsbkWG4IaT22YWoWRtQjCx8QQEoXdiaocFiVG3Atwk92dJ3AVxkT/po5Qh6xVSfuhxqzfCCb2yoLD4JfTjj4o91467x42HyqFIHSbS4ctY4VyDNk4Jkn/lffN4FC1dtRwh5HLzftWA/bLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737611574; c=relaxed/simple;
	bh=YJcYy6FvcSP7a5L9SPKEAovX+VDxR/9OmnxzR18avRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMhd8w/NXFFrW+XmWiJdi12OCh+vhEUDW3w/ScSEE6CAzMa8sSRKTfZC4mq4JJj+L6jnp35HnMIWCM+YtV73nCify0/QAOlBzo+E5gcdxt1J/f2a2g+C9Dqp4GK1h+1auExeqxnsrRzcJtYqyzKlCYaik0L/0z7t6z3kvmYiKTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Q5zc2V49; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=HZPg+6roJ7x4xUK2gSmzafnHFMqskHkdEYTKOCV7+vc=;
	b=Q5zc2V49ZZqwR9LpWUsbF3j4hGglg9o+i4zTy8nhhs/aT+8uy/cWE6t1haC5yq
	u6QYxTnGyPVEfagCga7A2zrfBXv6yJP2exlqNgHQ9r4RYe0qg53RvgrATLuxboK7
	sb52TSzQkNpo7L/uA4H4W5HiGHMzvFjl/yWKBOnNMrEp4=
Received: from jiwei-VirtualBox.lenovo.com (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXxy392JFnt3jOHw--.51666S4;
	Thu, 23 Jan 2025 13:52:00 +0800 (CST)
From: Jiwei Sun <sjiwei@163.com>
To: macro@orcam.me.uk,
	ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	helgaas@kernel.org,
	lukas@wunner.de,
	ahuang12@lenovo.com,
	sunjw10@lenovo.com,
	jiwei.sun.bj@qq.com,
	sunjw10@outlook.com
Subject: [PATCH v4 2/2] PCI: Adjust the position of reading the Link Control 2 register
Date: Thu, 23 Jan 2025 13:51:55 +0800
Message-Id: <20250123055155.22648-3-sjiwei@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123055155.22648-1-sjiwei@163.com>
References: <20250123055155.22648-1-sjiwei@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXxy392JFnt3jOHw--.51666S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryDXF45uFW3urykAF47Jwb_yoW8Kw15pF
	WfWry7tr1kGr47Z3yDWayfXFyDu3ZxCay7G3y7W3s8ZFy3tws5XF4FkF43t3W5Zrs7u34U
	XFW5trWkAa1YgFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7J5rUUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/xtbBDwXdmWeRy1vXuQAAsG

From: Jiwei Sun <sunjw10@lenovo.com>

In the commit a89c82249c37 ("PCI: Work around PCIe link training
failures"), if the speed limit is set to 2.5 GT/s and the retraining is
successful, an attempt will be made to lift the speed limit. One condition
for lifting the speed limit is to check whether the link speed field of
the Link Control 2 register is PCI_EXP_LNKCTL2_TLS_2_5GT.

However, since the commit de9a6c8d5dbf ("PCI/bwctrl: Add
pcie_set_target_speed() to set PCIe Link Speed"), the `lnkctl2` local
variable does not undergo any changes during the speed limit setting and
retraining process. As a result, the code intended to lift the speed limit
is not executed.

To address this issue, adjust the position of the Link Control 2 register
read operation in the code and place it before its use.

Fixes: de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed")
Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
---
 drivers/pci/quirks.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 76f4df75b08a..c2344706ba61 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -108,13 +108,13 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
 		return ret;
 
-	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
-		u16 oldlnkctl2 = lnkctl2;
+		u16 oldlnkctl2;
 
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 
+		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
 		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
 		if (ret) {
 			pci_info(dev, "retraining failed\n");
@@ -126,6 +126,8 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	}
 
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
+
 	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
 	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
 	    pci_match_id(ids, dev)) {
-- 
2.34.1


