Return-Path: <linux-pci+bounces-41266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E81FC5EE4F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 19:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5398735A542
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 18:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F483314DD;
	Fri, 14 Nov 2025 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTdhkQKU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF263218BA
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144860; cv=none; b=EVAQTxzYVQ1B4U/N4FGJmGzLN8Wy1FSVrJXwLj/lmRUYQR0rIEyqX01VuxfakYvTw4eWxpiNoyzMgbS1WvDgJ32RbOPvcGZ0bhxUmAMfcnkmWgR1QwtdtXEmb4LFkYvXstpAfXxc/OIHD0ukenacvd+u7FriI26eOCoMAIzipks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144860; c=relaxed/simple;
	bh=cYXp6vTHKD4+5HKyKDsS0LI6yssoViJnuOJ6XQWYNp4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tpB/cdY64/Dgz9dg7XyR5JyFxKBi1LjhIbL4mna1avGMlHlH5d0qBjJK0Bb7mz6yQiGLITwzMs8fKy6igFd+mc1cUGDhsUMhxWv57FDO7fuPGWvev/SKoj/Li5JDq1KvhK7LRVpeC3pcrR/4sE/vcjabg9dmdY5d75wcp86NVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTdhkQKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B82C4CEF1;
	Fri, 14 Nov 2025 18:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763144860;
	bh=cYXp6vTHKD4+5HKyKDsS0LI6yssoViJnuOJ6XQWYNp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hTdhkQKUi+PzhqiZrzsNxYV1ZF5i4s0dFL6ShBnirq9JvKqzo9WAtxlC9K4xNqREZ
	 jMGFeVLCfm1GpAMgDDxYAhrOiDpRjmb0u2p8xMH3jLfpdHiGDgrjkPSTtOccX39msM
	 QM0WIB+6+G1UIPFetlm0KsaA/yfiESW8bp2goJmd2NZ5COFKDrpjYKw4uvMvLEOPiT
	 mjfAYyUCSTgc6Fqf4hyEBUlOChgPM8dgsfooBUkuXLZTBnJT9yFRS0GEX9IsPhlSUA
	 lguFbUfMC0HYHxc/aswttWcArBbW3HbO2hNr+04smAX5GEmhFnLZUl8dAI8bL4J4X1
	 fUo+3KX2gZjNA==
Date: Fri, 14 Nov 2025 12:27:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
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
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Subject: Re: [PATCH v2 00/11] PCI: BAR resizing fix/rework
Message-ID: <20251114182739.GA2332823@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pl9lot9r.fsf@draig.linaro.org>

On Fri, Nov 14, 2025 at 09:30:56AM +0000, Alex Bennée wrote:
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> writes:
> 
> > Hi all,
> >
> > Thanks to issue reports from Simon Richter and Alex Bennée, I
> > discovered BAR resize rollback can corrupt the resource tree. As fixing
> > corruption requires avoiding overlapping resource assignments, the
> > correct fix can unfortunately results in worse user experience, what
> > appeared to be "working" previously might no longer do so. Thus, I had
> > to do a larger rework to pci_resize_resource() in order to properly
> > restore resource states as it was prior to BAR resize.
> >
> > This rework has been on my TODO list anyway but it wasn't the highest
> > prio item until pci_resize_resource() started to cause regressions due
> > to other resource assignment algorithm changes.
> 
> Thanks I'll have a look.
> 
> Where does this apply? At least v6.17 doesn't seem to have
> pbus_reassign_bridge_resources which 4/11 is trying to tweak.

This is based on v6.18-rc1 and is applied here:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=resource

I expect some conflicts with d30203739be7 ("drm/xe: Move rebar to be
done earlier"), which appeared in v6.18-rc2, and possibly with other
DRM changes planned for v6.19.

Bjorn

