Return-Path: <linux-pci+bounces-17237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5364C9D69ED
	for <lists+linux-pci@lfdr.de>; Sat, 23 Nov 2024 17:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0267B211D6
	for <lists+linux-pci@lfdr.de>; Sat, 23 Nov 2024 16:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7597DA79;
	Sat, 23 Nov 2024 16:14:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F171D545;
	Sat, 23 Nov 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732378458; cv=none; b=RV6tL8XwWb56t41901dzMVdXsRoYIue3eY6OyAHNsBsbr6hhQ2M8w97fVa6Jqevaix3UwfuVzA5ciuYCVuP8pas/H8EXyHwXai1t49dE1swDtXGwV5jOVP/+sYDGMh4JMme+cyfI7XisAv/KXdUhJFMcuFEQ8ENAJHYepIzybaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732378458; c=relaxed/simple;
	bh=HRvM1IslAbrTkck5NoxkGSQcBIsd+bujipNjiBqdrcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJWCe+Hcy2+mc53ITYell0leFmR7+d4ENF9iMt1TqqznQDQEV393x7Ak4D4UXCbt2Q4dE1eQWpgpfvQHV0l94VUt0clD+kFlHC2+lYb6rg9GzLBRbm05Tk2fxp0HlYlD5H0rtvnS3KpXHodrRi8VKzxK5/CLJ4dM5xaBlZBOBdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id A1EF330000950;
	Sat, 23 Nov 2024 17:14:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8B6903CEA09; Sat, 23 Nov 2024 17:14:05 +0100 (CET)
Date: Sat, 23 Nov 2024 17:14:05 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alistair Francis <alistair@alistair23.me>, Jonathan.Cameron@huawei.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	bjorn3_gh@protonmail.com, ojeda@kernel.org, tmgross@umich.edu,
	boqun.feng@gmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com, alistair23@gmail.com,
	alex.gaynor@gmail.com, gary@garyguo.net, aliceryhl@google.com
Subject: Re: [RFC 3/6] lib: rspdm: Initial commit of Rust SPDM
Message-ID: <Z0H_TYOPegVrkM9o@wunner.de>
References: <20241115054616.1226735-4-alistair@alistair23.me>
 <20241122173104.GA2432309@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122173104.GA2432309@bhelgaas>

On Fri, Nov 22, 2024 at 11:31:04AM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 15, 2024 at 03:46:13PM +1000, Alistair Francis wrote:
> > +++ b/lib/Kconfig
> > @@ -754,6 +754,23 @@ config SPDM
> >  	  in .config.  Drivers selecting SPDM therefore need to also select
> >  	  any algorithms they deem mandatory.
> >  
> > +config RSPDM
> > +	bool "Rust SPDM"
> > +	select CRYPTO
> > +	select KEYS
> > +	select ASYMMETRIC_KEY_TYPE
> > +	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > +	select X509_CERTIFICATE_PARSER
> > +	depends on SPDM = "n"
> > +	help
> > +	  The Rust implementation of the Security Protocol and Data Model (SPDM)
> > +	  allows for device authentication, measurement, key exchange and
> > +	  encrypted sessions.
> > +
> > +	  Crypto algorithms negotiated with SPDM are limited to those enabled
> > +	  in .config.  Drivers selecting SPDM therefore need to also select
> > +	  any algorithms they deem mandatory.
> 
> Maybe this (and config SPDM) should be tweaked to mention drivers that
> *depend* on SPDM or RSPDM, since they no longer use "select"?
> 
> PCI_CMA, which currently depends on SPDM, doesn't really look like a
> "driver", so maybe it should say "users of SPDM" or "features
> depending on SPDM" or something?

I anticipate that the SPDM library will eventually be used by at least
two actual drivers:  NVMe and an x86 platform driver for Intel SDSi
(Software Defined Silicon).  SCSI and ATA may follow suit.

Thus, although the PCI core may be the first user, the majority of
users will likely be actual drivers, which is why I've used that
term in the help text.

Referring to "users" instead of "drivers" may be misunderstood as
users in the sense of people using the kernel.  In particular because
the help text is seen by such users.  The terms "subsystems" or "features"
don't seem to be as clear as "drivers" IMO.

Thanks,

Lukas

