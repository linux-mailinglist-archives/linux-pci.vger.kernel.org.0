Return-Path: <linux-pci+bounces-11645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A04950AB3
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 18:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B580281815
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 16:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDC42744D;
	Tue, 13 Aug 2024 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="II6IUiFA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bgb2DOFq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="II6IUiFA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bgb2DOFq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3E1A08C6;
	Tue, 13 Aug 2024 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567554; cv=none; b=XplHZXXmAqzWDpUshcCVKXt+Du42I3p2ZsTwMLSoXkll9SJ0+KqcqOYN+YzxHNMNwrBFlk12FBZWCDh4wSyedzc/UWyvWKkJYWlqEqIUz6CKMhSpHJZXd8J+zqn8CDDtgz8ooYEBGavCmETfuCeg/J0144j22l/eMtHvQqJMYNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567554; c=relaxed/simple;
	bh=MTdFqsOGuyaeq/62Xi6aeUhWuOQIDo6KWOInGrJ8OVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faAELUfF+KieoGH0+m+TEkQHr1Dj1knw2N4aOBNSz2h4NQv+aAQVqBFX4Exb2gIJy+GK63IA+3jVOf3GPMFox0l5wW12lU9Gqx7ICixp+3i3uod3998KJsjjorHK2EujyA0bWIbwtnNz7ECx7p7mjOnGLMY/HSRMvFQ0XER1Wws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=II6IUiFA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bgb2DOFq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=II6IUiFA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bgb2DOFq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B1AD2263E;
	Tue, 13 Aug 2024 16:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723567550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCX42sWbYaS93PpPGqJ15YY5A+r5iPssglVamHlCLQE=;
	b=II6IUiFANoUFbVPC318w8JotLBZ0Czp/IdMLhwfe4RJh2HQz4o495UjJigsawc9sbXbT4x
	/oovVYH30fFXo2Kb6mHZuu5L970PiqhzI0Qx5kCa8hvBV0ue80e5Zdmo+xQbBXPbbH3r/n
	+UHrl+bxnXaLy05rZRxf/49jM4omwLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723567550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCX42sWbYaS93PpPGqJ15YY5A+r5iPssglVamHlCLQE=;
	b=bgb2DOFq8prTyMvZcsOSuoLY3Aimlmo8dr1VAfjjysV6XoiG+TPUfq7cuWa3EWdu8Rml9g
	j4Q0zdJpyNikM4Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=II6IUiFA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bgb2DOFq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723567550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCX42sWbYaS93PpPGqJ15YY5A+r5iPssglVamHlCLQE=;
	b=II6IUiFANoUFbVPC318w8JotLBZ0Czp/IdMLhwfe4RJh2HQz4o495UjJigsawc9sbXbT4x
	/oovVYH30fFXo2Kb6mHZuu5L970PiqhzI0Qx5kCa8hvBV0ue80e5Zdmo+xQbBXPbbH3r/n
	+UHrl+bxnXaLy05rZRxf/49jM4omwLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723567550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCX42sWbYaS93PpPGqJ15YY5A+r5iPssglVamHlCLQE=;
	b=bgb2DOFq8prTyMvZcsOSuoLY3Aimlmo8dr1VAfjjysV6XoiG+TPUfq7cuWa3EWdu8Rml9g
	j4Q0zdJpyNikM4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B374113983;
	Tue, 13 Aug 2024 16:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zWjNKL2Nu2YoUgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 13 Aug 2024 16:45:49 +0000
Message-ID: <9e3b0b10-7605-4203-a4c0-351b51b2e63b@suse.de>
Date: Tue, 13 Aug 2024 19:45:49 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] PCI: brcmstb: Use common error handling code in
 brcm_pcie_probe()
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
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
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-4-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240731222831.14895-4-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9B1AD2263E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,linaro.org,gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 

Hi Jim,

On 8/1/24 01:28, Jim Quinlan wrote:
> o Move the clk_prepare_enable() below the resource allocations.
> o Move the clk_prepare_enable() out of __brcm_pcie_remove() but
>   add it to the end of brcm_pcie_remove().
> o Add a jump target (clk_disable_unprepare) so that a bit of exception
>   handling can be better reused at the end of this function implementation.
> o Use dev_err_probe() where it makes sense.

