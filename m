Return-Path: <linux-pci+bounces-5942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2EB89DC5D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 16:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8921F21298
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE81101EC;
	Tue,  9 Apr 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bs/SHK6C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771CA94A;
	Tue,  9 Apr 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673235; cv=none; b=UTbMtgbpnaES/UU7lwWm2aVS9TuJkkW2AHSOdzTYQnLnCcbZh5H33qEaVT/kGTqOn9zsksmSxvGVgcbLcuI/sS2tzBTWbnUnpnStPrALt2pnlBLjpOvtnqdP6fOZPBhl34CMbZOL3moPuy9Gl1ZfhWXCMuiTeqFRd/F3ivKKqq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673235; c=relaxed/simple;
	bh=if366ozc5ZQv7pHljSsCus/73omwjt2XrkVWvzIwwuc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JyPjAWIQfw580cQ2OfkjqblbmhkA75MMAWozsV13w7vsKyr6OV58ypF+vuoh4GPlr4VhyWfkap3u9X+OIhfTVvLS6oNpdUCzA6TkoAFYP+IPzWz6UEPnvex/Ql2bzpfZFPtJoI/gKlDD6RadyPyBAJgrzZitjS71LUBKy6rKDtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bs/SHK6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4CAC433F1;
	Tue,  9 Apr 2024 14:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712673235;
	bh=if366ozc5ZQv7pHljSsCus/73omwjt2XrkVWvzIwwuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bs/SHK6C9sDdNlJRHQvFBhssB7MdhjNVWEDrJS5zORQCjbuEigkO6Xi/J3mhxcyRV
	 b7sPnrM1eWeu7jv/cFsjiGgepz2LX29RDjx2AMxx/lkTJ6BoN7P5cCx5U0tB8uZVOU
	 9+uT616/GCvEyyNhu5pPt67q1TDNkYt3UdORSvLv4K8fxG2E013s+OeJGsCji6c0fF
	 W6VnSKBy2eYyRv4sgDmSuWJC2DWn/G7BZm20bjX5qkMK0zPd3Y0iq8/SB6WBp4lCOK
	 SDAWzBXVOHWc316iqGUj1zXneVHY+px88oNxpfdtEt8IUV+yOA4bj+3GpbW9LQ71dT
	 4WNZpQx2nvG7Q==
Date: Tue, 9 Apr 2024 09:33:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH kernel v3] PCI/DOE: Support discovery version 2
Message-ID: <20240409143353.GA2073836@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307022006.3657433-1-aik@amd.com>

On Thu, Mar 07, 2024 at 01:20:06PM +1100, Alexey Kardashevskiy wrote:
> PCIe r6.1, sec 6.30.1.1 defines a "DOE Discovery Version" field in
> the DOE Discovery Request Data Object Contents (3rd DW) as:
> 
> 15:8 DOE Discovery Version – must be 02h if the Capability Version in
> the Data Object Exchange Extended Capability is 02h or greater.
> 
> Add support for the version on devices with the DOE v2 capability.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>

Applied with Sathy's reviewed-by to pci/doe for v6.10, thanks!

> ---
> Changes:
> v3:
> * updated subject line
> * dropped "DISCOVER_" from the new field macro
> 
> v2:
> * added the section number to the commit log
> ---
>  include/uapi/linux/pci_regs.h |  1 +
>  drivers/pci/doe.c             | 11 ++++++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a39193213ff2..fbca743b2b86 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1144,6 +1144,7 @@
>  #define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
>  
>  #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
> +#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER		0x0000ff00
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 61f0531d2b1d..c94c2b0767f3 100644
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
>  	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> -				    *index);
> +				    *index) |
> +			 FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER,
> +				    (capver >= 2) ? 2 : 0);
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

