Return-Path: <linux-pci+bounces-9796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAB5927677
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 14:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9AB1F212A1
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7F01ABCCB;
	Thu,  4 Jul 2024 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="be1DLUvs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gbNWeooP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DLHHJplP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i3WgNq/Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234726289;
	Thu,  4 Jul 2024 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097657; cv=none; b=a0FhixgFsm7WX1WTjWOxVZPbiCN2hvdBC9TbJG+GghfDSqjPir5SD/li3gTf/Bo/QeY1cx2BgKNLD5PbtM335oLc1IUxZTCM93hnQZz2anR/LaJRFkGUsl4NK+qjK2d/s8BIj6EXJ3UKuP9ZUCzj99EfqeotY8Pir/4G+G52XlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097657; c=relaxed/simple;
	bh=tShDoJsMMhWIu5HR/pk3kvVV1/tO24/BZrog9B0ki98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajYemfK63hsDQGR+OZy1veY8Hgxt5DJT3p2XrkjTJuGuGQBacsVosgLAZzM1LypY1BnFCPrewhufslN2+pJ/s3yP3MkfvZyoytPxR8MAZ5uma3rg9jOdL878sjLzBVhp84DiliiFYwKmLfIcw+00cGB1BB1KwVR5i5itfLq876I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=be1DLUvs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gbNWeooP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DLHHJplP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i3WgNq/Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4B1521BC5;
	Thu,  4 Jul 2024 12:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720097654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4AM5FpRPvUcHEf9YSBZUYhmHXe53kyv5A3TN6UfvTQ=;
	b=be1DLUvsRzYO403e9eypK7bILaEWXV/8Xk0OjeHXTFLKPzfaEh0y8gTkLNErc5mhnZKDtY
	b8AXLHvHaZ28Z1pX9aN01YvzbqfR1+1LIAoEmEgtKQ3tZ4eI8tMpYMgvbuP6ji/2PN1iOo
	pKqljtT1+UhIwOJ9pNjAx2ISJzqnnYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720097654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4AM5FpRPvUcHEf9YSBZUYhmHXe53kyv5A3TN6UfvTQ=;
	b=gbNWeooPQBqClpoTCzlDzLl/7VxwqMkVl9wfCkN/sRGoPrYPeLIsg25gWxChZy1OOvPIRM
	wY407yd1xAhjMZBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720097653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4AM5FpRPvUcHEf9YSBZUYhmHXe53kyv5A3TN6UfvTQ=;
	b=DLHHJplPLaO2MM/eCh6uxSDCndM8vMlPdpYOpLiy9vufM5FKMyS7N78kNaTF4SNRxltGho
	peXawOMUjGbqMvEAWI8T4Lyo859EmQ1603aMvyY5ZpojbJot+V/PoDgAXT6Y2RkTA+zoxl
	Ls5c/nBUAX3VnR2UPlG+3VaIjyy91Ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720097653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4AM5FpRPvUcHEf9YSBZUYhmHXe53kyv5A3TN6UfvTQ=;
	b=i3WgNq/Y9baN/6ya5zXhTV+2yCZ6ZTBCp7UcTZKYgui0tBWOi6ijaSvFu4eJlmrbb2knBo
	sfKMZdo+d41vmzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B78C13889;
	Thu,  4 Jul 2024 12:54:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AoZHAHWbhmaUFQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 04 Jul 2024 12:54:13 +0000
Message-ID: <45fdcd29-adb1-40eb-9f17-8c1ef8fde0d4@suse.de>
Date: Thu, 4 Jul 2024 15:53:58 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] PCI: brcmstb: Use "clk_out" error path label
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
 <20240703180300.42959-3-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240703180300.42959-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -8.28
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-8.28 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.975];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

Hi Jim,

On 7/3/24 21:02, Jim Quinlan wrote:
> Instead of invoking "clk_disable_unprepare(pcie->clk)" in
> a number of error paths, we can just use a "clk_out" label
> and goto the label after setting the return value.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c08683febdd4..c2eb29b886f7 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1620,24 +1620,25 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	}
>  	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
>  	if (IS_ERR(pcie->rescal)) {
> -		clk_disable_unprepare(pcie->clk);
> -		return PTR_ERR(pcie->rescal);
> +		ret = PTR_ERR(pcie->rescal);
> +		goto clk_out;
>  	}
>  	pcie->perst_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "perst");
>  	if (IS_ERR(pcie->perst_reset)) {
> -		clk_disable_unprepare(pcie->clk);
> -		return PTR_ERR(pcie->perst_reset);
> +		ret = PTR_ERR(pcie->perst_reset);
> +		goto clk_out;
>  	}
>  

	ret = clk_prepare_enable(pcie->clk);

Have you considered enabling pcie->clk clock here ^^^ and avoid jumping
to clk_out label?

Basically, it'd be easier from error-path POV to get all required
resources and just after that start the initialization sequence of pcie
controller.

~Stan

>  	ret = reset_control_reset(pcie->rescal);
> -	if (ret)
> +	if (ret) {
>  		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> +		goto clk_out;
> +	}
>  
>  	ret = brcm_phy_start(pcie);
>  	if (ret) {
>  		reset_control_rearm(pcie->rescal);
> -		clk_disable_unprepare(pcie->clk);
> -		return ret;
> +		goto clk_out;
>  	}
>  
>  	ret = brcm_pcie_setup(pcie);
> @@ -1676,6 +1677,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +clk_out:
> +	clk_disable_unprepare(pcie->clk);
> +	return ret;
>  fail:
>  	__brcm_pcie_remove(pcie);
>  	return ret;

