Return-Path: <linux-pci+bounces-5456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34F7892CEE
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 21:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62540282903
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 20:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DC441C7A;
	Sat, 30 Mar 2024 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AIy+ZxUC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E19E1D526;
	Sat, 30 Mar 2024 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830275; cv=none; b=eUNw9/t8jomHLQY+ByTYf5xK2CC+N5DFG1ciOUkaHQSN3oHQ8cDJj453n16/YK3CYYpiKQuMWsO2mrVyAU/7DjdKdN5KQ6C5LkszXt8DhNobzXgbimHdi2OrBCXdLvp58aToKKaP9ZIGqalDnefi1vClD8TSQ4PuCXMXj63I5hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830275; c=relaxed/simple;
	bh=M16AfNwVtHLamlKfg4jcGI9WG/ubtRtUfORvJHjJ5FU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Vm4JqjVbHJSVd0lGE7+cb5Pi7cGmrX7MjL/A1iPE1NeHIK1xmB4B76kPPrxRrODZuC7yQCj3AgXDKQzt6gDhtFhQu2LzO2JNF/G8S3RiOWzyzfFqDcstXNtmHnNjyeDHJ/BPpYb4RDhMU2NyEBnt7EXCFP3mxfkq+1+C1oki3cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=AIy+ZxUC; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711830223; x=1712435023; i=markus.elfring@web.de;
	bh=xD66JK+hqN9SH3xlHXfYDDN5LPeXo+dtKMtHomPeaEY=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=AIy+ZxUC0CLGbcs6pcIqpMBskcukgJmUGw/JQT80eCuslFW/+y12OZcZKf9TAEWS
	 uQDTwF9WtIKHU3EODgCJOTb4AU5R/hHisA+j8LzG6Yn9LAbwT0ZUAI/QbTd7EF6Mq
	 l+T0ZMKKS/L3MVt1PnFmVd08dvH7ny9CZeVIi5TSH99clVpvn7HwTde/eBs5IOoh+
	 SspCYD6zgJzCs3YmKIklaY1w3/KfzsOKNHO789tpms7kb/3WnqlNqxLGalhMuL2pw
	 xVu4QBvwxdgiQ4lKl/DYIZXBoYitB3PgUKhtUKCasrwtYEJDrWh+hE0bUqk7pqHFG
	 tbjDGw7V2W10zZ03vg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MvKXb-1shnxP3vjF-00r3T9; Sat, 30
 Mar 2024 21:23:43 +0100
Message-ID: <5e16b656-514d-4598-8397-f2f8f87a05da@web.de>
Date: Sat, 30 Mar 2024 21:23:39 +0100
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
References: <171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com>
Subject: Re: [PATCH v3] cleanup: Add usage and style documentation
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A8x+osJ1x64brIJRIo7QxmPu5vvARRUGvvpAeHdMnO5chqB/QhQ
 aNVVt7u12+tBjtiZoU9Y4y75cAwp36FHJjTHZ1kIlqCZhz6DKKoZWFTzZA9aw9TaD5/qWPC
 JtsYkWJWB9Wy28b+yM87ZuVTLmoZ4jim98urOpEPbAnyM8zEKIXI2f+pmlzKnXop3lxOeIG
 WqJGKeaUnD5tCklzxJQ/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c3ByjP073ec=;b8eZMOdHdutDRG+pLemxHPk62KZ
 WOZYvMZGY9r3JlPVIcjLpUvSQTnqruI9AYPXED40MdNFnEEoP6HbZP6zD3ZQprxOePU5YbXzN
 Tdjl3Z+xzrWTiBvwG6vrawgrXQsaRXZ2yKwr2y9TyK0sgHkogKo2nCjmxwk65F40RxYb/DFTA
 bac3C5wnwkXkF3OMqLUsvyl57L553Y7U5I20/6GZA4HoJ0H0SQtS+/W8vJP4gMdbKjmKuFlv2
 nj+768FSfqoIdFNV7Wv5MUZo8BwiBbBCXHJWKDfSo1sis97zu/GLQa8ynrltRwGqPx1+GUnO0
 jRj+tvgq4ljtqj4TlKPXyWRXS2Dgkbmm7KUNqvMb/wzcdYKKxxYNJWMMzre/XPpfeQtCdXyIw
 8g/fkMkE8YjpAjEEdbvZq3nW3JugIk4FZaBRn2UiLLR0V3CfTkYIXb2kzyTyluQZznt9mG+Zg
 KiOLoZVyvRCMZf7+00xIS3Sb2+CzJSc8NMNzjrc/VOBv0pSXGsYTToMI97fsfq6a2iaVnIqG1
 Fqj1ThAg8pcMzArUjNZ2pJQ+hq1AHLyFG3w1kMGlWSQyz5LtYtzh5NmgRRp4E+z0iYEPmX2iZ
 KJxpyPzdFghdNTMytQLlKq8LdPhJXQ9WjkoIv9kvzQcci81FfKNwy4hcsI9rTbxwdGYeEY4gC
 FC38rZsvRDNinUtS5wlIWDl++XSUwisC1aaimvtumdLX5QZFK5DYfVBgD9gldr7B8O4t6os62
 kb8PJXokGEGZ5YCeEJvXZDECpoOtRdC/b0mSM9XtzMIhCoXAZJ/BBC9TRuhO5POiTik04fXJH
 UrMBIHLwwCQkJTDEGMiXRKll+FkZ8+PDkzh1vLQrHC4y4=

