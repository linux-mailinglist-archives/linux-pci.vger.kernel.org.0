Return-Path: <linux-pci+bounces-4997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9107886C85
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 14:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56113282E2C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742A344C84;
	Fri, 22 Mar 2024 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GmDq6eJD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BE645C0B;
	Fri, 22 Mar 2024 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112500; cv=none; b=S08zRE7F6/Tb3fV5YZxxWpufmpgbDLpu4fHasKQyRZXkhuNgdUYGdpJIbY/x3DnLQc+6c/4TXkBLSpcm/HDmyiYWvjk/QkoWWCqcRxYT+heLkjq5wu3wNeCPo0MLMfUxX3O5G5zshDYch10twaxkDGGlbkNiscCtnY5HByB0HUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112500; c=relaxed/simple;
	bh=57Gnr1GDblaUtJoGzA33y6XntCYgqswvqSuwFA+G2xk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Znt/q8EBx93x2EBI4V6DW4BMfgtBgvgDZ83hxttve0Huyn7DMHFYmvQul1zLcEZCCfFN8sXA4px0dp0lpw/eRvvKxnhvrgfc5k+qTx4RB6NPnpvaJNFpAtTa0LmEw56Vn5ireWofUOyjD87P7uCY4DHfb0dhTfkCUS0SwhUA4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GmDq6eJD; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711112449; x=1711717249; i=markus.elfring@web.de;
	bh=j5W+zIrNrwXHwy8i6ouAXhosP3kZXQBL5lb5KfWqjAo=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=GmDq6eJDYgPPVb3quJwNngmgZIfK/mGylkG8DG1tBwkw+EOXza0QNOpkNTdHHw6q
	 m2NrpRltTR/uuy4AT30Z3Zxy/8TtUwRwrNDkw7jUOGABVmzFe5YUj9/CbIvTCKyEm
	 UbFWmOzF8t1sBIKMzWbsemMVu/xeKmHK35wlOSQ/3ktdfrTTNOgYXkiFnR3TtJSOI
	 veliHEpzy4pXcnUhWlWPLRdxl+hnGbzrN9MEKhaLo1OmPNibdQLvX4yTLgDLwyzL+
	 freHk7CPcsYWKtrJPdpJjYrcZuMTfp2hHHh6zV9bf2H6376kQ0ADmRgtsrHosvuQp
	 RwUIAHpaWm3asve6Ag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRMB-1r6vNe1ovH-00ht8U; Fri, 22
 Mar 2024 14:00:49 +0100
Message-ID: <8a1adff2-eb83-4dec-b8d0-1e523245de65@web.de>
Date: Fri, 22 Mar 2024 14:00:42 +0100
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
 Julia Lawall <Julia.Lawall@inria.fr>, Lukas Wunner <lukas.wunner@intel.com>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
