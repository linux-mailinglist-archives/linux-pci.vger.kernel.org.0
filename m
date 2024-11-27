Return-Path: <linux-pci+bounces-17387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454409DA1FD
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 07:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE14284BF7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 06:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C681474B2;
	Wed, 27 Nov 2024 06:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/7Qhd03"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325FDF51
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732687847; cv=none; b=GAaHypgQotuDHDTQoGkhPos/SmIMFFKpf0rC9zdWccO70k2U4XCfeilVNPAE5TYieKFwRW0Sjbamg5d4nRITAEksqt5P4gul9UvPVWG3t8vildMlKxly7HxcZuiOqXRPwIICQUgtrFg0AiR8+sDpci1frpYH3WogRo5THiNpGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732687847; c=relaxed/simple;
	bh=cPdvo1SMZFEQqJn7eeSCQKo/FFcAMU9G1ZiW83fwums=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0tz8Z74tEQNWgn4pV5e2LBvWOSNdo5+6EiOkhsQomOYfqJznvF87aDJDzEyCJr8SOLrEvObUI59BFg+3y1WG9dQPWeP9pWU6yYmtdFDCOZFk81fpoHyAkpG9BYdzMmiM1kBeUU9RBAYCOPHeWj5zcU7UWXL7XJWPoJPagyMrWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F/7Qhd03; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724fee568aaso3501441b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 22:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732687844; x=1733292644; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zqa/SgF6yTly97ZL5Wo5M3cWThMFlMnzVOsX4J3DANc=;
        b=F/7Qhd03NXlipv2FGM0SrftKWLCIuNM0ijMbYMipj5+dldrZHBUQYB3yiI/LtQ9g8G
         1x0NVvi879HNPG72K8QRO0O/JRsEYW2Ce5x6urRYJNepNhj0LZyx5+jd3ed49Ah4O5sX
         qn9lVRORxzhcB1v3tXodio6Yq91LE9S9vpe9Iz1/2nYgdOj8fR880rYv4gSnGqOZZs62
         M7KA/eZM0dYRhqTwitQopU8Yd8to4aL8m6gl6XUpCa4MH8Lf/gtNbSOlPX2PmQh90ATN
         /NzkRtzz9PpBoQmElhJRUNcxdNNc5nKAItHXAbcD70NKcHG2aAUZv5Vy/4NIeXOkpl9G
         fiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732687844; x=1733292644;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqa/SgF6yTly97ZL5Wo5M3cWThMFlMnzVOsX4J3DANc=;
        b=sAlK6pTPyreW+Cl8xP/mta938RDsTCoeu74KBXXzZQc0uIvN7TyBjMiHFXif3bxdYb
         9K+oNHNdf1X7z0qRGNykk5p3R+03MLqVsNTXaTHNk0/ppHHGONE0IxSr9WglQt8TVAhh
         utLGHmMToXb1GjpvaoRVZT0nYUXLdAVOIbI51B0iicjKA5jbl+swSlTUMN/c/TOblAeZ
         cfMIzPBDR8m6MVKW/2wnicw43lv3RdMR/bDrxbuCckGV6yIC2zq2LUiHkdcvnVIiJCFs
         cCQF1RIbn8F4KTDWG3zT+ddh+EYWqOW9yH8HatbnIAnpe/MDR9Em/51vpoypED2/WH6U
         ZoKw==
X-Forwarded-Encrypted: i=1; AJvYcCV14waIx9lSMkbLN7w+3pW4MvlZqjPsYKq8G63Xgo3ctCmrLBLcgwrHBGkp2hcti/2gdW8cpsz02bM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz+nz59WxejEK4XuXQ343JWd9zlSosE6FP0GnhPxz2XDRyVVtZ
	hf09EeNjJvq3hhOmnAT0LZDP/o7dwPGhzYlVCY7Nq58dZWec1kQoeH6RUnjxDA==
