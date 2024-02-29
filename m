Return-Path: <linux-pci+bounces-4285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E149886D6D8
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 23:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B48D284ACA
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 22:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D987274BFE;
	Thu, 29 Feb 2024 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbB6/SOP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CEB74BFB;
	Thu, 29 Feb 2024 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245606; cv=none; b=Sy7YFdL1ymDgZUE/KeH+GcZ0MYkGlsxioNXL5NV+Gx7HhpQL1RAnYG8InTHt4KbzOPA5MIc74SAUtZMsWs8yAoqXR4TQGY66AAe4r75PCHhTLAuOWczMvGBzbAPSejXE6Csg6m8elirjXOBmcgQOsuzvUsNL0OraVH2B+E751P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245606; c=relaxed/simple;
	bh=1tNC4l313xd0L6tRSMFRxmtHbYEFy9bxXy8SJFsh0UE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rzkzI0tpeczAzEP+Dp0CCWUbN2htGpp/1QNQrCQ4LdkORwgiQmASSwcIt5q0MBQJKdDLKOp/EvI/2+mbDCHOOsGmIGanHk9T3uVXvaEJym7onjihluk38mt2NL4CtPEIKEJ7/axBb5TiiTwkZbUdPQRkJ0HaAGhOzJ+u3RP8dAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbB6/SOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93635C433C7;
	Thu, 29 Feb 2024 22:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709245605;
	bh=1tNC4l313xd0L6tRSMFRxmtHbYEFy9bxXy8SJFsh0UE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nbB6/SOPGuSR5Uq8/jDpZtP+7ohJ5qqrgyC6xIoRbV29VxsnGlS7mV5pJHWnIx2im
	 2fCrmtwL82I5S9EKjlSjFlbvtbq5FdA0RwEqjz5otqAvgoCCdrQlEzh1jSmcmcRYIp
	 oRQ+VPljuLi/syNiImnsJjVzs/mxdAtLo/CbVZ9nAOroMrMqudhcVHiwOwTfhPfWdq
	 phQZMNX6+GDIbeAI1o7Bg/NqJO/lZsDxWopkNr82qAYtG+FGWPVwXIvWionzR7mRSs
	 5a6giZubMilwUnukErXOYsKV940sLWiIvSsJPtChTiV73YjZKPnDn4kjxC9PgzCrQY
	 ZtpxVuAiegJRQ==
Date: Thu, 29 Feb 2024 16:26:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
	jgg@ziepe.ca, kevin.tian@intel.com, dwmw2@infradead.org,
	will@kernel.org, lukas@wunner.de, yi.l.liu@intel.com,
	dan.carpenter@linaro.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH v13 1/3] PCI: make pci_dev_is_disconnected() helper
 public for other drivers
Message-ID: <20240229222644.GA367986@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222090251.2849702-2-haifeng.zhao@linux.intel.com>

On Thu, Feb 22, 2024 at 04:02:49AM -0500, Ethan Zhao wrote:
> Make pci_dev_is_disconnected() public so that it can be called from
> Intel VT-d driver to quickly fix/workaround the surprise removal
> unplug hang issue for those ATS capable devices on PCIe switch downstream
> hotplug capable ports.
> 
> Beside pci_device_is_present() function, this one has no config space
> space access, so is light enough to optimize the normal pure surprise
> removal and safe removal flow.
> 
> Tested-by: Haorong Ye <yehaorong@bytedance.com>
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.h   | 5 -----
>  include/linux/pci.h | 5 +++++
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index e9750b1b19ba..bfc56f7bee1c 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -368,11 +368,6 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>  	return 0;
>  }
>  
> -static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
> -{
> -	return dev->error_state == pci_channel_io_perm_failure;
> -}
> -
>  /* pci_dev priv_flags */
>  #define PCI_DEV_ADDED 0
>  #define PCI_DPC_RECOVERED 1
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 7ab0d13672da..213109d3c601 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2517,6 +2517,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
>  	return NULL;
>  }
>  
> +static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
> +{
> +	return dev->error_state == pci_channel_io_perm_failure;
> +}
> +
>  void pci_request_acs(void);
>  bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
>  bool pci_acs_path_enabled(struct pci_dev *start,
> -- 
> 2.31.1
> 

