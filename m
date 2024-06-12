Return-Path: <linux-pci+bounces-8689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B9B905C50
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 21:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADED71F225F6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 19:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C935464A;
	Wed, 12 Jun 2024 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FB8741tv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBFC381C4;
	Wed, 12 Jun 2024 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221914; cv=none; b=TMr/cY45xCSAFRdjnIrc9Nq26xwAGS1o5Bh49QDLBLywLDBpWxCzGkMeBYpvETYUVq29bQSHx9kNseLRdF5bYUwzQCPV2NONX99MGJc5BUDqbP7mtMxC6Zorsenqab+gtIDPkN5PGP9772c5iVJlq10qxfT91VnnlvIq0hG6VL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221914; c=relaxed/simple;
	bh=3DSoDGc2KpPo6PasfSy8FmR0m4FIDYDP5J4c9c8bcJA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gxhcRpdlsa2C1KzEWnyevPUQ8EtlOSzGfr4AcvBpxH87JZIonwp194A0cHlyMwvC86zDDfNExU89j1OCeMqU93UiCJeBo7BqnGG1IfD5p2rUrGPFWCQJlbXpRYaQKNroSwNB014+pqf9E93OtdRlvq6fzFJueYkJuVBCh6EvJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FB8741tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F06C116B1;
	Wed, 12 Jun 2024 19:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718221914;
	bh=3DSoDGc2KpPo6PasfSy8FmR0m4FIDYDP5J4c9c8bcJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FB8741tvIVXF3sOGHRQHVQuTM3uM9Gdxv4ZhM34fVOklCuocM6TRtmcNHV3VXvpuk
	 9KzHSMOgIsb5Z8FRyW+QWHBo/v+RQ+5TBxzEf3kZkyWbacImn+hLGXsmocXX4X8+Bd
	 B6y0iiKeBjBUAuV29CeTxQSQXUymxibct9N4j6Ixi8ECFDACp5hZfB8lLD+stmbi3Q
	 DfMVo16/kL0xLQ//Wxvm8snTKL2VMCFSnFc4aEOISPpYF9UsCPTwKQcaSaUuPqsQlI
	 64Anee6HpCLrBSzPs1+LM63/CT8QNCNMzZD9Taz+wVh3mL56TZZdJJkolf99L7r7/o
	 5bukcL5fZG8fQ==
Date: Wed, 12 Jun 2024 14:51:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Remove extra parenthesis from
 calculate_mem_align()
Message-ID: <20240612195152.GA1034721@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612093250.17544-1-ilpo.jarvinen@linux.intel.com>

On Wed, Jun 12, 2024 at 12:32:49PM +0300, Ilpo Järvinen wrote:
> RHS of <<= does not need parenthesis so remove them.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Squashed, thanks!

> ---
> 
> This patch can be folded into the commit 658bf5d36dc5 ("PCI: Make
> minimum bridge window alignment reference more obvious") in
> pci/resource if so desired.
> ---
>  drivers/pci/setup-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 11ee60b9ca71..23082bc0ca37 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -960,7 +960,7 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
>  	for (order = 0; order <= max_order; order++) {
>  		resource_size_t align1 = 1;
>  
> -		align1 <<= (order + __ffs(SZ_1M));
> +		align1 <<= order + __ffs(SZ_1M);
>  
>  		if (!align)
>  			min_align = align1;
> -- 
> 2.39.2
> 

