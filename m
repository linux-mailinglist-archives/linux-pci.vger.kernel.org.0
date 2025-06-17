Return-Path: <linux-pci+bounces-29932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA6EADD040
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB11E3BB5CE
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 14:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052C9202965;
	Tue, 17 Jun 2025 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3WgjR7f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4B42EB10;
	Tue, 17 Jun 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171240; cv=none; b=TOJk4tShuj4Llk5wdh/eM1CpihItECE7reCxiaiI4zJaEnBvOZJj3geSzE9OAJpdXfP42/v7g2zI8k3mV/1nrU2+22j7Gbchihb8e/Nb9EZ/EzYPX0JZ7SdHkYSWz/t2MpE0sYwlvttFzL4zG7/4euuSJ+saKu8Co+cpy9d7muM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171240; c=relaxed/simple;
	bh=TqtzmXYPJKEqTXMU+f7uN1rUv0VpX38ROAg2dTsXMek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NWuZPlpW4nxmWfY/11PdnQSKHj+pTmFT+MsGwKUnCEs9y3gY10Mk0iYIXCSEDrDhh4ZI6p5yRc5Va9W8VoNLeAErkrCh3J+PEmx6lSc0tSO8B/1KxKZhePwbR2tFwhePiHFkcn6SNsz7JgVjhXmc89yX2RZDrH2Dyfsqn8naFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3WgjR7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A514C4CEE3;
	Tue, 17 Jun 2025 14:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750171240;
	bh=TqtzmXYPJKEqTXMU+f7uN1rUv0VpX38ROAg2dTsXMek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P3WgjR7fLmn91+0xU8Hla3uG7iISQmyRbiw94Do9t79HnPRryQW91aQxjSru5nf5w
	 uT+oQMbTF96IrfX9N7QuW42vSOjnYQ6YdIa/jqrHfzB0CwvOWnWfr+EVIbpy1hUAhi
	 IsxLeqVzQZBVQoUkSm3Rd09GRekXl1ZBvnfS7OHuKzK0FAKqGZ2CFQtTJNC7SF/uN4
	 R03Fe1ZKEBtoJCVwSCcPlxoJp42MgUOfFxEl2hwoeCsFJ2rw+BMj9tQi8G8uR4O8Mr
	 BHWm+58erlcWIWl757167rxBk+/Fsfhnj6ejwq705UuMfxyq0q1T8IACscMltivasX
	 T+MfltiURB8HA==
Date: Tue, 17 Jun 2025 09:40:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhe Qiao <qiaozhe@iscas.ac.cn>
Cc: rafael@kernel.org, bhelgaas@google.com, lenb@kernel.org,
	kwilczynski@kernel.org, sashal@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2] PCI/ACPI: Fix double free bug in pci_acpi_scan_root()
 function
Message-ID: <20250617144038.GA1134072@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617023738.779081-1-qiaozhe@iscas.ac.cn>

[+cc Dan]

On Tue, Jun 17, 2025 at 10:37:38AM +0800, Zhe Qiao wrote:
> The patch "PCI/ACPI: Fix allocated memory release on error in
> pci_acpi_scan_root()" introduces a dual release issue. When
> acpi_pci_root_creat() fails, the pci_cpi_can_root() function
> will release 'ri ->cfg' and 'root_ops' in the error handling
> path.However, acpi_pci_root_creat() will also call
> __acpi_pci_root_release_info(), which in turn will call the
> release_info hook, causing the same block of memory to be
> released again.

These are all nits, but would have to be fixed before applying:

  - 'The patch "PCI/ACPI: Fix ..."' is not the usual way to identify a
    commit.  Use the same style as in the Fixes: tag below.

  - Typo in "acpi_pci_root_creat" (twice)

  - Typo in "pci_cpi_can_root"

  - Add space after the period in "path.However, ..."

  - Add "Reported-by: Dan Carpenter <dan.carpenter@linaro.org>" and
    "Closes: https://lore.kernel.org/all/aEmdnuw715btq7Q5@stanley.mountain/"
    and cc: Dan.

  - 631b2af2f357 appeared in v6.16-rc1, so we should try to get the
    fix into v6.16.  A hint after the "---" would be helpful to make
    sure that happens.

Wait a few days before reposting in case other folks have comments.

> Fixes: 631b2af2f357 ("PCI/ACPI: Fix allocated memory release on error in pci_acpi_scan_root()")
> Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
> ---
> v1 -> v2:
>  - Restore all changes from the first version.
>  - Remove unnecessary release info hooks.
>  - Add a NULL check before calling info->ops->release_info().
>  - Delete the currently unused pci_api_geneic_delease_info () function.
> ---
>  drivers/acpi/pci_root.c |  3 ++-
>  drivers/pci/pci-acpi.c  | 12 ------------
>  2 files changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 74ade4160314..83628adbc56b 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -974,7 +974,8 @@ static void __acpi_pci_root_release_info(struct acpi_pci_root_info *info)
>  		resource_list_destroy_entry(entry);
>  	}
>  
> -	info->ops->release_info(info);
> +	if (info->ops && info->ops->release_info)
> +		info->ops->release_info(info);
>  }
>  
>  static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index b78e0e417324..6e85816ee1c3 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1652,17 +1652,6 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
>  	return cfg;
>  }
>  
> -/* release_info: free resources allocated by init_info */
> -static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
> -{
> -	struct acpi_pci_generic_root_info *ri;
> -
> -	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
> -	pci_ecam_free(ri->cfg);
> -	kfree(ci->ops);
> -	kfree(ri);
> -}
> -
>  /* Interface called from ACPI code to setup PCI host controller */
>  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  {
> @@ -1683,7 +1672,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	if (!ri->cfg)
>  		goto free_root_ops;
>  
> -	root_ops->release_info = pci_acpi_generic_release_info;
>  	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
>  	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
>  	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
> -- 
> 2.43.0
> 

