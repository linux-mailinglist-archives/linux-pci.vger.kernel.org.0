Return-Path: <linux-pci+bounces-4522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CAE872164
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 15:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DDC1F21DB1
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 14:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0272186638;
	Tue,  5 Mar 2024 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0uUn/6V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352386122;
	Tue,  5 Mar 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648669; cv=none; b=UGz4S5cPyPaTbGJNUsKzfj4MenvZVThA3YVIr/sUDM9zMgIiKOt4gRK+jJWAt234GEROr3kVIiF8JOYBukrW6waU1vGrK6zyNuqay9ZCjGCfFgdgcZtAsumqkipW8ZPwp83uJlR4lgPxxWjGILc4lzmgGU1qq4ueRyttKLJB+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648669; c=relaxed/simple;
	bh=zan+ZoeDXxzZ7Py3Ib0gvt0twgnpqQJYfL+M/dbapaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfHKHYeOoK9tqH/bJBOusVaDBxtCBJxyl6dVCLBbV6WgqtFCjqpY1AmCF2kX/OCxg7jpLZisDGLablq/ZWPVGaw8mW1JFlAcCuNUxQnzI+PBbzRiyUz3d/NA5/AldjziK0qYmI1CuHauXpecgcD8OQ5u0zxRKMAME9q/RXvcrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0uUn/6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15069C43390;
	Tue,  5 Mar 2024 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709648669;
	bh=zan+ZoeDXxzZ7Py3Ib0gvt0twgnpqQJYfL+M/dbapaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0uUn/6VWsIRpBj0MI8Cs9Zlz68UfqVVESRLH41lV8Jnh0qjwNa2FKGJJv0OrELOB
	 sJFJUk0V1+sBQNKd+WToPNFo0HYwal0psvcVrmwZoAeord/9WQCA3XapUZp//xTdj/
	 O64EsudmuwyatGTs5ewvhP7aPebIcRtvi1SkoC6nfW6yFO6S/PG4jF/jPfFqdTmyUf
	 DIxyBjGbaq/o3OMndkl5rvNOMBoNwbBXcRGfmsD5yKAsWpkdjcRvF5fC3iUXG+OkhB
	 UXdXwYoZwzwVoOqfJ9AFCRHLn4lg2xpaJKc3n9eWlituqTr46U1alWxIdTIrrI5rnM
	 JCmTfpUrrootQ==
Date: Tue, 5 Mar 2024 08:24:26 -0600
From: Rob Herring <robh@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
	will@kernel.org, lpieralisi@kernel.org, kw@linux.com,
	frowand.list@gmail.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: Add support for preserving boot configuration
Message-ID: <20240305142426.GB3259724-robh@kernel.org>
References: <20240222124110.2681455-1-vidyas@nvidia.com>
 <20240223080021.1692996-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223080021.1692996-1-vidyas@nvidia.com>

On Fri, Feb 23, 2024 at 01:30:21PM +0530, Vidya Sagar wrote:
> Add support for preserving the boot configuration done by the
> platform firmware per host bridge basis, based on the presence of
> 'linux,pci-probe-only' property in the respective PCI host bridge
> device-tree node. It also unifies the ACPI and DT based boot flows
> in this regard.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * Addressed Bjorn's review comments
> 
> V3:
> * Unified ACPI and DT flows as part of addressing Bjorn's review comments
> 
> V2:
> * Addressed issues reported by kernel test robot <lkp@intel.com>
> 
>  drivers/acpi/pci_root.c                  | 12 -------
>  drivers/pci/controller/pci-host-common.c |  4 ---
>  drivers/pci/of.c                         | 21 +++++++++++
>  drivers/pci/probe.c                      | 46 ++++++++++++++++++------
>  include/linux/of_pci.h                   |  6 ++++
>  5 files changed, 62 insertions(+), 27 deletions(-)

One more thing.

> @@ -3080,20 +3106,18 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>  
>  	bus = bridge->bus;
>  
> +	/* If we must preserve the resource configuration, claim now */
> +	if (pci_has_flag(PCI_PROBE_ONLY) || bridge->preserve_config)
> +		pci_bus_claim_resources(bus);

No reason to check PCI_PROBE_ONLY if you set preserve_config based on 
/chosen as well. IOW, we should deprecate PCI_PROBE_ONLY flag in favor 
of the per host bridge setting.

Rob

