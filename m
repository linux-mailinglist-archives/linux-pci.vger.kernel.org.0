Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C4B29C6F
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 18:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390314AbfEXQkJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 12:40:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390210AbfEXQkJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 May 2019 12:40:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB3EF59450;
        Fri, 24 May 2019 16:40:08 +0000 (UTC)
Received: from x1.home (ovpn-117-37.phx2.redhat.com [10.3.117.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4324E18C78;
        Fri, 24 May 2019 16:40:05 +0000 (UTC)
Date:   Fri, 24 May 2019 10:40:03 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Maik Broemme <mbroemme@libmpq.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        vfio-users <vfio-users@redhat.com>
Subject: Re: [PATCH] PCI: Mark Intel bridge on SuperMicro Atom C3xxx
 motherboards to avoid bus reset
Message-ID: <20190524104003.2f7f1363@x1.home>
In-Reply-To: <20190524153118.GA12862@libmpq.org>
References: <20190524153118.GA12862@libmpq.org>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 24 May 2019 16:40:08 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 24 May 2019 17:31:18 +0200
Maik Broemme <mbroemme@libmpq.org> wrote:

> The Intel PCI bridge on SuperMicro Atom C3xxx motherboards do not
> successfully complete a bus reset when used with certain child devices.

What are these 'certain child devices'?  We can't really regression
test to know if/when the problem might be resolved if we don't know
what to test.  Do these devices reset properly in other systems?  Are
there any devices that can do a bus reset properly on this system?  We'd
really only want to blacklist bus reset on this root port(?) if this is
a systemic problem with the root port, which is not clearly proven
here.  Thanks,

Alex

> After the reset, config accesses to the child may fail. If assigning
> such device via VFIO it will immediately fail with:
> 
>   vfio-pci 0000:01:00.0: Failed to return from FLR
>   vfio-pci 0000:01:00.0: timed out waiting for pending transaction;
>   performing function level reset anyway
> 
> Device will disappear from PCI device list:
> 
>   !!! Unknown header type 7f
>   Kernel driver in use: vfio-pci
>   Kernel modules: ddbridge
> 
> The attached patch will mark the root port as incapable of doing a
> bus level reset. After that all my tested devices survive a VFIO
> assignment and several VM reboot cycles.
> 
> Signed-off-by: Maik Broemme <mbroemme@libmpq.org>
> ---
>  drivers/pci/quirks.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 0f16acc323c6..86cd42872708 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3433,6 +3433,13 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
>  
> +/*
> + * Root port on some SuperMicro Atom C3xxx motherboards do not successfully
> + * complete a bus reset when used with certain child devices. After the
> + * reset, config accesses to the child may fail.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x19a4, quirk_no_bus_reset);
> +
>  static void quirk_no_pm_reset(struct pci_dev *dev)
>  {
>  	/*

