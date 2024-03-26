Return-Path: <linux-pci+bounces-5177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DB088C192
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 13:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2DF2E1F29
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401466F09C;
	Tue, 26 Mar 2024 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Z6BGyx/a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8510C6F08E;
	Tue, 26 Mar 2024 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454820; cv=none; b=M8SerXpMLX39YQa+H2vx1AXb641IUJ/meTLPkAFO2WXMZFUHj38ZXm4UZkcgDl+Pcz6/sFonidRZhqTHZ7CJcXIl354cNfMWKfPVDbmJUxd/MdngQCEV8qfVOVdfyvW2zlCI91UDl+DkhmSwm+JQXCpHQw6D24nbcPTvmg3QTHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454820; c=relaxed/simple;
	bh=3FzmbtGZZ7DvyD3OJ+z6tU4V4LGQHD6/1YEh2weunmA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=OX8nY/gjG+47VhQMg2QoQ/siHExaeRXD2xMXOIk6m4NLU+fVp3IEN3lm2Z7qmcWGbe3NFpRpASctpYbixDJNV84Cp0xs8So4RT+jn7rS9d9Eg2oiS1ZVXGpXQt1Ch7GXPEpAqeCZvMA/r5dKLtJz1N0J2JPY3w0p7Ce7sQMVGkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Z6BGyx/a; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711454772; x=1712059572; i=markus.elfring@web.de;
	bh=reTJekpRAbVkVaR6Ps74n/JKQGAzpk6naWUcepoHBnc=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=Z6BGyx/amhmAtn4HI51cKgC3t5dpc/XA/EsJoLtv7yxJO3njsoXk9lUBiPLMu/jq
	 r67vRnuvcqFG79dvlW2+7Q2EVdW+wQ/6yoUw9KNL+IgFciz6rP4RI4B7PR42c6ryQ
	 XTs5A+FtZAaoHgv5Ootx4o/nJ8VK0x4i/x5jJORnkcW3hLZ3PcdLJCRgR5c+fVV+b
	 eXoeiNphZyj4rzQvGMKvVKpYy1f6rbNRRzKTez+BZ1QVDZVU7flSd3mTchrK8BGlX
	 zWZiGSsZNxBm5qGOQK2ZX8dJ3OCGmYJNgKvv/Ddxe2Eo3zN/Zgumm/4vUoWrRAODO
	 t10Nir0Br82/MYW11g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzTPQ-1skCSS2uGW-00vQEB; Tue, 26
 Mar 2024 13:06:12 +0100
Message-ID: <570afd53-b1ed-4456-b83e-fca29857f000@web.de>
Date: Tue, 26 Mar 2024 13:06:05 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Williams <dan.j.williams@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Kevin Tian <kevin.tian@intel.com>,
 Lukas Wunner <lukas.wunner@intel.com>, Matthew Wilcox <willy@infradead.org>
