Return-Path: <linux-pci+bounces-9583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79489923AF1
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 11:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF29B22AAE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 09:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A35F157469;
	Tue,  2 Jul 2024 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aGE3r5O5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2QKC9w2b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aGE3r5O5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2QKC9w2b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8214D703;
	Tue,  2 Jul 2024 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914307; cv=none; b=ZdLY1F4uG522HA27p7+xn+U3WhzBwtsqfN+HrC3XjVg5FWXbtJOLFkbM0/CKj4SIrXaTtnvzcuhY9Xr3T9GBXa1RYeUVX1CZxJy1u0ER2MaBsldiR1TqCXmATEiuhxeQrDc23b9kM+oBlNcOapRNAFBWvIq9Fk5f+1/wLppy2nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914307; c=relaxed/simple;
	bh=e6yjCIzmbK8Qtw+16A3D1rLwmbEufCE6BLEFJBvl3l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ds4LEqCNWHizFsPaxt1XfZAFQdh14S6x3zCJv3YeAwVM2VpQLBoVK0Wy+d7L961sXd7GQsmCtgrT38gunu872uNOyWVlVwf+YuH2eQOHkaT9QIN84stlf1wQ9zgIfYNFFpXzaH6WTLMECJL/fPYzhM3kXmQcdPilw2LZEe1yxgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aGE3r5O5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2QKC9w2b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aGE3r5O5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2QKC9w2b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C4151FB8F;
	Tue,  2 Jul 2024 09:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719914302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMWeCyvkYIy5BVhOwb4xPw5zFBDLYJARX5smrqLN/dg=;
	b=aGE3r5O5LtDf0srAtxeum3+MTQUtMPhM/LMIjTkm2lCoCVVRbb5EKFZ+EsC0Mpy2/t9HHQ
	fJqjhUPlW1kjDfLlkJpekNtCGHGFYz3dISBJCmq67loY+UruOMRiVS/7GTf1vNo5NVF+Hy
	ZS4wjz2eIX8dsbHihppxF0Cti8Zsu3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719914302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMWeCyvkYIy5BVhOwb4xPw5zFBDLYJARX5smrqLN/dg=;
	b=2QKC9w2bzmQdE19CWkrp9jAFR6rZM1VhYwGI94VDTz4afwpkeKEYGCvPIIb5rNncx5v8gn
	2X5P8ST1ujAe51Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719914302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMWeCyvkYIy5BVhOwb4xPw5zFBDLYJARX5smrqLN/dg=;
	b=aGE3r5O5LtDf0srAtxeum3+MTQUtMPhM/LMIjTkm2lCoCVVRbb5EKFZ+EsC0Mpy2/t9HHQ
	fJqjhUPlW1kjDfLlkJpekNtCGHGFYz3dISBJCmq67loY+UruOMRiVS/7GTf1vNo5NVF+Hy
	ZS4wjz2eIX8dsbHihppxF0Cti8Zsu3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719914302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMWeCyvkYIy5BVhOwb4xPw5zFBDLYJARX5smrqLN/dg=;
	b=2QKC9w2bzmQdE19CWkrp9jAFR6rZM1VhYwGI94VDTz4afwpkeKEYGCvPIIb5rNncx5v8gn
	2X5P8ST1ujAe51Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CAF213A9A;
	Tue,  2 Jul 2024 09:58:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iNbLHz3Pg2YDOAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Tue, 02 Jul 2024 09:58:21 +0000
Message-ID: <45201f8b-ad27-4087-a4ae-30f54914ff2e@suse.de>
Date: Tue, 2 Jul 2024 12:58:17 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: interrupt-controller: Add bcm2712 MSI-X
 DT bindings
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20240626104544.14233-1-svarbanov@suse.de>
 <20240626104544.14233-2-svarbanov@suse.de>
 <17642213-388e-4585-8775-1db1db9b9707@broadcom.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <17642213-388e-4585-8775-1db1db9b9707@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,gmail.com,google.com,linux.com,pengutronix.de,suse.com,raspberrypi.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]

Hi,

Thank you for the review!

On 6/26/24 14:35, Florian Fainelli wrote:
> 
> 
> On 26/06/2024 11:45, Stanimir Varbanov wrote:
>> Adds DT bindings for bcm2712 MSI-X interrupt peripheral controller.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

<cut>

>> +description: >
>> +  This interrupt controller is used to provide intterupt vectors to the
>> +  generic interrupt controller (GIC) on bcm2712. It will be used as
>> +  external MSI-X controller for PCIe root complex.
>> +
>> +allOf:
>> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - "brcm,bcm2712-mip-intc"
>> +  reg:
>> +    maxItems: 1
>> +    description: >
>> +      Specifies the base physical address and size of the registers
>> +
>> +  interrupt-controller: true
>> +
>> +  "#interrupt-cells":
>> +    const: 2
> 
> Should we have some sort of an interrupt-map or interrupt-map-mask
> property that defines the "linkage" between the inputs and the outputs?
> This controller does not really sit at the top-level of the interrupt
> tree as it feeds the ARM GIC, unfortunately this is not captured at all,
> and it seems to require ad-hoc properties to establish the mapping, that
> does not seem ideal.

Thank you for the suggestion. I will consider it.

~Stan

