Return-Path: <linux-pci+bounces-32751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A5CB0E332
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 20:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4970F566023
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A0B27F013;
	Tue, 22 Jul 2025 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bU71hCOU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-80.smtpout.orange.fr [80.12.242.80])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B052D1DF270;
	Tue, 22 Jul 2025 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207353; cv=none; b=FfEvK8BC25ti+GqAcbmHyGKs/LKh8NhATlElW8doGsjDjmCuoRG8Jpi1UV/BSbTkR+z+u0aTs1c5dvWnYPvmRtGe9tbo2V1czPCknCye2vorjKPpRsdZhV4iGo0f8TC5t4UmxwE2iF1v5GJBpe+a7Vvt2NboqSNNY01KZxd5iig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207353; c=relaxed/simple;
	bh=ohSbxCZo1MGSSKhP1RrM5PesDAWqXEpJa0cXSeKerxY=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=S1HkqFdT6mWkozUuxvd8gb/da1zi1fmH5+pfxHyzN57Y+QJpsE/YgYY06bgRFngTyoLki01vMUkyuPfi1rVoQI0NIj5mpS9zgSmXGGGY1gt1RDCM3zByuaI2EnqNkw4XWSseNjxiMv0JZwG1oEIZoCskCyd/drl5froDrlbMcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bU71hCOU; arc=none smtp.client-ip=80.12.242.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id eHIluGXwGlRPceHIluHOmd; Tue, 22 Jul 2025 20:01:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753207281;
	bh=RsdHt510/2iHrRRCRfkCz61iL9/9WAdLGdGdy3eepjg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=bU71hCOUq+wzPYSUTgP5XRsJ0VCdgDKatPuTx60NPFLmSXgVtq8iVAxAwlZFr5CLI
	 eP0U2fo8bb16pY3S21j6mgfcLqcqnIVzAT/C5dxjixFpNqYBbe97OqgE1oHh0/N4S/
	 ZBuuS3JPAmslgGkh1yf6V9Op+NeLKqXlP0V/W9TNx2FHY76LRfn69Xty8A+8ZvmzwY
	 v4l/ijS3vfnFwWNKpc93aVjkzK7UvdSZM8dwzbfqgRie4fG4HjuJS/WG+Bq7Px4LP7
	 Gl/jDX9yVP4kN/PE7JJWR7G+fe0OmK+vXPmGK5BelTR8DYNs+zbFamKRWZURkwRlTN
	 ERqsStQ1BNpYg==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 22 Jul 2025 20:01:21 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <0f52bdd7-0318-4762-8557-1fd1ab7a9f1f@wanadoo.fr>
Date: Tue, 22 Jul 2025 20:01:18 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/7] PCI: keystone: Add support for PVU-based DMA
 isolation on AM654
References: <20250721025945.204422-1-huaqian.li@siemens.com>
 <20250721025945.204422-5-huaqian.li@siemens.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: huaqian.li@siemens.com
Cc: baocheng.su@siemens.com, bhelgaas@google.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, diogo.ivo@siemens.com, helgaas@kernel.org,
 jan.kiszka@siemens.com, kristo@kernel.org, krzk+dt@kernel.org, kw@linux.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lpieralisi@kernel.org, nm@ti.com,
 robh@kernel.org, s-vadapalli@ti.com, ssantosh@kernel.org, vigneshr@ti.com
In-Reply-To: <20250721025945.204422-5-huaqian.li@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/07/2025 à 04:59, 
huaqian.li-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org a écrit :
> From: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
> 
> The AM654 lacks an IOMMU, thus does not support isolating DMA requests
> from untrusted PCI devices to selected memory regions this way. Use
> static PVU-based protection instead. The PVU, when enabled, will only
> accept DMA requests that address previously configured regions.
> 
> Use the availability of a restricted-dma-pool memory region as trigger
> and register it as valid DMA target with the PVU. In addition, enable
> the mapping of requester IDs to VirtIDs in the PCI RC. Use only a single
> VirtID so far, catching all devices.

Hi,

...

>   	case DW_PCIE_EP_TYPE:
>   		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_EP)) {
> @@ -1346,6 +1450,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
>   
>   err_ep_init:
>   	dw_pcie_ep_deinit(&pci->ep);
> +err_dma_cleanup:
> +	ks_release_restricted_dma(pdev);
>   err_get_sync:
>   	pm_runtime_put(dev);
>   	pm_runtime_disable(dev);
> @@ -1362,9 +1468,15 @@ static void ks_pcie_remove(struct platform_device *pdev)
>   {
>   	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
>   	struct device_link **link = ks_pcie->link;
> +	const struct ks_pcie_of_data *data;
>   	int num_lanes = ks_pcie->num_lanes;
>   	struct device *dev = &pdev->dev;
>   
> +	data = of_device_get_match_data(dev);
> +	if (data && data->mode == DW_PCIE_RC_TYPE) {

If this test against DW_PCIE_RC_TYPE is needed in the remove function,
should the same be done in the error handling path of the probe?

If we go through "case DW_PCIE_EP_TYPE", we can end to "goto 
err_ep_init" and call ks_release_restricted_dma() unconditionally.

If it is not an issue in the error handling path of the probe, then I 
suppose that it can be removed from the remove function as well.


(and BTW, the extra {} could be removed)

CJ

> +		ks_release_restricted_dma(pdev);
> +	}
> +
>   	pm_runtime_put(dev);
>   	pm_runtime_disable(dev);
>   	ks_pcie_disable_phy(ks_pcie);


