Return-Path: <linux-pci+bounces-36190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208C1B5839D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 19:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EF92056DC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 17:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBC027A103;
	Mon, 15 Sep 2025 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMzJVgK7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016AA1FDA61;
	Mon, 15 Sep 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757957299; cv=none; b=khaWTjBkH9OEjQ7im+YZziWG8X8ue7WNsfKJBgE3noJrnO52qn0U9N+f79PSelcwC4VSqBUGlWQ2ni0kALX3FWzT3mVx+56sf4TMqtql+sXa9HzWobxuJn/HN3RLtg9S9wLU6nluEtcJ1q6gjexBjcyAUKDou+wGJSia972mTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757957299; c=relaxed/simple;
	bh=WBrowgOToiif9/SwrzeA8YZAkvq+V1SbWNrN6GETuZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdP8psNotDs7AcXqutLVNCkesiyBYiwJVdBTrOOBFxvBzAVWeFd24didEPcUnC7lu+3Jnyub8guITkYWcnbwZbPsD//ZZONSJkiXXK4VJOLT1ni3lMIhpLp5rw4oyR8w13ZZr8OBsolFmDi1reyjgN9SfwZyDO2VIq8zu08d2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMzJVgK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA87C4CEF1;
	Mon, 15 Sep 2025 17:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757957298;
	bh=WBrowgOToiif9/SwrzeA8YZAkvq+V1SbWNrN6GETuZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMzJVgK7y3SLp1fQzrQIWbdZSzzhJca+3uQ+8F092ypr5PzejwQYLqWOEIl1Fg5GQ
	 fQ2TIzITlcaP1ZCBbi5xRZzK6Czh8QEvjhZLe1wbXfKEg02QgaE3x3qTKsOHox2rFD
	 0HCcQLblpJoNGdLvtsfgiF/ithkqjY5mSxtQRLs9FeJP5KnH7g4zLPD7jKzbinsbv4
	 FfcyJyXuVUyOkZcHThzQx2qp/6RnLSNZPjiTaddSBOOntSPHUrLbLSzjF+13Bv66d1
	 3fzJy1DeWqICpjFLiP3wHkPEsrvSiuQvH8NJ4icQ1djOnZ6d2C+R6EeZPrKbF6Tw4R
	 OSNW0NChAg8ww==
Date: Mon, 15 Sep 2025 19:28:15 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, "Michael J . Ruhl" <mjruhl@habana.ai>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 05/11] PCI: Add pci_rebar_size_supported() helper
Message-ID: <cduh4ave3lbdgd2kutfhgf3obf3wuskgxf6rrhggsiksw7wrwa@lqly5npj5g3r>
References: <20250915091358.9203-1-ilpo.jarvinen@linux.intel.com>
 <20250915091358.9203-6-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915091358.9203-6-ilpo.jarvinen@linux.intel.com>

Hi Ilpo,

> +/**
> + * pci_rebar_size_supported - check if size is supported for BAR
> + * @pdev: PCI device
> + * @bar: BAR to check
> + * @size: size as defined in the PCIe spec (0=1MB, 31=128TB)
> + *
> + * Return: %true if @bar is resizable and @size is a supported, otherwise
> + *	   %false.
> + */
> +bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size)
> +{
> +	u64 sizes = pci_rebar_get_possible_sizes(pdev, bar);
> +
> +	return BIT(size) & sizes;

I would return here "!!(BIT(size) & sizes)", but it doesn't
really matter.

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi

