Return-Path: <linux-pci+bounces-11528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69E694CE04
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 12:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9F928483A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 10:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B574C191F8B;
	Fri,  9 Aug 2024 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xQSrO19j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cR84YcGw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xQSrO19j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cR84YcGw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742F190686;
	Fri,  9 Aug 2024 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197190; cv=none; b=acJ4fXa4IY8VmM5dbM84ecHhxviIon8K3ydDd51yaUGu1ONqtJuGR4b+5m85f+rUZoo+4YVOWa2en1+97KjhW0dfHonJiv+2AAgpEp3Yjk3GCGJllUvfroLKcas+8A6LZ0Fl/2RL22PUCLm6uZd4yj3q77fEooBQ7vB34eKFltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197190; c=relaxed/simple;
	bh=qgkuo5ZI9Fg8YOEQwDuCKy7wo3wnm2cbQdZX++Q6W/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gefUU7eXBA71eS1TpL6IIbAO1H28YFbilwAN9iSkLFxIJXb1nYOvYEODnmcw1EZmKIiwFcFFEsBO+r4P9X6lselaIUPC4WKs9gmRYEbs1PUjoK0m9apu0UIP/W+0gZAAvB3z02EcgQx/aUKDCG8tuZwGx00eG+6nLX2rYxDEPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xQSrO19j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cR84YcGw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xQSrO19j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cR84YcGw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 015F31F801;
	Fri,  9 Aug 2024 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723197187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EL8ezaHLjYm5VgFZL0TrmF5rU96smvF6G4BYOd0Svog=;
	b=xQSrO19jKxaLIX9hXf/gTgxSTf7jS+ShbPweaymqCTenDSxj04jtR14kZXxqDAZADHcbw9
	m6yCc8U9g5ASmJHGrYpa7Riw7Slz6zwTfr6IW4ChM+3De910XcE6AD/4nAk4qo7rG2hrwk
	HFFCF/mMa9erY67lJlisYivdSzn5dhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723197187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EL8ezaHLjYm5VgFZL0TrmF5rU96smvF6G4BYOd0Svog=;
	b=cR84YcGwlK3zYtqv30Hj3ZNL1ypB1wEO3/soqZKsaZQgEqIjhV4Gl4N741/SlZ8KXs2nya
	Y2mkjRHgAk1Pe0Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xQSrO19j;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cR84YcGw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723197187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EL8ezaHLjYm5VgFZL0TrmF5rU96smvF6G4BYOd0Svog=;
	b=xQSrO19jKxaLIX9hXf/gTgxSTf7jS+ShbPweaymqCTenDSxj04jtR14kZXxqDAZADHcbw9
	m6yCc8U9g5ASmJHGrYpa7Riw7Slz6zwTfr6IW4ChM+3De910XcE6AD/4nAk4qo7rG2hrwk
	HFFCF/mMa9erY67lJlisYivdSzn5dhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723197187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EL8ezaHLjYm5VgFZL0TrmF5rU96smvF6G4BYOd0Svog=;
	b=cR84YcGwlK3zYtqv30Hj3ZNL1ypB1wEO3/soqZKsaZQgEqIjhV4Gl4N741/SlZ8KXs2nya
	Y2mkjRHgAk1Pe0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 190951379A;
	Fri,  9 Aug 2024 09:53:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /WkwAwLntWZ0PgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 09 Aug 2024 09:53:06 +0000
Message-ID: <57f11aff-95f8-41fd-b35e-a9e5a85c68e3@suse.de>
Date: Fri, 9 Aug 2024 12:53:05 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] PCI: brcmstb: Use swinit reset if available
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
 <20240731222831.14895-6-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240731222831.14895-6-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.50 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,linaro.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.50
X-Rspamd-Queue-Id: 015F31F801

Hi Jim,

On 8/1/24 01:28, Jim Quinlan wrote:
> The 7712 SOC adds a software init reset device for the PCIe HW.
> If found in the DT node, use it.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 4d68fe318178..948fd4d176bc 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -266,6 +266,7 @@ struct brcm_pcie {
>  	struct reset_control	*rescal;
>  	struct reset_control	*perst_reset;
>  	struct reset_control	*bridge_reset;
> +	struct reset_control	*swinit_reset;
>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> @@ -1633,12 +1634,30 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(pcie->bridge_reset))
>  		return PTR_ERR(pcie->bridge_reset);
>  
> +	pcie->swinit_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "swinit");
> +	if (IS_ERR(pcie->swinit_reset))
> +		return PTR_ERR(pcie->swinit_reset);
> +
>  	ret = clk_prepare_enable(pcie->clk);
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
>  
>  	pcie->bridge_sw_init_set(pcie, 0);
>  
> +	if (pcie->swinit_reset) {
> +		ret = reset_control_assert(pcie->swinit_reset);
> +		if (dev_err_probe(&pdev->dev, ret, "could not assert reset 'swinit'\n"))
> +			goto clk_disable_unprepare;
> +
> +		/* HW team recommends 1us for proper sync and propagation of reset */
> +		udelay(1);

Hmm, shouldn't this delay be part of .assert/.deassert reset_control
driver?  I think this detail is reset-control hw specific and the
consumers does not need to know it.

> +
> +		ret = reset_control_deassert(pcie->swinit_reset);
> +		if (dev_err_probe(&pdev->dev, ret,
> +				  "could not de-assert reset 'swinit' after asserting\n"))
> +			goto clk_disable_unprepare;
> +	}
> +
>  	ret = reset_control_reset(pcie->rescal);
>  	if (dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n"))
>  		goto clk_disable_unprepare;

~Stan

