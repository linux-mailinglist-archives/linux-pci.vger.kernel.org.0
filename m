Return-Path: <linux-pci+bounces-3260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 192EA84EB0C
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 23:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2712B1C26AF4
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 22:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCC24F21A;
	Thu,  8 Feb 2024 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAC18m2n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C24F88C;
	Thu,  8 Feb 2024 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429629; cv=none; b=usY3ZjjJJF+U/UqXsL9ezCcgR7i5T2bF3VLWRe7mRj201kSABElhFOpiqymgErla+LdeKnUErbW43MO5tn62J7ifOS8tviX5ET0gmFcfC1F+ZcYOcEU5LL56RnU8DIUcRgZt90v/fMlisfjjEDWpZMioaBVh3AyhMFsnMiT9n34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429629; c=relaxed/simple;
	bh=sfqU/s/3SiEvSEePFviZWJkwmQb3jHOvGvS8pWeeXZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A3A5BErObC8r9ZetdIXrVz26z/wDsfWeMl7U9X4cuZvB5DuDuZllu9ELW1hv/ur6YfXosKj1KcqsB0yz9Rjxyl9TO7AgptTCIZP1U/w1/LSeUYmJOe+mYIkAMgtyaT+PqP7fa/aWr3QNt636jk3LZuofLaIgn4JT3SoEw3NbfMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAC18m2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EA6C433C7;
	Thu,  8 Feb 2024 22:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707429629;
	bh=sfqU/s/3SiEvSEePFviZWJkwmQb3jHOvGvS8pWeeXZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HAC18m2ncaPmq5J7DCM9ZqsPgRFcSlY9RiD20SThR76iZUy348j/TuwqqdfxdQ9u1
	 WmjqgY7vOj2hJ1j7KW6M1bnJddK7MWjWSy8KNt7lnqICugcvxM6Rjo+tKjR/t9ncKy
	 l1l8hL91Rqx7ufOWymvpq6esMakpcr/F9Jh86t98kC1KA2Kpj2jQUx1/+gsPD5Ku2+
	 c274pG+q4NzJsUw3WczdAt9TbFozmyCXAOTiI2KcAuUvnzxmsDAxjWvK+NPLfS3Wii
	 9qjKFQRVYY6geRg+oy3FWZj53OX6raJRGiEHcBzi2uIhfdT8J0U+6/bPEtyP5Sti4G
	 9J/1G2LlMmD+A==
Date: Thu, 8 Feb 2024 16:00:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH kernel 2/4] pci/doe: Support discovery version
Message-ID: <20240208220027.GA975008@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240201060228.3070928-3-aik@amd.com>

On Thu, Feb 01, 2024 at 05:02:26PM +1100, Alexey Kardashevskiy wrote:
> PCIe spec v6.1 defines a "DOE Discovery Version" field in the DOE Discovery
> Request Data Object Contents (3rd DW) as:

Please include spec section number, e.g., "PCIe r6.1, sec xx.xx".

(Also note PCI-SIG uses "revision" as the major, "version" as the
minor, so this would be "PCIe r6.1", not "PCIe v6.1".)

> 15:8 DOE Discovery Version – must be 02h if the Capability Version in
> the Data Object Exchange Extended Capability is 02h or greater.
> 
> Add support for the version on devices with the DOE v2 capability.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
>  include/uapi/linux/pci_regs.h |  1 +
>  drivers/pci/doe.c             | 11 ++++++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a39193213ff2..b9c681f14181 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1144,6 +1144,7 @@
>  #define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
>  
>  #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
> +#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER	0x0000ff00
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 61f0531d2b1d..f57def002175 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -381,11 +381,13 @@ static void pci_doe_task_complete(struct pci_doe_task *task)
>  	complete(task->private);
>  }
>  
> -static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> +static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u16 *vid,
>  			     u8 *protocol)
>  {
> +	u32 disver = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER,
> +				(capver >= 2) ? 2 : 0);
>  	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> -				    *index);
> +				    *index) | disver;
>  	__le32 request_pl_le = cpu_to_le32(request_pl);
>  	__le32 response_pl_le;
>  	u32 response_pl;
> @@ -419,13 +421,16 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
>  {
>  	u8 index = 0;
>  	u8 xa_idx = 0;
> +	u32 hdr = 0;
> +
> +	pci_read_config_dword(doe_mb->pdev, doe_mb->cap_offset, &hdr);
>  
>  	do {
>  		int rc;
>  		u16 vid;
>  		u8 prot;
>  
> -		rc = pci_doe_discovery(doe_mb, &index, &vid, &prot);
> +		rc = pci_doe_discovery(doe_mb, PCI_EXT_CAP_VER(hdr), &index, &vid, &prot);
>  		if (rc)
>  			return rc;
>  
> -- 
> 2.41.0
> 

