Return-Path: <linux-pci+bounces-13231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E095979F53
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 12:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB7C28424D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 10:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701B414BFA3;
	Mon, 16 Sep 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GgSKh/iM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qf5/5sEW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GgSKh/iM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qf5/5sEW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B739E1CF83;
	Mon, 16 Sep 2024 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482766; cv=none; b=nvrZA2qbRRaejRPYBSCrqEHEW+ZINm07yUvGNsus2/WgwqFjcP3JExIAiYLfr8iAtv6BDPErh7t3Ohmt3NmxLeh2Q1TM9iJ3AdE1HpdVCvcMCaeTyieP8xP3PsKb16Nv1IqdrATejUcueNUqq1gG0+fatDrc0cInSG4jNtnvSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482766; c=relaxed/simple;
	bh=kN2tLmTwtAeLvHdpahKB+hx/wXDn+ABywghAx+yQqJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQrdGYAg0WGVudvSC+yhtLw6gqzWlBp7MMmMQtyWYfY6G/7vwRmi0o7iYgxQRjoq6WRDPFN/3IPQszvOAWeaJJO1u3GeGVmEA4jHUljUrpcJsxruUTq8tnJfiTM7ejNUHl6K1+GDp076bmYgf2cwb71LLg6S0hJBBakysaH6qRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GgSKh/iM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qf5/5sEW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GgSKh/iM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qf5/5sEW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE41C21AAD;
	Mon, 16 Sep 2024 10:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726482762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDZPsOE8S64OUNNvCNuXXFuZs9RSJRdgavt14Vqc3VI=;
	b=GgSKh/iMk38I8lb4va9XfGNDQy5jJrpUivlIRurq+Rx7OvUp3JCiJzBcjjQsaJaBteH+ka
	U41zwuaWawdNqIQyGEaKnALoourFjvJS0tIEgqAq6tIX1pqQD2g7DmPGavM4UBaMBava8n
	HIAqzMon2KOq7VmYxaKhrUZdnPHjSGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726482762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDZPsOE8S64OUNNvCNuXXFuZs9RSJRdgavt14Vqc3VI=;
	b=qf5/5sEWREeZzAgtseDbWfe5WoRPt13aDIVz+oAZQeOOxDELy9mrwzhhx4h908xLn1U132
	4fLsRpxht5FKjlCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726482762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDZPsOE8S64OUNNvCNuXXFuZs9RSJRdgavt14Vqc3VI=;
	b=GgSKh/iMk38I8lb4va9XfGNDQy5jJrpUivlIRurq+Rx7OvUp3JCiJzBcjjQsaJaBteH+ka
	U41zwuaWawdNqIQyGEaKnALoourFjvJS0tIEgqAq6tIX1pqQD2g7DmPGavM4UBaMBava8n
	HIAqzMon2KOq7VmYxaKhrUZdnPHjSGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726482762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDZPsOE8S64OUNNvCNuXXFuZs9RSJRdgavt14Vqc3VI=;
	b=qf5/5sEWREeZzAgtseDbWfe5WoRPt13aDIVz+oAZQeOOxDELy9mrwzhhx4h908xLn1U132
	4fLsRpxht5FKjlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D216139CE;
	Mon, 16 Sep 2024 10:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4S9pD0kJ6GaYZgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 16 Sep 2024 10:32:41 +0000
Message-ID: <a22e095c-d0fb-4414-8a4b-eea86bb90d02@suse.de>
Date: Mon, 16 Sep 2024 13:32:32 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 01/11] dt-bindings: interrupt-controller: Add
 bcm2712 MSI-X DT bindings
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
References: <20240910151845.17308-1-svarbanov@suse.de>
 <20240910151845.17308-2-svarbanov@suse.de>
 <20240911165611.GA897131-robh@kernel.org>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <20240911165611.GA897131-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,broadcom.com,linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi Rob,

Thank you for the review comments!

On 9/11/24 19:56, Rob Herring wrote:
> On Tue, Sep 10, 2024 at 06:18:35PM +0300, Stanimir Varbanov wrote:
>> Adds DT bindings for bcm2712 MSI-X interrupt peripheral controller.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
>> ---
>>  .../brcm,bcm2712-msix.yaml                    | 69 +++++++++++++++++++
>>  1 file changed, 69 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
>> new file mode 100644
>> index 000000000000..2b53dfa7c25e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
>> @@ -0,0 +1,69 @@
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
> 
> Don't need '>' here.

OK.

> 
>> +  This interrupt controller is used to provide interrupt vectors to the
>> +  generic interrupt controller (GIC) on bcm2712. It will be used as
>> +  external MSI-X controller for PCIe root complex.
>> +
>> +allOf:
>> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: brcm,bcm2712-mip
>> +
>> +  reg:
>> +    items:
>> +      - description: base registers address
>> +      - description: pcie message address
>> +
>> +  interrupt-controller: true
>> +
>> +  "#interrupt-cells":
>> +    const: 2
> 
> What goes in these cells?
> 
> But really, what interrupts does an MSI controller handle? Or are we 
> just putting "interrupt-controller" in here so that kernel handles this 
> with IRQCHIP_DECLARE()?
> 

Yes, looks like interrupt-controller property is need by IRQCHIP_DECLARE().

I will drop interrupt-controller/cells and convert the driver to use
IRQCHIP_PLATFORM_DRIVER_BEGIN/END().

>> +
>> +  msi-controller: true
> 
> Drop and use 'unevaluatedProperties'.

OK.

> 
>> +
>> +  "#msi-cells":
>> +    enum: [0]
> 
> const: 0

OK.

> 
>> +
>> +  msi-ranges: true
> 
> Drop.

OK.

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
>> +  - msi-ranges
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    axi {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        msi-controller@1000130000 {
>> +            compatible = "brcm,bcm2712-mip";
>> +            reg = <0x10 0x00130000 0x00 0xc0>,
>> +                  <0xff 0xfffff000 0x00 0x1000>;
>> +            msi-controller;
>> +            #msi-cells = <0>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +            msi-ranges = <&gicv2 GIC_SPI 128 IRQ_TYPE_EDGE_RISING 64>;
>> +        };
>> +    };
>> -- 
>> 2.35.3
>>

