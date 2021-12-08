Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A603146DD8C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 22:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbhLHVYx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 16:24:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46694 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbhLHVYx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 16:24:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47FF7B822DB
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 21:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1040C00446;
        Wed,  8 Dec 2021 21:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638998479;
        bh=73Vl8RwVmilo4fD3Hf9e+Isj9nMRtlDaBdmSQJdZgOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Uxizaj68TeaZ6luuiJ0NOsqU/zv65inqWQD15cM5rWXtnu49Tm/MWs7siom/aP6Mq
         DkdPBKgqjMJ227y1gsPhn1ixUW2pIENLJOVRgeBnSO473RxMsvMdkHJb7MacFhtm7r
         Ifk7VwgPTaI6fMAvZS4qJ0Or/FeoB9JeMIicSTZnF9qhSs1a9Hn9wotDK5bwwOak6X
         8W3GC7axKnyEagUWcYCB7bnAAUekJX4BO/Y1HNXAODFph2vEAjRLhUB9igH3e3QNDX
         /hCLfQPf/fQmqdP9q+uoSPI0INpYosQZZXfbnIR5pFv5K6oD4d7CLJPOlwyXFXgNvA
         B3PxdIDJV5BHQ==
Date:   Wed, 8 Dec 2021 15:21:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Fan Fei <ffclaire1224@gmail.com>
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 0/7] PCI: Prefer of_device_get_match_data() over
 of_match_device()
Message-ID: <20211208212116.GA162128@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208205047.GA153767@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 08, 2021 at 02:50:47PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 23, 2021 at 04:37:55PM +0100, Fan Fei wrote:
> > Some drivers use of_match_device() in probe(), which returns a 
> > "struct of_device_id *". They need only the of_device_id.data member, so 
> > replace of_device_get_match_data() with of_match_device().
> > 
> > Fan Fei (7):
> >   PCI: altera: Prefer of_device_get_match_data() over of_match_device()
> >   PCI: cadence: Prefer of_device_get_match_data() over of_match_device()
> >   PCI: kirin: Prefer of_device_get_match_data() over of_match_device()
> >   PCI: dra7xx: Prefer of_device_get_match_data() over of_match_device()
> >   PCI: keystone: Prefer of_device_get_match_data() over
> >     of_match_device()
> >   PCI: artpec6: Prefer of_device_get_match_data() over of_match_device()
> >   PCI: dwc: Prefer of_device_get_match_data() over of_device_device()
> > 
> >  drivers/pci/controller/cadence/pcie-cadence-plat.c | 6 ++----
> >  drivers/pci/controller/dwc/pci-dra7xx.c            | 6 ++----
> >  drivers/pci/controller/dwc/pci-keystone.c          | 4 +---
> >  drivers/pci/controller/dwc/pcie-artpec6.c          | 6 ++----
> >  drivers/pci/controller/dwc/pcie-designware-plat.c  | 6 ++----
> >  drivers/pci/controller/dwc/pcie-kirin.c            | 6 ++----
> >  drivers/pci/controller/pcie-altera.c               | 8 ++++----
> >  7 files changed, 15 insertions(+), 27 deletions(-)
> 
> Applied to pci/driver-cleanup for v5.17, thank you, Fan!

Also applied the following patch since it's closely related.


commit 667c60afad25 ("PCI: j721e: Drop pointless of_device_get_match_data() cast")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Dec 8 15:18:20 2021 -0600

    PCI: j721e: Drop pointless of_device_get_match_data() cast
    
    of_device_get_match_data() returns "void *", so no cast is needed when
    assigning the result to a pointer type.  Drop the unnecessary cast.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 918e11082e6a..0aa1c184bd42 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -367,7 +367,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	int ret;
 	int irq;
 
-	data = (struct j721e_pcie_data *)of_device_get_match_data(dev);
+	data = of_device_get_match_data(dev);
 	if (!data)
 		return -EINVAL;
 
