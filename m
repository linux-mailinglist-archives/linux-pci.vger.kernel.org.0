Return-Path: <linux-pci+bounces-18152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E47D9ECFB6
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 16:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC1C1888BF1
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 15:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33631AC88A;
	Wed, 11 Dec 2024 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHgXlIQS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42261AA1C4;
	Wed, 11 Dec 2024 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930944; cv=none; b=nwppIAcZs8siE4NGyApd3SDw3lQa32sTXBJiu0jUDZeJ1abAOT0uOsamPjsrvbYt5k3kFFNhyx7+97aqVKdAzFlM0riWLFxMU5VwtJaiojB0kOHZv6yLDLoi4OmSzYg2+h0f0EIs2zDq8jnqdvHwXGXcevy99VopAaBlkrkqxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930944; c=relaxed/simple;
	bh=TAkXGoru7IboFNheO16srMs+Hv5/y72CCn02eUzuyLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5mVkS/tdNlBlJel+bnsUYfYpE3Vm25DT0seMj7A+ZuINeJQ/n43MdtsZU7CyQglQ1X0/7A2VGY/4fC6ecgoZeNNLGf4TcYFUEsMK/wYs0BkP82kNAIt80b+Ly7aNOouuzxjGX9gY0eINHawDyzGl6b9EImfEU1wnCESHMJWzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHgXlIQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D080C4CED2;
	Wed, 11 Dec 2024 15:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733930944;
	bh=TAkXGoru7IboFNheO16srMs+Hv5/y72CCn02eUzuyLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHgXlIQS5eH2JmCMGpmZPM3HedoUkg84SHg9kmruUuiNuDtG8QDl7H9t36d5WxEr5
	 aXrrnqQPNu6bNZvZ9mVaybvDJFw3N6gl8it+sISL8MZFDk5IQIadFCvyYky3GRWpK/
	 QHgF9I/k74OIcP2X/f1ghbYfyNdIOjgF65uSPv5RwonYOB4RHY26yWOG17CJy1l7Uk
	 RNZGin55Y5nDXqx2JBI/1yuTAXYr77znMJsV3ecZFqUU1jW2b2nDQ7StuVWthpA/Xs
	 1UZ2YWHIr+edDF9GGvVGCVwK6Jfo/guMgaO9dYAxSf5qRbN81YGMPtqyT2cPw8nQoV
	 zeik5zrE7WbKA==
Date: Wed, 11 Dec 2024 09:29:02 -0600
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
Subject: Re: [PATCH v5 15/16] samples: rust: add Rust platform sample driver
Message-ID: <20241211152902.GB2906470-robh@kernel.org>
References: <20241210224947.23804-1-dakr@kernel.org>
 <20241210224947.23804-16-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210224947.23804-16-dakr@kernel.org>

On Tue, Dec 10, 2024 at 11:46:42PM +0100, Danilo Krummrich wrote:
> Add a sample Rust platform driver illustrating the usage of the platform
> bus abstractions.
> 
> This driver probes through either a match of device / driver name or a
> match within the OF ID table.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  MAINTAINERS                                  |  1 +
>  drivers/of/unittest-data/tests-platform.dtsi |  5 ++
>  samples/rust/Kconfig                         | 10 ++++
>  samples/rust/Makefile                        |  1 +
>  samples/rust/rust_driver_platform.rs         | 49 ++++++++++++++++++++
>  5 files changed, 66 insertions(+)
>  create mode 100644 samples/rust/rust_driver_platform.rs

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

