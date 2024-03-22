Return-Path: <linux-pci+bounces-4998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E0B886D8E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 14:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5D71F24F29
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603FC59179;
	Fri, 22 Mar 2024 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6tJ8DnS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3059259177;
	Fri, 22 Mar 2024 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114477; cv=none; b=QgrEL+dkU6GU1rZWy9iIxHsKgq2EClaCEo8jRPc7PYnoD8lKAQXdKm8xeE9YT7SxRpBcbMVKg8tH11UXsuQgNxBdw98clBPdHAXtaQ/FqqNzQUhqWW/V3IOav2JigDbU1sVqLfsyCWxf/VMo9aqL02X1hRL5RHh29ENdsuAZZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114477; c=relaxed/simple;
	bh=/Awesc9BVSWbif0Zj62k5pq5AFrhPIARqy7s82jiX7U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hcnu7bb0P7++CKTY1fqcjypglaQCmDZguHSD8xrFvn/3JMfqaTJsE99wnsMPw7ttITU7y2UyoI7sRe9GLK3Y04AxMpnWOIxO2HEisX+QXhB/lthEHw2r4zAW/NRjmAy44y3ziZJlS/SLerk8RrslO8ftE2KRO+n7hvJ7G6RRVQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6tJ8DnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83953C433C7;
	Fri, 22 Mar 2024 13:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711114476;
	bh=/Awesc9BVSWbif0Zj62k5pq5AFrhPIARqy7s82jiX7U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=U6tJ8DnSa3DpC7whncBJVKojypORgaugBI/Pt3DDfazcMYtNZf/Dz4vDSJQCuCaOu
	 rIbTFWnWJWxNyMxCdL2jjA4i9g5B8KhEz6Zru6HAfYk0F9EidpeFPvIBqSLj3ug2+h
	 XlQFL3eypDk+HhTPo5A+pJBEYzr27z8X+dt7HmRrTDbDZGpa/Fs6CS+I0CwI1cgL4u
	 p9KgVW0xipIvJwy6DCeWkflaEfWVBqeeVvBBUN63M1AEZ0NJxFc4dcnaiNjHf/Rm0E
	 ZPlmURxqv9GMERH7V+wnqjXJzh+GAGxQH8b/et+5Z8d+4cWuTUFq/GqxKVS5pgklRK
	 as/orngi3+x4A==
Date: Fri, 22 Mar 2024 08:34:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: peterz@infradead.org, torvalds@linux-foundation.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas.wunner@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] cleanup: Add usage and style documentation
Message-ID: <20240322133434.GA1340126@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>

On Wed, Mar 20, 2024 at 03:04:41PM -0700, Dan Williams wrote:
> When proposing that PCI grow some new cleanup helpers for pci_dev_put()
> and pci_dev_{lock,unlock} [1], Bjorn had some fundamental questions
> about expectations and best practices. Upon reviewing an updated
> changelog with those details he recommended adding them to documentation
> in the header file itself.
> 
> Add that documentation and link it into the rendering for
> Documentation/core-api/.
> 
> Link: http://lore.kernel.org/r/20240104183218.GA1820872@bhelgaas [1]
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Lukas Wunner <lukas.wunner@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Peter, Linus,
> 
> I am starting to see more usage of the cleanup helpers and some
> style confusion or misunderstanding on best practices on how to use
> them. As I mention above, Bjorn found the writeup I did for justifying
> __free(pci_dev_put) and guard(pci_dev) useful, so here is an attempt to
> uplevel and centralize those notes.

Thanks for doing this; I appreciate it!

> +++ b/Documentation/core-api/cleanup.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========================
> +Scope-based Cleanup Helpers
> +===========================
> +
> +.. kernel-doc:: include/linux/cleanup.h
> +   :doc: scope-based cleanup helpers

Neat, I didn't know about this way of referencing doc in the source
file, although I see the markup isn't universally loved in source.
Either in cleanup.h or under Documentation/ is fine with me; grep will
find it either place.

