Return-Path: <linux-pci+bounces-16917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3FF9CF375
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525D428CCCE
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A96A1D90BD;
	Fri, 15 Nov 2024 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwqQXXfO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEE31D90BC;
	Fri, 15 Nov 2024 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693514; cv=none; b=NooMaRF3dcUySI1cyuTs0rJsqIcMX8HWmL2mGg12PtX0UCLhbI0xoOOeg1cStA4nrbzE5vv3weKsq9tOGnvciYtQK5wvdyEbm1fJ4x+3DhC0KjPbFeEwbN59eP8AYKIaW5KSbKFT1ppR9Jnq9/ro2tLwB1jhSC8kSagBZ5mUwu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693514; c=relaxed/simple;
	bh=ZGRCi8zZpH1Uctw/XTMyPaVtMQl4V2RnetddnPHqEyU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KlWgtAO/SaBv8R4pQBkKqAKKjSmUuiaGJjPXWLst62pWZqXlVLPaIGWv3FQTp2NLlGwU49j1ESvtdir2/aIGu9PqiQV3rKd03/NvQ51OnA5IT0dvzNpgrFVwkeLShSTz+OmMGBx7tQA3QLSzwAWI2Nfu/TMQpCaGdMJ1gtI4olg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwqQXXfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7616C4CED5;
	Fri, 15 Nov 2024 17:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731693513;
	bh=ZGRCi8zZpH1Uctw/XTMyPaVtMQl4V2RnetddnPHqEyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CwqQXXfOYKt/19FjBfzUtwWA+vQ+sfWs9jcfK40mafcm4pdVqMzz66zAa2c2o4RbG
	 4bfky51b38tp/3hKJ91q9zEMi0XJE3c4hhOWUGo2y9HUf75TBm5AHyLgWEXrX9fvDr
	 UMgcn56FtP9RETMp9auY6mCb4lLxO51XoHrct1FVOGtY3hcO1wskRPWOYftmz/u3QK
	 NH0G+b0WMy3cTHGJG7uLf9Rkwz3qlz8K7IL2G5tlz38YVVqwf4VIYxBxkWbP6K/mIC
	 NrQ/BKJfWDlClUfO4oYaXCKp44I55y26PZ+btkj2dlhVBTpCJo8wlaaanfFikUqemc
	 cBBZFmVe4jj4g==
Date: Fri, 15 Nov 2024 11:58:31 -0600
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
Subject: Re: [RFC 2/6] drivers: pci: Change CONFIG_SPDM to a dependency
Message-ID: <20241115175831.GA2046032@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115054616.1226735-3-alistair@alistair23.me>

On Fri, Nov 15, 2024 at 03:46:12PM +1000, Alistair Francis wrote:
> In preparation for adding a Rust SPDM library change SPDM to a
> dependency so that the user can select which SPDM library to use at
> build time.

Run "git log --oneline drivers/pci" and follow the existing
subject line convention.

> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/pci/Kconfig |  2 +-
>  lib/Kconfig         | 30 +++++++++++++++---------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index f1c39a6477a5..690a2a38cb52 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -128,7 +128,7 @@ config PCI_CMA
>  	select CRYPTO_SHA256
>  	select CRYPTO_SHA512
>  	select PCI_DOE
> -	select SPDM
> +	depends on SPDM
>  	help
>  	  Authenticate devices on enumeration per PCIe r6.2 sec 6.31.
>  	  A PCI DOE mailbox is used as transport for DMTF SPDM based
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 68f46e4a72a6..4db9bc8e29f8 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -739,6 +739,21 @@ config LWQ_TEST
>  	help
>            Run boot-time test of light-weight queuing.
>  
> +config SPDM
> +	bool "SPDM"

If this appears in a menuconfig or similar menu, I think expanding
"SPDM" would be helpful to users.

> +	select CRYPTO
> +	select KEYS
> +	select ASYMMETRIC_KEY_TYPE
> +	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +	select X509_CERTIFICATE_PARSER
> +	help
> +	  The Security Protocol and Data Model (SPDM) allows for device
> +	  authentication, measurement, key exchange and encrypted sessions.
> +
> +	  Crypto algorithms negotiated with SPDM are limited to those enabled
> +	  in .config.  Drivers selecting SPDM therefore need to also select
> +	  any algorithms they deem mandatory.
> +
>  endmenu
>  
>  config GENERIC_IOREMAP
> @@ -777,18 +792,3 @@ config POLYNOMIAL
>  
>  config FIRMWARE_TABLE
>  	bool
> -
> -config SPDM
> -	tristate
> -	select CRYPTO
> -	select KEYS
> -	select ASYMMETRIC_KEY_TYPE
> -	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> -	select X509_CERTIFICATE_PARSER
> -	help
> -	  The Security Protocol and Data Model (SPDM) allows for device
> -	  authentication, measurement, key exchange and encrypted sessions.
> -
> -	  Crypto algorithms negotiated with SPDM are limited to those enabled
> -	  in .config.  Drivers selecting SPDM therefore need to also select
> -	  any algorithms they deem mandatory.
> -- 
> 2.47.0
> 

