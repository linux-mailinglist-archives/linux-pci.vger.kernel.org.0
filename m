Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19ADD24A486
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgHSQ61 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 12:58:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43718 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726754AbgHSQ60 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Aug 2020 12:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597856303;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N1Sa02aKAFEAcoYWswRIPqgVoZCVrHYtFa06l02MHrs=;
        b=eC9FZ1O8gjEcZg8RnOAe9ef/mNXqzvsm6vBPfxP5gDE9SmnuK4qltwGuRsfMifixkG8NOC
        L8yZzsfUs/WgL9zCNKRgfZSoEKSNim4v8ljIqdjYUUVajs86UlHLRy6PmzENgGTARv5C91
        aFZbexrWZJZJOpyfP9Kad49JJ1oorBU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-jk2fqKM1PHSwu7mck6V5rw-1; Wed, 19 Aug 2020 12:58:21 -0400
X-MC-Unique: jk2fqKM1PHSwu7mck6V5rw-1
Received: by mail-qv1-f69.google.com with SMTP id h6so16043044qvz.14
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2020 09:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=N1Sa02aKAFEAcoYWswRIPqgVoZCVrHYtFa06l02MHrs=;
        b=oFzy+sUDYt3VwSwnBFrK1nXJz7DS8XZXNOQw0Q5tcGPDIEalwAOfwEvtjNiiYaiT6h
         /o5WS1PeyWTurCWC+/ZRFTbXWEBmm40EqYUeL4Lqw1TI3qraW/WmLs1JrY1A3MDUlEPl
         Bdg+bjwOH2/KVECeGAr+Ysk7nB6X2xx7dGfwFGYjZSvYAiwx2WwOxcVGJkqkLnDUsKaK
         h9ao3w1zYVYfJzzBUj4zmEvz2Cp9seT1QUvWsiyQTth5h5dadqTB0Ju6wWQLvMt8Aytw
         fMBF0pGLg1ZbKVaFkOCYZUcgVoL8YTLNL2VD9IqVwYv5CiSM4p7Ko14j6IauK2dY1Vmf
         o48g==
X-Gm-Message-State: AOAM5331jMaQr3oHaXyDJJQ1Jl1he3iExbqGINlRtdTtkxK80PzlOvWJ
        uDd8a2Uor4nkjC6dlGcYOOdUBfZXso+GdT2obYTnnGkdl3jQo8CnOb9637ec8Qbceg1/xIrlczR
        U0js+uTMkpaZeYSlPjHxz
X-Received: by 2002:a0c:f4cb:: with SMTP id o11mr24284093qvm.3.1597856301024;
        Wed, 19 Aug 2020 09:58:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIX2qlpqsiqC+zTooY06IllrxOE1Sum4RQXJktu5wzybJx9iXoe2kzeRuku5eHTCT60rHJAA==
X-Received: by 2002:a0c:f4cb:: with SMTP id o11mr24284066qvm.3.1597856300667;
        Wed, 19 Aug 2020 09:58:20 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id g184sm25133061qkd.51.2020.08.19.09.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 09:58:19 -0700 (PDT)
Message-ID: <1777574256b2f8acacbf1d77ec78862a638b28e0.camel@redhat.com>
Subject: Re: [PATCH] PCI/PM: Assume ports without DLL Link Active train
 links in 100 ms
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Karol Herbst <kherbst@redhat.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Ben Skeggs <bskeggs@redhat.com>, linux-pci@vger.kernel.org
Date:   Wed, 19 Aug 2020 12:58:18 -0400
In-Reply-To: <20200819130625.12778-1-mika.westerberg@linux.intel.com>
References: <20200819130625.12778-1-mika.westerberg@linux.intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-08-19 at 16:06 +0300, Mika Westerberg wrote:
> Kai-Heng Feng reported that it takes a long time (> 1 s) to resume
> Thunderbolt-connected devices from both runtime suspend and system sleep
> (s2idle).
> 
> This was because some Downstream Ports that support > 5 GT/s do not also
> support Data Link Layer Link Active reporting.  Per PCIe r5.0 sec 6.6.1:
> 
>   With a Downstream Port that supports Link speeds greater than 5.0 GT/s,
>   software must wait a minimum of 100 ms after Link training completes
>   before sending a Configuration Request to the device immediately below
>   that Port. Software can determine when Link training completes by polling
>   the Data Link Layer Link Active bit or by setting up an associated
>   interrupt (see Section 6.7.3.3).
> 
> Sec 7.5.3.6 requires such Ports to support DLL Link Active reporting, but
> at least the Intel JHL6240 Thunderbolt 3 Bridge [8086:15c0] and the Intel
> JHL7540 Thunderbolt 3 Bridge [8086:15ea] do not.
> 
> Previously we tried to wait for Link training to complete, but since there
> was no DLL Link Active reporting, all we could do was wait the worst-case
> 1000 ms, then another 100 ms.
> 
> Instead of using the supported speeds to determine whether to wait for Link
> training, check whether the port supports DLL Link Active reporting.  The
> Ports in question do not, so we'll wait only the 100 ms required for Ports
> that support Link speeds <= 5 GT/s.
> 
> This of course assumes these Ports always train the Link within 100 ms even
> if they are operating at > 5 GT/s, which is not required by the spec.
> 
> This version adds a special check for devices whose power management is
> disabled by their driver (->pm_cap is set to zero). This is needed to
> avoid regression with some NVIDIA GPUs.

