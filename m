Return-Path: <linux-pci+bounces-14481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06C299D404
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82A3AB254F4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97571C0DCB;
	Mon, 14 Oct 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i1RkyCDs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rECCMoVh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i1RkyCDs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rECCMoVh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8E83A14;
	Mon, 14 Oct 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920470; cv=none; b=nmHwiNMV52WmGlNuWVYSK6gr1J6oBPAoyA2kJ0KBNwYOXF2XEAu9c/eo1XvP+hBPJfBQoWLrURIFdxmu64zI5rqF7Fn9lar8QoK13VdzsFhDtXhzJKu1LWxCp3nV+bfG1oZ9hkktLvAmPBO+oH+J+jFJ9yGRe/vQJPlBQS/4znw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920470; c=relaxed/simple;
	bh=+VBu3zagKcK6w+UgcxicDjXDUho5UjsJmz0KtxTye6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQ3jTnrWf8XYDdrMEKfb79OwYObjzmXfoSPbVPGZez+9GkOvf4o21WPMynmpTehC1hvtuj90gcVXTgzIoMucGCD8+pizsMcN7Qdn0dEkCJ2AJDcbJk1boMxjdm749pGhrPWmGTq+ycumR/9ODyGAdq7hT12+ffD3LeUkhjcX9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i1RkyCDs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rECCMoVh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i1RkyCDs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rECCMoVh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1637C1F80B;
	Mon, 14 Oct 2024 15:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728920467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWLVJk3sxq76pmdkakLZ23+Lq6++B+EeSNXoL3gBhsU=;
	b=i1RkyCDs99yzTOAWQjhH4Bc1yEMagxKMLapWBgkOnW+UdFKJygNA1GN36AzLqi6tYj5sq6
	pERNfQ/2MDpiTYMr5BmaUnXs+saFgv3tcqx09f1xZJGcb7zhYOPPBJvikdRhSmSJjyLWyU
	+N4/1I05dcKHRanLIklrYWy8W6jupP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728920467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWLVJk3sxq76pmdkakLZ23+Lq6++B+EeSNXoL3gBhsU=;
	b=rECCMoVhtfQFX2DilrjBgvvluiKQL04hU9i+iM1XueOHmt4ibg8lfbWJGCXlToPdt2QSpN
	gHUb33abFAH4kiAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i1RkyCDs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rECCMoVh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728920467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWLVJk3sxq76pmdkakLZ23+Lq6++B+EeSNXoL3gBhsU=;
	b=i1RkyCDs99yzTOAWQjhH4Bc1yEMagxKMLapWBgkOnW+UdFKJygNA1GN36AzLqi6tYj5sq6
	pERNfQ/2MDpiTYMr5BmaUnXs+saFgv3tcqx09f1xZJGcb7zhYOPPBJvikdRhSmSJjyLWyU
	+N4/1I05dcKHRanLIklrYWy8W6jupP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728920467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWLVJk3sxq76pmdkakLZ23+Lq6++B+EeSNXoL3gBhsU=;
	b=rECCMoVhtfQFX2DilrjBgvvluiKQL04hU9i+iM1XueOHmt4ibg8lfbWJGCXlToPdt2QSpN
	gHUb33abFAH4kiAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C98813A51;
	Mon, 14 Oct 2024 15:41:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E5GYO5E7DWctfgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 14 Oct 2024 15:41:05 +0000
Message-ID: <c3546c71-46d9-4999-8e53-8e8babd4bb35@suse.de>
Date: Mon, 14 Oct 2024 18:41:01 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] Add PCIe support for bcm2712
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Stanimir Varbanov <svarbanov@suse.de>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Jonathan Bell <jonathan@raspberrypi.com>, Jim Quinlan
 <jim2101024@gmail.com>, linux-rpi-kernel@lists.infradead.org, kw@linux.com,
 Andrea della Porta <andrea.porta@suse.com>, devicetree@vger.kernel.org,
 Phil Elwell <phil@raspberrypi.com>, Thomas Gleixner <tglx@linutronix.de>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Conor Dooley <conor+dt@kernel.org>
