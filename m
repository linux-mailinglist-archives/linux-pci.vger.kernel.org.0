Return-Path: <linux-pci+bounces-11397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4228C949BAF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 00:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F156728343E
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 22:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D68B3FE55;
	Tue,  6 Aug 2024 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XfiABRtP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0xGv57f+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tY9hLgOR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4c5OUOTa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A93BB30;
	Tue,  6 Aug 2024 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985139; cv=none; b=o5+VLJEmzJyq5SU7ZC8jDIl08jdFRuoxGECGAFOdF7TZ/9FpjqEJVyujFR55UDOMhHz/NUvE5cn3XE8j5U/a+iTr6gnRciZ7wF80rR2ohb09mFpm1JLmbmkZSVQJg9R8WhP0wXzS32+y2Jee9FGti90BPtrgYTYexoqCtplJyes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985139; c=relaxed/simple;
	bh=KWj+SAl+YekNZVSswavwZEirGV4//jriXP7kbZSgpyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsUs0z1CaJidbmkySA3w4P//HOMHlcFop9Uk05jHiWaDLhoGPvUJ/p0ROGwlzYot6tyNIB0PUyim4jtHfIL0nQqHNMUa8+YNfV7H776luxQECOMYVmf8FKGj9Qcz2YapFgd9xEjDEAAdeOZG+aQdps2tZVd5HFk7LLkn358Mm9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XfiABRtP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0xGv57f+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tY9hLgOR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4c5OUOTa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4F9B21B3C;
	Tue,  6 Aug 2024 22:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722985135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1A3iGNjuoT+XHTMcslcpXcWmw5DrEYfcY8wDXr2okuc=;
	b=XfiABRtPLMaHoRKQvphIx87RFTwwZ96BmDDotBBciJcSmFJvmL643zjI5j4T8mcCNiqRjJ
	VtgdVAnqPB+2bytm9R5jMiqBATk2sv960iTx6egBvN45KkII+J+CqXvQslmJnWwK2wr5Am
	KaIJVIwhsPNccUGeaf1/V7Wd+T0fPN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722985135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1A3iGNjuoT+XHTMcslcpXcWmw5DrEYfcY8wDXr2okuc=;
	b=0xGv57f+ST5tsYhRF5HPbqAYNklf66PVC3JreycYkjYme1z/xlPRAACiW6+OSXlo1HAkn0
	Vh5eFsL6X4hURsCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tY9hLgOR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4c5OUOTa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722985134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1A3iGNjuoT+XHTMcslcpXcWmw5DrEYfcY8wDXr2okuc=;
	b=tY9hLgORSZWdKE/1VN35p5+YFWUtBBfM3zFMZto9hSp8qF4PYHBgY9mVm9O7Sdbj0q1K4W
	QpkaaXkuwkrO6/AQDNkwLBKzecVgRE5zcYJJ+J4B6UuqrU2EUyvHxja0IaKq0FyFavqkVh
	vKytt6wUbD+VKUXSgAj6IoLBJzZMuHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722985134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1A3iGNjuoT+XHTMcslcpXcWmw5DrEYfcY8wDXr2okuc=;
	b=4c5OUOTaNy0e5NXA6RaD5Lox8c/6hOqMYWa0soNq7ycTHRw3vPifWGax4RY0MghhsH1unr
	lxGb4weWr95yCCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED7CD13770;
	Tue,  6 Aug 2024 22:58:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CyDHN62qsmbEZAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 06 Aug 2024 22:58:53 +0000
Message-ID: <c77b6011-68e8-467c-9218-4fd4aa3e4ee3@suse.de>
Date: Wed, 7 Aug 2024 01:58:53 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] PCI: brcmstb: Refactor for chips with many
 regular inbound windows
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
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-10-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240731222831.14895-10-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -4.50
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C4F9B21B3C
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,kernel.org,google.com,arm.com,debian.org,suse.de,linaro.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi Jim,


On 8/1/24 01:28, Jim Quinlan wrote:
> Provide support for new chips with multiple inbound windows while
> keeping the legacy support for the older chips.
> 
> In existing chips there are three inbound windows with fixed purposes: the
> first was for mapping SoC internal registers, the second was for memory,
> and the third was for memory but with the endian swapped.  Typically, only
> one window was used.
> 
> Complicating the inbound window usage was the fact that the PCIe HW would
> do a baroque internal mapping of system memory, and concatenate the regions
> of multiple memory controllers.
> 
> Newer chips such as the 7712 and Cable Modem SOCs take a step forward and
> drop the internal mapping while providing for multiple inbound windows.
> This works in concert with the dma-ranges property, where each provided
> range becomes an inbound window.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 228 ++++++++++++++++++++------
>  1 file changed, 177 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 4659208ae8da..0ecca3d9576f 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -75,15 +75,19 @@
>  #define PCIE_MEM_WIN0_HI(win)	\
>  		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 8)
>  
> +/*
> + * NOTE: You may see the term "BAR" in a number of register names used by
> + *   this driver.  The term is an artifact of when the HW core was an
> + *   endpoint device (EP).  Now it is a root complex (RC) and anywhere a
> + *   register has the term "BAR" it is related to an inbound window.
> + */
> +
> +#define PCIE_BRCM_MAX_INBOUND_WINS			16
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
> @@ -130,6 +134,10 @@
>  	  (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
>  	   PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
>  
> +#define PCIE_MISC_UBUS_BAR1_CONFIG_REMAP			0x40ac
> +#define  PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK	BIT(0)
> +#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP			0x410c
> +
>  #define PCIE_MSI_INTR2_BASE		0x4500
>  
>  /* Offsets from INTR2_CPU and MSI_INTR2 BASE offsets */
> @@ -217,12 +225,20 @@ enum pcie_type {
>  	BCM4908,
>  	BCM7278,
>  	BCM2711,
> +	BCM7712,
> +};
> +
> +struct inbound_win {
> +	u64 size;
> +	u64 pci_offset;
> +	u64 cpu_addr;
>  };
>  
>  struct pcie_cfg_data {
>  	const int *offsets;
>  	const enum pcie_type type;
>  	const bool has_phy;
> +	unsigned int num_inbound_wins;
>  	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
>  	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
>  };
> @@ -274,6 +290,7 @@ struct brcm_pcie {
>  	struct subdev_regulators *sr;
>  	bool			ep_wakeup_capable;
>  	bool			has_phy;
> +	int			num_inbound_wins;

Could you unify the type of num_inbound_wins field. I think u8 should be
enough?

>  };
>  
>  static inline bool is_bmips(const struct brcm_pcie *pcie)
> @@ -789,23 +806,61 @@ static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
>  	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>  }
>  
> -static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
> -							u64 *rc_bar2_size,
> -							u64 *rc_bar2_offset)
> +static inline void set_bar(struct inbound_win *b, int *count, u64 size,

The number of BARs cannot be more than 256, could you make "count" an u8
like the num_inbound_wins.

> +			   u64 cpu_addr, u64 pci_offset)
> +{
> +	b->size = size;
> +	b->cpu_addr = cpu_addr;
> +	b->pci_offset = pci_offset;
> +	(*count)++;
> +}
> +

<cut>

In case you send a new version please address the comments, otherwise

Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>

~Stan

