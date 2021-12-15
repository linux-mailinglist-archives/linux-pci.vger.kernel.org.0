Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F64F4764C9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 22:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhLOVr0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 16:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhLOVrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 16:47:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C24C061574;
        Wed, 15 Dec 2021 13:47:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73843B8212C;
        Wed, 15 Dec 2021 21:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB419C36AE3;
        Wed, 15 Dec 2021 21:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639604843;
        bh=J4oalArU9/UgdlFM6Jz7Zy6gGGeghE6Xy/A4jthyHEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ju2IDMuyocvcIjnw/CTO8jPRzLxWltKzEoF3Nhp57gl8K9JFqHfVy6yxNa1vDUfoh
         bSHdRnHvG0q7jnf50uTKExWjcUSWSH+jnpnvzY3qfD15zCh1FLRkf3HkQL5xrz/YC0
         bDy7kgjFeL/g/VJ1FU9phqIE6hsOBAFV0E0EBBlFzFJE8SaHNI7UyFLwC+92RjT6cD
         ujfMpeaD+MQBbYF/HxoPrTJxnKfXL/wupecm7mw+/ILIx/Xye7PMOWAHsALFpPVHLe
         BDMO0mDb+nRCYXjmaXh2Z757X28q5vOWJs/Rzn88egm5xGB8XzVxFILHE5WsHaqOmy
         ndjGkF28Ckemw==
Date:   Wed, 15 Dec 2021 15:47:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] PCI/P2PDMA: Save a few cycles in 'pci_alloc_p2pmem()'
Message-ID: <20211215214721.GA715509@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7676711-52c0-2ca4-f117-bea540d61cb1@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 15, 2021 at 02:37:51PM -0700, Logan Gunthorpe wrote:
> On 2021-12-15 10:35 a.m., Bjorn Helgaas wrote:
> > Maybe we need a MAINTAINERS entry for P2PDMA?
> 
> I'm not opposed to this. Would it be a duplicate of the PCI SUBSYSTEM
> just with my name added as maintainer? I could send a patch if so.

Maybe something like this?  Are there other relevant files?  I just
want to make sure that you see updates to p2pdma stuff.

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345ce8521..3180160fcc28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14717,6 +14717,20 @@ L:	linux-pci@vger.kernel.org
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
+F:	Documentation/PCI/
+F:	Documentation/devicetree/bindings/pci/
+F:	drivers/pci/p2pdma.c
+F:	include/linux/pci-p2pdma.h
+
 PCI MSI DRIVER FOR ALTERA MSI IP
 M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-pci@vger.kernel.org
