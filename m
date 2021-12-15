Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5C6476521
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 23:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhLOWEi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 17:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhLOWEh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 17:04:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AA6C061574;
        Wed, 15 Dec 2021 14:04:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78660B821B9;
        Wed, 15 Dec 2021 22:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF860C36AE2;
        Wed, 15 Dec 2021 22:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639605875;
        bh=knse+0Hdn54MjN96J5reKfjV1T2e3qkqBTSrE5quAn8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H6PwiMHbs4+XhrYiMChkBwWSAceBNTc9hu7qeY7ik22cE2FRvjO6ZsDQm7XiyD495
         2DYUbnHRZ4quYDoIMdJCaXhx+UsbW5WdcICTXbPtOq51aWT1hqNmKjX4qDWnNKphZI
         nJ+YC9xzgkHCRO0xkAG4nvJ0MEVmG/MKi+a9R1aVi8pgXJwuAGvWU4JwDlfjSAwrEi
         S95Txrzj7Mc+hDez9gUj4TPHjDjWY9E4HIahDwi6SjsBdyBkaw+XoUBBUXD+t4Yzca
         G+UAeQIglx3g6nMztyQOWzfNlSqE//vkWHsLgEAN9jmkgdYdp1GDolJDEg8g4q+IH0
         9QV0CO2Wwvuyg==
Date:   Wed, 15 Dec 2021 16:04:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] PCI/P2PDMA: Save a few cycles in 'pci_alloc_p2pmem()'
Message-ID: <20211215220433.GA716667@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3043c3ab-2b0a-4e97-ac43-21e4398d08e6@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 15, 2021 at 02:51:51PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2021-12-15 2:47 p.m., Bjorn Helgaas wrote:
> > On Wed, Dec 15, 2021 at 02:37:51PM -0700, Logan Gunthorpe wrote:
> >> On 2021-12-15 10:35 a.m., Bjorn Helgaas wrote:
> >>> Maybe we need a MAINTAINERS entry for P2PDMA?
> >>
> >> I'm not opposed to this. Would it be a duplicate of the PCI SUBSYSTEM
> >> just with my name added as maintainer? I could send a patch if so.
> > 
> > Maybe something like this?  Are there other relevant files?  I just
> > want to make sure that you see updates to p2pdma stuff.
> 
> Largely looks good to me.
> 
> The one missing file is:
> 
> Documentation/driver-api/pci/p2pdma.rst
> 
> Do you want me to put that in a patch or will you handle it?

I put the patch below on pci/p2pdma for v5.17, let me know if you want
any other tweaks.

I had mistakenly included these, which don't include any P2PDMA
content, so I dropped them so you don't get inundated with other
random changes:

  +F:     Documentation/PCI/
  +F:     Documentation/devicetree/bindings/pci/

commit bdebed96bd4d ("MAINTAINERS: Add Logan Gunthorpe as P2PDMA maintainer")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Dec 15 15:43:04 2021 -0600

    MAINTAINERS: Add Logan Gunthorpe as P2PDMA maintainer
    
    Add a P2PDMA entry to make sure Logan is aware of changes to that area.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..ea59e32e1e81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14717,6 +14717,19 @@ L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/PCI/pci-error-recovery.rst
 
+PCI PEER-TO-PEER DMA (P2PDMA)
+M:	Bjorn Helgaas <bhelgaas@google.com>
+M:	Logan Gunthorpe <logang@deltatee.com>
+L:	linux-pci@vger.kernel.org
+S:	Supported
+Q:	https://patchwork.kernel.org/project/linux-pci/list/
+B:	https://bugzilla.kernel.org
+C:	irc://irc.oftc.net/linux-pci
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
+F:	Documentation/driver-api/pci/p2pdma.rst
+F:	drivers/pci/p2pdma.c
+F:	include/linux/pci-p2pdma.h
+
 PCI MSI DRIVER FOR ALTERA MSI IP
 M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-pci@vger.kernel.org
