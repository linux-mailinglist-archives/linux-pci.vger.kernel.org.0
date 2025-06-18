Return-Path: <linux-pci+bounces-30128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD20ADF694
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 21:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0957F7AF4B3
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C17D19E96D;
	Wed, 18 Jun 2025 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIUbZUIf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D8D3085C7;
	Wed, 18 Jun 2025 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273308; cv=none; b=dAXUi9/1Qh33LJRR8qOQsQ5hEMZeYtkGvxlWelvOCYxCQNVIl0owirkk5O87dgzBEFFcBCUdHLqEv0XbhuyMNVpEA/bP9yCic3Pm8prv95PqoMipTLTRlKBhb3xknmrfxj6tzTjmCg1x8fBGUjsJhQBG7S+N0Oga+SuCIZ8dBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273308; c=relaxed/simple;
	bh=+KcHMYRo/RJ8EBPeL+YSCOGo7cPihC08cm5ZqMYgQMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IG0YMNjcarjoQiRwuzXaxP2oSfLVWILGPwSgqhFCUcudLFNGxuLiJPfop+2fpLx1HMteHeY3lDLjsnnWHuyc5jVa5ry4vQFf7/2ONWx9Svt6qvkzBp0erflWSS4MaLK5NWfV/ZXvJQ8mxkTfn9CK9wpz74+wmOeiOduq55I5DWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIUbZUIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8753C4CEE7;
	Wed, 18 Jun 2025 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750273307;
	bh=+KcHMYRo/RJ8EBPeL+YSCOGo7cPihC08cm5ZqMYgQMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aIUbZUIfrIdiBvY7idLtRJUkaYJ/xfiqwwQy1OIAx52V25PKkcPJxJguQWRzuJpqj
	 ZNkzWYcW1f3fbhWO2Ifn4bIqQ3Qc0WSETv37uz/c6+kReljDLKiRamHSOzWV7NoBwr
	 yM0rznDrbbdHO4p8NdjbNFaZ2IkKFuFze+Iv3Symvxv0E9OqhZyhx99BFyxVL7iuP9
	 R64qMpQuljf5g6JkieRXZRRtqJrl4SuGUMJNMnfm/PVWMRTKx+QBO2LizPLw5AJYqz
	 RGDkV2KIFBK0hXOskyjmT6FsqVAMyalrPDSyK+RXe0Zv2DKjNee4pwjVrpykcIQeFF
	 wtNZo2r7FTkCg==
Date: Wed, 18 Jun 2025 14:01:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention
 indicator
Message-ID: <20250618190146.GA1213349@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <300098407.1310656.1750265939231.JavaMail.zimbra@raptorengineeringinc.com>

On Wed, Jun 18, 2025 at 11:58:59AM -0500, Timothy Pearson wrote:
>  state

Weird wrapping of last word of subject to here.

> The PCIe specification allows three attention indicator states,
> on, off, and blink.  Enable all three states instead of basic
> on / off control.
> 
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> ---
>  drivers/pci/hotplug/pnv_php.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index 0ceb4a2c3c79..c3005324be3d 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -440,10 +440,23 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
>  	return ret;
>  }
>  
> +static int pnv_php_get_raw_indicator_status(struct hotplug_slot *slot, u8 *state)
> +{
> +	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
> +	struct pci_dev *bridge = php_slot->pdev;
> +	u16 status;
> +
> +	pcie_capability_read_word(bridge, PCI_EXP_SLTCTL, &status);
> +	*state = (status & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;

Should be able to do this with FIELD_GET().

Is the PCI_EXP_SLTCTL_PIC part needed?  It wasn't there before, commit
log doesn't mention it, and as far as I can tell, this would be the
only driver to do that.  Most expose only the attention status (0=off,
1=on, 2=identify/blink).

> +	return 0;
> +}
> +
> +
>  static int pnv_php_get_attention_state(struct hotplug_slot *slot, u8 *state)
>  {
>  	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
>  
> +	pnv_php_get_raw_indicator_status(slot, &php_slot->attention_state);

This is a change worth noting.  Previously we didn't read the AIC
state from PCI_EXP_SLTCTL at all; we used php_slot->attention_state to
keep track of whatever had been previously set via
pnv_php_set_attention_state().

Now we read the current state from PCI_EXP_SLTCTL.  It's not clear
that php_slot->attention_state is still needed at all.

Previously, the user could write any value at all to the sysfs
"attention" file and then read that same value back.  After this
patch, the user can still write anything, but reads will only return
values with PCI_EXP_SLTCTL_AIC and PCI_EXP_SLTCTL_PIC.

>  	*state = php_slot->attention_state;
>  	return 0;
>  }
> @@ -461,7 +474,7 @@ static int pnv_php_set_attention_state(struct hotplug_slot *slot, u8 state)
>  	mask = PCI_EXP_SLTCTL_AIC;
>  
>  	if (state)
> -		new = PCI_EXP_SLTCTL_ATTN_IND_ON;
> +		new = FIELD_PREP(PCI_EXP_SLTCTL_AIC, state);

This changes the behavior in some cases:

  write 0: previously turned indicator off, now writes reserved value
  write 2: previously turned indicator on, now sets to blink
  write 3: previously turned indicator on, now turns it off

>  	else
>  		new = PCI_EXP_SLTCTL_ATTN_IND_OFF;
>  
> -- 
> 2.39.5

