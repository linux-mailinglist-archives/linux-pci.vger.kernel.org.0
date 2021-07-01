Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E414D3B96D2
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 22:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhGAUDQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 16:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhGAUDP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jul 2021 16:03:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFDEC061762;
        Thu,  1 Jul 2021 13:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2ganeE00SBXOwBU2O1xJ62bK3rWSDq5wi9nDN9SxfSM=; b=mwJmyjYzr2+doiZ/frEnR3cdj5
        PvR/WKKQSKYsTMxAGkXKtEFBDQNVnfIBrWcc5RsuCez32pqHFny7/VP0QT/cniAoFTgszcBlZvRgX
        LdPgP2t50fDtdQ9xd2PPyT0Jo5ScTGDkMWeh7equFg1jdlaHYz9VZR18alvHDitsH5UjZI+6+splU
        PLzrI9XEy1Uo1kEZ6N5AptZOtMH0dYETm9sm8eUls+1hxxdBBl6slKZIyRGABrf43EcM8YL4ecstJ
        XJu4QEhedJXXBUDX3NK/niy6TsRGjifEB1rXNn4MxeivaGkAXCF00hoKAtByKsAAvFttMlNALPCdJ
        p+74I2qw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lz2qj-006wg3-4a; Thu, 01 Jul 2021 20:00:02 +0000
Date:   Thu, 1 Jul 2021 20:59:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Robert Straw <drbawb@fatalsyntax.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com
Subject: Re: [PATCH v2] PCI: Disable Samsung SM951/PM951 NVMe before FLR
Message-ID: <YN4etaP6hInKvSgG@infradead.org>
References: <20210430230119.2432760-1-drbawb@fatalsyntax.com>
 <20210701193856.GA82535@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701193856.GA82535@bjorn-Precision-5520>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 01, 2021 at 02:38:56PM -0500, Bjorn Helgaas wrote:
> On Fri, Apr 30, 2021 at 06:01:19PM -0500, Robert Straw wrote:
> > The SM951/PM951, when used in conjunction with the vfio-pci driver and
> > passed to a KVM guest, can exhibit the fatal state addressed by the
> > existing `nvme_disable_and_flr` quirk. If the guest cleanly shuts down
> > the SSD, and vfio-pci attempts an FLR to the device while it is in this
> > state, the nvme driver will fail when it attempts to bind to the device
> > after the FLR due to the frozen config area, e.g:
> > 
> >   nvme nvme2: frozen state error detected, reset controller
> >   nvme nvme2: Removing after probe failure status: -12
> > 
> > By including this older model (Samsung 950 PRO) of the controller in the
> > existing quirk: the device is able to be cleanly reset after being used
> > by a KVM guest.
> > 
> > Signed-off-by: Robert Straw <drbawb@fatalsyntax.com>
> 
> Applied to pci/virtualization for v5.14, thanks!

FYI, I really do not like the idea of the PCIe core messing with NVMe
registers like this.
