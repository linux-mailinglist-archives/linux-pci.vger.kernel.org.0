Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADDA33E167
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 23:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhCPW3D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 18:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhCPW2r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Mar 2021 18:28:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33530C06174A;
        Tue, 16 Mar 2021 15:28:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g25so409728wmh.0;
        Tue, 16 Mar 2021 15:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1TBeHHwKh/cw+rd4agcrdioYHPRg/phJM2sm+tNaUf8=;
        b=CrArDqjdaDPuAqxTLp9W59v0Y8VugU5Ewe6wMt6hT8H3W8SqK9udJQD0tj8adWV7RT
         FsEfaIfNqTh30ZhEE2T6obhRtqwTyBb/4vxgvM1N/Cv5ZN6VAJ9mocS+c7lVTRFKmbhy
         ThC2unLjCsCCmK4st+En9/u8hgYD7TTYgdXamXWATrVosk8F/8tk7SWCaHoGiN/zUSgK
         OnodNmKOEYo9w3eg2lkkXjMnUzBPhmNBi3SS54nZupyt8vlXeexhPGAMUcv5NK+KOlcE
         AEe39+QBwHWLziYnZ3Jcjb7W3fRCF27ZWft1Sy4/Ikygi7hQu9Sd45xyR7lw+/wy+Fyh
         NUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1TBeHHwKh/cw+rd4agcrdioYHPRg/phJM2sm+tNaUf8=;
        b=Kq3XE21uOmZDNRUbiQUUns5glkWLRoixQpEIjV7JMPt+eG4zr7u4MY3hdT1qlGZv3R
         x6cdZ1/HAADNydTRBGAKzg4OiaZANeAMWp5JyZE+QU7jhtHJXhch9b472Z/LlPHPAF4B
         qw2kEydGloveUe8oAKlkMMYRU7+urySTpiXp7mok+cbWVvIV9O8bponBVff+rSdBa3vD
         C6Nj4d3KXwbkKfZeskLNRcfVnz2jPHJWxY7gvwvZpiK5JRCQ9gVFtbxAqDoTSEhCtZ5R
         w2abHY0NdCW2X9hFt1nJ/dpL9F0OFo8nZdTjqC1paO2AE8WrfQQqb+6tbCO1g3cRluFb
         Y1NA==
X-Gm-Message-State: AOAM5317cUlay6LvCvCamzgvKolSJmtvSlDyv9H7rLhuCMJRqzOlaPIZ
        wydso3nuBv35b6whCmyyRARyipNxZBY=
X-Google-Smtp-Source: ABdhPJwS0gfCGHw+e+W53ahlAmyh8WOs47r6GDLD7R/fNzsIE2744X996ZPU+1wvhXfMjteS92e01Q==
X-Received: by 2002:a1c:9d51:: with SMTP id g78mr875873wme.5.1615933725482;
        Tue, 16 Mar 2021 15:28:45 -0700 (PDT)
Received: from [192.168.2.202] (p5487b93a.dip0.t-ipconnect.de. [84.135.185.58])
        by smtp.gmail.com with ESMTPSA id m14sm590903wmi.27.2021.03.16.15.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 15:28:45 -0700 (PDT)
Subject: Re: [PATCH] PCI: PM: Do not read power state in
 pci_enable_device_flags()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>
References: <3219454.74lMxhSOWB@kreacher>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <05e3ae3e-1a5f-c413-dae1-4c24e61a8b1b@gmail.com>
Date:   Tue, 16 Mar 2021 23:28:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3219454.74lMxhSOWB@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/16/21 4:51 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It should not be necessary to update the current_state field of
> struct pci_dev in pci_enable_device_flags() before calling
> do_pci_enable_device() for the device, because none of the
> code between that point and the pci_set_power_state() call in
> do_pci_enable_device() invoked later depends on it.
> 
> Moreover, doing that is actively harmful in some cases.  For example,
> if the given PCI device depends on an ACPI power resource whose _STA
> method initially returns 0 ("off"), but the config space of the PCI
> device is accessible and the power state retrieved from the
> PCI_PM_CTRL register is D0, the current_state field in the struct
> pci_dev representing that device will get out of sync with the
> power.state of its ACPI companion object and that will lead to
> power management issues going forward.
> 
> To avoid such issues it is better to leave the current_state value
> as is until it is changed to PCI_D0 by do_pci_enable_device() as
> appropriate.  However, the power state of the device is not changed
> to PCI_D0 if it is already enabled when pci_enable_device_flags()
> gets called for it, so update its current_state in that case, but
> use pci_update_current_state() covering platform PM too for that.
> 
> Link: https://lore.kernel.org/lkml/20210314000439.3138941-1-luzmaximilian@gmail.com/
> Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
> Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Max, I've added a T-by from you even though the patch is slightly different
> from what you have tested, but the difference shouldn't matter for your case.

Thanks! I've tested this now as well, all looks good.

Regards,
Max

> 
> ---
>   drivers/pci/pci.c |   16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -1870,20 +1870,10 @@ static int pci_enable_device_flags(struc
>   	int err;
>   	int i, bars = 0;
>   
> -	/*
> -	 * Power state could be unknown at this point, either due to a fresh
> -	 * boot or a device removal call.  So get the current power state
> -	 * so that things like MSI message writing will behave as expected
> -	 * (e.g. if the device really is in D0 at enable time).
> -	 */
> -	if (dev->pm_cap) {
> -		u16 pmcsr;
> -		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> -		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> -	}
> -
> -	if (atomic_inc_return(&dev->enable_cnt) > 1)
> +	if (atomic_inc_return(&dev->enable_cnt) > 1) {
> +		pci_update_current_state(dev, dev->current_state);
>   		return 0;		/* already enabled */
> +	}
>   
>   	bridge = pci_upstream_bridge(dev);
>   	if (bridge)
> 
> 
> 
