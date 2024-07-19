Return-Path: <linux-pci+bounces-10555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7137937AE2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 18:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611B11F20F0B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 16:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E89722071;
	Fri, 19 Jul 2024 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WR28BtXI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XaBU3Ga2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WR28BtXI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XaBU3Ga2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FB146D6E;
	Fri, 19 Jul 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406149; cv=none; b=e2oqMHXErB6vCprIUND0XB5D9jmgx1NLxmj++hfFC2JtkQtrNfoOv5u2RbkIEk4Dv9OtyJGb6EJqoQSXTgg2mLTSSSveVAS5NTgi/nX/HTzWUA0ddQ5U8Fhx9uinP9HDEOYFbmYMjYFJIyk8So+89Vn1cjb4CjDMn0AwIwcpekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406149; c=relaxed/simple;
	bh=C7TE/E7B0+CtxRe0AdNtSZinEtvs2Z+Qm9XvLJnGdjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHH+elqonPaACjoMImLDwgg1TCwY3xp21lTjSvp3Fo07m/u1Jvg8TOHYyWzWURhevbnaVX0r+wRvx0uI5x2uaVpHA/rkZqzt/g2EOw2/+LRDJwuo8VtVZ/o8rveX0oJRT/0L9mPgK6YsxF2QCmGIHriZYlosA4n+IyJSnavcliU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WR28BtXI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XaBU3Ga2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WR28BtXI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XaBU3Ga2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 560ED21198;
	Fri, 19 Jul 2024 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721406144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6bn1mAfzyBLUI6FeMOTT+noQDl0b3nyAwBkCg0rofg=;
	b=WR28BtXI6JYmVZDBOW6szdTcRnRxG34cIWtLD/WwtcuoE61TinL0nNZiLAUxhQfGpnS/S+
	5ZyL5/HIyNm9/d6RhLtg5hVXtSXspFzRQ8S4S7/KSf/CQRVeDfS/z2zlqXkwe/8KAkqWVA
	Os6u5F1pO2ZN2/j+rQqEQabp/EKCn94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721406144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6bn1mAfzyBLUI6FeMOTT+noQDl0b3nyAwBkCg0rofg=;
	b=XaBU3Ga27YwuE3MgOQHtzSgnGI2MJe1ggp/U6QxZ2ZxZhn2L6DgEn89+Q8ghL1soji9CVF
	ZOLYYKTUiNmbk9Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WR28BtXI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XaBU3Ga2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721406144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6bn1mAfzyBLUI6FeMOTT+noQDl0b3nyAwBkCg0rofg=;
	b=WR28BtXI6JYmVZDBOW6szdTcRnRxG34cIWtLD/WwtcuoE61TinL0nNZiLAUxhQfGpnS/S+
	5ZyL5/HIyNm9/d6RhLtg5hVXtSXspFzRQ8S4S7/KSf/CQRVeDfS/z2zlqXkwe/8KAkqWVA
	Os6u5F1pO2ZN2/j+rQqEQabp/EKCn94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721406144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6bn1mAfzyBLUI6FeMOTT+noQDl0b3nyAwBkCg0rofg=;
	b=XaBU3Ga27YwuE3MgOQHtzSgnGI2MJe1ggp/U6QxZ2ZxZhn2L6DgEn89+Q8ghL1soji9CVF
	ZOLYYKTUiNmbk9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5766413808;
	Fri, 19 Jul 2024 16:22:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +aFTEr+Smma7FQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 19 Jul 2024 16:22:23 +0000
Message-ID: <82472066-56a5-4f4f-8034-cf3a7afc206e@suse.de>
Date: Fri, 19 Jul 2024 19:22:22 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: interrupt-controller: Add bcm2712 MSI-X
 DT bindings
