Return-Path: <linux-pci+bounces-42713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 267E3CA9DEB
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 02:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 563103011B3C
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 01:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1597621CA0D;
	Sat,  6 Dec 2025 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL/pkDqU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE62727453;
	Sat,  6 Dec 2025 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764986175; cv=none; b=gddM7QmMR7aq/Ht1uk1HUWdtaVY2Bf67RSCHvSBtM2VVEE513t7LN8oGjLqSovsyZq8/Dqyh4nOYl9qRpfA/koWv36DVIAKhQznnEdp/QPdsh2o6Qrb1AzdXUNsHPA8ku1Gjj89AMBgKK8t8lLDKES8mSGhBlGBgcbDfiHjUcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764986175; c=relaxed/simple;
	bh=iB2h2FWhRZmhtUOFjO3fWAG3PYa7RXNW7LOXxenCUPk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c+J9CVH63+5UGQe219PdrLOq1TXuQnLKZg6BvtWwfVEoqSt1/DWappWEIBqlLpbkO4caJp4SLBKpCESHwj9Tq11iZZTiJDdfWoI4g1iw8x9MsPIM8Z8yv/NFKmacCM6pfBekEW41OcRcONRpnb3aTCHVGxHwiq6kDLzwOIDLlU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL/pkDqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435F0C4CEF1;
	Sat,  6 Dec 2025 01:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764986174;
	bh=iB2h2FWhRZmhtUOFjO3fWAG3PYa7RXNW7LOXxenCUPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uL/pkDqUadcrNaKB85ABdilSBHT7Mqog1zP5/2jsp7uwGFpFGN3jI1knrMi6o7J2p
	 YUZ4p6xNS+1hdnOM6hpPuf8555JlFfIlKKJleKgEQvsJufqNq7K/ryxF5C+VKOm80Z
	 Br3gYHDXi1iYeszmFIyKtgpOt3erAVkS0OjCS8p/XOJJAj7TKA5F+1E1ub5C48vyS0
	 Hj5nPFVA7ZGtpny337J+q0k7IB+SOyqErhkXKYcQeuSvO/K1dVsh2UfjR33XMaQlsg
	 rx/Uua6f7vHcUBG8SToFwV09rfVoa/WCngUv62n0+4FSX0mVBy5KjFunPbHJP+J8xf
	 BIkTVjXev5j7Q==
Date: Fri, 5 Dec 2025 19:56:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: dan.j.williams@intel.com
Cc: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, bhelgaas@google.com,
	shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 01/25] CXL/PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
Message-ID: <20251206015613.GA3303517@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69337bc4d1943_1b2e100a9@dwillia2-mobl4.notmuch>

On Fri, Dec 05, 2025 at 04:41:40PM -0800, dan.j.williams@intel.com wrote:
> Bjorn Helgaas wrote:
> > On Mon, Nov 03, 2025 at 06:09:37PM -0600, Terry Bowman wrote:
> > > The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
> > > accessible to other subsystems. Move these to uapi/linux/pci_regs.h.

> > > +#define PCI_DVSEC_HEADER1_LENGTH_MASK  __GENMASK(31, 20)
> > 
> > Looks like a functional duplicate of PCI_DVSEC_HEADER1_LEN().
> > 
> > Why __GENMASK() instead of GENMASK()?  I don't know the purpose of
> > __GENMASK(), but I see other include/uapi/ files using GENMASK().
> > Maybe they're wrong?
> > 
> > Same questions for _BITUL() below.
> 
> See this commit:
> 
> 3c7a8e190bc5 uapi: introduce uapi-friendly macros for GENMASK
> 
> GENMASK() for a long time was not available to uapi headers since uapi
> headers can only include other include/uapi/ headers, not
> include/linux/. That commit made some common kernel bitfield helpers
> finally available to the uapi side of the house.

So are the uses I see here wrong?

  git grep "\<GENMASK\|\<BIT\>" include/uapi/

