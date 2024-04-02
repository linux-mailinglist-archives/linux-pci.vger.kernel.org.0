Return-Path: <linux-pci+bounces-5558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB45895925
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 18:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1024B222B3
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F591133439;
	Tue,  2 Apr 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSLA4esj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91AB133422;
	Tue,  2 Apr 2024 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073698; cv=none; b=qihu3l16+ZPgvQdtp153znlotydyIKZ3M/b5zVfefKH0YH1HcUjlLNEh8gukuZwKu0ewHXsgUTgEvPKaAXmjhK2E/RspNiz54VK4VbknY1s6CBUQzzdSGvS/KHgO0k4oDXwk3jsDTLmgriOWdsJXF75vizoHq4dqi8djkYdQORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073698; c=relaxed/simple;
	bh=piAeRL8jL5H//bWXatXO+ZkDRSotyneYNOXg1rYkXlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpJk4bENlLm86kCAYz8/zif2ZST+rJTnvpbrLjphja03INuoMqc+sXxeN3nIbShukjz3AjeiAEkHl20fn3wqLUHTVp+8tvPEGkZQUZRJ67w7q5bW/yVfTFlmjF/rh6qfBweyXPnYJ105+XIFiOckuRBBpD7swZUMbJU6r/OB9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSLA4esj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B04C433F1;
	Tue,  2 Apr 2024 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712073697;
	bh=piAeRL8jL5H//bWXatXO+ZkDRSotyneYNOXg1rYkXlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aSLA4esj25B6Ow9aAFy65xp2uv+GjcvwJVWZJpNlI4qQX93hI9VMBj9DB5pnefXCl
	 Z5R2qfqGdYil99aiGgFNQIfd+8Gu0mV8X3a7Ti5pw5ZqXiBvnDnJjn54qU6TEdLj3c
	 fnvjiOLwNPj2sXiwJLxnlIPpzwK5ns6clE5kms1wEp+0HkgQL36ALQc7aZqXCcYERo
	 QPjPhY1citXxJ7N2/I1kxnrX89IeSHQqzr/4hvCiXuyVjbjUnhGOTQk3F+OLrsGu5O
	 PBf/CVoGi2mT+YAd2KqzxYFXrsnN29t7LWbTPq/ZYhaSHLHIYcEFI5JRJmLT4hrI13
	 8odU9toOF8e3Q==
Date: Tue, 2 Apr 2024 11:01:35 -0500
From: Rob Herring <robh@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: lpieralisi@kernel.org, mmaddireddy@nvidia.com,
	linux-kernel@vger.kernel.org, will@kernel.org, jonathanh@nvidia.com,
	kthota@nvidia.com, frowand.list@gmail.com, kw@linux.com,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org,
	devicetree@vger.kernel.org, sagar.tv@gmail.com, rafael@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org, treding@nvidia.com,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH V5] PCI: Add support for preserving boot configuration
Message-ID: <171207369295.222743.17702844066682854972.robh@kernel.org>
References: <20240223080021.1692996-1-vidyas@nvidia.com>
 <20240401075031.3337211-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401075031.3337211-1-vidyas@nvidia.com>


On Mon, 01 Apr 2024 13:20:31 +0530, Vidya Sagar wrote:
> Add support for preserving the boot configuration done by the
> platform firmware per host bridge basis, based on the presence of
> 'linux,pci-probe-only' property in the respective PCI host bridge
> device-tree node. It also unifies the ACPI and DT based boot flows
> in this regard.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V5:
> * Addressed Rob's review comments
> 
> V4:
> * Addressed Bjorn's review comments
> 
> V3:
> * Unified ACPI and DT flows as part of addressing Bjorn's review comments
> 
> V2:
> * Addressed issues reported by kernel test robot <lkp@intel.com>
> 
>  drivers/acpi/pci_root.c                  | 12 -----
>  drivers/pci/controller/pci-host-common.c |  4 --
>  drivers/pci/of.c                         | 57 +++++++++++++++++++-----
>  drivers/pci/probe.c                      | 46 ++++++++++++++-----
>  include/linux/of_pci.h                   |  6 +++
>  5 files changed, 88 insertions(+), 37 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


