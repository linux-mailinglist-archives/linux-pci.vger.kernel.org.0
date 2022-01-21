Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015FD4958D2
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 05:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiAUENF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 23:13:05 -0500
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25595 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiAUENE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 23:13:04 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1642738378; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Xe7I4/F5q1pXlFL1rhmzWFPv/ozwn99MqZpMCvCsah6sieW+5MvoEAzvaNiDl6k7sCsC0Hz9iNt9n0kb3ExrHC5OgsaGlEFyQlHPjwYoTgdp/wN7wq6pZW6FbA8+RoSmL8ef5q0I6wXCL8gSEqWOKoNFEm32sdzExSu2s7Emc/A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1642738378; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=6OqN5KFL3TzRtCH3fbY7QtTlkqaTO04W2B0TqAkZ6Pg=; 
        b=UpfwIdV1rWzn8q6goAcWWQrfnpZ6RL/cXHzdHHzsI2Q5J45NbLfLc8TaJgPlm8Qrgs/1WwBCCsa4kHj3SoHIV3OO27XyhkgngSywIKM8FiYlXDOneCecSxB/r5JfhPHFuSHJ+wQ5Q9MCz/50EEFEiZ5Ug5We6twBe0Lv1bQWz3w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642738378;
        s=zm2020; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=6OqN5KFL3TzRtCH3fbY7QtTlkqaTO04W2B0TqAkZ6Pg=;
        b=P8UbR6VdnFgqss5emjwEaYWQGOBbwXW6CLObUR1h6X+az1sHTEnKanLrzhEcmgfS
        Q0qlBcOC0VoaUId1wc39hmBLpIt1uuUDQM8fWf9IHtfAjA9AKJvSag7RJ2n85dyLZUt
        NtBOJrTwrmpXtNGnh9awwZcWC648cO9yxDe9tEnk=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1642738376718895.9144931596065; Thu, 20 Jan 2022 20:12:56 -0800 (PST)
Received: from  [203.218.243.128] by mail.zoho.com
        with HTTP;Thu, 20 Jan 2022 20:12:56 -0800 (PST)
Date:   Fri, 21 Jan 2022 12:12:56 +0800
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17e7ad65ff5.d9de88b4962.1109678039880040918@zohomail.com>
In-Reply-To: 
Subject: [PATCH v4] PCI: endpoint: Add prefetch BAR support
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

Before this commit, epf cannot set BAR to be prefetchable.
Prefetchable BAR can also help epf device to use bridge's
prefetch memory window.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
Changes in v2:
Remove Gerrit Change-id
Changes in v3:
capitalize "BAR" in the subject and commit log as suggested by Bjorn.
Changes in v4:
This patch context doesn't change but resend with my Zoho mail account in that previous
company mail will contain un-removeable proprietary messages. 
Add "From:" to the first line of the message body.

 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++++
 include/linux/pci-epc.h                       | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 90d84d3bc868..96489cfdf58d 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -817,15 +817,19 @@ static void pci_epf_configure_bar(struct pci_epf *epf,
 {
 	struct pci_epf_bar *epf_bar;
 	bool bar_fixed_64bit;
+	bool bar_prefetch;
 	int i;
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		epf_bar = &epf->bar[i];
 		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
+		bar_prefetch = !!(epc_features->bar_prefetch & (1 << i));
 		if (bar_fixed_64bit)
 			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
 		if (epc_features->bar_fixed_size[i])
 			bar_size[i] = epc_features->bar_fixed_size[i];
+		if (bar_prefetch)
+			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;
 	}
 }
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index a48778e1a4ee..825632d581d0 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -161,6 +161,7 @@ struct pci_epc {
  * @msix_capable: indicate if the endpoint function has MSI-X capability
  * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
  * @bar_fixed_64bit: bitmap to indicate fixed 64bit BARs
+ * @bar_prefetch: bitmap to indicate prefetchable BARs
  * @bar_fixed_size: Array specifying the size supported by each BAR
  * @align: alignment size required for BAR buffer allocation
  */
@@ -171,6 +172,7 @@ struct pci_epc_features {
 	unsigned int	msix_capable : 1;
 	u8	reserved_bar;
 	u8	bar_fixed_64bit;
+	u8	bar_prefetch;
 	u64	bar_fixed_size[PCI_STD_NUM_BARS];
 	size_t	align;
 };
-- 
2.34.1


