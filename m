Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6711DE112
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 09:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgEVHdl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 03:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbgEVHdk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 03:33:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D1982073B;
        Fri, 22 May 2020 07:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590132818;
        bh=Vuf16WA2V9OsrlkerdUYPyLnxQpbjETrlHooIjSPzAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8I5yZbwkID/oNFMyvvNbLFmZL2qvI+1QDWuNI4wuDdW7ABfuerlGGW+agzhyEeCz
         DdH0TcxwyRX6PvOpzpzxFBlPffFT04rRlp8jNQdwfaLjMcs5FZaWm8miivOnQTOEhQ
         10vTMQz83vaEhzQuPDALqpiYdSEoULhv7JiG4Qr4=
Date:   Fri, 22 May 2020 09:33:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Klaus Doth <kdlnx@doth.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, helgaas@kernel.org,
        linux-pci@vger.kernel.org, rui_feng@realsil.com.cn
Subject: Re: Possible bug in drivers/misc/cardreader/rtsx_pcr.c
Message-ID: <20200522073336.GA929703@kroah.com>
References: <b7ff0106-e4e7-5d0f-667b-8552cf5535dc@doth.eu>
 <20200521085211.GA2732409@kroah.com>
 <3ed62141-8060-dcd2-d1e0-d2381f4930dd@doth.eu>
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
> 
> 
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

Looks sane, can you resend it in a format I can apply it in (i.e. as a
stand-alone patch with a correct subject line?)

thanks,

greg k-h
