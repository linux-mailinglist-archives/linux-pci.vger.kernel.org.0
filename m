Return-Path: <linux-pci+bounces-41774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E28BC736C3
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 11:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE2A64F08C0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 10:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0711306B02;
	Thu, 20 Nov 2025 10:13:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F2428B40E;
	Thu, 20 Nov 2025 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763633583; cv=none; b=HOmdw+HSo0taIC5lHKyEV8YkIW8IBrCH1rWMTC1F/Rk3unAeO6HXIDgkkNGZGcpCa1wS20ARXXUZvCoVbYOjgD5FaqiFGE3Na0s4r1SW4ynJjiYQQOmxhxl37gqXDpPSPf7i5MVokppTJ2qj7cexmhmgynYxmoiNQ6bvQiqs25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763633583; c=relaxed/simple;
	bh=gOMiq57HTxx79NRhQi+7+831DMzl1qRNS4Gvn3ry15s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILzOf6SMfP3TueF9yhPJB/YpXzzOk1K1zBCOPkBK0x7/dmigZMpppN4ObQ5VIMZXubTBpEc2qUkXBXxXdU1/Yqf7ODSna6a5DLRpPykQnbdF8YKnVtJiKMVChTZ5Tl+XUPp2Yv2Tp0K78rB5o3lbFTrnmnFlTPfB5YF8eOWfwPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004758DT.eswin.cn (unknown [10.12.96.83])
	by app1 (Coremail) with SMTP id TAJkCgCnoWmW6R5p5P18AA--.34347S2;
	Thu, 20 Nov 2025 18:12:39 +0800 (CST)
From: zhangsenchuan@eswincomputing.com
To: bhelgaas@google.com,
	mani@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	p.zabel@pengutronix.de,
	jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christian.bruel@foss.st.com,
	mayank.rana@oss.qualcomm.com,
	shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com,
	thippeswamy.havalige@amd.com,
	inochiama@gmail.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	ouyanghui@eswincomputing.com,
	Frank.li@nxp.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v6 3/3] PCI: dwc: Add no_suspport_L2 flag and skip PME_Turn_Off broadcast
Date: Thu, 20 Nov 2025 18:12:35 +0800
Message-ID: <20251120101236.1538-1-zhangsenchuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20251120101018.1477-1-zhangsenchuan@eswincomputing.com>
References: <20251120101018.1477-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgCnoWmW6R5p5P18AA--.34347S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1xXr1DCry8Zw15WFyDJrb_yoW8ZrWUpa
	98KFWIyF18JF45Za1Yy3Z3ur43t3Z8AFyUCa9293WfWa42va4Dt34xJFy3tFn7Jr4Iv343
	Kr15ta93Ga13JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNSdgDUUUU
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/

From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>

The ESWIN EIC7700 soc does not support enter L2 link state. Therefore add
no_suspport_L2 flag skip PME_Turn_Off broadcast and link state check code,
other driver can reuse this flag if meet the similar situation.

Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e92513c5bda5..a203577606e5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1156,6 +1156,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
 		return 0;

+	if (pci->no_suspport_L2)
+		goto stop_link;
+
 	if (pci->pp.ops->pme_turn_off) {
 		pci->pp.ops->pme_turn_off(&pci->pp);
 	} else {
@@ -1182,6 +1185,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	 */
 	udelay(1);

+stop_link:
 	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ec..170a73299ce5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -539,6 +539,7 @@ struct dw_pcie {
 	 * use_parent_dt_ranges to true to avoid this warning.
 	 */
 	bool			use_parent_dt_ranges;
+	bool			no_suspport_L2;
 };

 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
--
2.25.1