Subject: Re: [PATCH] cleanup: Add usage and style documentation
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UkSGC+4qo1n4XxoQDl15NnuOy58e3sPzB2i6UlqqDfSfdW9U9JQ
 35gaoqp9m504/U5DfPHcqvKGeGm3kKpN378SPB3hEpNClCey/Yrbp1tFLLlJH3hMWbSufs3
 ayuqzVHb0ioFxaqpyaaPMkJvuT7nZwJiYsRptUuE3FAmNDk8oRMghoIKKQSVXVGn0gDMGFH
 EJQ8MfXNN+4Q01lcJzLpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sDd5Oswr9wg=;oUpHLGsbXWg5ca5bC8NBGfysCrf
 DFv6hUPq8S4H/XwQpwPiQuK4HLa3C2XsqohEPgF8DqzZ2fDNQxfq5ZjtnTiRXOh+cIfSx0si5
 I8p6NBAwC4kK18ez+vuj4QBiYZaedbKGinfljFLez8lz3PFDPoXvsJZ9FhWQUIY8x0KLDejZj
 9SYVMpL7Hy2KSi85kGlwTXLj+OwNqHVdoBcZHVwXjiXUQLCFI9WqvY3zmPxKgYC3x1ql/1DeO
 6iXHJ4zA7rzyBFgnZwFhA+sloNmWRsp7UQr5yT9HUFot1v3W//MS9grpfZoKs17jL7RM+7mqq
 VTJczbJTQY5/TS/miewAlPcLmi2qur+NZtXsdGMrOLgkpNuuwpVW5CylSlyQHwxHAl5OQSC0n
 hE/yVcRxZ+iIH1RMl6m9TNwEBvd1uvg4XvMbDaxPCLLbSQjp62otI96yLupwQNyHkvyOFlH6m
 0kCUa+/bWDP8a8C72EV5qelNJEE3zux7FKyL6bWbZVjo6zs8T3HP0h9fmKjtnBSms3Jp6Lpui
 QmlqSE+Rae1sJUDalnx1KDcXNGI+N1D/aGvmytshJ1PgS4VRXj/hwjyrINOLgkGHuD7LuSscy
 jDoL363DGW2A1q5YWiEPzqKg0W7zBMepvkloBNElY5oIHN/GZNqfAVf5dhTyXqhWtbLLpbnHc
 4f98L+PSD4h17gPOZusT1LB3gQCsD+MYLkKzIOfkNOTMpkpqoIccy7Xu8ao+FYHduF5742Ut/
 roZZ91Y7fK8Bk2rKmukct+SBsyqR+6lB8+CB5nRb7ybqmJXj0S33GNNL8NMNtwh15WRT74dZ9
 ak5aJWDVHTUL0WWtPbmSRaM3uFSuKvoFJUegBWNPntwQk=

=E2=80=A6
> +++ b/include/linux/cleanup.h
> @@ -4,6 +4,118 @@
>
>  #include <linux/compiler.h>
>
> +/**
> + * DOC: scope-based cleanup helpers
> + *
> + * The "goto error" pattern is notorious for introducing =E2=80=A6

Will any other label become more helpful for this description approach?


> + * this tedium and can aid in maintaining FILO (first in last out)
             =E2=AC=86
Would an other word be more appropriate here?



> + * contraindicates a pattern like the following:

I would prefer an other wording approach.


> + *	struct pci_dev *dev __free(pci_dev_put) =3D NULL;

Programmers got used to null pointer initialisations.


> + * In this case @dev is declared in x-mas tree style in a preamble
> + * declaration block. That is problematic because it destroys the
> + * compiler's ability to infer proper unwind order.

Can capabilities be clarified better for the applied compilers?


>                                                      If other cleanup
> + * helpers appeared in such a function that depended on @dev being live
> + * to complete their unwind then using the "struct obj_type *obj
> + * __free(...) =3D NULL" style is an anti-pattern that potentially caus=
es
> + * a use-after-free bug.

I suggest to reconsider such a development concern in more detail.


> + *	struct pci_dev *dev __free(pci_dev_put) =3D
> + *		pci_get_slot(parent, PCI_DEVFN(0, 0));
> + *
> + * ...which implies that declaring variables in mid-function scope is
> + * not only allowed, but expected.

* Is there a need to separate the ellipsis from the subsequent word
  by a space character?

* You propose a variable definition without specifying extra curly bracket=
s
  (for another compound statement / code block).
  This can work only if an appropriate pointer is returned by the called f=
unction.

* The involved identifiers can occasionally get longer.
  Further code layout challenges would need corresponding clarifications.
  How will the handling of line length concerns evolve?

* I suggest to take another look also at the transformation pattern
  =E2=80=9CReduce Scope of Variable=E2=80=9D.
  https://refactoring.com/catalog/reduceScopeOfVariable.html


> + * Conversions of existing code to use cleanup helpers should convert
> + * all resources so that no "goto" unwind statements remain. If not all
> + * resources are amenable to cleanup then additional refactoring is
> + * needed to build helper functions, or the function is simply not a
> + * good candidate for conversion.

* How do you think about to specify any more resource cleanup functions
  for growing usage of =E2=80=9Csmart pointers=E2=80=9D?

* Would you like to extend the specification of function pairs for
  improved applications of guard variants?


Regards,
Markus

