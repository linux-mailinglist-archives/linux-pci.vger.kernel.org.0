Return-Path: <linux-pci+bounces-20401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66911A1D55E
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 12:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FAE166F89
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 11:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1DA1FECBF;
	Mon, 27 Jan 2025 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0sWa5k9Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3iHIpuAB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0sWa5k9Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3iHIpuAB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7341FDE1E;
	Mon, 27 Jan 2025 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737977576; cv=none; b=RE9vXD5gb59yUAouvhBsTCSxkk4k3Ma+yraJipMhKCnknwyMk3mb441ThSOIqL6kZTWe5hPgMxiyQZo4Qc3492927/LLv7y4MCDin1ltCXbZNRP9vimw4bCXPJj3NTA061ptfJQpag4M+BSqPp1Y0SzdjAuNCobM2QoyN+CwjEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737977576; c=relaxed/simple;
	bh=y+vHtdTSJC4DjGyFpjQSejkmKcu/p6Kw/FabSI2N5kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIepXFt+EuDbmNIRO2WTltPZnnF9UKQekvHwftNiCPPB20nFzuNbuhZ1Nl0uLr5rPId7My0DNpNIQxc8PSSHLU4fMOd9XGRMbvczVUgnrlhTk/pnzguB3546aFeepd/9NiNPWiRmdfxX8XC/GpIRdME+duIInauRHTvEHvI5V0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0sWa5k9Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3iHIpuAB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0sWa5k9Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3iHIpuAB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 693C91F383;
	Mon, 27 Jan 2025 11:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737977572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+UeXUAFZ9jac5oktZG7LFtZi5Y22Ga8bFH0IEhCvRQ=;
	b=0sWa5k9YwfERVrJVLcAvbrvep4w+HQh6KtYygR5tyt1SbWVYDlTgu5wfsxGiTIRdFRgWdA
	KcoIh9llf6MTv5p+NUnM5m0WN9Yh5v6q7Zx3q++Qs1vZotYwr4a1UZJ8XQNar5vazajyku
	2EwMx/r48apRIutlVOu67IkHS6ahdUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737977572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+UeXUAFZ9jac5oktZG7LFtZi5Y22Ga8bFH0IEhCvRQ=;
	b=3iHIpuABV3QWSTxVHHP7aMW6Vy811/Y42l/axR6ce8XMPpUIkxzPH/JK11DQbFffB7MlD8
	TttF5h9HLnjjKFBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737977572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+UeXUAFZ9jac5oktZG7LFtZi5Y22Ga8bFH0IEhCvRQ=;
	b=0sWa5k9YwfERVrJVLcAvbrvep4w+HQh6KtYygR5tyt1SbWVYDlTgu5wfsxGiTIRdFRgWdA
	KcoIh9llf6MTv5p+NUnM5m0WN9Yh5v6q7Zx3q++Qs1vZotYwr4a1UZJ8XQNar5vazajyku
	2EwMx/r48apRIutlVOu67IkHS6ahdUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737977572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+UeXUAFZ9jac5oktZG7LFtZi5Y22Ga8bFH0IEhCvRQ=;
	b=3iHIpuABV3QWSTxVHHP7aMW6Vy811/Y42l/axR6ce8XMPpUIkxzPH/JK11DQbFffB7MlD8
	TttF5h9HLnjjKFBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 468E9137C0;
	Mon, 27 Jan 2025 11:32:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aWAxEeRul2ecawAAD6G6ig
	(envelope-from <iivanov@suse.de>); Mon, 27 Jan 2025 11:32:52 +0000
Date: Mon, 27 Jan 2025 13:32:51 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 -next 00/11] Add PCIe support for bcm2712
Message-ID: <20250127113251.b2tqacoalcjrtcap@localhost.localdomain>
References: <20250120130119.671119-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120130119.671119-1-svarbanov@suse.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,broadcom.com,linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi Stan,

On 01-20 15:01, Stanimir Varbanov wrote:
> 
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

Thanks! This works fine.

Tested-by: Ivan T. Ivanov <iivanov@suse.de>


