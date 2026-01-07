Return-Path: <linux-pci+bounces-44216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45855CFFB92
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 20:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 698CB309AD88
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5DA33D6E1;
	Wed,  7 Jan 2026 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm3mvFXY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0463733291D;
	Wed,  7 Jan 2026 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810141; cv=none; b=Q0HJtB8lbrREjkHpjm7MdoSTEmL1Xe0y/tvMskn310FME/7NP+hFIpMEWV0KYlAlSWWQIsczpNs+dY5bv48aEt6YuAYK3kdLh3FxKZKcuAo3DNzWe4hq+to20088QdHM4SzFVf5VDkpkjuAXGGH6fXcdsMbgF2SqsjeTW+3T2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810141; c=relaxed/simple;
	bh=GJAdPBl3buHrqZGTq+uHvhNjF7Ltxd2tIwrKt8BbQPs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=hlsE4SWaKkaGwntr8Re4I7Ou7LrkV6aFFnvYXAdSUp+InozEO4k4o6p7Jak0Uuf/r5h4cDajVY17NBUn73egPJLxOwg9e9cZOVxuK5ZmJ3BNt53XCs2bk1s/BMOAX4O9jpk1Xu+I5c2zkaCJIT+vdtGWf0pyYAEtf857Xbi6lu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nm3mvFXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E06C4CEF1;
	Wed,  7 Jan 2026 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767810140;
	bh=GJAdPBl3buHrqZGTq+uHvhNjF7Ltxd2tIwrKt8BbQPs=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=Nm3mvFXY7r2bj+qNF4+NI/sAK50pNiYSuNWuqkVNZ4r0kO+D3OHrVE5CJf3akQDBf
	 zadPDQpIaFHIIQsu7BGjO4xY29R5z8pWsKCXToFWQo/GBoIQwuTcGLnkLDvJKdXJdX
	 t0MzB4eN1XNnt3k0TwyhC6ZhdkwhtihaxDEG9wj1vlrxo1F3g+sRs3WjMKeCoTithb
	 7B2LiDcFvezaujwda5zb1iz5f+0GgsxGNceov94TG4ma5WpW3oqcspsVwmjBoDECih
	 Cz3yun/72qa2rpPmckf/pk4bfUsPqgjgWw3mYqKDB/+TqwAPjod/NCLGRtGoT723de
	 Pu4KgXbLZHrTQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Jan 2026 19:22:15 +0100
Message-Id: <DFIKE4Z23Q0O.2ZC7FR40XO8SR@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/3] driver core: Add NUMA-node awareness to the
 synchronous probe path
Cc: <alexander.h.duyck@linux.intel.com>, <alexanderduyck@fb.com>,
 <bhelgaas@google.com>, <bvanassche@acm.org>, <dan.j.williams@intel.com>,
 <gregkh@linuxfoundation.org>, <helgaas@kernel.org>, <rafael@kernel.org>,
 <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
To: "Jinhui Guo" <guojinhui.liam@bytedance.com>
References: <20260107175548.1792-1-guojinhui.liam@bytedance.com>
 <20260107175548.1792-3-guojinhui.liam@bytedance.com>
In-Reply-To: <20260107175548.1792-3-guojinhui.liam@bytedance.com>

On Wed Jan 7, 2026 at 6:55 PM CET, Jinhui Guo wrote:
> + * __exec_on_numa_node - Execute a function on a specific NUMA node sync=
hronously
> + * @node: Target NUMA node ID
> + * @func: The wrapper function to execute
> + * @arg1: First argument (void *)
> + * @arg2: Second argument (void *)
> + *
> + * Returns the result of the function execution, or -ENODEV if initializ=
ation fails.
> + * If the node is invalid or offline, it falls back to local execution.
> + */
> +static int __exec_on_numa_node(int node, numa_func_t func, void *arg1, v=
oid *arg2)
> +{
> +	struct numa_work_ctx ctx;
> +
> +	/* Fallback to local execution if the node is invalid or offline */
> +	if (node < 0 || node >=3D MAX_NUMNODES || !node_online(node))
> +		return func(arg1, arg2);

Just a quick drive-by comment (I=E2=80=99ll go through it more thoroughly l=
ater).

What about the case where we are already on the requested node?

Also, we should probably set the corresponding CPU affinity for the time we=
 are
executing func() to prevent migration.

> +
> +	ctx.func =3D func;
> +	ctx.arg1 =3D arg1;
> +	ctx.arg2 =3D arg2;
> +	ctx.result =3D -ENODEV;
> +	INIT_WORK_ONSTACK(&ctx.work, numa_work_func);
> +
> +	/* Use system_dfl_wq to allow execution on the specific node. */
> +	queue_work_node(node, system_dfl_wq, &ctx.work);
> +	flush_work(&ctx.work);
> +	destroy_work_on_stack(&ctx.work);
> +
> +	return ctx.result;
> +}

