Return-Path: <linux-pci+bounces-17222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CD19D632D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 18:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42E51617E7
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 17:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2F31DF742;
	Fri, 22 Nov 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVQyCy72"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6052E40B;
	Fri, 22 Nov 2024 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296666; cv=none; b=WnMVzIBkzc3RYRc04b6u3PUBKl4YVsvCRGPMfIVIf9eTeaVw4JkDt6mbcqJnLrWvYk6PtFfNk8pT1efbPvXyu1/LDjwv7sSV2RhCZSn52mUFqTB3BaS10cR9C7uQ3KtAyCoAD2RXT++F9Vt22aFbCynqmq+BwAnjVanPBKiUNco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296666; c=relaxed/simple;
	bh=wBRqCsItS+i4siZ71y2qQf0vBKXU+yZWPzOSfE5vasI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Z9rWNGqTmx0NeII3rSiH6OcpYsDUF+HgLq/H0ajAb5U+YoN7I0DXyTtmgekgh5hB5QsQHWoecfU/102zgqDqeD5tXcrYiiLnT79k/DLv7CnMwTTScocz6k6RMFhlwHTZfeWnQuqXTGT3A6IuxdBDWMnFKJT+qWoA3ATc+Jj+6Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVQyCy72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCA6C4CECE;
	Fri, 22 Nov 2024 17:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732296665;
	bh=wBRqCsItS+i4siZ71y2qQf0vBKXU+yZWPzOSfE5vasI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iVQyCy72cBp9avZdk6ECaO5qzcYaRbUo93dTCfFgRAOpvJC5OuD5J9k856zUPzWo3
	 rkE2Gay7Ouq2g5xK6wdZiUh+ILD4iVcHUdKk39ahO5k6EPyWOs3SH6XnjIBzAmTobN
	 eD6mzCkcckM43848CDWacleG7MlU36PIuTlNNBX/mr5MjS4bocCLKMDq15cwboJLs/
	 T2Im24O0AXExk9K7taMW/vps2eWMLZtBAv7IGWAZ0hJPCJ+6Zhg+XsyJqxl75NwOxy
	 LSikWSe3K9PLvQ7C8mvC/GiOJhryWoPQ35021Ghn8t34TmFzrxur0kTZK543Pu1F/V
	 aT/xttu/m6muQ==
Date: Fri, 22 Nov 2024 11:31:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alistair Francis <alistair@alistair23.me>
Cc: lukas@wunner.de, Jonathan.Cameron@huawei.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	bjorn3_gh@protonmail.com, ojeda@kernel.org, tmgross@umich.edu,
	boqun.feng@gmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com, alistair23@gmail.com,
	alex.gaynor@gmail.com, gary@garyguo.net, aliceryhl@google.com
Subject: Re: [RFC 3/6] lib: rspdm: Initial commit of Rust SPDM
Message-ID: <20241122173104.GA2432309@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115054616.1226735-4-alistair@alistair23.me>

On Fri, Nov 15, 2024 at 03:46:13PM +1000, Alistair Francis wrote:
> This is the initial commit of the Rust SPDM library. It is based on and
> compatible with the C SPDM library in the kernel (lib/spdm).

> +++ b/lib/Kconfig
> @@ -754,6 +754,23 @@ config SPDM
>  	  in .config.  Drivers selecting SPDM therefore need to also select
>  	  any algorithms they deem mandatory.
>  
> +config RSPDM
> +	bool "Rust SPDM"
> +	select CRYPTO
> +	select KEYS
> +	select ASYMMETRIC_KEY_TYPE
> +	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +	select X509_CERTIFICATE_PARSER
> +	depends on SPDM = "n"
> +	help
> +	  The Rust implementation of the Security Protocol and Data Model (SPDM)
> +	  allows for device authentication, measurement, key exchange and
> +	  encrypted sessions.
> +
> +	  Crypto algorithms negotiated with SPDM are limited to those enabled
> +	  in .config.  Drivers selecting SPDM therefore need to also select
> +	  any algorithms they deem mandatory.

Maybe this (and config SPDM) should be tweaked to mention drivers that
*depend* on SPDM or RSPDM, since they no longer use "select"?

PCI_CMA, which currently depends on SPDM, doesn't really look like a
"driver", so maybe it should say "users of SPDM" or "features
depending on SPDM" or something?

