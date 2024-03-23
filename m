Return-Path: <linux-pci+bounces-5036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12158879D4
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 19:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC57B21475
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572BD53E0E;
	Sat, 23 Mar 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iqUrlb+e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB763D;
	Sat, 23 Mar 2024 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711216915; cv=none; b=TC3EgJPtIFpr0kkNSsUI30Ctr5nCkERm+HAYYlwf15YMCN69wGR6WIB+CLx39+1WF9kxzCiRKCexBeguZiVKil/my7fBQA8ldOXNi9p1G8jemDDG67ucp+1NWhCUaGvPTy3SIQmstsxIJS8q4jHi/ZuIRUAq3vHaCTvYvTiE2Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711216915; c=relaxed/simple;
	bh=QVrfyERZB/O2NaoOaw/v0iV9cdqwocK7uYeLZ2eGZcI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=u2LbysP78WDoMWOtYjYkUfDzzNH+/VSDlw8g/fUfB6IT6lDncBVLNcTriurq0ZkU2bQkP6nyXbq1Iicu5oRmiMY9BenYi5XxIG8f8IaChYkRmEh0UJIAT84FDjsn+RePru3xppgJy7FZ0jgm2SQ+LY7NJ5ZnceOC90yApevl3IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iqUrlb+e; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711216868; x=1711821668; i=markus.elfring@web.de;
	bh=PyL2Ioh4vlALFYGvyjWWeKkUOfZjj8evfoP8akboAlw=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=iqUrlb+eCxD5v3QWSGMGSn0sg84vRhtzyJ14IT2t7CKw2G+CREDGrIQ8SprUgNaa
	 qwyEKTb10wlKWY2R74C2Qr4t4B81khDw7Wvb7KRVFH97aJSitVK40ZYIERFJgX8TU
	 kBVb7EhbklERu95cuaUo3s6xac3NmzN8U7SerzDJaEeynueSvCGPV0CSDESu3V31o
	 tpjJpKZxZR1VORFde0mRn/viCvKxnqsC8MqrTZFPDpA4gp17NLR+g1jTovYdhzpQc
	 rXtuydO1w20NWNKzwcpZiP7ACBbbbYuzHN9C5T6GAHpBo+IlO14tWPvBpwOYcbJPx
	 Rlp+mSnxwFSJsQ+x0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3Xnj-1qnudT2Rxz-00zEZM; Sat, 23
 Mar 2024 19:01:08 +0100
Message-ID: <f3849725-b7b3-4edc-8220-aabeb79b8151@web.de>
Date: Sat, 23 Mar 2024 19:01:03 +0100
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
 Lukas Wunner <lukas.wunner@intel.com>
References: <65fe1f9aadf51_2690d2948f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Subject: RE: [PATCH] cleanup: Add usage and style documentation
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <65fe1f9aadf51_2690d2948f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SmyqD010p0uwXhTqLFAT+MKBEAIrDaiCEBHBDDR0wyTqCIJfaTN
 hhkOvtxDEjq2pESON3LwSrVFy/5Xu2I1SsB7NG4o5ftJB7ZkZLH4LOzUVFD0uKqtgGFZMFr
 8q5118J4thJ7hf5Y4Ub/QAmDfKjWBmU7udNDS7aLl6uVpMKyT8deDvoU3/NxrKA63mmdodS
 skuSI80wdZBvkcGZVUEnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dUActWliC4w=;hdeZqY0mxakffsHlGyutv6l/x6V
 34T0aoeci1Pufl8ZUt98g5j4kqBglt7/6+xJLX20BZCxEPRVEyxgJOi6+vYlCX71SLR5DbsZV
 kxtYuforeNfBXZR5B8/IlwPock3+ibJXaH8Rjr9GScuAZA1ua+N/cfgy7K2lZHZ7Z02vYHvrC
 yQoXjLj93PxQGx3a/iHgoqpVkoGtMNl96sgYQK/cP4o1AKetq/43EUfZGheTq5rlryNYtK/aZ
 byIESvgr2hfz0z6YzqJ7cejyvDMJGoqDYWYs6rMCERlsxiupcXmxpHEiRiXdAntXoGZsAN7vL
 Ru+rIYBspjysvIeO/lxC0BnDKN4/ITZEygYocFdgxLCapf0Z1PqzpzRrB2rrt6rR0WO1R7wCG
 BfBTs6bb3NYSBo2dOrewns61D3jj1VuAjop9G4bWRiu7IQ0kLkIeObE8Q5gGlx0+5aJsp3Gpu
 KDlcASUKWOoo64SjR02m24SJICe5AS+7COIN3+xmM6s/EdsCWwngMUmOaguzq59TF3Q6a0drh
 n5Z0/7IISQ2F9Tu/FkbziUvZT253ScXShp/JR9AAJ0r0AY6894x2HXkuSpcKQZxXiSVrH9pbY
 vKfg5PSUUakfb019YxzC2bTQlFDOD5QRWxIQxTE6VGrIVFNbD4E3lBLk/6w60rBWVY+DbKilv
 4k6FGjglKA5vGIFNCrP85/rAA3yPIeTumJWOiAEJAAv2gwrSwB2evs6ZFWlA2u1dUigQIykgf
 VuxVrYjlCypDlzqFSFPp0kwKucI1g43CGhcAGZZNmq8E/8RenBET09I+XJvko4X6V3AQch++o
 Xn7twrHuWGHtQ+rOvu6glL7ivS+wJ/1BgNqA83P6JjDoI=

> DEFINE_FREE(remove_free, struct object *, if (_T) remove_free(_T))
> static int init(void)
> {
>         struct object *obj __free(remove_free) =3D NULL;
>         int err;
>
>         guard(mutex)(lock);
>         obj =3D alloc_add();
>
>         if (!obj)
>                 return -ENOMEM;
>
>         err =3D other_init(obj);
>         if (err)
>                 return err; // remove_free() called without the lock!!
>
>         no_free_ptr(obj);
>         return 0;
> }

You demonstrated an improvable lock granularity and a questionable combina=
tion
of variable scopes.


> The fix for this bug is to replace the "__free(...) =3D NULL" pattern an=
d
> move the assignment to the declaration.
>
>         guard(mutex)(lock);
>         struct object *obj __free(remove_free) =3D alloc_add();

How do you think about to describe such a source code transformation
as a conversion of a variable assignment to a variable definition
at the place of a resource allocation?

Would you like to increase the collaboration with the macros =E2=80=9CDEFI=
NE_CLASS=E2=80=9D and =E2=80=9CCLASS=E2=80=9D?
https://elixir.bootlin.com/linux/v6.8.1/source/include/linux/cleanup.h#L82

Regards,
Markus

