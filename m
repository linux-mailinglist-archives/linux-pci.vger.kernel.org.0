Return-Path: <linux-pci+bounces-6458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2BC8AA243
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 20:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2E21C20896
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 18:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E0A168B17;
	Thu, 18 Apr 2024 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS3ixYd4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306EE16F919
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466006; cv=none; b=s7Abs3RJxyiYaX4Jfka77PoByaIg0Q/sMTmBSLM30QJCwgBIQ4saHwKP/Xq58P+sIDj2212VJy2JAviS5/mDddvcctON4guBdMmaix7T6Kb0P5SHBtqx7bfXAdAHI189BHO08q6Ezm+rEOBBpNZy5OgBO1L1/bBiUyMSs1RvlJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466006; c=relaxed/simple;
	bh=OpSGAMtEEJoFVbRL8K/2yS2PcHKsqlAZZNDOGY0Nz9g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Bw4y2icB+LcB+738hgEGnQ5pIvSxuDKv+Mdbokk+CJrwLR4vKX3HQ3uTvCKKv7acvrDXOI+XQYvVxRbMskNnEX9y06sA+tkjCwuxuS2f8vMu/vNYL9W5V2yHZrJypuhs/e3tiGuUMqdRixhxeVATkAvkJCiWBCFH7S3s4PSIDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS3ixYd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E772C113CC;
	Thu, 18 Apr 2024 18:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713466005;
	bh=OpSGAMtEEJoFVbRL8K/2yS2PcHKsqlAZZNDOGY0Nz9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oS3ixYd4PhuF2e9A5iuZGVj5oOfg3J7j3nuDHMv9nhNxG7wsz2/r5I5Q9njMeZg4s
	 4oMH3qWrgUfBG5YWVZEttLkTnbORx0RL7YgkGPSVjipM9kjI7vzcIjuYjnnTq1+hUA
	 HKN8x5EgYvXlue7PA4IPOOKBEtG7TtO10WL4c2CtplSNYsbl4wDhUCfCJ3tnv0zX27
	 JNl+L9YX6/4SzW00QuUyu+iLVSHaJ27QU8ZkuZOxHK00C/P/29Qmq38i0rq7UjtGPt
	 CzoI2nQv7jOLavS/UzQsW606qfcIeS5vWi1RL8k+jLTlcCe9dQSbdAJuF+GRcZ6jqb
	 VrufD9Bd6DIjA==
Date: Thu, 18 Apr 2024 13:46:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Annotate pci_cache_line_size variables as
 __ro_after_init
Message-ID: <20240418184644.GA246566@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52fd058d-6d72-48db-8e61-5fcddcd0aa51@gmail.com>

On Thu, Apr 18, 2024 at 08:29:21PM +0200, Heiner Kallweit wrote:
> Annotate both variables as __ro_after_init, enforcing that they can't
> be changed after the init phase.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to pci/misc for v6.10, thanks!

> ---
> v2:
> - remove annotation from extern declaration in pci.h
> ---
>  drivers/pci/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5f8edba78..59aaebb67 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -142,8 +142,8 @@ enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
>   * the dfl or actual value as it sees fit.  Don't forget this is
>   * measured in 32-bit words, not bytes.
>   */
> -u8 pci_dfl_cache_line_size = L1_CACHE_BYTES >> 2;
> -u8 pci_cache_line_size;
> +u8 pci_dfl_cache_line_size __ro_after_init = L1_CACHE_BYTES >> 2;
> +u8 pci_cache_line_size __ro_after_init ;
>  
>  /*
>   * If we set up a device for bus mastering, we need to check the latency
> -- 
> 2.44.0

