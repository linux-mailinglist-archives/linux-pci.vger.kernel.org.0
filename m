Return-Path: <linux-pci+bounces-15758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3539B8535
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 22:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B7C1C21150
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 21:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DF21922F1;
	Thu, 31 Oct 2024 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPd79usM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BF513C9C0;
	Thu, 31 Oct 2024 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409771; cv=none; b=gFI7DgJ0rWxkBW3bzDYpq0/NAapjDTZpZoBQEk+O6CL7irVP/2p8lcKc6dxjEieksWy+zFdzXWDM5VU0QwAA6vmiYgSD+Fv4U+4oPTwQJM3iShDlu5z8k/+t8P7J3q0a2w4mAUKiC0HhykZUktcwKiwnDgWRCfmMIrFzAR39RS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409771; c=relaxed/simple;
	bh=PgcMBwr/s2S9yZx2+wQTVmHYDbosjx0vKnuVX9907MQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+sNgP0N5JQe97L5/qYLG1xILHetwm65kLfbBluTnaWncxxSv7jl2KFFAHo+4kdyoNJdubYCiFa1+pkeGRzUVZFIjaI21mOeTkY1K7NUco8ve3Le/QbEZgJwPM0dlyKhtrwvhLtMHuTENx5B5sp5SJcW9Eck3a9we3GgZz49G4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPd79usM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720be2b27acso866963b3a.0;
        Thu, 31 Oct 2024 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730409764; x=1731014564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xaowfYoL4ccPBj6E3WMNX/UPY0D/S/vlf6D5F0IhQcI=;
        b=NPd79usMbpqxAvtWYMCwPHRMCs9ccv+O85gfBwemqUn3IFBFL9pYa31eCsL9hrXv72
         IP6QbVfxO7610rXlJkmBW8JX2ZzMAP3DuOX/DAnc5EtiqWl02BZ5LURlryx9FJNXAwMA
         +M+nXKAFt2C5lP0GROwEUPjqvcT8e1ztQThSt/zYYv4OFJC/uf0fIrUqDNZtk2KZiA9M
         o49z7a0DNIjUlF+DcvVX0COelMNUwOuAcE8gAYO53ypZMwPc4lpaLO2Se2KdYCdqC6Jx
         q6P6IqbclSz0MXpVjbLspLBM47fkgSMWJtkkEGz6B3bPlcEWWuHhHRfAjzfB//YnpdXZ
         A3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730409764; x=1731014564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaowfYoL4ccPBj6E3WMNX/UPY0D/S/vlf6D5F0IhQcI=;
        b=i/Ybm7D7WLI1i4u6SKnRisquxzSzglEzj/+sA5YyfipyPE8rcYXdi3O2WCMRD3Gx4x
         ftCxUWYCdsWsveIWNnhbuAnEI/8kjAhEh0lbO6P6zhPE7KE/s+xG4vScOZVGO0xDfk5R
         NABaieqcn77oPfLjokAJ/Cp2BTnqqHfPsN7PUlxlrN803Ac7bcvlBu5vPgAeMlZ0Ostj
         FHAKonPN5t6LMM39yUznwM2aoAixdTsdgjNY07NOk7iCKlrBtr5P4mDr+zjYVLDo+HkI
         qESxpPSLPtbf3T7qQGdNJkkida8dmdz/Fc8+zFYVT515emYnIlj0U9naCSZ3rL3O3OFY
         wkTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfwnXVqEw/j/TpX8ZHzcD2SkqhA2ZkwttT9fiPku+PMhWipGXzYd4rxp2muUOsqUDnf1rpB55ztnvE@vger.kernel.org, AJvYcCW3i+4fKlZsYQe9sHj4U7n1jmJn3/QdNkRbiSAXEd7fTDh9jC7aLPZ1DDC6iRrNBgZbOszUe44qbIg=@vger.kernel.org, AJvYcCWdUlwmeWUolO/V0I4S789Hs8Ph1VWC0lZ+ajuEHCWdA8TmBdeaiN+WshTQc8/Ya+hRlmNLpkLGFKO4DLHx@vger.kernel.org
X-Gm-Message-State: AOJu0YzCq0IinZKXH73SaAU3RRH/d9rrkyvMSRtke1b2oUrJTSH1j6iE
	gDSj18RhSHxiPB8qYcvxod9tNntku7MCY73Ln0lWGOqWtgjRyOrTaZj+ztxt
