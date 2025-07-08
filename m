Return-Path: <linux-pci+bounces-31664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02201AFC50D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 10:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10B81AA7A81
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 08:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33A42BCF6F;
	Tue,  8 Jul 2025 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rUnGXuTp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7830F2BCF4D;
	Tue,  8 Jul 2025 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962035; cv=none; b=MVaan2i52fF18XRVvpKvVk7q0CBw3OjPLRPLPkEumC/FfpMEKEN2LniPT+b+t7cH2MWzwRWF/arwiDrXrKxGXtdwrzpDfBIEED8L9H5BXbI+aVNuFrcML99OCQrHuf6BR7M0uWIYt3KGkLMLFXoo3kqHhay/UBLqrPB204RlXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962035; c=relaxed/simple;
	bh=HrHtM7sJE2xFVo6cAcEdVsvAypCb0Ki8ifZxZVG9Dz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMDG1GR131PrCNqrKxXwWD1OY5RTQ995bJD2UffVUmNOrWHT1gpVBcorG+CTfXV6r0EX/v11efg2/Jc3lUMcI7EGrKQFoxGA/EfnjHH36rWnD49gOoWTvaKCt/FyLySIreReRH23igMKCXKup4+qZwZ65pjLq9Xcni9kzS0qDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rUnGXuTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B95C4CEFD;
	Tue,  8 Jul 2025 08:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751962034;
	bh=HrHtM7sJE2xFVo6cAcEdVsvAypCb0Ki8ifZxZVG9Dz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUnGXuTpHs7ek6SLsQsaJetj0As6wqY7XnKJZwC4f0nVRfLT/ZD7lUHs7T2zsQGzz
	 o2Ogq3GA4MkpdE78ml73cZFa4xmXDt7V6Nb6USxt3MI7A+fJmpPVXNJ+kIRfvpBMpH
	 yFWQl4Fb2r+5Y5vifwQwlrxJqqkUNlHRAIUZ0Fvs=
Date: Tue, 8 Jul 2025 10:07:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: Add several miscellaneous PCI helpers
Message-ID: <2025070856-ferris-enjoyable-f2de@gregkh>
References: <20250708060451.398323-1-apopple@nvidia.com>
 <20250708060451.398323-2-apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708060451.398323-2-apopple@nvidia.com>

On Tue, Jul 08, 2025 at 04:04:51PM +1000, Alistair Popple wrote:
> Add bindings to obtain a PCI device's resource start address, bus/
> device function, revision ID and subsystem device and vendor IDs.


Do we have a user for these new helpers already?

thanks,

greg k-h

