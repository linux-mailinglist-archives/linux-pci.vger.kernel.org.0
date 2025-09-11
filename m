Return-Path: <linux-pci+bounces-35911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EB4B533D6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 15:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8B2171151
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 13:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1100E327A3C;
	Thu, 11 Sep 2025 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb6nD0JB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73D72EAD09;
	Thu, 11 Sep 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597699; cv=none; b=Qy30xFI/cWCNSyaGowgU30761ceNbIG4ckLc5E0g6Nyq+AyhdzRVsQH5smC5DHaQIFPOmzEpEFOGgGZJ1A8jNmsqlzxMGrbm5BTkul6uEKx7g+ykEp2mxLYyx5Hg/Am56oxHgrfq4F4FlzWbezNgMPz4DUVOXJ/Yy5aAmbg4ORY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597699; c=relaxed/simple;
	bh=LjszRtjdDgvj+QbwdKiaqNxhoUDblH81b/oX9Yv2XAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGdV0I3jpEVtd3WTxN3Y3EXO+bNTX81AAVih6vUztKa3W97GBQJLO7UWI6uAP8X0sItXhYp6s8btvPz4dwf4N0sxWoTnhY0jrId+se/U0CC0tjZAgV3XUZ0+YU4WEr8SvWj0HloNkVAYzYN6UOeCK0FgZiVevCxyT//KXjQE6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb6nD0JB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598CDC4CEF0;
	Thu, 11 Sep 2025 13:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757597699;
	bh=LjszRtjdDgvj+QbwdKiaqNxhoUDblH81b/oX9Yv2XAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Tb6nD0JB3mrrDhrWJvg+HtzP1Kge9bBHpyZFgCPRpOTnldg8q1C1JgaUaBJ1bBZR7
	 8Vvgbq2YWCLjU7VzTfbD+LmNECPMVvpsxV/rvT9UDR+Li45e4aXV3oGs78IaDecfLK
	 dGdjaKRhsg9fk1KIbCa+boeN5Dw/XXUgRiPR9t+HyRuOI+xPtBPjlJA9IFuBNKCl6M
	 FpHC064IE8IOSi60V/TmnsGUSL/psqx30v1VAdbVAsacsVGt8Zr5Ugx8RyZlpkdc/1
	 1mT+lHo3JRRkxlR7rkU/zonHUnCxZfYu7VWJ+QtK2O1I6mYHH+/ciuZYKaU7ahIJVL
	 QHQpcyPLK1nJQ==
Message-ID: <80980751-64db-4dc2-9516-03046e8b4b31@kernel.org>
Date: Thu, 11 Sep 2025 08:34:56 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/PM: Move ASUS EHCI workaround out of generic code
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Timo Jyrinki <timo.jyrinki@iki.fi>, Ernst Persson <ernstp@gmail.com>,
 Steven Harms <sjharms@gmail.com>, James Ettle <james@ettle.org.uk>,
 Nick Coghlan <ncoghlan@gmail.com>, Weng Xuetian <wengxt@gmail.com>,
 Andrey Rahmatullin <wrar@wrar.name>, Boris Barbour <boris.barbour@ens.fr>,
 Vlastimil Zima <vlastimil.zima@gmail.com>, David Banks <amoebae@gmail.com>,
 Michal Jaegermann <michal@harddata.com>, Chris Moeller <kode54@gmail.com>,
 Daniel Fraga <fragabr@gmail.com>, Javier Marcet <jmarcet@gmail.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