X-Google-Smtp-Source: AGHT+IEdhWcb37E7r8sAP0OHqJnLQL4mMASrXRCrxjLKERy6Cl2RXp+TGtFyhjBlomU/Wuc5CPZZPA==
X-Received: by 2002:a05:6a00:4653:b0:71e:77e7:d60 with SMTP id d2e1a72fcca58-720b9ddb788mr6584049b3a.23.1730409764310;
        Thu, 31 Oct 2024 14:22:44 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:1a14:7759:606e:c90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2eb683sm1630859b3a.175.2024.10.31.14.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 14:22:43 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 31 Oct 2024 14:22:24 -0700
To: Terry Bowman <terry.bowman@amd.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
	oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 03/14] cxl/pci: Introduce helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
Message-ID: <ZyP1EBLzjwTgzhAR@fan>
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-4-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025210305.27499-4-terry.bowman@amd.com>

On Fri, Oct 25, 2024 at 04:02:54PM -0500, Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices and CXL port
> devices.
> 
> First, add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC
> presence. The CXL Flexbus DVSEC presence is used because it is required
> for all the CXL PCIe devices.[1]
> 
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> Flexbus presence.
> 
> Add pcie_is_cxl() as a macro to return 'struct pci_dev::is_cxl',
> 
> Add pcie_is_cxl_port() to check if a device is a CXL root port, CXL
> upstream switch port, or CXL downstream switch port. Also, verify the
> CXL extensions DVSEC for port is present.[1]
> 
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>     Capability (DVSEC) ID Assignment, Table 8-2
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/pci/pci.c             | 14 ++++++++++++++
>  drivers/pci/probe.c           | 10 ++++++++++
>  include/linux/pci.h           |  4 ++++
>  include/uapi/linux/pci_regs.h |  3 ++-
>  4 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d85c04fbba2..c1b243aec61c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5034,6 +5034,20 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
>  					 PCI_DVSEC_CXL_PORT);
>  }
>  
> +bool pcie_is_cxl_port(struct pci_dev *dev)
> +{
> +	if (!pcie_is_cxl(dev))
> +		return false;
> +
> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
> +		return false;
> +
> +	return cxl_port_dvsec(dev);
> +}
> +EXPORT_SYMBOL_GPL(pcie_is_cxl_port);
> +
>  static bool cxl_sbr_masked(struct pci_dev *dev)
>  {
>  	u16 dvsec, reg;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4f68414c3086..9324eb345f11 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1631,6 +1631,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  		dev->is_thunderbolt = 1;
>  }
>  
> +static void set_pcie_cxl(struct pci_dev *dev)
> +{
> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					      PCI_DVSEC_CXL_FLEXBUS);
> +	if (dvsec)
> +		dev->is_cxl = 1;
> +}
> +
>  static void set_pcie_untrusted(struct pci_dev *dev)
>  {
>  	struct pci_dev *parent;
> @@ -1945,6 +1953,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* Need to have dev->cfg_size ready */
>  	set_pcie_thunderbolt(dev);
>  
> +	set_pcie_cxl(dev);
> +
>  	set_pcie_untrusted(dev);
>  
>  	/* "Unknown power state" */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 106ac83e3a7b..d3b1af9fb273 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -443,6 +443,7 @@ struct pci_dev {
>  	unsigned int	is_hotplug_bridge:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> +	unsigned int	is_cxl:1;               /* CXL alternate protocol */
>  	/*
>  	 * Devices marked being untrusted are the ones that can potentially
>  	 * execute DMA attacks and similar. They are typically connected
> @@ -743,6 +744,9 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>  	return false;
>  }
>  
> +#define pcie_is_cxl(dev) (dev->is_cxl)
> +bool pcie_is_cxl_port(struct pci_dev *dev);
> +
>  #define for_each_pci_bridge(dev, bus)				\
>  	list_for_each_entry(dev, &bus->devices, bus_list)	\
>  		if (!pci_is_bridge(dev)) {} else
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 12323b3334a9..5df6c74963c5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1186,9 +1186,10 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>  
> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> +/* Compute Express Link (CXL r3.1, sec 8.1) */
>  #define PCI_DVSEC_CXL_PORT				3
>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> +#define PCI_DVSEC_CXL_FLEXBUS				7
>  
>  #endif /* LINUX_PCI_REGS_H */
> -- 
> 2.34.1
> 

-- 
Fan Ni

