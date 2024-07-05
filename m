Return-Path: <linux-pci+bounces-9829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D180928399
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 10:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28F41F2275A
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6B713CFBB;
	Fri,  5 Jul 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OZ/imxoC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gDMMPwam";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bl5NLvN3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cX0r4Wo4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EECD41A81;
	Fri,  5 Jul 2024 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167810; cv=none; b=iTBtF9FgrmT0MuLr8+gMqWA7iYIsk8LuDuqjMszyFFE7wpVjXHwAcwRcB2YUB8ARQ0HdOlp+qOjqmemaR1Fk9ZRVCBnkiAH7i4jRTXsZaABRXHlVlZQJjoYqoqbl9woaETZS0zb+LXQk0qn/apsIiaej/puZdrghCjtRBUfO8Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167810; c=relaxed/simple;
	bh=PlY8IYqWBL+ou+Ep+qFJ50EpDs+ID4Fbfi0KnQP4nU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAcNkfwHDG/pW52Vm2OLcm5MPib8ot+1zGBMfBdlZkzQ4QeEA1oVLl+6E3tTJUu92b0hSwfv4nf+jWkYtk5m6YJOpaqxfhr1Oqg6jAW0Iu0eyvLaMefLykW+IGSwWvBENjIN4IJM8oEp/ep+K6DIdWXPy5NCGz/1rT7Hian1HJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OZ/imxoC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gDMMPwam; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bl5NLvN3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cX0r4Wo4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D2081F825;
	Fri,  5 Jul 2024 08:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720167806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLtPACuyicMzM8L2XKlTR6VN0t+Eo9WHFN3dKtYcoHE=;
	b=OZ/imxoC8Z3yhy6gixLaOBAJEUHcYpvKIYqAzkbENK4pS8czifwsnpO+AVhbTn+EGCxe6t
	MShgx9KngbBPaUV+m9iVxL9kFJRRQfl31MkubRBXg1pZ6BBRw8HXMS3qTEETtcJx0HzyZv
	wQPL8Y+t+wUF3wFNno6Jcl8Pin0DU8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720167806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLtPACuyicMzM8L2XKlTR6VN0t+Eo9WHFN3dKtYcoHE=;
	b=gDMMPwam/wTLH6Ahz80ULWZ/qMEtuqUGIlHpERrkssPdUSWoeBmfy+yejDwmFQbTJqFnrG
	lXh+2Uhs5BZWfzCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bl5NLvN3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cX0r4Wo4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720167805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLtPACuyicMzM8L2XKlTR6VN0t+Eo9WHFN3dKtYcoHE=;
	b=bl5NLvN309i5e3hSUbBdhcy/TkAJPdyGTg6RIybAITHQcAePz94lnuoFIrnHvcJ0cUsiH2
	91y6bCVa0JtCDKH5Y1PDd1pJKOa0R5Aq0AvIKs73GwO0QgpsC3Wkmiac4TyA7a3KvbzB8e
	ZrJh9pLEeWlz9jgjoViZYXz57TSpXYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720167805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLtPACuyicMzM8L2XKlTR6VN0t+Eo9WHFN3dKtYcoHE=;
	b=cX0r4Wo4FhjSyC1hf5QriseOvj4VcJ80pjRvXMIEHV0vvAM1H6VObtMgO2qPmv56YyBBNV
	WLf42xuYVKAUi6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85B741396E;
	Fri,  5 Jul 2024 08:23:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kg79HXyth2a4OAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 05 Jul 2024 08:23:24 +0000
Message-ID: <efe5824c-3a05-4320-b8a1-85d22dbbf379@suse.de>
Date: Fri, 5 Jul 2024 11:23:15 +0300
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
X-Rspamd-Queue-Id: 5D2081F825
X-Spam-Score: -4.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[17];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi,

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

Why "swinit" reset is special in this series? For example previous 3/12
patch which add "bridge" reset does not use dev_err_probe.

IMO you should use dev_err() here and below, and make a new follow-up
patch which change dev_err -> dev_err_probe on all places where getting
resources like resets and clocks.

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

ditto

> +	}
> +	ret = reset_control_deassert(pcie->swinit);
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not de-assert reset 'swinit' after asserting\n");
> +		goto clk_out;

this is fine

> +	}
> +
>  	ret = reset_control_reset(pcie->rescal);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");

~Stan

