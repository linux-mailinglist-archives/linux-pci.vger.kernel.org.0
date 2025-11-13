Return-Path: <linux-pci+bounces-41133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D593C59245
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F5C14FC83C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7032F35A944;
	Thu, 13 Nov 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2rK0EFS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E635A93C;
	Thu, 13 Nov 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051374; cv=none; b=BicYVjtrfxwr4BWJJCw7fqxPKJRw6ysxon5Go7u4a0kc6OIlhzlHw99hsEOCGajEuxSYMk7eGVZWJwrdfSyO2xZZZwUo+351c98UaaNSyP0cKPefL/VDNmLekpaWVdRc81SlzdZMPdqzdIEx95n5wMBrQZsE0+3WQfeAU9CHM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051374; c=relaxed/simple;
	bh=o4PnkyZUx4AYVVRBtOx+l6lCbnmaN+rai8Qixxl6L+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f5OiJnlQep+u4Wcmb0mOy5oRPsF+EeJVhx1Lxv9YwCKrZ0ewB9CoyocBhoESiQsh7DSZQVjg5xXcButNi9ZghuBDAHXDlenXEUPLPXhJ+GZCnjXmmLJHtYahPWDZIEaDoRMabKl0lRndPhQDhm3UUZS9i1/jAVci2SOMGeX7x9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2rK0EFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1191C4CEF7;
	Thu, 13 Nov 2025 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051373;
	bh=o4PnkyZUx4AYVVRBtOx+l6lCbnmaN+rai8Qixxl6L+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P2rK0EFSKs/CQAHyYHeYXKw/qINMyPHZ1K73aZD2yWYVFoz4BSYjwNoo+Hhexm9b3
	 1ZjdcJEBSe/cCF70DrUF7hKQ+CEIrcpB8wn6+VZm8IuaQrj3KXz5HSceHT376Phscl
	 BGBAg18oeiF76IPtS3qMaKyX4tRZD+jIo704XV8JmP7PAM0ocjBdsqkkRbO9mCCKk7
	 awZkLY/AvaEm263KeN2vRJsnljGPH+StvtePJkcPlRegrnBEjhpf+OGF2sIRD6UfJh
	 qeTQpCkXQLsNQVUkf7xPrfoyfdGVXQlYIYiJ6hjGQ8PGjxauXTR6m6IthInv/seNtS
	 8ZpaBcj2EXzCw==
Date: Thu, 13 Nov 2025 10:29:32 -0600
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
Subject: Re: [PATCH 2/9] PCI/IOV: Adjust ->barsz[] when changing BAR size
Message-ID: <20251113162932.GA2285446@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028173551.22578-3-ilpo.jarvinen@linux.intel.com>

On Tue, Oct 28, 2025 at 07:35:44PM +0200, Ilpo Järvinen wrote:
> pci_rebar_set_size() adjusts BAR size for both normal and IOV BARs. The
> struct pci_srvio keeps a cached copy of BAR size in unit of
> resource_size_t in ->barsz[] ...

Nit: s/pci_srvio/pci/sriov/  (fixed locally, FYI in case you post a v2)

I'm not sure what "unit of resource_size_t" adds here, maybe could be
removed to just say this?

  struct pci_srvio keeps a cached copy of BAR size in ->barsz[] ...

