Return-Path: <linux-pci+bounces-39170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B59C02695
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 18:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FEE51AA6BD1
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A022BDC0F;
	Thu, 23 Oct 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5Rxndot"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494F92BD5AF;
	Thu, 23 Oct 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236416; cv=none; b=BNYz/VkfYjde48VdCkRpTGtpr4S5cCbmzqBftwkzg1cOqasneOiBkZfKCvVvBu9LEAH1BtudrCUphvYlqvTMbfCNkdQKE/6A7FuAOypq3gkyo3nqvMW3g+kIRSaBdNeJwffR7VdrHn6xdRJgXJJFGMTQUYWUhvsyNw7TNtYB7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236416; c=relaxed/simple;
	bh=rRPDDXxNpsWlZ6/Xjt6nPcJS/JvZvNDmte8DVh1GIvg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qqYybvw75Ewjz1ebmvH4voCb4Nq+BqtbHvQ6zPY3fyTnJ7/0VaTuhgMIjXenRrhLMqPtLnF9I6pRWazqxOcqL4fwZp3b8hkSCvmgResIn8oOAd1MHcYHpj1/S4XpxP2m2JMmNvPQ9J16nBQEJQjulFsvv0fncNFdxVolYkBWM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5Rxndot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A027CC4CEE7;
	Thu, 23 Oct 2025 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761236415;
	bh=rRPDDXxNpsWlZ6/Xjt6nPcJS/JvZvNDmte8DVh1GIvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=s5Rxndotd91+OAFCcZhGqu1lY5rUnkFxNKucSqq4WuNhK3rpyPqeuzE5OwF13gcyc
	 LoswyTZmm+7DMUlv995vPADCezgnnplo2jWh+EdTNzXuxQUVJTVG6pIwJo7TUKsTBr
	 VEyvjGerJHGwi6Tkl0ayW7won58v7CJQa4nLuqYZkEHKjY1X6FrOU8fbvqwvn4oxuO
	 qU0xu3PgqfPguW33xkb53+28EBeD2uxtDQZFGfVOQfH2gjCken0/JFQiUAEtie++p/
	 QQ4ituhjaz26LIrLGCtIrVG0BdLZkDVeebw3zHt9BIaNOkeAnMWA3vlhpRyehIcoGd
	 jSeIYBpCmtyBg==
Date: Thu, 23 Oct 2025 11:20:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: linux-pci@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	regressions@lists.linux.dev
Subject: Re: 2499f53 (PCI: Rework optional resource handling) regression with
 AMDGPU on Arm AVA platform
Message-ID: <20251023162014.GA1298313@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874irqop6b.fsf@draig.linaro.org>

On Wed, Oct 22, 2025 at 05:51:24PM +0100, Alex Bennée wrote:
> I've been tracking a regression on my Arm64 (Altra) AVA platform between
> 6.14 and 6.15. It looks like the rework commit broke the ability of the
> amdgpu driver to resize it's bar, resulting in an SError and failure to
> boot:
> ...

#regzbot ^introduced: 2499f5348431 ("PCI: Rework optional resource handling")
#regzbot title: arm64 SError panic with amdgpu BAR resize

