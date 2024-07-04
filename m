Return-Path: <linux-pci+bounces-9821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE626927E44
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 22:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DEFB28341E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 20:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1FB45000;
	Thu,  4 Jul 2024 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LSUU4jt7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gt5746Pj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pQ78c23w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hMHRGD1q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4D2BCF6;
	Thu,  4 Jul 2024 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720124264; cv=none; b=LzM2axN2G76lRr8/EhsMhD957z9Qcxv9ZX/3gdCPb0swZFWzBZ0fCGso3PRB2+T9gtSdQ0Vy8+ur/Cr8yN9E0BRWu/wMtF65EmXYcwz3dXIFE1eaVYVbM7ZkLrwGqrRf8w+4y3JJXulz6cJ5gCMK/3IqpgoY7UR1aXTQexcFH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720124264; c=relaxed/simple;
	bh=aPS529UnB7EmMrhnyLAWwkwIUUmMaXMl9CHOyB7UieQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFDHMFUfTCuu6qjqSNi5XHH+lMoW0qOqcsRNh9G9O/cFjsBVgz76PEx6ImgMeBajv+O6W0Sodu3ag+XTwGYtSn1CSe1ZR1kPPsGn8Memvt1wMHv05OL2Y3crk2J+EV7kGnbm8i0/q+z0fT/FLMgGuudVQLRZaHbq2/b2JoV+ynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LSUU4jt7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gt5746Pj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pQ78c23w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hMHRGD1q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6D4221B59;
	Thu,  4 Jul 2024 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720124259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHOCWE3EkhiNlL1wxuvq4tBlp7GGItSDi5bJBhDYXuI=;
	b=LSUU4jt7Yz+Lfj6s/xdgwJizkfQWnDJv8cu47oYTtpSk4jwXsCTQUevr8psghqx04QQC0i
	+QQ86sSD7jFXL2J/zATBToJBxtkGic73XN8/2GWl8bDzHYdMUOMu0SKKqKTxpvbwzpW5Fw
	/i7rWfJIACtI+9h9BaoBePPXcUzV2TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720124259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHOCWE3EkhiNlL1wxuvq4tBlp7GGItSDi5bJBhDYXuI=;
	b=gt5746PjnRm7GZmMg4sw7kAzfqUXDshMAlM6y314VBHiZi/c8ZxwB4axsDyt/uSLVX6y9t
	z4LJyf1Z7VehjbBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720124258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHOCWE3EkhiNlL1wxuvq4tBlp7GGItSDi5bJBhDYXuI=;
	b=pQ78c23wqqTk3xkf/Ew1f6CzX2t+4g6x2XSEHXCwZYhN7Q/hGms95+9m697d4AVoqxkDEZ
	PcmbwklUnWaxpU+BGaos5mhGOvSNEZRdu6zvbsRYx94dVebR3L5NZl0wHf995DMB5UGgv+
	K2Tfi/TeoAOiId+U/B7jGbsQawDUjCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720124258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHOCWE3EkhiNlL1wxuvq4tBlp7GGItSDi5bJBhDYXuI=;
	b=hMHRGD1qkKymzqBVFSLVcyk/SZf+JAfwEm912j15nMRel0PFP/UaBJ7pkWCsc+IDy+YluX
	2jbSFgm1l9Zy2hAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14DBA1369F;
	Thu,  4 Jul 2024 20:17:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X6zZAWIDh2ZDCgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 04 Jul 2024 20:17:38 +0000
Message-ID: <ffbf19f4-d213-4133-84a9-02bbf760b925@suse.de>
Date: Thu, 4 Jul 2024 23:17:37 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] PCI: brcmstb: Refactor for chips with many
 regular inbound BARs
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
 <20240703180300.42959-10-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240703180300.42959-10-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]

Hi Jim,

On 7/3/24 21:02, Jim Quinlan wrote:
> Previously, our chips provided three inbound "BARS" with fixed purposes:
> the first was for mapping SOC registers, the second was for memory, and the
> third was for memory but with the endian swapped.  We typically only used
> one of these BARs.
> 
> Complicating that BARs usage was the fact that the PCIe HW would do a
> baroque internal mapping of system memory, and concatenate the regions of
> multiple memory controllers.
> 
> Newer chips such as the 7712 and Cable Modem SOCs have taken a step forward
> and now provide multiple inbound BARs.  This works in concert with the
> dma-ranges property, where each provided range becomes an inbound BAR.
> 
> This commit provides support for these new chips and their multiple
> inbound BARs but also keeps the legacy support for the older system.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 199 +++++++++++++++++++-------
>  1 file changed, 150 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index ffb3e8d8fb2a..5f632fdc0052 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -75,15 +75,12 @@
>  #define PCIE_MEM_WIN0_HI(win)	\
>  		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 8)
>  
> +#define PCIE_BRCM_MAX_RC_BARS				16
>  #define PCIE_MISC_RC_BAR1_CONFIG_LO			0x402c
>  #define  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK		0x1f
>  
> -#define PCIE_MISC_RC_BAR2_CONFIG_LO			0x4034
> -#define  PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK		0x1f
> -#define PCIE_MISC_RC_BAR2_CONFIG_HI			0x4038
> +#define PCIE_MISC_RC_BAR4_CONFIG_LO			0x40d4
>  
> -#define PCIE_MISC_RC_BAR3_CONFIG_LO			0x403c
> -#define  PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK		0x1f
>  
>  #define PCIE_MISC_MSI_BAR_CONFIG_LO			0x4044
>  #define PCIE_MISC_MSI_BAR_CONFIG_HI			0x4048
> @@ -130,6 +127,10 @@
>  	  (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
>  	   PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
>  
> +#define PCIE_MISC_UBUS_BAR1_CONFIG_REMAP			0x40ac
> +#define  PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK	0x1

could you use BIT(0)

~Stan

