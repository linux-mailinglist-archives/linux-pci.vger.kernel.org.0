Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09C7233550
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgG3P1Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 11:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3P1N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jul 2020 11:27:13 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2752E20829;
        Thu, 30 Jul 2020 15:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596122832;
        bh=KCyq/zOj5qNJ2u6DpNndotsDRFFpeiKIXrv4aEsMJKY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FiDyM/K3WXa4OsjNfuAXQZEuHxIna/1+4SXUrzaHELeqDig8rBQTLr1+B8AcuXMuL
         UmIEL+Ys/GWJ/oLVJDViCHAsIUi4yXry1nrfmWKb4NPatO01Wwd+Xtersxv0MGE5nn
         ePlzes8VcumqqZnHqR48si433BmvVZArHu4M+lqA=
Date:   Thu, 30 Jul 2020 10:27:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH v2] PCI/P2PDMA: Allow P2PDMA on all AMD CPUs newer than
 the Zen family
Message-ID: <20200730152707.GA2037922@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200729231844.4653-1-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 29, 2020 at 05:18:44PM -0600, Logan Gunthorpe wrote:
> In order to avoid needing to add every new AMD CPU host bridge to the list
> every cycle, allow P2PDMA if the CPUs vendor is AMD and family is
> greater than 0x17 (Zen).
> 
> This should cut down a bunch of the churn adding to the list of allowed
> host bridges.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Alex Deucher <alexdeucher@gmail.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>

Thanks, applied as below with Alex's reviewed-by to pci/peer-to-peer
for v5.9.

I had to enable CONFIG_MEMORY_HOTREMOVE and CONFIG_ZONE_DEVICE in
order to compile p2pdma.c.  I see some reasons why that is, but it's
not exactly intuitive, especially for MEMORY_HOTREMOVE.


commit dea286bb71ba ("PCI/P2PDMA: Allow P2PDMA on AMD Zen and newer CPUs")
Author: Logan Gunthorpe <logang@deltatee.com>
Date:   Wed Jul 29 17:18:44 2020 -0600

    PCI/P2PDMA: Allow P2PDMA on AMD Zen and newer CPUs
    
    Allow P2PDMA if the CPU vendor is AMD and family is 0x17 (Zen) or greater.
    
    [bhelgaas: commit log, simplify #if/#else/#endif]
    Link: https://lore.kernel.org/r/20200729231844.4653-1-logang@deltatee.com
    Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
    Cc: Christian König <christian.koenig@amd.com>
    Cc: Huang Rui <ray.huang@amd.com>

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index e8e444eeb1cd..1ec61fced4c3 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -273,6 +273,19 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 	seq_buf_printf(buf, "%s;", pci_name(pdev));
 }
 
+static bool cpu_supports_p2pdma(void)
+{
+#ifdef CONFIG_X86
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	/* Any AMD CPU whose family ID is Zen or newer supports p2pdma */
+	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 >= 0x17)
+		return true;
+#endif
+
+	return false;
+}
+
 static const struct pci_p2pdma_whitelist_entry {
 	unsigned short vendor;
 	unsigned short device;
@@ -280,11 +293,6 @@ static const struct pci_p2pdma_whitelist_entry {
 		REQ_SAME_HOST_BRIDGE	= 1 << 0,
 	} flags;
 } pci_p2pdma_whitelist[] = {
-	/* AMD ZEN */
-	{PCI_VENDOR_ID_AMD,	0x1450,	0},
-	{PCI_VENDOR_ID_AMD,	0x15d0,	0},
-	{PCI_VENDOR_ID_AMD,	0x1630,	0},
-
 	/* Intel Xeon E5/Core i7 */
 	{PCI_VENDOR_ID_INTEL,	0x3c00, REQ_SAME_HOST_BRIDGE},
 	{PCI_VENDOR_ID_INTEL,	0x3c01, REQ_SAME_HOST_BRIDGE},
@@ -473,7 +481,8 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 					      acs_redirects, acs_list);
 
 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
-		if (!host_bridge_whitelist(provider, client))
+		if (!cpu_supports_p2pdma() &&
+		    !host_bridge_whitelist(provider, client))
 			map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	}
 
