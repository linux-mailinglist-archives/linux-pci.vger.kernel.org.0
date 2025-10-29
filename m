Return-Path: <linux-pci+bounces-39735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C0CC1DB1C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 00:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCBF18869B7
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 23:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB74311C2F;
	Wed, 29 Oct 2025 23:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFoqw0hb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D913F1A0BD6;
	Wed, 29 Oct 2025 23:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781005; cv=none; b=WcpDJyjfvhaWn2U+htOVup6IXxs+Cl+b3cXWYMl61tK1hjlLFaWFFizp993To9klthcHstYZ/2IL3S+Ypy5VMKDpEyQpo4HcGuaukFnNoUP7AIFqozOKY2OKJRdaHlAjJ56eIjEvv/jhRQT7wI/DcNCrXQlXrnGArEaYFb4hjGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781005; c=relaxed/simple;
	bh=fck7k1hPIVSb2U+bkvJUWFyiCUlbqbEKQyXu7S1GQKs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CO7yYfh/VAcfztQ25Nr0MLOW0jwEOqinCmuzvkgPHg6EE7S7iDSNNmdLjnKY5Ki09EkacbI8dxDco8+n8R65eyC7ebPERUqAXXLSYA7664hQwqJzDy+L2MFo05Ml/jnTdS39mYGQpNvjCeEAE52CJDNGjl9mFvHcOK70V9Js41E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFoqw0hb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5698DC4CEF7;
	Wed, 29 Oct 2025 23:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761781005;
	bh=fck7k1hPIVSb2U+bkvJUWFyiCUlbqbEKQyXu7S1GQKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WFoqw0hbFjfO+zHfIvL1ke04rVtmZjvjhEv5NObP4J9cUv46oC12R9ZEMyr7v01XD
	 EzBI5499NdCXyBgJp7jTZH/S+xMa8o456/DTfP6wQCNwj3rJWkXbPqm26xYzatA69F
	 P7RsllrwYUV0Xc/k34LaS0VjxcdFULf1yXaquJEzjNyoK5Rlrb0PKMXjcMpP/mXtTz
	 1vYj0kXvlv9csZ7saZZ4ldfrFjnIDCBOkXl4Y/xF8B2B9sO5HKEyfDJ9gUUSqhkTgx
	 ebBKBstVgcXNPReUsDeA+LNssBzMZuInZvsHcBQmJ+OsxRfhA8kgYn0721O4YAZpVD
	 p8rN6TYYmEqNg==
Date: Wed, 29 Oct 2025 18:36:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] PCI: Prevent resource tree corruption when BAR
 resize fails
Message-ID: <20251029233644.GA1604285@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028173551.22578-2-ilpo.jarvinen@linux.intel.com>

On Tue, Oct 28, 2025 at 07:35:43PM +0200, Ilpo Järvinen wrote:
> pbus_reassign_bridge_resources() saves bridge windows into the saved
> list before attempting to adjust resource assignments to perform a BAR
> resize operation. If resource adjustments cannot be completed fully,
> rollback is attempted by restoring the resource from the saved list.

> Fixes: 8bb705e3e79d ("PCI: Add pci_resize_resource() for resizing BARs")
> Reported-by: Simon Richter <Simon.Richter@hogyros.de>
> Reported-by: Alex Bennée <alex.bennee@linaro.org>

If these reports were public, can we include lore URLs for them?

Same question for [PATCH 5/9] PCI: Fix restoring BARs on BAR resize
rollback path.

I put these all on pci/resource for build testing.  I assume we'll
tweak these based on testing reports and sorting out the pci/rebar
conflicts.

Bjorn

