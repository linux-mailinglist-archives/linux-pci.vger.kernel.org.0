Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447701DE556
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 13:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgEVL1d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 07:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbgEVL1d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 07:27:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4528F206BE;
        Fri, 22 May 2020 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590146851;
        bh=h7Y/HlMJmaGgooB3XBvawhcwgapQpSo8942mWF4SmvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6OfxmAAjw1woouQ/n9W0mHi51n3Zr9OvKcAhl2Gxues8URMbbFFNhEoy8tKac6w5
         7F75MgFPfjWKxx7DMaLZl9ezwswBtZV35yKnEHQ8OU9m5tZBPBvFxpNRBehEd91Czx
         jUO3K2dpWqHDGD9X2/SXFm6qpj+2EAfOxWAKfJbo=
Date:   Fri, 22 May 2020 13:27:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Klaus Doth <kdlnx@doth.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Subject: Re: [PATCH v3] misc: rtsx: Add short delay after exit from ASPM
Message-ID: <20200522112728.GA1387314@kroah.com>
References: <b7ff0106-e4e7-5d0f-667b-8552cf5535dc@doth.eu>
 <20200521085211.GA2732409@kroah.com>
 <b966d133-4e1e-f050-f1ca-67aa7eaf0ca7@doth.eu>
 <CAK8P3a0YwMJmTimtj0_KfKaPuPs3SMvUgj4eDow1jp8CY5Ugng@mail.gmail.com>
 <4434eaa7-2ee3-a560-faee-6cee63ebd6d4@doth.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4434eaa7-2ee3-a560-faee-6cee63ebd6d4@doth.eu>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 22, 2020 at 12:56:04PM +0200, Klaus Doth wrote:
> From: Klaus Doth <kdlnx@doth.eu>
> 
> DMA transfers to and from the SD card stall for 10 seconds and run into
> timeout on RTS5260 card readers after ASPM was enabled.
> 
> Adding a short msleep after disabling ASPM fixes the issue on several
> Dell Precision 7530/7540 systems I tested.
> 
> This function is only called when waking up after the chip went into
> power-save after not transferring data for a few seconds. The added
> msleep does therefore not change anything in data transfer speed or
> induce any excessive waiting while data transfers are running, or the
> chip is sleeping. Only the transition from sleep to active is affected.
> 
> Signed-off-by: Klaus Doth <kdlnx@doth.eu>
> Cc: stable <stable@vger.kernel.org>
> ---
> Changes from v2:
>   - Added this changelog. Tabs should now be tabs instead of spaces.
> 
> Changes from v1:
>   - Added comment explaining why the msleep is required
> 
>  drivers/misc/cardreader/rtsx_pcr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> index 06038b325b02..3a6a6988cf80 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -141,6 +141,9 @@ static void rtsx_comm_pm_full_on(struct rtsx_pcr *pcr)
>  	struct rtsx_cr_option *option = &pcr->option;
>  
>  	rtsx_disable_aspm(pcr);
> +	

That's trailing whitespace :(

I'll fix it up by hand, but next time, always run your patches through
scripts/checkpatch.pl to catch these things.

thanks,

greg k-h
