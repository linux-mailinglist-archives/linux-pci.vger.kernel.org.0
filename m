Return-Path: <linux-pci+bounces-12966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F06B972630
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 02:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24817B22BA5
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 00:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0960A1DFF8;
	Tue, 10 Sep 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjaSf7Gf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55C7171A7;
	Tue, 10 Sep 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725928231; cv=none; b=NO8NDQBsMLmFfiixvnedloF62ECKeuxScJUrrCnDL8eUAKULPduxHIn+WFBXqZsTRALMoIeQajo4MnERWhFvg9FYlBKpLPcycv6m5oqe1d8qw/LAJP5AhU2N/fkp+R0KzRhpgacvbXYUsNd5thpj4S4CriAASenCgBuCQvlIeiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725928231; c=relaxed/simple;
	bh=NPDG6HhpSpFTCHJnQLGKLf+acaYp9fsdNd1H4F2xr0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k08G55Sp0XXktF7b2UhjCHnwnVfMYKOs1PUVU5SiBM8j/AuCetr1gBSwgIEs3CRGPAf8mjG0JhfCR3LMhVsqlAJvDypssI5WWnjrG9TtbudkoQFSm0n0RDiR8RNa7dAS8XNp6tV1ZdZK9Kwr2+U6IYiVOWTCiT9/1ZSrTiNPkJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjaSf7Gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5A6C4CEC5;
	Tue, 10 Sep 2024 00:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725928231;
	bh=NPDG6HhpSpFTCHJnQLGKLf+acaYp9fsdNd1H4F2xr0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MjaSf7GfRB63wlpSemifS8oQZVoyLdOTKGWmJ6APhkIHmR46qm3jxWyMxHnnle9bu
	 KD5ek+i7swhL9z9I2hVck/HEShewfwZYm756G8B9sAS6RNPey8dpJQuh04PtiiSYBi
	 KGH4IIDH+TQGr4WQaeQCajxnSsOPlvmv5OAa6v69TOnjGdqvXbOk3gJslv2nAXbZhJ
	 g4rSiV6Om9HQX75gOvhiWwZB3G+zOpLOzn5Hh97lq2hpVf+LbhL+3o9bzzVOvU3hiA
	 L32NscMFHWvyJqqDfxi74QXVqHGXKWevgqfM7if36hgL2RLuoAUpFzoqcuSpgHiF4n
	 aoB5NAYR9RQWw==
Date: Mon, 9 Sep 2024 19:30:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: joyce.ooi@intel.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: altera: Replace TLP_REQ_ID() with macro
 PCI_DEVID()
Message-ID: <20240910003029.GA554499@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828104202.3683491-1-ruanjinjie@huawei.com>

On Wed, Aug 28, 2024 at 06:42:02PM +0800, Jinjie Ruan wrote:
> The TLP_REQ_ID's function is same as current PCI_DEVID()
> macro, replace it.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/pci/controller/pcie-altera.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index ef73baefaeb9..650b2dd81c48 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -55,12 +55,11 @@
>  #define TLP_READ_TAG			0x1d
>  #define TLP_WRITE_TAG			0x10
>  #define RP_DEVFN			0
> -#define TLP_REQ_ID(bus, devfn)		(((bus) << 8) | (devfn))
>  #define TLP_CFG_DW0(pcie, cfg)		\
>  		(((cfg) << 24) |	\
>  		  TLP_PAYLOAD_SIZE)
>  #define TLP_CFG_DW1(pcie, tag, be)	\
> -	(((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
> +	(((PCI_DEVID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))

This doesn't cause a problem per se, but PCI_DEVID() is defined
basically as a PCI core convenience without any particular connection
to the PCIe Requester ID format, so I don't think this is an
improvement.

I think it *would* be an improvement to move TLP_REQ_ID() to
drivers/pci/pci.h, where other drivers could share it.  

It's obvious how the Requester ID must be laid out, but I took a quick
look through the PCIe spec and was surprised that I couldn't find a
clear definition of it, unlike the *Completer ID*, which is specified
in PCIe r6.0, sec 2.2.9.1.

Bjorn

