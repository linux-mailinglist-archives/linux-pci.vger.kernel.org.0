Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A18D2F2275
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jan 2021 23:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388753AbhAKWKf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 17:10:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:52934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731436AbhAKWKf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Jan 2021 17:10:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E31622CBE;
        Mon, 11 Jan 2021 22:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610402994;
        bh=ymVq1SwnJXzXnkG0/Z70Lr9Rn511bZp2A9egCYeYPR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqFVEsMyZYHcuWXmCrUHc+nXE8iXqGiPf5+mlfIbN+s8wkTVJEGI+FteRksXqc0tD
         yBRX0r19o0j+1aIz5LoV71r69aFr4ht9bAbTfvPv50vYugRo3UNj5Enm9TBRL0ayNG
         K8gLLTo3Dd31MLEjhwz8C85iQLI1InxhAaaTp5vz7SqZ+HjUl0yhNb1KQvAzFTTbeX
         MJim041wVUXNTPFszs6izyvmqEHfPR5+vaXFlutWOC+EJ3AMu2MoFFnCyAM0CDjUsB
         6Er5wqFwGKNlT7eBtj3OxpikkiGs8UhuX55W84nThtcUqUOW6Gwogt/9oLOuk4zUGN
         bwWScbWVCS/SQ==
Date:   Mon, 11 Jan 2021 14:09:51 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Hinko Kocevar <hinko.kocevar@ess.eu>
Cc:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCHv2 0/5] aer handling fixups
Message-ID: <20210111220951.GA1472929@dhcp-10-100-145-180.wdc.com>
References: <20210104230300.1277180-1-kbusch@kernel.org>
 <bcc440b0-0ab9-c25f-e7d5-f7ce65db5019@ess.eu>
 <4242a9a9-c881-0af4-1cab-396931fee420@ess.eu>
 <20210105183302.GA1278205@dhcp-10-100-145-180.wdc.com>
 <B31F8CA9-D62B-4488-B4C1-EB31E9117203@intel.com>
 <20210107214236.GA1284006@dhcp-10-100-145-180.wdc.com>
 <70f2288d-2d1e-df82-d107-e977e1f50dca@ess.eu>
 <c3117c51-144f-ae59-ad68-bdc5532d12cb@ess.eu>
 <20210111163708.GA1458209@dhcp-10-100-145-180.wdc.com>
 <6783d09d-1431-15fd-961e-3820b14e001e@ess.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6783d09d-1431-15fd-961e-3820b14e001e@ess.eu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 11, 2021 at 09:02:39PM +0100, Hinko Kocevar wrote:
> Attached are the messages.
> 
> Thanks!

Thank you. It kind of looks like the frequent ext capabilty lookup might
just be really slow for some reason. Could you try the following patch
and let me know if this improves the CPU lockup?

---
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5c59365092fa..8a61a9365c28 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -106,6 +106,7 @@ void pci_pm_init(struct pci_dev *dev);
 void pci_ea_init(struct pci_dev *dev);
 void pci_msi_init(struct pci_dev *dev);
 void pci_msix_init(struct pci_dev *dev);
+void pci_vc_init(struct pci_dev *dev);
 void pci_allocate_cap_save_buffers(struct pci_dev *dev);
 void pci_free_cap_save_buffers(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc850..56992a42bac6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2401,6 +2401,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
+	pci_vc_init(dev);		/* Virtual Channel */
 
 	pcie_report_downtraining(dev);
 
diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index 5fc59ac31145..76ac118b9b5d 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -357,7 +357,7 @@ int pci_save_vc_state(struct pci_dev *dev)
 		int pos, ret;
 		struct pci_cap_saved_state *save_state;
 
-		pos = pci_find_ext_capability(dev, vc_caps[i].id);
+		pos = dev->vc_caps[i];
 		if (!pos)
 			continue;
 
@@ -394,9 +394,12 @@ void pci_restore_vc_state(struct pci_dev *dev)
 		int pos;
 		struct pci_cap_saved_state *save_state;
 
-		pos = pci_find_ext_capability(dev, vc_caps[i].id);
+		pos = dev->vc_caps[i];
+		if (!pos)
+			continue;
+
 		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
-		if (!save_state || !pos)
+		if (!save_state)
 			continue;
 
 		pci_vc_do_save_buffer(dev, pos, save_state, false);
@@ -415,7 +418,7 @@ void pci_allocate_vc_save_buffers(struct pci_dev *dev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
-		int len, pos = pci_find_ext_capability(dev, vc_caps[i].id);
+		int len, pos = dev->vc_caps[i];
 
 		if (!pos)
 			continue;
@@ -426,3 +429,11 @@ void pci_allocate_vc_save_buffers(struct pci_dev *dev)
 				vc_caps[i].name);
 	}
 }
+
+void pci_vc_init(struct pci_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vc_caps); i++)
+		dev->vc_caps[i] = pci_find_ext_capability(dev, vc_caps[i].id);
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b32126d26997..7a3aa7e4d6f8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -501,6 +501,7 @@ struct pci_dev {
 	struct pci_p2pdma *p2pdma;
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
+	u16		vc_caps[3];	/* Virtual Channel capability offsets */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */
 	char		*driver_override; /* Driver name to force a match */
--