Those dev_err_probe produce these errors on RPi5:

rpi5:~ # dmesg -l err
[    1.004960] brcm-pcie 1000110000.pcie: error 0000000000000000: could
not assert reset 'swinit'
[    1.013812] brcm-pcie 1000110000.pcie: error 0000000000000000: could
not de-assert reset 'swinit' after asserting
[    1.024222] brcm-pcie 1000110000.pcie: error 0000000000000000: failed
to deassert 'rescal'
[    1.533839] brcm-pcie 1000110000.pcie: link down
[    1.627564] brcm-pcie 1000120000.pcie: error 0000000000000000: could
not assert reset 'swinit'
[    1.636415] brcm-pcie 1000120000.pcie: error 0000000000000000: could
not de-assert reset 'swinit' after asserting
[    1.646829] brcm-pcie 1000120000.pcie: error 0000000000000000: failed
to deassert 'rescal'

... as you can see there is no error at all.

~Stan

> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 34 ++++++++++++---------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c08683febdd4..7595e7009192 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1473,7 +1473,6 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
>  		dev_err(pcie->dev, "Could not stop phy\n");
>  	if (reset_control_rearm(pcie->rescal))
>  		dev_err(pcie->dev, "Could not rearm rescal reset\n");
> -	clk_disable_unprepare(pcie->clk);
>  }
>  
>  static void brcm_pcie_remove(struct platform_device *pdev)
> @@ -1484,6 +1483,7 @@ static void brcm_pcie_remove(struct platform_device *pdev)
>  	pci_stop_root_bus(bridge->bus);
>  	pci_remove_root_bus(bridge->bus);
>  	__brcm_pcie_remove(pcie);
> +	clk_disable_unprepare(pcie->clk);
>  }
>  
>  static const int pcie_offsets[] = {
> @@ -1613,31 +1613,26 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
>  
> -	ret = clk_prepare_enable(pcie->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "could not enable clock\n");
> -		return ret;
> -	}
>  	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
> -	if (IS_ERR(pcie->rescal)) {
> -		clk_disable_unprepare(pcie->clk);
> +	if (IS_ERR(pcie->rescal))
>  		return PTR_ERR(pcie->rescal);
> -	}
> +
>  	pcie->perst_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "perst");
> -	if (IS_ERR(pcie->perst_reset)) {
> -		clk_disable_unprepare(pcie->clk);
> +	if (IS_ERR(pcie->perst_reset))
>  		return PTR_ERR(pcie->perst_reset);
> -	}
>  
> -	ret = reset_control_reset(pcie->rescal);
> +	ret = clk_prepare_enable(pcie->clk);
>  	if (ret)
> -		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> +		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
> +
> +	ret = reset_control_reset(pcie->rescal);
> +	if (dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n"))
> +		goto clk_disable_unprepare;
>  
>  	ret = brcm_phy_start(pcie);
>  	if (ret) {
>  		reset_control_rearm(pcie->rescal);
> -		clk_disable_unprepare(pcie->clk);
> -		return ret;
> +		goto clk_disable_unprepare;
>  	}
>  
>  	ret = brcm_pcie_setup(pcie);
> @@ -1654,10 +1649,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
>  	if (pci_msi_enabled() && msi_np == pcie->np) {
>  		ret = brcm_pcie_enable_msi(pcie);
> -		if (ret) {
> -			dev_err(pcie->dev, "probe of internal MSI failed");
> +		if (dev_err_probe(pcie->dev, ret, "probe of internal MSI failed"))
>  			goto fail;
> -		}
>  	}
>  
>  	bridge->ops = pcie->type == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
> @@ -1678,6 +1671,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  
>  fail:
>  	__brcm_pcie_remove(pcie);
> +clk_disable_unprepare:
> +	clk_disable_unprepare(pcie->clk);
> +
>  	return ret;
>  }
>  