Hm, I'm not entirely sure that the link training delay is specific to laptops
with ->pm_cap set to 0, I think we should try figuring out if there's any
laptops that match those characteristics before moving forward with this - I'll
take a look through the test machines I've got available today


> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=208597
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206837
> Link: 
> https://lore.kernel.org/r/20200514133043.27429-1-mika.westerberg@linux.intel.com
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pci.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a458c46d7e39..33eb502a60c8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4658,7 +4658,8 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
>   * pcie_wait_for_link_delay - Wait until link is active or inactive
>   * @pdev: Bridge device
>   * @active: waiting for active or inactive?
> - * @delay: Delay to wait after link has become active (in ms)
> + * @delay: Delay to wait after link has become active (in ms). Specify %0
> + *	   for no delay.
>   *
>   * Use this to wait till link becomes active or inactive.
>   */
> @@ -4699,7 +4700,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev
> *pdev, bool active,
>  		msleep(10);
>  		timeout -= 10;
>  	}
> -	if (active && ret)
> +	if (active && ret && delay)
>  		msleep(delay);
>  	else if (ret != active)
>  		pci_info(pdev, "Data Link Layer Link Active not %s in 1000
> msec\n",
> @@ -4793,8 +4794,13 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev
> *dev)
>  	 * accessing the device after reset (that is 1000 ms + 100 ms). In
>  	 * practice this should not be needed because we don't do power
>  	 * management for them (see pci_bridge_d3_possible()).
> +	 *
> +	 * Also do the same for devices that have power management disabled
> +	 * by their driver and are completely power managed through the
> +	 * root port power resource instead. This is a special case for
> +	 * nouveau.
>  	 */
> -	if (!pci_is_pcie(dev)) {
> +	if (!pci_is_pcie(dev) || !child->pm_cap) {
>  		pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
>  		msleep(1000 + delay);
>  		return;
> @@ -4820,17 +4826,28 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev
> *dev)
>  	if (!pcie_downstream_port(dev))
>  		return;
>  
> -	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
> -		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
> -		msleep(delay);
> -	} else {
> -		pci_dbg(dev, "waiting %d ms for downstream link, after
> activation\n",
> -			delay);
> -		if (!pcie_wait_for_link_delay(dev, true, delay)) {
> +	/*
> +	 * Per PCIe r5.0, sec 6.6.1, for downstream ports that support
> +	 * speeds > 5 GT/s, we must wait for link training to complete
> +	 * before the mandatory delay.
> +	 *
> +	 * We can only tell when link training completes via DLL Link
> +	 * Active, which is required for downstream ports that support
> +	 * speeds > 5 GT/s (sec 7.5.3.6).  Unfortunately some common
> +	 * devices do not implement Link Active reporting even when it's
> +	 * required, so we'll check for that directly instead of checking
> +	 * the supported link speed.  We assume devices without Link Active
> +	 * reporting can train in 100 ms regardless of speed.
> +	 */
> +	if (dev->link_active_reporting) {
> +		pci_dbg(dev, "waiting for link to train\n");
> +		if (!pcie_wait_for_link_delay(dev, true, 0)) {
>  			/* Did not train, no need to wait any further */
>  			return;
>  		}
>  	}
> +	pci_dbg(child, "waiting %d ms to become accessible\n", delay);
> +	msleep(delay);
>  
>  	if (!pci_device_is_present(child)) {
>  		pci_dbg(child, "waiting additional %d ms to become
> accessible\n", delay);
-- 
Sincerely,
      Lyude Paul (she/her)
      Software Engineer at Red Hat

