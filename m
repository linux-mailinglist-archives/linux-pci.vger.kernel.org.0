Return-Path: <linux-pci+bounces-11192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C781945EF9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 15:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CE31C2203B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8569A1E4857;
	Fri,  2 Aug 2024 13:59:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56F31E4879;
	Fri,  2 Aug 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607149; cv=none; b=pNuQbleJv/MfB2W8mgMjBjH67febJI+9VKZ9gK13sO/9ZU3hHsxi6V1j6agfQ6OddGz0fN6yTXF4SS6xM8qPox+s9KOq+51OiO5cF2nQNPLzSq2QnOtXTm5kpXaaMRZo7H9vF97A4RcNToNxH4WLlJxmwyttd+F5USU7rZY51mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607149; c=relaxed/simple;
	bh=xrPB0JRytqGqnV1j3GFVu3q7Owa1qlxF6nHLRsE9kVU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzQDUN5B+MKw7SnD40X9YH/syq4v7Ekw1LaapMuQApl+3P5gcVGYcsKUQcqGdJ+NiiERv2M39guZ1C9/rm5wjhyO6+hjbIZFzLSvEtBY3b1dnF/RJWd4SR5/3sc/V9S1+4vVP1pq3Hg3VDTFJxci0uQdMK6jl14oBozoKzsXe90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wb6nG4wkcz6K6Lm;
	Fri,  2 Aug 2024 21:56:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 78957140B3C;
	Fri,  2 Aug 2024 21:58:57 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 2 Aug
 2024 14:58:57 +0100
Date: Fri, 2 Aug 2024 14:58:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <peterz@infradead.org>, <torvalds@linux-foundation.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, "Jonathan
 Corbet" <corbet@lwn.net>, <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3] cleanup: Add usage and style documentation
Message-ID: <20240802145856.00002717@Huawei.com>
In-Reply-To: <171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com>
References: <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
	<171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 29 Mar 2024 16:48:48 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> When proposing that PCI grow some new cleanup helpers for pci_dev_put()
> and pci_dev_{lock,unlock} [1], Bjorn had some fundamental questions
> about expectations and best practices. Upon reviewing an updated
> changelog with those details he recommended adding them to documentation
> in the header file itself.
>=20
> Add that documentation and link it into the rendering for
> Documentation/core-api/.
>=20
> Link: http://lore.kernel.org/r/20240104183218.GA1820872@bhelgaas [1]
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v2:
> * remove the unnecessary newlines around code examples further reducing
>   the visual interruption of RST metadata (Jon)
> * Fix a missing FILO=3D>LIFO conversion
> * Fix a bug in the example
> * Collect Jonathan's reviewed-by
>=20
> Review has been quiet on this thread for a few days so I think is the
> final rev. Let me know if anything else to fix up.

Would be good to either get more review, or this applied.

Currently I'm pointing people at the email. Would much rather
point them at the upstream docs!

