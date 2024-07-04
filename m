Return-Path: <linux-pci+bounces-9800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1BF9276CF
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 15:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1444D285B14
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 13:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CEF1AC221;
	Thu,  4 Jul 2024 13:05:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2692F7E9;
	Thu,  4 Jul 2024 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098331; cv=none; b=f9LQz3HmlFKzUoVvrB9IhVlwnpHqqk92TnXt2TDBIWDVigK+HL2V8p+rC2KZvoxc5Tz3GZXID8WdU/5/vJj5MqUkoFGcGfhwXNIVa+foUXIIJp46DHoX3Tz0Pzbb8H3bLLNKtplnhedXttJhgoz2bUIIw6roRFlTf8zW7wr47XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098331; c=relaxed/simple;
	bh=RQk7tE0/w5gVbSYZXfznfyC1ncfi65f6dAeeTU+5b1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQuhcz/zov1E1WZjGbJnCpjJrFk6zFXZYLyvmcPlg50rGUp8CkaGLvLIQxUbjw9a3sbwn1rd1N7wPT/2fE8yfEbRx05vqbxf6VvjGf0zIa+BqRNlBQV+uzxFuRrM+ax0HOGMmiwTmiRzZuavn7B0YPSWYSDm44ohd0BEMnYKQ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D3FA211E5;
	Thu,  4 Jul 2024 13:05:28 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9354513889;
	Thu,  4 Jul 2024 13:05:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aU6OIReehmY0GQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 04 Jul 2024 13:05:27 +0000
Message-ID: <8e21c868-2409-4260-9b56-6feb0eea512a@suse.de>
Date: Thu, 4 Jul 2024 16:05:27 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG,
 INTR2_CPU_BASE offsets SoC-specific
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
 <20240703180300.42959-7-james.quinlan@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240703180300.42959-7-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 6D3FA211E5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Hi Jim,

On 7/3/24 21:02, Jim Quinlan wrote:
> Our HW design has again changed a register offset which used to be standard
> for all Broadcom SOCs with PCIe cores.  This difference is now reconciled
> for the registers HARD_DEBUG and INTR2_CPU_BASE.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 33 +++++++++++++++++----------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 59daa4b2e6c5..d8c0f1474369 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -122,7 +122,6 @@
>  #define PCIE_MEM_WIN0_LIMIT_HI(win)	\
>  		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
>  
> -#define PCIE_MISC_HARD_PCIE_HARD_DEBUG					0x4204
>  #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
>  #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK		0x200000
>  #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
> @@ -131,9 +130,9 @@
>  	  (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
>  	   PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
>  
> -#define PCIE_INTR2_CPU_BASE		0x4300
>  #define PCIE_MSI_INTR2_BASE		0x4500
> -/* Offsets from PCIE_INTR2_CPU_BASE and PCIE_MSI_INTR2_BASE */
> +
> +/* Offsets from INTR2_CPU and MSI_INTR2 BASE offsets */
>  #define  MSI_INT_STATUS			0x0
>  #define  MSI_INT_CLR			0x8
>  #define  MSI_INT_MASK_SET		0x10
> @@ -187,6 +186,8 @@
>  #define IDX_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_INDEX])
>  #define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
>  #define PCIE_RGR1_SW_INIT_1(pcie)	(pcie->reg_offsets[RGR1_SW_INIT_1])
> +#define	HARD_DEBUG(pcie)		(pcie->reg_offsets[PCIE_HARD_DEBUG])
> +#define	INTR2_CPU_BASE(pcie)		(pcie->reg_offsets[PCIE_INTR2_CPU_BASE])
>  

Drop the tab before HARD_DEBUG & INTR2_CPU_BASE. Also checkpatch should
complain about missing brackets around pcie:

#define	HARD_DEBUG(pcie) ((pcie)->reg_offsets[PCIE_HARD_DEBUG])

~Stan

