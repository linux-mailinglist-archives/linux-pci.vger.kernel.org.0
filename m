Return-Path: <linux-pci+bounces-6363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834628A8813
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1131C21358
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91186147C89;
	Wed, 17 Apr 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6knl96L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C757147C7F
	for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369040; cv=none; b=M3ZTphgm+lLVaDbawDhzSnRAOjUSW7FFkt8GFAI0QhfyWuYRLPMIxnbO7gXPcCacxdDIV3lSmdd1rmKyJRNZ7pmr1J/TzCj6jzQT3RXc42BxcJPBfASJLfIZrI00kDd5ckSLLbaWpwH1hDe+Ac+C81bxjgcCoqsFWcjI4j2NLbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369040; c=relaxed/simple;
	bh=+xFGawARnxkjeNVo4MCkO2pEjcXYceD5TGzV9K2yofw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NoEdacNrH/fKoP/6dANJSmwDYRKlFhnOfKzeQUl3Ve1C/HREuEo6fniDf15y4fEFYSHfVRqYTI9J3jaUuqsi4xQQOvOs19JVFNnEKgZD9XXvUJ0QJYfF5y3LjX45PdXNnsPW5S2ZVBRDBXWqR2CwVYVWjX9KUQ8J/TzK6O7XF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6knl96L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ACDC072AA;
	Wed, 17 Apr 2024 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713369040;
	bh=+xFGawARnxkjeNVo4MCkO2pEjcXYceD5TGzV9K2yofw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=M6knl96L18geHhukZrcCdRN0ocTG7dBhPeSKqo1zmaQUzkWaDsxEQTn5lLEc8cWjo
	 LvBDIR1Y6k9sffhX9VU3X+SxGSQzL0sOMOfvwBvOOqzYVTkJwgCnyt6hbrG7eQmZOo
	 YtHh9LcTd/TnwPtja13rYY36nGKjJWKvEEGYmAHzDDgaCaMePtdZoDbRTt3US7nnLg
	 /JNYlb2L9iGmLBIPg5c4+q16yjD+/R5mvwu5qtRabmu0MvNYwKbeHC5TWWapZ3FRcJ
	 dGQnrkmSjx4NWIg+xgWkaSIPd+5RAOIr942FlspfNYjO+RpIc0G6JQq4unD8ivL/qp
	 hILFQuwOcOjKA==
Date: Wed, 17 Apr 2024 10:50:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Constify pcibus_class
Message-ID: <20240417155038.GA204552@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e01f46f-266f-4fb3-be8a-8cb9e566cd75@gmail.com>

On Sat, Apr 13, 2024 at 11:01:17PM +0200, Heiner Kallweit wrote:
> Constify pcibus_class. All users take a const struct class * argument.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to pci/misc for v6.10, thanks!

> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1325fbae2..4ec903291 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -95,7 +95,7 @@ static void release_pcibus_dev(struct device *dev)
>  	kfree(pci_bus);
>  }
>  
> -static struct class pcibus_class = {
> +static const struct class pcibus_class = {
>  	.name		= "pci_bus",
>  	.dev_release	= &release_pcibus_dev,
>  	.dev_groups	= pcibus_groups,
> -- 
> 2.44.0
> 