X-Gm-Gg: ASbGncvy5hKuQPRRwwImRCwUclTg/H4usSjHyXzAEJdJ5852XsDstcPQcF8on0RDpnG
	7Dvd+/ebKIKY6UO9dKG8NNtvUzwLVlM2UqsFbSwpO+SIKue8ZsL9LmcvpsNAxzs/s5pn6uklG8Z
	h4zBoOudYZj5tHOD4zZ3ucc8O1WDcVV1kh0BCE6SI6DwLxcN9fQuT7LqHq00ikV6mfNqLQbUiCD
	5rJJMzlUBtyPpRWGJkF/qLwaA/iHPMFII2bPRYE1e8TqeU36yP0HHJZMCe5
X-Google-Smtp-Source: AGHT+IGaHS3AyXRTU+a3Eu+LV+18G7egpriN+zK0KvIQMZt/bOebgNCGoDrBCNgxqRGORwKNCzNPfg==
X-Received: by 2002:a05:6a00:13a7:b0:71e:f83:5c00 with SMTP id d2e1a72fcca58-72530014285mr2668234b3a.2.1732687844004;
        Tue, 26 Nov 2024 22:10:44 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de474c9fsm9447348b3a.44.2024.11.26.22.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 22:10:43 -0800 (PST)
Date: Wed, 27 Nov 2024 11:40:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: Re: [PATCH v5] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <20241127061039.ls3ghxswft3hvww5@thinkpad>
References: <20241126151711.v5.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126151711.v5.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>

On Tue, Nov 26, 2024 at 03:17:11PM -0800, Brian Norris wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Unlike ACPI based platforms, there are no known issues with D3Hot for
> the PCI bridges in Device Tree based platforms. Past discussions (Link
> [1]) determined the restrictions around D3 should be relaxed for all
> Device Tree systems. So let's allow the PCI bridges to go to D3Hot
> during runtime.
> 
> To match devm_pci_alloc_host_bridge() -> devm_of_pci_bridge_init(), we
> look at the host bridge's parent when determining whether this is a
> Device Tree based platform. Not all bridges have their own node, but the
> parent (controller) should.
> 
> Link: https://lore.kernel.org/linux-pci/20240227225442.GA249898@bhelgaas/ [1]
> Link: https://lore.kernel.org/linux-pci/20240828210705.GA37859@bhelgaas/ [2]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> [Brian: look at host bridge's parent, not bridge node; rewrite
> description]
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Thanks for picking it up!

- Mani

> ---
> Based on prior work by Manivannan Sadhasivam that was part of a bigger
> series that stalled:
> 
> [PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all Devicetree based platforms
> https://lore.kernel.org/linux-pci/20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org/
> 
> I'm resubmitting this single patch, since it's useful and seemingly had
> agreement. I massaged it a bit to relax some restrictions on how the
> Device Tree should look.
> 
> Changes in v5:
> - Pulled out of the larger series, as there were more controversial
>   changes in there, while this one had agreement (Link [2]).
> - Rewritten with a relaxed set of rules, because the above patch
>   required us to modify many device trees to add bridge nodes.
> 
>  drivers/pci/pci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e278861684bc..5d898f5ea155 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3018,6 +3018,8 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
>   */
>  bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  {
> +	struct pci_host_bridge *host_bridge;
> +
>  	if (!pci_is_pcie(bridge))
>  		return false;
>  
> @@ -3038,6 +3040,15 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  		if (pci_bridge_d3_force)
>  			return true;
>  
> +		/*
> +		 * Allow D3 for all Device Tree based systems. We assume a host
> +		 * bridge's parent will have a device node, even if this bridge
> +		 * may not have its own.
> +		 */
> +		host_bridge = pci_find_host_bridge(bridge->bus);
> +		if (dev_of_node(host_bridge->dev.parent))
> +			return true;
> +
>  		/* Even the oldest 2010 Thunderbolt controller supports D3. */
>  		if (bridge->is_thunderbolt)
>  			return true;
> -- 
> 2.47.0.338
> 

-- 
மணிவண்ணன் சதாசிவம்