> +/**
> + * DOC: scope-based cleanup helpers
> + *
> + * The "goto error" pattern is notorious for introducing subtle resource
> + * leaks. It is tedious and error prone to add new resource acquisition
> + * constraints into code paths that already have several unwind
> + * conditions. The "cleanup" helpers enable the compiler to help with
> + * this tedium and can aid in maintaining FILO (first in last out)
> + * unwind ordering to avoid unintentional leaks.

I'm not a data structures person, but I don't remember seeing "FILO"
before.  IIUC, FILO == LIFO.  "FILO" appears about five times in the
tree; "LIFO" about 25.

> + * As drivers make up the majority of the kernel code base lets describe
> + * the Theory of Operation, Coding Style implications, and motivation
> + * for using these helpers through the example of cleaning up PCI
> + * drivers with DEFINE_FREE() and DEFINE_GUARD(), e.g.:

Maybe:

  As drivers make up the majority of the kernel code base, here is an
  example of using these helpers to clean up PCI drivers with
  DEFINE_FREE() and DEFINE_GUARD, e.g.,:

Or just s/lets/let's/, although to my ear "let's" is a suggestion and
doesn't sound quite right in documentation.

> + * .. code-block:: c
> + *
> + *	DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
> + *	DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))

I think DEFINE_FREE() and DEFINE_GUARD() are separable concepts, so
possibly move DEFINE_GUARD to that discussion.

> + * The DEFINE_FREE(pci_dev_put, ...) definition allows for declaring
> + * variables like this:
> + *
> + * .. code-block:: c
> + *
> + *	struct pci_dev *dev __free(pci_dev_put) =
> + *		pci_get_slot(parent, PCI_DEVFN(0, 0));
> + *
> + * The above will automatically call pci_dev_put() if @pdev is non-NULL
> + * when @pdev goes out of scope (automatic variable scope). If a
> + * function wants to invoke pci_dev_put() on error, but return @pdev
> + * (i.e. without freeing it) on success, it can do:
> + *
> + * .. code-block:: c
> + *
> + *	return no_free_ptr(pdev);
> + *
> + * ...or:
> + *
> + * .. code-block:: c
> + *
> + *	return_ptr(pdev);
> + *
> + * Note that unwind order is dictated by declaration order.

Not only dictated, but it's strictly first-declared, last-unwound;
i.e., unwind order is the reverse of the declaration order, right?

> + * That
> + * contraindicates a pattern like the following:
> + *
> + * .. code-block:: c
> + *
> + *	int num, ret = 0;
> + *	struct pci_dev *bridge = ctrl->pcie->port;
> + *	struct pci_bus *parent = bridge->subordinate;
> + *	struct pci_dev *dev __free(pci_dev_put) = NULL;
> + *
> + *	pci_lock_rescan_remove();
> + *
> + *	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));

As-is, I don't see the problem with this ordering.  I also don't see
why num, ret, bridge, and parent are relevant.  I think maybe this
just needs to be fleshed out a little more with a second cleanup to
fully illustrate the problem.

> + * In this case @dev is declared in x-mas tree style in a preamble
> + * declaration block. That is problematic because it destroys the
> + * compiler's ability to infer proper unwind order. If other cleanup
> + * helpers appeared in such a function that depended on @dev being live
> + * to complete their unwind then using the "struct obj_type *obj
> + * __free(...) = NULL" style is an anti-pattern that potentially causes
> + * a use-after-free bug. Instead, the expectation is this conversion:

I don't think "xmas-tree style" is relevant to the argument here.  The
point is ordering with respect to other cleanup helpers.  I think it
would be good to include another such helper directly in the example.

> + * .. code-block:: c
> + *
> + *	int num, ret = 0;
> + *	struct pci_dev *bridge = ctrl->pcie->port;
> + *	struct pci_bus *parent = bridge->subordinate;
> + *
> + *	pci_lock_rescan_remove();
> + *
> + *	struct pci_dev *dev __free(pci_dev_put) =
> + *		pci_get_slot(parent, PCI_DEVFN(0, 0));
> + *
> + * ...which implies that declaring variables in mid-function scope is
> + * not only allowed, but expected.

A declaration mid-function may be required in some cases, but it's not
required here.  I'm not sure if adding an example to include a case
where it is required would be useful or overkill.

> + * The motivation for deploying DEFINE_FREE(pci_dev_put, ...) is that at
> + * the time of writing of this documentation there are ~590 instances of
> + * pci_dev_put(), ~70 of them with 10 lines of a goto implying that a
> + * significant number of gotos might be cleaned up for incremental
> + * maintenance burden relief.

Good motivation for a commit log, but maybe a bit TMI for long-lived
documentation.

> + * The guard() helper holds the associated lock for the remainder of the
> + * current scope in which it was invoked. So, for example:
> + *
> + * .. code-block:: c
> + *
> + *	func(...)
> + *	{
> + *		if (...) {
> + *			...
> + *			guard(pci_dev); // pci_dev_lock() invoked here
> + *			...
> + *		} // <- implied pci_dev_unlock() triggered here
> + *	}
> + *
> + * ...in other words, the lock is held for the remainder of the current
> + * scope not the remainder of "func()".
> + *
> + * At the time of writing there are 15 invocations of pci_dev_unlock() in
> + * the kernel with 5 within 10 lines of a goto.
> + *
> + * Conversions of existing code to use cleanup helpers should convert
> + * all resources so that no "goto" unwind statements remain. If not all
> + * resources are amenable to cleanup then additional refactoring is
> + * needed to build helper functions, or the function is simply not a
> + * good candidate for conversion.
> + */
> +
>  /*
>   * DEFINE_FREE(name, type, free):
>   *	simple helper macro that defines the required wrapper for a __free()
> 

