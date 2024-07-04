Return-Path: <linux-pci+bounces-9797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2D592768D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 14:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9A71F2152C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 12:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830781AC221;
	Thu,  4 Jul 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cILsAUD9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vkQPGR33";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cILsAUD9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vkQPGR33"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC571AE87E;
	Thu,  4 Jul 2024 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097813; cv=none; b=isQu5IUthksSY34/Vss9MmSQ9Y/UxNBhO/S5aNFYW8m4oxjcm/39L7/EKqmcf3vc4AdHWgSYfWG3Uu0oSzzJuTT9z5QU0sDvN5MiZ/CnEgIYME5t3fSOEhKGugCe2x5pgqFKHe4TH8Lbmu09/j5iT+HU6d3N7cH36fnOeDFCcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097813; c=relaxed/simple;
	bh=xxQFluIuPAcwiS2zQBjjned5eFTKDzR0fJWIs4myPzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FM+pfABuji2cN3dCYRLkkl1C6xknIfe901isBhOv03baFUkC+3BSrXooI/J6jySWrkmjf6FBn27f2UITlNDpknl6O2PElrz2Mc0DGv4pFeIYBM1zUJVJ/ZlnBB8EYt4DWOHHyYyGNK3NuAZj9aX7Qv39Cp2Cv2vHgCGE3/48pxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cILsAUD9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vkQPGR33; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cILsAUD9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vkQPGR33; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2E0421C08;
	Thu,  4 Jul 2024 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720097810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HA0Sq4hCjEH+fEIEKa7J7k8zC8cdafIFAs9CKmuIpW0=;
	b=cILsAUD9lag1kNhIjfOszM81kM6U7HBb8a477v6iJyvIFEgjSsxiASWM7GdPOvoxZ8ZPsN
	8o5ldAk4xDlixm0fi+EuFUuylYlYiB5iczVAeolvdwMhoUFC8ilqL5QB2Je0Leg9raongd
	wGktYO01e/Hvnqp3eHMEJ4wyrFQ4rXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720097810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HA0Sq4hCjEH+fEIEKa7J7k8zC8cdafIFAs9CKmuIpW0=;
	b=vkQPGR33gc8KYMggPRxXrtDFmL3IrnwVumgmv0HhHKX+uIuzaxUEWERfMA8k4yCV59Iw4s
	2/y0MR0cqAONS3Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720097810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HA0Sq4hCjEH+fEIEKa7J7k8zC8cdafIFAs9CKmuIpW0=;
	b=cILsAUD9lag1kNhIjfOszM81kM6U7HBb8a477v6iJyvIFEgjSsxiASWM7GdPOvoxZ8ZPsN
	8o5ldAk4xDlixm0fi+EuFUuylYlYiB5iczVAeolvdwMhoUFC8ilqL5QB2Je0Leg9raongd
	wGktYO01e/Hvnqp3eHMEJ4wyrFQ4rXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720097810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HA0Sq4hCjEH+fEIEKa7J7k8zC8cdafIFAs9CKmuIpW0=;
	b=vkQPGR33gc8KYMggPRxXrtDFmL3IrnwVumgmv0HhHKX+uIuzaxUEWERfMA8k4yCV59Iw4s
	2/y0MR0cqAONS3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1515613889;
	Thu,  4 Jul 2024 12:56:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wq2AAhGchmZnFgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 04 Jul 2024 12:56:49 +0000
Message-ID: <362a728f-5487-47da-b7b9-a9220b27d567@suse.de>
Date: Thu, 4 Jul 2024 15:56:40 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] PCI: brcmstb: Use swinit reset if available
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
 <20240703180300.42959-5-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240703180300.42959-5-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.28 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.975];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.28
X-Spam-Level: 

Hi Jim,

On 7/3/24 21:02, Jim Quinlan wrote:
> The 7712 SOC adds a software init reset device for the PCIe HW.
> If found in the DT node, use it.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 4104c3668fdb..69926ee5c961 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -266,6 +266,7 @@ struct brcm_pcie {
>  	struct reset_control	*rescal;
>  	struct reset_control	*perst_reset;
>  	struct reset_control	*bridge;
> +	struct reset_control	*swinit;
>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> @@ -1626,6 +1627,13 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "could not enable clock\n");
>  		return ret;
>  	}
> +
> +	pcie->swinit = devm_reset_control_get_optional_exclusive(&pdev->dev, "swinit");
> +	if (IS_ERR(pcie->swinit)) {
> +		ret = dev_err_probe(&pdev->dev, PTR_ERR(pcie->swinit),
> +				    "failed to get 'swinit' reset\n");
> +		goto clk_out;
> +	}
>  	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
>  	if (IS_ERR(pcie->rescal)) {
>  		ret = PTR_ERR(pcie->rescal);
> @@ -1637,6 +1645,17 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		goto clk_out;
>  	}
>  
> +	ret = reset_control_assert(pcie->swinit);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "could not assert reset 'swinit'\n");
> +		goto clk_out;
> +	}
> +	ret = reset_control_deassert(pcie->swinit);
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not de-assert reset 'swinit' after asserting\n");
> +		goto clk_out;
> +	}

why not call reset_control_reset(pcie->swinit) directly?

~Stan
> +
>  	ret = reset_control_reset(pcie->rescal);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");