Jon, would you consider picking this up?
>=20
>  Documentation/core-api/cleanup.rst |    8 ++
>  Documentation/core-api/index.rst   |    1=20
>  include/linux/cleanup.h            |  136 ++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 145 insertions(+)
>  create mode 100644 Documentation/core-api/cleanup.rst
>=20
> diff --git a/Documentation/core-api/cleanup.rst b/Documentation/core-api/=
cleanup.rst
> new file mode 100644
> index 000000000000..527eb2f8ec6e
> --- /dev/null
> +++ b/Documentation/core-api/cleanup.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Scope-based Cleanup Helpers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +.. kernel-doc:: include/linux/cleanup.h
> +   :doc: scope-based cleanup helpers
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/in=
dex.rst
> index 7a3a08d81f11..2d2b3719567e 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -35,6 +35,7 @@ Library functionality that is used throughout the kerne=
l.
> =20
>     kobject
>     kref
> +   cleanup
>     assoc_array
>     xarray
>     maple_tree
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index c2d09bc4f976..5ffb2127e3ac 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -4,6 +4,142 @@
> =20
>  #include <linux/compiler.h>
> =20
> +/**
> + * DOC: scope-based cleanup helpers
> + *
> + * The "goto error" pattern is notorious for introducing subtle resource
> + * leaks. It is tedious and error prone to add new resource acquisition
> + * constraints into code paths that already have several unwind
> + * conditions. The "cleanup" helpers enable the compiler to help with
> + * this tedium and can aid in maintaining LIFO (last in first out)
> + * unwind ordering to avoid unintentional leaks.
> + *
> + * As drivers make up the majority of the kernel code base, here is an
> + * example of using these helpers to clean up PCI drivers. The target of
> + * the cleanups are occasions where a goto is used to unwind a device
> + * reference (pci_dev_put()), or unlock the device (pci_dev_unlock())
> + * before returning.
> + *
> + * The DEFINE_FREE() macro can arrange for PCI device references to be
> + * dropped when the associated variable goes out of scope::
> + *
> + *	DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
> + *	...
> + *	struct pci_dev *dev __free(pci_dev_put) =3D
> + *		pci_get_slot(parent, PCI_DEVFN(0, 0));
> + *
> + * The above will automatically call pci_dev_put() if @dev is non-NULL
> + * when @dev goes out of scope (automatic variable scope). If a function
> + * wants to invoke pci_dev_put() on error, but return @dev (i.e. without
> + * freeing it) on success, it can do::
> + *
> + *	return no_free_ptr(dev);
> + *
> + * ...or::
> + *
> + *	return_ptr(dev);
> + *
> + * The DEFINE_GUARD() macro can arrange for the PCI device lock to be
> + * dropped when the scope where guard() is invoked ends::
> + *
> + *	DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unl=
ock(_T))
> + *	...
> + *	guard(pci_dev)(dev);
> + *
> + * The lifetime of the lock obtained by the guard() helper follows the
> + * scope of automatic variable declaration. Take the following example::
> + *
> + *	func(...)
> + *	{
> + *		if (...) {
> + *			...
> + *			guard(pci_dev)(dev); // pci_dev_lock() invoked here
> + *			...
> + *		} // <- implied pci_dev_unlock() triggered here
> + *	}
> + *
> + * Observe the lock is held for the remainder of the "if ()" block not
> + * the remainder of "func()".
> + *
> + * Now, when a function uses both __free() and guard(), or multiple
> + * instances of __free(), the LIFO order of variable definition order
> + * matters. GCC documentation says:
> + *
> + * "When multiple variables in the same scope have cleanup attributes,
> + * at exit from the scope their associated cleanup functions are run in
> + * reverse order of definition (last defined, first cleanup)."
> + *
> + * When the unwind order matters it requires that variables be defined
> + * mid-function scope rather than at the top of the file.  Take the
> + * following example and notice the bug highlighted by "!!"::
> + *
> + *	LIST_HEAD(list);
> + *	DEFINE_MUTEX(lock);
> + *
> + *	struct object {
> + *	        struct list_head node;
> + *	};
> + *
> + *	static struct object *alloc_add(void)
> + *	{
> + *	        struct object *obj;
> + *
> + *	        lockdep_assert_held(&lock);
> + *	        obj =3D kzalloc(sizeof(*obj), GFP_KERNEL);
> + *	        if (obj) {
> + *	                LIST_HEAD_INIT(&obj->node);
> + *	                list_add(obj->node, &list):
> + *	        }
> + *	        return obj;
> + *	}
> + *
> + *	static void remove_free(struct object *obj)
> + *	{
> + *	        lockdep_assert_held(&lock);
> + *	        list_del(&obj->node);
> + *	        kfree(obj);
> + *	}
> + *
> + *	DEFINE_FREE(remove_free, struct object *, if (_T) remove_free(_T))
> + *	static int init(void)
> + *	{
> + *	        struct object *obj __free(remove_free) =3D NULL;
> + *	        int err;
> + *
> + *	        guard(mutex)(&lock);
> + *	        obj =3D alloc_add();
> + *
> + *	        if (!obj)
> + *	                return -ENOMEM;
> + *
> + *	        err =3D other_init(obj);
> + *	        if (err)
> + *	                return err; // remove_free() called without the lock!!
> + *
> + *	        no_free_ptr(obj);
> + *	        return 0;
> + *	}
> + *
> + * That bug is fixed by changing init() to call guard() and define +
> + * initialize @obj in this order::
> + *
> + *	guard(mutex)(&lock);
> + *	struct object *obj __free(remove_free) =3D alloc_add();
> + *
> + * Given that the "__free(...) =3D NULL" pattern for variables defined at
> + * the top of the function poses this potential interdependency problem
> + * the recommendation is to always define and assign variables in one
> + * statement and not group variable definitions at the top of the
> + * function when __free() is used.
> + *
> + * Lastly, given that the benefit of cleanup helpers is removal of
> + * "goto", and that the "goto" statement can jump between scopes, the
> + * expectation is that usage of "goto" and cleanup helpers is never
> + * mixed in the same function. I.e. for a given routine, convert all
> + * resources that need a "goto" cleanup to scope-based cleanup, or
> + * convert none of them.
> + */
> +
>  /*
>   * DEFINE_FREE(name, type, free):
>   *	simple helper macro that defines the required wrapper for a __free()
>=20


