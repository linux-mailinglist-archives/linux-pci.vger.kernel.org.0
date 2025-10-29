Return-Path: <linux-pci+bounces-39655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83609C1BB07
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D45C1349F8F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 15:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F0A329366;
	Wed, 29 Oct 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtcHDpte"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24F29DB65;
	Wed, 29 Oct 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752005; cv=none; b=KW8UyvehA6IOL9FJ7lhbFO8fuBcl2kw3l4c6yobMWMAirkOP1R79pRxLVPhBJ35zLyBSu10N5Xn8xdgHIT/7iwldPgu5OSxrd2GfItocOgE4iOosQFD7n8KS+kgMC6GAY3proJa0XKO71LK1rNAGF6gJV1ZnMtP+mtM3TALIOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752005; c=relaxed/simple;
	bh=YkjLzcWzu5npTsZdcICWCghQ3/qLgL8lA0vFu7y9i0k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qBL8kUFHcqQXnxbDzy+ujMsQWAh/uYMBsBwKE1604u0+mSZBJ+KKwawqWIbuxoKYgaob+spHcJiTHQmW4HLZ2Na3CK89u1ZvNa3ivE+ZzaO9Q2fs72Bej3LraxITWhHw3TUwj+O6y3furweSRqa8Acb7wyN+i/sz6/OJaL1R2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtcHDpte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564A6C4CEFF;
	Wed, 29 Oct 2025 15:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761752005;
	bh=YkjLzcWzu5npTsZdcICWCghQ3/qLgL8lA0vFu7y9i0k=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=OtcHDpteJ1TPbr24tR7zT2T58Naxe5x/irqXJn+5UtA4jmPHKQGbxJkzXm6YgegOM
	 HYCrlOfD2WHYBXpgaaymGsN1J33dv3Iyg1E2zoswD+kx47v7b8iGFV7tzGy26ELZ4z
	 Fl/jnuQTRUH1B2qwm6z99CUrWsdMCe+uFjpcEvLOl2H1HriDEtUD0sUqmUrADkECwM
	 l/DMUlTcyhvOfWEx3TYnhgqij5ECCya4d/9/XO14mOX/laXPjWP1+3YkNeto0v6QIA
	 UgonmDzY1vdb2VpkirZPFWEOefvso1ift1Jrl23B5/faHrU9boOsu0ihcSxSpSZTZa
	 okFsu9ZBPQ7lQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 16:33:19 +0100
Message-Id: <DDUWYNJTZ7RT.3ML0O9UNX5LON@kernel.org>
Subject: Re: [PATCH 0/8] Device::drvdata() and driver/driver interaction
 (auxiliary)
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <acourbot@nvidia.com>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <pcolberg@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251020223516.241050-1-dakr@kernel.org>
 <aQIQl8lMhztucZhK@google.com>
In-Reply-To: <aQIQl8lMhztucZhK@google.com>

On Wed Oct 29, 2025 at 2:03 PM CET, Alice Ryhl wrote:
> It looks like there are some patches that add code that doesn't pass
> rustfmt, which are then fixed in follow-up commits. You might want to do
> a pass of rustfmt after each commit.

Oops, thanks for catching this -- my apply scripts will do exactly that. :)

> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