> Changes since v2:
> * remove the unnecessary newlines around code examples further reducing
>   the visual interruption of RST metadata (Jon)
> * Fix a missing FILO=3D>LIFO conversion
> * Fix a bug in the example

I find such improvements nice.


> * Collect Jonathan's reviewed-by

How good does this action fit to the event that you pointed issues out als=
o yourself?


> Review has been quiet on this thread for a few days so I think is the
> final rev.

I got an other impression.


> Let me know if anything else to fix up.

I would appreciate if further patch review comments can get more attention=
.


=E2=80=A6
> +++ b/include/linux/cleanup.h
> @@ -4,6 +4,142 @@
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
https://elixir.bootlin.com/linux/v6.8.2/source/include/linux/cleanup.h#L78


> + * Observe the lock is held for the remainder of the "if ()" block not
> + * the remainder of "func()".

I suggest to add a word in this sentence.

* Observe the lock is held for the remainder of the "if ()" block
* (and not the remainder of "func()").


> + * That bug is fixed by changing init() to call guard() and define +
> + * initialize @obj in this order::
> + *
> + *	guard(mutex)(&lock);
> + *	struct object *obj __free(remove_free) =3D alloc_add();

It is helpful to point such a design possibility and preference out.

But I imagine that the abstraction level should be raised another bit.
It seems that the mentioned variable definition should be achieved by
calling the macro =E2=80=9CCLASS=E2=80=9D instead for =E2=80=9Can instance=
 of the named class=E2=80=9D.
Thus the macro =E2=80=9CDEFINE_CLASS=E2=80=9D should also be called before=
 accordingly.
https://elixir.bootlin.com/linux/v6.8.2/source/include/linux/cleanup.h#L82


> + * the top of the function poses this potential interdependency problem

I suggest to add a comma at the end of this line.


> + * the recommendation is to always define and assign variables in one
> + * statement and not group variable definitions at the top of the
> + * function when __free() is used.

I became curious how code layout guidance will evolve further also
according to such an advice.


> + * Lastly, given that the benefit of cleanup helpers is removal of
> + * "goto", and that the "goto" statement can jump between scopes, the
> + * expectation is that usage of "goto" and cleanup helpers is never
> + * mixed in the same function. I.e. for a given routine, convert all
> + * resources that need a "goto" cleanup to scope-based cleanup, or
> + * convert none of them.

Can the word wrapping become nicer another bit?

* Lastly, given that the benefit of cleanup helpers is removal of "goto",
* and that the "goto" statement can jump between scopes,
* the expectation is that usage of "goto" and cleanup helpers is never
* mixed in the same function. I.e. for a given routine, convert all
* resources that need a "goto" cleanup to scope-based cleanup,
* or convert none of them.


Regards,
Markus

