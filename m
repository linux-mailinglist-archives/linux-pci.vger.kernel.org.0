Return-Path: <linux-pci+bounces-10269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 983FC93164C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 16:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245E41F2228B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C101218C166;
	Mon, 15 Jul 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xQNMTknN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s96+alHR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PoxUaKoI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5NYjoUQo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FC21836D4;
	Mon, 15 Jul 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052087; cv=none; b=gDcKey1irBbzxTfS+t2bFxskteskkd641m5iqy1CqpNSHxrx0WvFQPyqYxeiZ3n3/nGSQW4K9gA4Z8BGRKLT14Nob4BnUY3xA3yk9DMASpQskZL9IiK96+iZLXEbScrTI/SSFSrTXdgavuaObuoIlTzpNpvDdVq2GGXH0wcc7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052087; c=relaxed/simple;
	bh=OUBXN9lElVgsA0EjOPFCnq2S7IJgOAnZ+ok3Nr+msNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kC2VjDqUSWrKP7mJjnssd3RJcxJrOKDKjEjl9MxDS0Cdt7LBitXAW054jrcUckdhvk6OVX6oMkuHSxm9xyXEXlGjtuqGx26+tPrKy/ePaWoG/ECGxInsdLfm2Kvf+Ltuoq2me6F/sozzXSOjAUCqvJb2lP1v6/px1T6p2b/uIxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xQNMTknN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s96+alHR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PoxUaKoI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5NYjoUQo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE74F21BBE;
	Mon, 15 Jul 2024 14:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721052084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Zn/o0vWxJvI8uafBBDslyWACdzZ+2xD3hQW8mRKVxU=;
	b=xQNMTknNXhDPj8wSl2RpchGQCVZCMmL86IgH8AA6wiq+e8hprw10ZoOKUexZDbaD9/UxVQ
	WCSx8QAMS51wdhrjA+rlokIM/LJFp/InRp5HORWqo7L3I2xP5reSIGwplrThhzlG5QV9M0
	Eohgg0HuqUYFfV12zhTPysZHg8WRUvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721052084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Zn/o0vWxJvI8uafBBDslyWACdzZ+2xD3hQW8mRKVxU=;
	b=s96+alHRnsGOJu+qVcpxR42UwIaZakk0kFuVH3/M559MzBvGNrqHeLQU+w+eNyoeRWhgjv
	TvX6OifyXnQv/qCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721052083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Zn/o0vWxJvI8uafBBDslyWACdzZ+2xD3hQW8mRKVxU=;
	b=PoxUaKoIOc3p0GhFr6usKFy5dhk6g6kuz5m+nQaXZPumXbBUAzGZSoFm4XoLOuzBhE1b1i
	+BhEAq+4LWTS5hKdvGHSLXkiFF6YyFDo9XoFFNcbt/Zyi22SVlLiIsIcGsgh4SS0CKib6Y
	rPNCKtor8pdCPw1vPXF88SI6UfeORuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721052083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Zn/o0vWxJvI8uafBBDslyWACdzZ+2xD3hQW8mRKVxU=;
	b=5NYjoUQoArWFelRw52kCH0VQ00Fpvg9Mck9JGGZgNTdo4L7WT5CMBAMZaqACgjQi2Uji1N
	OCW6kM9tBdpPFqAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F9A9137EB;
	Mon, 15 Jul 2024 14:01:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SINeAbMrlWaHYAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 15 Jul 2024 14:01:23 +0000
Message-ID: <dd95d25c-4bea-4019-a5e4-e68f359516ef@suse.de>
Date: Mon, 15 Jul 2024 17:01:18 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] PCI: brcmstb: Check return value of all
 reset_control_xxx calls
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
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
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
 <20240710221630.29561-11-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240710221630.29561-11-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -0.29
X-Spamd-Result: default: False [-0.29 / 50.00];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Level: 



On 7/11/24 01:16, Jim Quinlan wrote:
> In some cases the result of a reset_control_xxx() call have been ignored.
> Now we check all return values of such functions and propagate the error to
> the next level.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 100 ++++++++++++++++++--------
>  1 file changed, 71 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c44a92217855..c334cc427fb7 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -232,8 +232,8 @@ struct pcie_cfg_data {
>  	const enum pcie_type type;
>  	const bool has_phy;
>  	unsigned int num_inbound;
> -	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
> -	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> +	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
> +	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>  };
>  
>  struct subdev_regulators {
> @@ -278,8 +278,8 @@ struct brcm_pcie {
>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> -	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
> -	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> +	int			(*perst_set)(struct brcm_pcie *pcie, u32 val);
> +	int			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>  	struct subdev_regulators *sr;
>  	bool			ep_wakeup_capable;
>  	bool			has_phy;
> @@ -742,13 +742,18 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
>  	return base + DATA_ADDR(pcie);
>  }
>  
> -static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
> +static int brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>  {
> +	int ret = 0;
> +
>  	if (pcie->bridge) {
>  		if (val)
> -			reset_control_assert(pcie->bridge);
> +			ret = reset_control_assert(pcie->bridge);
>  		else
> -			reset_control_deassert(pcie->bridge);
> +			ret = reset_control_deassert(pcie->bridge);
> +		if (ret)
> +			dev_err(pcie->dev, "failed to %s 'bridge' reset, err=%d\n",
> +				val ? "assert" : "deassert", ret);
>  	} else {
>  		u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
>  		u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> @@ -757,9 +762,10 @@ static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val
>  		tmp = (tmp & ~mask) | ((val << shift) & mask);
>  		writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>  	}

In case you sending new version, please add a blank like here.

Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>

~Stan

> +	return ret;
>  }
>  