References: <75e4ae507fa4faddd063a3a9e17d319ed84529b6.1757562971.git.lukas@wunner.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <75e4ae507fa4faddd063a3a9e17d319ed84529b6.1757562971.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 8:11 AM, Lukas Wunner wrote:
> In 2012, commit dbf0e4c7257f ("PCI: EHCI: fix crash during suspend on ASUS
> computers") amended pci_pm_suspend_noirq() to work around a BIOS issue by
> clearing the Command register if the suspended device is a USB EHCI host
> controller.
> 
> Commit 0b68c8e2c3af ("PCI: EHCI: Fix crash during hibernation on ASUS
> computers") subsequently amended pci_pm_poweroff_noirq() to do the same.
> 
> Two years later, commit 7d2a01b87f16 ("PCI: Add pci_fixup_suspend_late
> quirk pass") introduced the ability to execute arbitrary quirks
> specifically in pci_pm_suspend_noirq() and pci_pm_poweroff_noirq().
> 
> This allows moving the ASUS workaround out of generic code and into a
> proper quirk to improve maintainability and readability.  Constrain to x86
> since the ASUS BIOS doesn't seem to have been used on other arches.
> 
> lspci output of affected EHCI host controllers reveals that the only bits
> set in the Command register are Memory Space Enable and Bus Master Enable:
>    https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=658778
> 
> The latter is cleared by:
>    hcd_pci_suspend()
>      suspend_common()
>        pci_disable_device()
> 
> pci_disable_device() does not clear I/O and Memory Space Enable, although
> its name suggests otherwise.  

That was my gut reaction as well.

> The kernel has never disabled these bits
> once they're enabled.  Doing so would avoid the need for the quirk, but it
> is unclear what will break if this fundamental behavior is changed.
> 

It's too late for this cycle to do so, but how would you feel about 
making this change at the start of the next cycle so it had a whole 
cycle to bake in linux-next and see if there is a problem in doing so?
If there is it could certainly be moved back to a quirk.

> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   arch/x86/pci/fixup.c     | 19 +++++++++++++++++++
>   drivers/pci/pci-driver.c | 19 -------------------
>   2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index e7e71490bd25..c34ff72434f2 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -1041,3 +1041,22 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev)
>   }
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
>   #endif /* CONFIG_SUSPEND */
> +
> +#ifdef CONFIG_PM_SLEEP
> +/*
> + * Some BIOSes from ASUS have a bug: If a USB EHCI host controller's Command
> + * register is not 0 on suspend, the BIOS assumes that the controller has not
> + * been quiesced and tries to turn it off.  If the controller is already in D3,
> + * this can hang or cause memory corruption.
> + *
> + * Since the value of the Command register does not matter once the device has
> + * been suspended, it can safely be set to 0.
> + */
> +static void quirk_clear_command_reg(struct pci_dev *pdev)
> +{
> +	pci_write_config_word(pdev, PCI_COMMAND, 0);
> +}
> +DECLARE_PCI_FIXUP_CLASS_SUSPEND_LATE(PCI_ANY_ID, PCI_ANY_ID,
> +				     PCI_CLASS_SERIAL_USB_EHCI, 0,
> +				     quirk_clear_command_reg);
> +#endif /* CONFIG_PM_SLEEP */
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 63665240ae87..e1089dfeb419 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -914,18 +914,6 @@ static int pci_pm_suspend_noirq(struct device *dev)
>   
>   	pci_pm_set_unknown_state(pci_dev);
>   
> -	/*
> -	 * Some BIOSes from ASUS have a bug: If a USB EHCI host controller's
> -	 * PCI COMMAND register isn't 0, the BIOS assumes that the controller
> -	 * hasn't been quiesced and tries to turn it off.  If the controller
> -	 * is already in D3, this can hang or cause memory corruption.
> -	 *
> -	 * Since the value of the COMMAND register doesn't matter once the
> -	 * device has been suspended, we can safely set it to 0 here.
> -	 */
> -	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
> -		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
> -
>   Fixup:
>   	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
>   
> @@ -1205,13 +1193,6 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>   	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
>   		pci_prepare_to_sleep(pci_dev);
>   
> -	/*
> -	 * The reason for doing this here is the same as for the analogous code
> -	 * in pci_pm_suspend_noirq().
> -	 */
> -	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
> -		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
> -
>   	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
>   
>   	return 0;


