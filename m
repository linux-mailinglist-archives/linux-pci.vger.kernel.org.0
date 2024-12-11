Return-Path: <linux-pci+bounces-18151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F2F9ECFB0
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 16:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE9D166B62
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4531ABEA1;
	Wed, 11 Dec 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6gYo1gK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3997117736;
	Wed, 11 Dec 2024 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930828; cv=none; b=iQaL59P4PZKT1AOw+gLdVfx/OKIyi9cI67Ui/J+XUWzjn5HwUdOaqE1v+D3tkt/kNvGOatKDfx+Xa06sqG7zrB+bwjRDY9FNR8IuT9CNX5vfjTNGpd61ekTKgV99C7Gt6U6h8cXLMa8Q/eWFNSdWfkJ83z75qaBAYr4J/cs2LpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930828; c=relaxed/simple;
	bh=BKIP6Fts7P9VMVBcKntIxvtkkTHt1ZG9kg8V7SXwY/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yf0b45wD7aRWrysJ4jMgUCticRpPxqJfCaTZ7arN3cGFIxJYwCU4MhfcgL1OJI09HPj24wmzguOaWNKiJo6k355TSW+Orar5Mnfx/1I3sRZAvGLsBvzEpj+go1G9zRTylv9OuMc6MNMPpeEU5N679VST1NG/kKCBkbPLXHlMnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6gYo1gK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967EAC4CED2;
	Wed, 11 Dec 2024 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733930826;
	bh=BKIP6Fts7P9VMVBcKntIxvtkkTHt1ZG9kg8V7SXwY/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6gYo1gKS1TNb34aBzsmRZ3OY5SEP9rvNWACpNpHnclMjKTxwiyPLxhoftQhiGAme
	 tLFm0boXwqIO2PVppDOclyPQ5aiEuigwFJTyZQj3A4oiE+SiXmDTtek8iYBzrzBx8q
	 vwH49vHmbS95ScOZV9vx/LvkPnYkt08tQg5+UA7Pfl01ufiifSKUoUiV9WZoV5NVYV
	 Rn9EuR4TeX/M8Pyoe3pEmpItrEDp0BryTSl9oYTK9NHCgcVdaYkGqNRPwb7tXg9wAQ
	 4/0Z9AeITSZ07I3lYUsSiJu4jgLAs6+RqOJ1jlDUR/qS39YLWNwUEAMF75vNfRf2BZ
	 g4kkIVa/kR3VA==
Date: Wed, 11 Dec 2024 09:27:04 -0600
From: Rob Herring <robh@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 14/16] rust: platform: add basic platform device /
 driver abstractions
Message-ID: <20241211152704.GA2906470-robh@kernel.org>
References: <20241210224947.23804-1-dakr@kernel.org>
 <20241210224947.23804-15-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210224947.23804-15-dakr@kernel.org>

On Tue, Dec 10, 2024 at 11:46:41PM +0100, Danilo Krummrich wrote:
> Implement the basic platform bus abstractions required to write a basic
> platform driver. This includes the following data structures:
> 
> The `platform::Driver` trait represents the interface to the driver and
> provides `platform::Driver::probe` for the driver to implement.
> 
> The `platform::Device` abstraction represents a `struct platform_device`.
> 
> In order to provide the platform bus specific parts to a generic
> `driver::Registration` the `driver::RegistrationOps` trait is implemented
> by `platform::Adapter`.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  MAINTAINERS                     |   1 +
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/platform.c         |  13 +++
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/platform.rs         | 193 ++++++++++++++++++++++++++++++++
>  6 files changed, 211 insertions(+)
>  create mode 100644 rust/helpers/platform.c
>  create mode 100644 rust/kernel/platform.rs

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

