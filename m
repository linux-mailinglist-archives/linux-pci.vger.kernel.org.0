Return-Path: <linux-pci+bounces-35337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED838B40CC5
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 20:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EFD77A78FB
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 18:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04DC3128D1;
	Tue,  2 Sep 2025 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="dtSR+rlz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout9.mo534.mail-out.ovh.net (smtpout9.mo534.mail-out.ovh.net [178.33.251.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7142FD1DC;
	Tue,  2 Sep 2025 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.251.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836405; cv=none; b=pw7fRpKQOkXxrhGaOuwggTUtnEB3I//Dvupbx7UNO8H4ld9ZSYondQ9JS7AXSz1hyy3wumdfL8Cq1Rz8wA00QQoywQgF9li5ExexcbQtWbMWY7Hd/YS46b2ho01QEAGg1kCHtRIJHzJw1iaU2Z1Dz8WoLn8xPgYajbt16IGygxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836405; c=relaxed/simple;
	bh=Od+kByzKMtlKwxWTpbaY2oui20iYJ8JhWWg6aV/Lr2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksHTIxZLaFzmq++XNCT45iBzYylwGuWO7zpqBsCvWi/9H+MPvbQVal2NByfW0mxVJUQJuksxZvI5hs4nzAjJ6qfBBw9ePb4QofF51CtXU9RyNnHSRR4qSn+T3xiuDfgEdgO7z9NQB3wTRKP4SopOYO8rKbkEKTImtocavnrCsLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=dtSR+rlz; arc=none smtp.client-ip=178.33.251.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4cGYbL69wnz6XLN;
	Tue,  2 Sep 2025 18:06:38 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Tue,  2 Sep 2025 18:06:38 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.231.133])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4cGYbL0rDGz5wFY;
	Tue,  2 Sep 2025 18:06:38 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.9])
	by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id BA95894332F;
	Tue,  2 Sep 2025 18:06:36 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-104R005f80e0bac-1c8b-4e6a-b81b-3b0d9acbbebe,
                    B677A376967D575A53C78FE4FF5C940A066EF03B) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.41.176
Message-ID: <45b84c38-4046-4fb0-89af-6a2cc4de99cf@orca.pet>
Date: Tue, 2 Sep 2025 20:06:37 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] mfd: vortex: implement new driver for Vortex
 southbridges
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Michael Walle <mwalle@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250822135816.739582-1-marcos@orca.pet>
 <20250822135816.739582-4-marcos@orca.pet>
 <20250902151828.GU2163762@google.com>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <20250902151828.GU2163762@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3615827553760990822
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepofgrrhgtohhsucffvghlucfuohhlucggihhvvghsuceomhgrrhgtohhssehorhgtrgdrphgvtheqnecuggftrfgrthhtvghrnheptdegudfgiedugfekudfhlefgjefguedvjeffieevgeetjedvvdeihfeiudejvdehnecukfhppeduvdejrddtrddtrddupdejledruddujedrgedurddujeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehmrghrtghoshesohhrtggrrdhpvghtpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhifrghllhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
 hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehfeegmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=BShoJ9CtShHpPKQfSV3go4koAPboGRUp6AQIugmCTyM=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1756836399;
 v=1;
 b=dtSR+rlz6mvtRdeeIRrhsNfIdY8db6C6KPVunAs2rwNt+gfj4kcrHPT1qwr93+yKjZYRlfKB
 9UeGMly98dojMoe9yQ+xqJuy8UMn6+PdqtyGso0VsLTxr3MzSaU55mG7VbMkgdTY23rp39hpBtH
 6AUyGAR7IdypAqJvcTHojpSaOWgxVd7gDFhR00cwunLvkTKdA/8HW2QBqhXg/B4zCJTQcRVHA8r
 tfSJ+JRuPFjGM6GyVniEVmhSm4Kfmmyi6HMEjtsrNq4y/HwMKV3B6OhgMTteWcNUELOz2Y5osbV
 V0y70B20wNX6u6vcvQwxQq6x3CVcnArt6HomtuQop1BjA==

El 02/09/2025 a las 17:18, Lee Jones escribió:
>> +
>> +struct vortex_southbridge {
>> +	const struct mfd_cell *cells;
>> +	int n_cells;
>> +};
> 
> Why is this needed?
> 

To have a variable amount of cells. Currently I am only implementing the
GPIO device because it's the most critical (required for device shutdown),
but I plan on implementing once this gets merged at least also the watchdog,
which is provided by the same southbridge.

Adding support for this is should make adding that simpler.

>> +static const struct mfd_cell vortex_dx_sb_cells[] = {
>> +	{
>> +		.name		= "vortex-gpio",
>> +		.resources	= vortex_dx_gpio_resources,
>> +		.num_resources	= ARRAY_SIZE(vortex_dx_gpio_resources),
>> +	},
>> +};
> 
> It's not an MFD until you have more than one device.

Same as above.

>> +static const struct pci_device_id vortex_sb_table[] = {
>> +	/* Vortex86DX */
>> +	{ PCI_DEVICE_DATA(RDC, R6031, &vortex_dx_sb) },
> 
> We're not passing one initialisation API's data (MFD) through another (PCI).

Unless I understood you incorrectly, you mean I should not pass MFD cells/
data as private data?

vortex_dx_sb are "struct vortex_southbridge" type, not raw MFD API data.

