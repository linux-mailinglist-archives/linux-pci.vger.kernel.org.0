Return-Path: <linux-pci+bounces-25425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5F9A7E96E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 20:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB9B17C9B4
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 18:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8114421ABBB;
	Mon,  7 Apr 2025 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt6JdKbU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C13D21ABC4;
	Mon,  7 Apr 2025 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049225; cv=none; b=HkYhXqPa97x5fw9wbACpOaxP81wH/rvybM7u8cafvkQeJbq109mVRoSM5fUMdxUULSxH0CyhzcI20AaTWILCSbvdZhQ+tHObvUSV1YbbhwlyXXsD4U0PxijLAN6MKxb5WbwriUSn0hol+X0m03sEMChff2EMSgDsbJFFb8/bIek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049225; c=relaxed/simple;
	bh=uU12NXRlphx6MjKtaq+HPkahipo858GXs1r+8aLru/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cwOkwNpaXllf727C6apFDQ13Jc9Lhqp1y+ksrUA8EKT+vtlEsUSU+iYOlh7PK3o+yuaWQAO2eHIhr+JcfSRo8X/Q3SvLCoeCI6ZoZe4nKCJWL/3qQgKqV6J6lKovD0DsS/xM5Rf4eezCborAAHm3oeVyPCNomVrZxnfZzQLAx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt6JdKbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B763EC4CEDD;
	Mon,  7 Apr 2025 18:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049224;
	bh=uU12NXRlphx6MjKtaq+HPkahipo858GXs1r+8aLru/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Qt6JdKbUN9BMlRu1LaTLHcEw3prd8n9gpaHA0dpAsCaIbQlncF5F6I4BCfNl/cqI8
	 shcE+rDPu6OTpPVN2KMYCWjim3+xJhyNDDEOIln8p1601UD2hpCsvwdF0PMrWvG3s4
	 sC4f68QGPTg8qv7VqBBuZ027gunXHey8qrDyYFaFZUypPzx+2UvPD+6AVNuWlD+jDO
	 04DXeKC1OmPnPkg3zeNKiXJowFll6CrV50odhMt1m0+QftQ2iAKXpy5cHjzmL8ILey
	 edV4N1yXEMqgad0V3Q2GxoA2v1E/E1szHL6ogTLYvwfVI1BpGjL9zZrmab3FIkthVX
	 wsiDysrgVZmLQ==
Date: Mon, 7 Apr 2025 13:07:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: pci: add entry for Rust PCI code
Message-ID: <20250407180703.GA189930@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407133059.164042-1-dakr@kernel.org>

On Mon, Apr 07, 2025 at 03:29:50PM +0200, Danilo Krummrich wrote:
> Bjorn, Krzysztof and I agreed that I will maintain the Rust PCI code.
> Therefore, create a new entry in the MAINTAINERS file.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96b827049501..89f4bf7d9013 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18686,6 +18686,16 @@ F:	include/asm-generic/pci*
>  F:	include/linux/of_pci.h
>  F:	include/linux/pci*
>  F:	include/uapi/linux/pci*
> +
> +PCI SUBSYSTEM [RUST]
> +M:	Danilo Krummrich <dakr@kernel.org>
> +R:	Bjorn Helgaas <bhelgaas@google.com>
> +R:	Krzysztof Wilczyński <kw@linux.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +C:	irc://irc.oftc.net/linux-pci
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> +F:	rust/helpers/pci.c
>  F:	rust/kernel/pci.rs
>  F:	samples/rust/rust_driver_pci.rs
>  
> 
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> -- 
> 2.49.0
> 

