Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BBC1DD565
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 19:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgEUR7X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 13:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgEUR7X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 13:59:23 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36200207FB;
        Thu, 21 May 2020 17:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590083962;
        bh=e8f1yqwtBuUBfHKfpzlcKEZRrr4tDOCxmfhCFW0pl2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lK3MdP7JY7NnQltgRgT8QZrBM0RHJyzox4CftMZzO7xemBo2T3kwA9Ofeptq2NrJD
         uGKLvOzbeXgYMaqpXX3HPc5oy+X9sTsfeZgeglmEE1dzd46fiusx1WzqEoc/O9CBXq
         uJyA7N/DIUmqlZYu5+Ne+WgVZvwIJaPECbLIqAxg=
Date:   Thu, 21 May 2020 12:59:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Klaus Doth <kdlnx@doth.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        rui_feng@realsil.com.cn
Subject: Re: Possible bug in drivers/misc/cardreader/rtsx_pcr.c
Message-ID: <20200521175920.GA1140028@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ed62141-8060-dcd2-d1e0-d2381f4930dd@doth.eu>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 01:50:02PM +0200, Klaus Doth wrote:
> On 5/21/20 10:52 AM, Greg Kroah-Hartman wrote:
> > On Tue, May 19, 2020 at 07:04:06PM +0200, Klaus Doth wrote:
> >> Hi,
> >>
> >> As per the info from kernelnewbies IRC, I'm sending this also to the PCI
> >> list.
> > <snip>
> >
> > Can you submit a proposed patch in a format that it can be tested and
> > possibly submitted in so that we can review this easier?
> >
> > Also try cc:ing the author of changes in that code, Rui Feng
> > <rui_feng@realsil.com.cn>, as well, as they are the best one to review
> > and comment on your issue.
> >
> > thanks,
> >
> > greg k-h
> 
> DMA transfers to and from the SD card stall for 10 seconds and run into
> timeout on RTS5260 card readers after ASPM was enabled.
> 
> Adding a short msleep after disabling ASPM fixes the issue on several
> Dell Precision 7530/7540 systems I tested.
> 
> This function is only called when waking up after the chip went into
> powersave after not transferring data for a few seconds. The added
> msleep does therefore not change anything in data transfer speed or
> induce any excessive waiting while data transfers are running, or the
> chip is sleeping. Only the transistion from sleep to active is affected.

s/transistion/transition/

I don't see anything in the PCIe spec that would require a delay here.
In general, drivers should not be configuration ASPM directly because
doing it correctly requires knowledge of the upstream component, i.e.,
a root port or a switch downstream port.

But these chips seem to be pretty buggy in terms of ASPM, so it
doesn't really surprise me if they're broken here.

That's all to say that I don't know *why* this would be needed, but I
don't object to it.

> Signed-off-by: Klaus Doth <kdlnx@doth.eu>
> 
> ---
>  drivers/misc/cardreader/rtsx_pcr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c
> b/drivers/misc/cardreader/rtsx_pcr.c
> index 06038b325b02..8b0799cd88c2 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -141,6 +141,7 @@ static void rtsx_comm_pm_full_on(struct rtsx_pcr *pcr)
>      struct rtsx_cr_option *option = &pcr->option;
>  
>      rtsx_disable_aspm(pcr);
> +    msleep(1);
>  
>      if (option->ltr_enabled)
>          rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
> -- 
> 2.26.2
> 
> 
