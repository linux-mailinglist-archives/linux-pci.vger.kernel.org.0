Return-Path: <linux-pci+bounces-41183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 099D1C5A08E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 22:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3533AB69A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 21:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB62F5A05;
	Thu, 13 Nov 2025 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTpdnjky"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAFE2F5311;
	Thu, 13 Nov 2025 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763067674; cv=none; b=Sdd5w5ohxjczofIVvUgO5z7y8XhzNMBtZKgyht2J/DU46Y2SyuQxpq+uvZKn1vt1QAD1rZ1GtXRTODKvfwE9XiRYfoZEWv29EHSoILHp50+lwbWaznva3LzmGeGovhaERRXKEPJuRE9QVPWQCHl4lEIShhSc10pDBCBaX1w5pzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763067674; c=relaxed/simple;
	bh=D3kautNBX7VHVPxLlPAzlmTDnxHyydHklCkRChinAyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=e6QTGp/YcBAJ1uirNfAn26brzwwassJSmNsMfFztB+9ZPI7jLF28NOEeB8ZZZsD68lN33UaUyK2cGfdosFyRuYI1iN+wcJj6vnZkCygFVjcKQX9Af6bgKYzcOTburo+lz/2kRj1CbkiVYVzhBEepTsaoqE1hPFSwZLg1yD4uYUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTpdnjky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496EDC4CEFB;
	Thu, 13 Nov 2025 21:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763067673;
	bh=D3kautNBX7VHVPxLlPAzlmTDnxHyydHklCkRChinAyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bTpdnjky/7MCB/iFzjyK5M0y5opSt/cCYv4pnRkBE5UmQv9ww8SxC6wRdatRUKoZ4
	 3wxv6DBOILB5LDPnVp80+6TbkEuEKHzwLP/u/l20D3iMRM3huZYvNJPsLwW+kPbSdl
	 PE0pbkUlDTDoLNx+3whvnslxuYur0X9iONuYXad64Ye4hNogw6MjU4gDu4rbfTDjGR
	 aYZY3glOwqDGUi3h2PkIxgQGibPMCcehySTzPaDTwLaDQPwoaZI5JWV14G0rPRIBwX
	 vcYycL4RHepuBRnELvOyIG/TNeGLd7eBO06oIsyzE5TqxbjU9EZybRzrPqcieQ7Zko
	 pDBc36To+lo1w==
Date: Thu, 13 Nov 2025 15:01:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/11] PCI: Fix restoring BARs on BAR resize rollback
 path
Message-ID: <20251113210112.GA2314791@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba725a72-7863-3dd2-6ba2-ff2259229bbe@linux.intel.com>

On Thu, Nov 13, 2025 at 06:46:07PM +0200, Ilpo Järvinen wrote:
> On Thu, 13 Nov 2025, Ilpo Järvinen wrote:

> > -int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
> > +int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size,
> > +				     int exlucde_bars);
> 
> It seems I managed to mistype this in the prototype, please let me know if 
> you want me to send v3 addressing this and the other comments.

Fixed this one, thanks.

