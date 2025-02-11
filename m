Return-Path: <linux-pci+bounces-21166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1D3A31010
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 16:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 245787A061E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 15:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479FF1F1527;
	Tue, 11 Feb 2025 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F2unZw7G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/E8DrGDJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F2unZw7G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/E8DrGDJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9661C5D40;
	Tue, 11 Feb 2025 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288752; cv=none; b=EkLDRXmlc7wCP2B4Wd+aPpO3XCU69YylfrJHWkQyjVRgzxDrskkGp2RlURzTKh72bdKxwFQxy/m+mcANSguwE8EE8Rw6+o8wO+WaK9SQXIj2TWJ9thWR2kJHgdOn5M/kLEfffSxjWI1Gh714vJxF/bN+adnl7fGZZ3cP7Bde1qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288752; c=relaxed/simple;
	bh=YH9L8BAvGg8Ojm7t/vF2VDWs1nrhICjErmvv7ZpWAA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7gDxELE8BwkuXdc2rRmWDcxwUdNoXqe7szahGloJGdFw/9Snmp/5KM2oLhz0kzjNGB3eKEvbmR0fylGdCrYtyeD7hmT+Ij769gjchIu+6OxQ1KsHtGWK13ZCAIP6pUOzsFginm1MpmVEXVP1Ly80aLdK/912HHh3ZnXMQB3KTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F2unZw7G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/E8DrGDJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F2unZw7G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/E8DrGDJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50D1635353;
	Tue, 11 Feb 2025 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739280628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C23Gwwkn7m1Wdwav9p34gnuQqrDiAzm3UcBEGEmFUh0=;
	b=F2unZw7G8aguyoj/n2LjlG1oaHG8LPWWa8jgBjJqM+RuaqrhZi5VGv2xCXiiT5Ss/Ml0Ts
	O54ks37bGh0wkaiAw3eTUAgIgG1G2dKdjKXED/toW8ns+VQ/dseMTWyJeNBt3sXTu+NqV4
	J4qyIilZuZMQmGQIi4NFAZN02Xdh3/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739280628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C23Gwwkn7m1Wdwav9p34gnuQqrDiAzm3UcBEGEmFUh0=;
	b=/E8DrGDJ7w/U26RXWQV2J3Hir2AvbD69OWCrorjvdSGGAw4xZ3mRwhBthVYARewb5EkM7E
	LXQRKZkVENd0zEBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739280628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C23Gwwkn7m1Wdwav9p34gnuQqrDiAzm3UcBEGEmFUh0=;
	b=F2unZw7G8aguyoj/n2LjlG1oaHG8LPWWa8jgBjJqM+RuaqrhZi5VGv2xCXiiT5Ss/Ml0Ts
	O54ks37bGh0wkaiAw3eTUAgIgG1G2dKdjKXED/toW8ns+VQ/dseMTWyJeNBt3sXTu+NqV4
	J4qyIilZuZMQmGQIi4NFAZN02Xdh3/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739280628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C23Gwwkn7m1Wdwav9p34gnuQqrDiAzm3UcBEGEmFUh0=;
	b=/E8DrGDJ7w/U26RXWQV2J3Hir2AvbD69OWCrorjvdSGGAw4xZ3mRwhBthVYARewb5EkM7E
	LXQRKZkVENd0zEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BC6613AA6;
	Tue, 11 Feb 2025 13:30:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rjLlC/NQq2exOQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 11 Feb 2025 13:30:27 +0000
Message-ID: <a74f5917-af94-42a1-9a7a-dd449d34dbfc@suse.de>
Date: Tue, 11 Feb 2025 15:30:22 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 -next 00/11] Add PCIe support for bcm2712
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250120130119.671119-1-svarbanov@suse.de>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20250120130119.671119-1-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,broadcom.com,gmail.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Bjorn,

Do I need to send a new version with the collected Acked/Reviewed tags?

Thanks,
~Stan

On 1/20/25 3:01 PM, Stanimir Varbanov wrote:
> Here is v5 of the series which aims to add support for PCIe on bcm2712 SoC
> used by RPi5. Previous v4 can be found at [1].
> 
> Based the series on linux-next because of vc4 gpu node in bcm2712.dtsi.
> 
> v4 -> v5 changes include:
>  - Addressed comments to interrupt-controller driver. (Thomas)
>  - Fixed DTB warnings  broadcom/bcm2712-rpi-5-b.dtb.
>  - New patch in the series to fix missing of_node_put.
>  - New patch to make a softdep to a MIP MSI-X driver.
>  - Dropped the patch which adds MSI-X support in pcie-brcmstb driver,
>    and instead use DT dma-ranges to pass the needed information. (Jim)
> 
> For more detailed info check patches.
> 
> Comments are welcome!
> ~Stan
> 
> [1] https://patchwork.kernel.org/project/linux-pci/cover/20241025124515.14066-1-svarbanov@suse.de/
> 
> Stanimir Varbanov (11):
>   dt-bindings: interrupt-controller: Add bcm2712 MSI-X DT bindings
>   dt-bindings: PCI: brcmstb: Update bindings for PCIe on bcm2712
>   irqchip: Add Broadcom bcm2712 MSI-X interrupt controller
>   PCI: brcmstb: Reuse config structure
>   PCI: brcmstb: Expand inbound window size up to 64GB
>   PCI: brcmstb: Add bcm2712 support
>   PCI: brcmstb: Adjust PHY PLL setup to use a 54MHz input refclk
>   PCI: brcmstb: Adding a softdep to MIP MSI-X driver
>   PCI: brcmstb: Fix for missing of_node_put
>   arm64: dts: broadcom: bcm2712: Add PCIe DT nodes
>   arm64: dts: broadcom: bcm2712-rpi-5-b: Enable PCIe DT nodes
> 
>  .../brcm,bcm2712-msix.yaml                    |  60 ++++
>  .../bindings/pci/brcm,stb-pcie.yaml           |   6 +-
>  .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |   8 +
>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 147 +++++++++
>  drivers/irqchip/Kconfig                       |  16 +
>  drivers/irqchip/Makefile                      |   1 +
>  drivers/irqchip/irq-bcm2712-mip.c             | 292 ++++++++++++++++++
>  drivers/pci/controller/pcie-brcmstb.c         | 147 ++++++---
>  8 files changed, 632 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
>  create mode 100644 drivers/irqchip/irq-bcm2712-mip.c
> 