References: <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
Subject: Re: [PATCH v2] cleanup: Add usage and style documentation
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BgFUPW3xHjwYrRMtgoo20y7vIBXuyr8pzAvnoMtyk1VznSTTOA+
 2HfzRJYuGFNVvMurFxHzbBoNNRYG+EIg6fREeH5NF5yWUGKiU2Vj7TiGIuBcl0cn4JlVhuU
 9taiqRiAeuyZQieLLOJMQeaT4cVFeOVHJMJ7moDXsY0Xvcg9phuSTdUcJHwk39SCZ2/Ddzs
 5geFhBWgiMHSGrK9Ee3oA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dfm3TQltfcE=;YyoCq04Dxq5vJPAzHeOVEsmsgUJ
 ibbY/IEQoLPNOSviWzWggc96XJUIZgoGt1QKE0Hlf1HjWGR5IEfIdo3Q+N3vmDII6fVcCLJZY
 nzoYlJrchUdt0gEH19pgG7p6WQpAgifS1GN1LvWDE5l6f/P9CGRKc0HpB2F1dMqj8YdNjBZIf
 hS6x+vKNcxc90yHEP8cv1QxtyLTkYsRbclbEtsNEtq+j3rRMDn+2tJ2sSObS45+2E2w2FhH8V
 QBzVKDt89i/4slYMQI0HPK/zxsGpy0IGC/IWUKPj6/OgK3bQzZAEqa4AoOEczrJ+8XMOq80rQ
 STNadkCTBafiH9XAGPJrDq5SkF/xHavXGlF2RzzdSckoXwPSvW+hFfEo4T6A2TSWttoM7RkYJ
 u5CFCkmnRwMDR/pJKABbFnbkk8Xw32G0RiRLMYwUxOJV2q0Vq19VZ0XP+dIFK2yb6FN3ycnIN
 zpqEZe+QKMuiWr/8XF5pgRNcYFCLh3BZ/wmhAX0dvcKbJ824j/VSV6fZcNAPzIp19aLpihA4E
 qfR/gSHODGWGu/Jr+PhonGA6Hgw9wH5KPoheX6okwuLwZIjQNM2lM8MPKak4TP6A3Ii6mARJ3
 LlNMF+4Dg7vIj9K23129gRdhe3M3FtU3GAu/aG7jjzXhpShMv1NNR4EBdEdxkPE8nyT/iHi9L
 wU/eXbcgRSPntqMOzgFe/atxdu+Hbck/U09++JJ5uhcWYmcQv1v6JVQWKMAWLcK98H5jdfXqi
 DwTXP65n7WGkAFKt5xCxY72A5mduJSXcsRz9w+Wyw1ySZ5C+BOoUkQ8X7oNWz4GBfSes5wERl
 bwz/zuTdAccjYHBKaGLbquB6G6fuXD1TcuXoHzE74X6uc=

=E2=80=A6
> +++ b/include/linux/cleanup.h
> @@ -4,6 +4,157 @@
>
>  #include <linux/compiler.h>
>
> +/**
> + * DOC: scope-based cleanup helpers
> + *
> + * The "goto error" pattern is notorious for introducing =E2=80=A6

Will any other label become more helpful for this description approach?

> + * this tedium =E2=80=A6

Would an other wording be more appropriate here?


> + *                          =E2=80=A6 maintaining FILO (first in last o=
ut)

How does this text fit to your response from yesterday?
https://lore.kernel.org/all/6601c7f7369d4_2690d29490@dwillia2-mobl3.amr.co=
rp.intel.com.notmuch/


> + *                                                       =E2=80=A6 If a=
 function
> + * wants to invoke pci_dev_put() on error, but return @dev (i.e. withou=
t
> + * freeing it) on success, it can do:
> + *
> + * ::
> + *
> + *	return no_free_ptr(dev);
> + *
> + * ...or:
> + *
> + * ::
> + *
> + *	return_ptr(dev);
=E2=80=A6

Would this macro call be preferred as a succinct specification
(so that only the shorter one should be mentioned here)?
https://elixir.bootlin.com/linux/v6.8.1/source/include/linux/cleanup.h#L78


> + * Observe the lock is held for the remainder of the "if ()" block not
> + * the remainder of "func()".

I suggest to add a word in this sentence.

* Observe the lock is held for the remainder of the "if ()" block
* (and not the remainder of "func()").


> + * the top of the function poses this potential interdependency problem

I suggest to add a comma at the end of this line.


> + * the recommendation is to always define and assign variables in one
> + * statement and not group variable definitions at the top of the
> + * function when __free() is used.

I became curious how code layout guidance will evolve further also
according to such an advice.


Would you like to increase the collaboration with the macros =E2=80=9CDEFI=
NE_CLASS=E2=80=9D and =E2=80=9CCLASS=E2=80=9D?
https://elixir.bootlin.com/linux/v6.8.1/source/include/linux/cleanup.h#L82

Regards,
Markus