To: Rob Herring <robh@kernel.org>, Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20240626104544.14233-1-svarbanov@suse.de>
 <20240626104544.14233-2-svarbanov@suse.de>
 <20240628220521.GA274493-robh@kernel.org>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240628220521.GA274493-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.20 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,broadcom.com,linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email]
X-Spam-Level: 
X-Rspamd-Queue-Id: 560ED21198
X-Spam-Score: 0.20
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Bar: /

Hi Rob,

Thank you for the comments!

On 6/29/24 01:05, Rob Herring wrote:
> On Wed, Jun 26, 2024 at 01:45:38PM +0300, Stanimir Varbanov wrote:
>> Adds DT bindings for bcm2712 MSI-X interrupt peripheral controller.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>> ---
>>  .../brcm,bcm2712-msix.yaml                    | 74 +++++++++++++++++++
>>  1 file changed, 74 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
>> new file mode 100644
>> index 000000000000..ca610e4467d9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
>> @@ -0,0 +1,74 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interrupt-controller/brcm,bcm2712-msix.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Broadcom bcm2712 MSI-X Interrupt Peripheral support
>> +
>> +maintainers:
>> +  - Stanimir Varbanov <svarbanov@suse.de>
>> +
>> +description: >
>> +  This interrupt controller is used to provide intterupt vectors to the
> 
> typo

Will fix it.

> 
>> +  generic interrupt controller (GIC) on bcm2712. It will be used as
>> +  external MSI-X controller for PCIe root complex.
>> +
>> +allOf:
>> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - "brcm,bcm2712-mip-intc"
> 
> Don't need quotes. Nor 'items'. And enum can be 'const' 

OK.

> 
>> +  reg:
>> +    maxItems: 1
>> +    description: >
>> +      Specifies the base physical address and size of the registers
> 
> drop. That's *every* reg property.

OK.

> 
>> +
>> +  interrupt-controller: true
>> +
>> +  "#interrupt-cells":
>> +    const: 2
>> +
>> +  msi-controller: true
> 
> Add #msi-cells. The default is 0, but that's legacy.

OK.

> 
>> +
>> +  brcm,msi-base-spi:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: The SGI number that MSIs start.
>> +
>> +  brcm,msi-num-spis:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: The number of SGIs for MSIs.
>> +
>> +  brcm,msi-offset:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Shift the allocated MSIs up by N.
> 
> If only we had a property that every MSI controller seems to need. Go 
> check msi-controller.yaml...

This exists because the second instance of MIP MSI-X
interrupt-controller (mip1) has some limitations.

Snippet from donwstream dtsi:

	brcm,msi-base-spi = <247>;
	/* Actually 20 total, but the others are
	 * both sparse and non-consecutive
	 */
	brcm,msi-num-spis = <8>;
	brcm,msi-offset = <8>;
	brcm,msi-pci-addr = <0xff 0xffffe000>;

I don't know how to model this except private property.

> 
>> +
>> +  brcm,msi-pci-addr:
>> +    $ref: /schemas/types.yaml#/definitions/uint64
>> +    description: MSI-X message address.
> 
> Why don't other platforms need something like this?

This is a destination address for MSI mem writes from PCIe endpoint
devices, i.e. msi_msg.address filled when composing msi_msg
(irq_chip::irq_compose_msi_msg).

~Stan

> 
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupt-controller
>> +  - "#interrupt-cells"
>> +  - msi-controller
>> +
>> +examples:
>> +  - |
>> +    msi-controller@130000 {
>> +      compatible = "brcm,bcm2712-mip-intc";
>> +      reg = <0x00130000 0xc0>;
>> +      msi-controller;
>> +      interrupt-controller;
>> +      #interrupt-cells = <2>;
>> +      brcm,msi-base-spi = <128>;
>> +      brcm,msi-num-spis = <64>;
>> +      brcm,msi-offset = <0>;
>> +      brcm,msi-pci-addr = <0xff 0xfffff000>;
>> +    };
>> -- 
>> 2.43.0
>>

