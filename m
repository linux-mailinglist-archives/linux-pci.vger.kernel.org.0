Return-Path: <linux-pci+bounces-34687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC840B34F19
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 00:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979E348703A
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 22:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70DE29B8FE;
	Mon, 25 Aug 2025 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV0wD93P"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB129B783;
	Mon, 25 Aug 2025 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756161453; cv=none; b=FuXvVyJb97cCkBpMYQzy/veXYuqbfUC2wwsINMZ9L4BLVOgSdDS+n7/eF3DTEJ+4jDHPTvY3FCu+MIzFFt5pVdt7KwNcdGL79M79qcFLxZSCoWkikTh2G5PXnj6iM0hMHMSB0Hakn95K1SLnWaw2E8fHgbaIMuJ1E9ehKkJqXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756161453; c=relaxed/simple;
	bh=bRkID7EIJJq/oVofnIksYjaHn0Ek+raLoQLfxWEpfD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QKpd9V/gyA1Si6Jh2a3EXNmkYEK+0IgjbZqewlUwdrU3+foyVgVLsyUePWF2bwcFDMXyIxBUmsXnsMhIDxprLr0G/7T1ul/0aL2VDJhXUfbnE/X0JqcdgYnmvl7gOZLZ43q0MiuL3AHocuzlvg1OEz6IWFkBskLuVeuhy5bC44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV0wD93P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC616C4CEED;
	Mon, 25 Aug 2025 22:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756161453;
	bh=bRkID7EIJJq/oVofnIksYjaHn0Ek+raLoQLfxWEpfD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VV0wD93P0JrXAib+Kml9Hd2JmfWNiO0OC1wqOEkheIbjoBeNUd7zva+/Za4mi4K7N
	 d8tG9O+NaiKChGDpDSgykFtVIHbmQuc+eupg4Zj45SIehdT+9MzQnE3p/v9hbFVSiT
	 6ky+cGvJ3LLDP8oIkx4JxnjhSh0Fd1iBC4tx37XLf3av3z3GUk+JMvFq7zyCLUCBdE
	 VQOYtoD5bUUrVvOq9kZ3x3T97go7j6kiDZ3UU7aEM5x17p9dPT3+82O/fdYcKNRRTa
	 Jxz3TVdmr0JFA7nA7tFx6YXxvZQv3pbE0Orbo9zjcuhPtRkc6icdayN7yvta9LyUoh
	 WJWrUqapTc2tw==
Date: Mon, 25 Aug 2025 17:37:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI/PCI: Fix memory leak fix in pci_acpi_preserve_config
Message-ID: <20250825223731.GA808746@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825214642.142135-1-nirmoyd@nvidia.com>

On Mon, Aug 25, 2025 at 02:46:42PM -0700, Nirmoy Das wrote:
> The pci_acpi_preserve_config() function is leaking memory by returning
> early without freeing the ACPI object on success. Fix that by always
> freeing the obj which is not needed by the caller.
> 
> Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_register_host_bridge()")
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>

Applied to pci/misc for v6.18, thanks!

> ---
>  drivers/pci/pci-acpi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index ddb25960ea47d..9369377725fa0 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -122,6 +122,8 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
>  
>  bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
>  {
> +	bool ret = false;
> +
>  	if (ACPI_HANDLE(&host_bridge->dev)) {
>  		union acpi_object *obj;
>  
> @@ -135,11 +137,11 @@ bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
>  					      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
>  					      NULL, ACPI_TYPE_INTEGER);
>  		if (obj && obj->integer.value == 0)
> -			return true;
> +			ret = true;
>  		ACPI_FREE(obj);
>  	}
>  
> -	return false;
> +	return ret;
>  }
>  
>  /* _HPX PCI Setting Record (Type 0); same as _HPP */
> -- 
> 2.43.0
> 

