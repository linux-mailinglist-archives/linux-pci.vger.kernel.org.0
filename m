Return-Path: <linux-pci+bounces-24263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DB0A6B002
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 22:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA49188B5CF
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 21:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABDC22173C;
	Thu, 20 Mar 2025 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnqBDVwF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3C1CB332;
	Thu, 20 Mar 2025 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506729; cv=none; b=Rn01o3XSfKHfO7trrOisOY+xmzfpubaS9+Hg4NYsnUxr8S8ulkZfk7kQ43OwjNSww/eLyMrA58JPBkeKVAsajHmSZFMIqmBe1I9qPuFhKlaTYtawdfPY3y8NzuVeje9itx27EPivW40ZXyANokMpsnUy0eLjGZT2jR+dXL4BRhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506729; c=relaxed/simple;
	bh=xBq+kuml8gUMhTga7dWd9x5psa834hL/dQF5A53Fuwg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ghMQpp+IJfmQEwZMl0RAAi+jMyHOdgvHPXJBnNUQK8oGKLMfwvzcN1ypywP6rSrgfHuQBR6eew4EJpB3WH3ht5yyoTcpqXX4pMR0lSr6G48XqalhSaveGdnHse19mir2BGUOseoBqLzz90zgBdAvqvXUMmWN1hSnWr6IfXpE1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnqBDVwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34C7C4CEDD;
	Thu, 20 Mar 2025 21:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742506728;
	bh=xBq+kuml8gUMhTga7dWd9x5psa834hL/dQF5A53Fuwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nnqBDVwFcnvXBfRcM1fqHqEcO5t6SXY96MSB9SBtkXDp4d0BmGpdpRGIM1Bu5v6BK
	 G0G63Wc04deBl1r4Iwaw0NAdhJN+19SfIbJzddvIdUNxU4eLWIeeyVAaDpw8Svl7bS
	 PZD9s91uI41s74lvPJNXzd67JcTiJ/8zp2tfNY9Rdr4iLOuXnpW14mKthbMi5YpLNR
	 wJWdStZ7gd0TfH087g481gTcybLronAdouheIdSylefpXkSi2fHRqo5tEY4ZF2y6Dr
	 YypqTWoejWrIYHt4an6w1nMqZsw7gdSOP5VNOm1q1MgjlsVLSaxiDJ7CUSPQiZexqP
	 SYxPFRoNzZjAw==
Date: Thu, 20 Mar 2025 16:38:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Hsin-Yi Wang <hsinyi@chromium.org>, lukas@wunner.de,
	mika.westerberg@linux.intel.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v6] PCI: Allow PCI bridges to go to D3Hot on all non-x86
Message-ID: <20250320213847.GA1101373@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320110604.v6.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>

On Thu, Mar 20, 2025 at 11:06:04AM -0700, Brian Norris wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Currently, pci_bridge_d3_possible() encodes a variety of decision
> factors when deciding whether a given bridge can be put into D3. A
> particular one of note is for "recent enough PCIe ports." Per Rafael [0]:
> 
>   "There were hardware issues related to PM on x86 platforms predating
>    the introduction of Connected Standby in Windows.  For instance,
>    programming a port into D3hot by writing to its PMCSR might cause the
>    PCIe link behind it to go down and the only way to revive it was to
>    power cycle the Root Complex.  And similar."
> 
> Thus, this function contains a DMI-based check for post-2015 BIOS.
> 
> The above factors (Windows, x86) don't really apply to non-x86 systems,
> and also, many such systems don't have BIOS or DMI. However, we'd like
> to be able to suspend bridges on non-x86 systems too.
> 
> Restrict the "recent enough" check to x86. If we find further
> incompatibilities, it probably makes sense to expand on the deny-list
> approach (i.e., bridge_d3_blacklist or similar).
> 
> Link: https://lore.kernel.org/linux-pci/CAJZ5v0j_6jeMAQ7eFkZBe5Yi+USGzysxAgfemYh=-zq4h5W+Qg@mail.gmail.com/ [0]
> Link: https://lore.kernel.org/linux-pci/20240227225442.GA249898@bhelgaas/ [1]
> Link: https://lore.kernel.org/linux-pci/20240828210705.GA37859@bhelgaas/ [2]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> [Brian: rewrite to !X86 based on Rafael's suggestions]
> Signed-off-by: Brian Norris <briannorris@chromium.org>

OK, I give up.  It seems like we don't have any better way than to
guess which platforms don't have issues.

Applied to pci/pm for v6.15, thanks!

> ---
> Based on prior work by Manivannan Sadhasivam that was part of a bigger
> series that stalled:
> 
> [PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all Devicetree based platforms
> https://lore.kernel.org/linux-pci/20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org/
> 
> I'm resubmitting this single patch, since it's useful and seemingly had
> agreement.
> 
> Changes in v6:
> - Include more background lore (thanks Rafael)
> - Switch to "non-x86" instead of "uses Device Tree" condition
> 
> Changes in v5:
> - Pulled out of the larger series, as there were more controversial
>   changes in there, while this one had agreement (Link [1][2]).
> - Rewritten with a relaxed set of rules, because the above patch
>   required us to modify many device trees to add bridge nodes.
> 
>  drivers/pci/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ff69f3d653ce..4d7c9f64ea24 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3031,7 +3031,7 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
>   * @bridge: Bridge to check
>   *
>   * This function checks if it is possible to move the bridge to D3.
> - * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt.
> + * Currently we only allow D3 for some PCIe ports and for Thunderbolt.
>   */
>  bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  {
> @@ -3075,10 +3075,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  			return false;
>  
>  		/*
> -		 * It should be safe to put PCIe ports from 2015 or newer
> -		 * to D3.
> +		 * Out of caution, we only allow PCIe ports from 2015 or newer
> +		 * into D3 on x86.
>  		 */
> -		if (dmi_get_bios_year() >= 2015)
> +		if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >= 2015)
>  			return true;
>  		break;
>  	}
> -- 
> 2.49.0.395.g12beb8f557-goog
> 