References: <20241014130710.413-1-svarbanov@suse.de>
 <172891445648.1127418.3673645217921706886.robh@kernel.org>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <172891445648.1127418.3673645217921706886.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1637C1F80B
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,google.com,vger.kernel.org,raspberrypi.com,gmail.com,lists.infradead.org,linux.com,suse.com,linutronix.de,pengutronix.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,devicetree.org:url]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO



On 10/14/24 17:05, Rob Herring (Arm) wrote:
> 
> On Mon, 14 Oct 2024 16:06:59 +0300, Stanimir Varbanov wrote:
>> Hello,
>>
>> Here is v3 the series to add support for PCIe on bcm2712 SoC
>> used by RPi5. Previous v2 can be found at [1].
>>
>> v2 -> v3 changes include:
>>  - Added Reviewed-by/Acked-by tags.
>>  - MIP MSI-X driver has been converted to MSI parent.
>>  - Added a new patch for PHY PLL adjustment need to succesfully
>>    enumerate PCIe endpoints on extension connector (tested with
>>    Pineboards AI Bundle + NVME SSD adapter card).
>>  - Re-introduced brcm,msi-offset DT private property for MIP
>>    interrupt-controller (without it I'm anable to use the interrupts
>>    of adapter cards on PCIe enxtension connector).
>>
>> For more info check patches.
>>
>> [1] https://patchwork.kernel.org/project/linux-pci/cover/20240910151845.17308-1-svarbanov@suse.de/
>>
>> Stanimir Varbanov (11):
>>   dt-bindings: interrupt-controller: Add bcm2712 MSI-X DT bindings
>>   dt-bindings: PCI: brcmstb: Update bindings for PCIe on bcm2712
>>   irqchip: mip: Add Broadcom bcm2712 MSI-X interrupt controller
>>   PCI: brcmstb: Expand inbound size calculation helper
>>   PCI: brcmstb: Enable external MSI-X if available
>>   PCI: brcmstb: Avoid turn off of bridge reset
>>   PCI: brcmstb: Add bcm2712 support
>>   PCI: brcmstb: Reuse config structure
>>   PCI: brcmstb: Adjust PHY PLL setup to use a 54MHz input refclk
>>   arm64: dts: broadcom: bcm2712: Add PCIe DT nodes
>>   arm64: dts: broadcom: bcm2712-rpi-5-b: Enable PCIe DT nodes
>>
>>  .../brcm,bcm2712-msix.yaml                    |  60 ++++
>>  .../bindings/pci/brcm,stb-pcie.yaml           |   5 +-
>>  .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |   8 +
>>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 160 +++++++++
>>  drivers/irqchip/Kconfig                       |  16 +
>>  drivers/irqchip/Makefile                      |   1 +
>>  drivers/irqchip/irq-bcm2712-mip.c             | 308 ++++++++++++++++++
>>  drivers/pci/controller/pcie-brcmstb.c         | 197 ++++++++---
>>  8 files changed, 707 insertions(+), 48 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
>>  create mode 100644 drivers/irqchip/irq-bcm2712-mip.c
>>
>> --
>> 2.43.0
>>
>>
>>
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y broadcom/bcm2712-rpi-5-b.dtb' for 20241014130710.413-1-svarbanov@suse.de:

Sorry about that. I forgot to update brcm,stb-pcie.yaml schema for
number of resets.

~Stan

> 
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@100000: resets: [[12, 42], [13]] is too short
> 	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@100000: reset-names:0: 'rescal' was expected
> 	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@100000: reset-names:1: 'bridge' was expected
> 	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@100000: reset-names: ['bridge', 'rescal'] is too short
> 	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@110000: 'msi-controller' is a required property
> 	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@110000: resets: [[12, 43], [13]] is too short
> 	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@110000: reset-names:0: 'rescal' was expected
> 	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@110000: reset-names:1: 'bridge' was expected
> 	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@110000: reset-names: ['bridge', 'rescal'] is too short
> 	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@120000: 'msi-controller' is a required property
> 	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@120000: resets: [[12, 44], [13]] is too short
> 	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@120000: reset-names:0: 'rescal' was expected
> 	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@120000: reset-names:1: 'bridge' was expected
> 	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@120000: reset-names: ['bridge', 'rescal'] is too short
> 	from schema $id: http://devicetree.org/schemas/pci/brcm,stb-pcie.yaml#
> 
> 
> 
> 
> 

