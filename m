Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD551DE358
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgEVJio (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 05:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgEVJio (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 05:38:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1665F207CB;
        Fri, 22 May 2020 09:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590140323;
        bh=eVFkHqA+FJ8rlbwkmoUqfD9bQaBNMXMRJelRUI8xopA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+rW82nRjvSCACzaTf7hhDxO2Ngk4Zc892y9/Nny3+AxeEhNN9lub9vNBKjW8mfHc
         2H0iFUcj/+qXiyePaM/gbbPX7u/qm5uyPLjrZMstp/wDGITKEmRPYzsQgORe0XTKYu
         a3p3sLSs6bzjyYkdovloPCcIfetxjFisw0iTehnQ=
Date:   Fri, 22 May 2020 11:38:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Klaus Doth <kdlnx@doth.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Subject: Re: [PATCH v2] misc: rtsx: Add short delay after exit from ASPM
Message-ID: <20200522093841.GB1231689@kroah.com>
References: <b7ff0106-e4e7-5d0f-667b-8552cf5535dc@doth.eu>
 <20200521085211.GA2732409@kroah.com>
 <b966d133-4e1e-f050-f1ca-67aa7eaf0ca7@doth.eu>
 <CAK8P3a0YwMJmTimtj0_KfKaPuPs3SMvUgj4eDow1jp8CY5Ugng@mail.gmail.com>
 <fb202fc5-a96e-a6f1-7d4e-5d5821957a79@doth.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb202fc5-a96e-a6f1-7d4e-5d5821957a79@doth.eu>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 22, 2020 at 11:18:24AM +0200, Klaus Doth wrote:
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
> ---
>  drivers/misc/cardreader/rtsx_pcr.c | 3 +++
>  1 file changed, 3 insertions(+)

What changed from v1?  Always put that below the --- line like the
documentation says to do so.

> 
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c
> b/drivers/misc/cardreader/rtsx_pcr.c
> index 06038b325b02..3a6a6988cf80 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -141,6 +141,9 @@ static void rtsx_comm_pm_full_on(struct rtsx_pcr *pcr)
>      struct rtsx_cr_option *option = &pcr->option;
>  
>      rtsx_disable_aspm(pcr);
> +   
> +    /* Fixes DMA transfer timeout issue after disabling ASPM on RTS5260 */
> +    msleep(1);
>  
>      if (option->ltr_enabled)
>          rtsx_set_ltr_latency(pcr, option->ltr_active_latency);

All tabs are gone and replaced with spaces, making this impossible to
apply :(

thanks,

greg k-h
