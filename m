Return-Path: <linux-pci+bounces-26052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC22A912C4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 07:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC1017AA841
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 05:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654021DE883;
	Thu, 17 Apr 2025 05:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T08ZG8D3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092EF1B3934
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 05:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868372; cv=none; b=fK3jh8RMBsi/gwt9sf7I5/L1EBp1QMtMAWl2R1/krXSxmVgHyHniuGUBkoFPbRpeVOPaUD4Q2SIF7ANjHtjdVEMGBdrIUuyy03u4REkveil2rV0hKKkER53kCy1Ma3V0DZWuG279DiV9XLc5Gg5+GmuDSGjKg41OSjKat/qjdBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868372; c=relaxed/simple;
	bh=H6m5Tdy8+/JRNoNm7oMsQVHxeGyCxsf3G0xsF81+8rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk/YCAlmsYcnAmFb4daapcnf24k8AS7nyLw4LGEa5Pc6OVEeo61FR2hagSavdzhjX2N0o3qk4QIAgrMlqaiKWbTVhVd+hBc06be400xHUhMg1bQbvfYmS6b8ZxAW+T0dNo3keh6DUz84oxihw2u8OaLD9AQybqMEJ+As3mOu170=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T08ZG8D3; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736c3e7b390so278756b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Apr 2025 22:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744868368; x=1745473168; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f5v426PMT/rcYy79308JbFGxzA66xRwLsnLNveGybTY=;
        b=T08ZG8D31AwiBMqwYV4paElnQEkUWmntcSNg2cgUF0M3Lh5Hru97Sd74WtQvf4O5jp
         BvquM5Rf4Tnj8ALqgClX91ddrxWuG1ghEM7aPUYAEzG7S5mwgUpeeqT0+iBq8Wcms472
         x7WarVdP2SNHpBOy8zmTFZpR5abWBB045InDppanFqIg5knX6YiTXfDvoWwCQ5Tq2oAw
         7jGsyB4VIGOUCuA1CQP7AU/CtFXzMkUJdc/MDMqUhoGyo51OBh5DqwJQDPGHI+1uudTf
         3KzLKGlxSGUZeu6XMkWXdkJwpGHc4EijtlLRwORJkGkHHdVyXAgydbxAm9pQCXSDm8Ds
         NnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744868368; x=1745473168;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5v426PMT/rcYy79308JbFGxzA66xRwLsnLNveGybTY=;
        b=mnguM9jGMHyMoMzYJMstZIKcEsPFsbuCCNSnBAqaM1j2GSaaPzkHYWkSZB0+5K3NE3
         5zaTnX3+nu4R57/EE/JmnanBxYK40ZXbXGJO/lJDUCzkUzU8oOzrrwOEk8rWjtk3xMpv
         0g5A6ax6CEsR0b/qeWPGWNrBeqsArpevwLlQGLmi0sOC3l6iiG2fB3VdMvjrU2oAIb6v
         bj9Kmc9k4HAIgmdb5YGXtkjs3izT8hoSQa5dcwVL+iyHMYnpsRNB3O6gPSmGqYQ2n5hv
         J3HqyWKmnFs+/OfeuX/zeCartiPIGR7++QXfykesJ+Ae0/HCAp7kVq2ZQ/ddqYK1FGAa
         gtTA==
X-Forwarded-Encrypted: i=1; AJvYcCXIPSrr6UrxPfXpoXBnq3sppWHSxJZITO8MJ//APw52QtVK7JNxWSO/EWe/H+hwFlGegAgvNrb+570=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrkgkyZ7sEb0shn96VdztlC0z+uGkfyCR8cIsrVwcg4to+J2o0
	nB8PIQtNp3seBtvNEe6tmDNqmilltsDCo9PjonCXPJ0PuL95A34KKipulF8xKw==
X-Gm-Gg: ASbGncs5wyf7jH266yGgVKBpqnJhHspk0BsTMrnbryawK3sZJf6fMJ/uHe64af1GugT
	daMIygl5sJ6NzZ47LvbvQstlLAY2EhyzMlYoLNF3hqrJmL0Z6UljemQrRkbSh5zv5w2dJckgpBa
	6VERYHsR5ojAz52ZLTcL82xIlBIN8BEBz4vR5f3GuJ6PrCFDBD9h1jQGhob3VUwHat1PqfktdkN
	trheSons4lb9DR/x4ucnAGipgQuPxoLHsac5LMFeWwxB7I/HQY6ZuRUHokZQKNc6oKh+9fiehuT
	nIyaFAFPuYpUNi0ehCE4nNwk2A1EMaqeiIqdiNOvOJOsSy+/
X-Google-Smtp-Source: AGHT+IEndgfa94YN7BMZh5STCpP7wGFsaSVlAG8SMJDtj+c3nxd5AzXnq+goeqg6hGMJKi6M/Nlsaw==
X-Received: by 2002:a05:6a20:ce48:b0:1f5:862b:a583 with SMTP id adf61e73a8af0-203b3fbe8ffmr7026509637.34.1744868368169;
        Wed, 16 Apr 2025 22:39:28 -0700 (PDT)
Received: from thinkpad ([120.60.54.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b220a988bsm2235387a12.14.2025.04.16.22.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 22:39:27 -0700 (PDT)
Date: Thu, 17 Apr 2025 11:09:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, dingwei@marvell.com, cassel@kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI/ERR: Add support for resetting the slot in a
 platforms specific way
Message-ID: <jb4iq364iqwk3swux5cjiczyvdyrkjtqjclefyfjrntepvroyn@7vbvbzu3pd3p>
References: <20250404-pcie-reset-slot-v1-0-98952918bf90@linaro.org>
 <20250404-pcie-reset-slot-v1-2-98952918bf90@linaro.org>
 <Z--cY5Uf6JyTYL9y@wunner.de>
 <3dokyirkf47lqxgx5k2ybij5b5an6qnceifsub3mcmjvzp3kdb@sm7f2jxxepdc>
 <Z__AyQeZmXiNwT7c@wunner.de>
 <rrqn7hlefn7klaczi2jkfta72pwmtentj3zp37yvw3brwpnalk@3eapwfeo5y4d>
 <aABJ_u8-FXeJoPyF@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aABJ_u8-FXeJoPyF@wunner.de>

On Thu, Apr 17, 2025 at 02:23:26AM +0200, Lukas Wunner wrote:
> On Wed, Apr 16, 2025 at 08:34:21PM +0530, Manivannan Sadhasivam wrote:
> > I don't think it is possible to get rid of the powerpc version. It has
> > its own pci_dev::sysdata pointing to 'struct pci_controller' pointer
> > which is internal to powerpc arch code. And the generic code would need
> > 'struct pci_host_bridge' to access the callback.
> 
> Below is my proposal to convert powerpc to the new ->slot_reset() callback.
> Compile-tested only.
> 
> Feel free to include this in your series, alternatively I can submit it
> to powerpc maintainers once your series has landed.  Thanks!
> 
> -- >8 --
> 
> From: Lukas Wunner <lukas@wunner.de>
> Subject: [PATCH] powerpc/powernv/pci: Migrate to pci_host_bridge::reset_slot
>  callback
> 
> struct pci_host_bridge has just been amended with a ->reset_slot()
> callback to allow for a per-host-bridge Secondary Bus Reset procedure.
> 
> PowerNV needs a platform-specific reset procedure and has historically
> implemented it by overriding pcibios_reset_secondary_bus().
> 
> Migrate PowerNV to the new ->reset_slot() callback for simplicity and
> cleanliness.  Assign the callback as soon as the pci_host_bridge is
> allocated through the following call chain:
> 
> pcibios_init()
>   pcibios_scan_phb()
>     pci_create_root_bus()
>       pci_register_host_bridge()
>         pcibios_root_bridge_prepare()
> 
> The powerpc-specific implementation of pcibios_reset_secondary_bus() can
> thus be deleted and the remaining default implementation in the PCI core
> can be made private.  The ->reset_secondary_bus() callback in struct
> pci_controller_ops likewise becomes obsolete and can be deleted.
> 

Looks good to me, thanks! I think it would be better if it is submitted once my
series has landed in mainline (just to avoid immutable branch hassle between
powerpc and PCI trees).

- Mani

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  arch/powerpc/include/asm/pci-bridge.h        |  1 -
>  arch/powerpc/kernel/pci-common.c             | 12 ------------
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 14 +++++++++-----
>  arch/powerpc/platforms/powernv/pci-ioda.c    |  9 +++++++--
>  arch/powerpc/platforms/powernv/pci.h         |  3 ++-
>  drivers/pci/pci.c                            |  2 +-
>  include/linux/pci.h                          |  1 -
>  7 files changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 2aa3a091ef20..0de09fc90641 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -36,7 +36,6 @@ struct pci_controller_ops {
>  					    unsigned long type);
>  	void		(*setup_bridge)(struct pci_bus *bus,
>  					unsigned long type);
> -	void		(*reset_secondary_bus)(struct pci_dev *pdev);
>  
>  #ifdef CONFIG_PCI_MSI
>  	int		(*setup_msi_irqs)(struct pci_dev *pdev,
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index eac84d687b53..dad15fbec4e0 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -233,18 +233,6 @@ void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)
>  		hose->controller_ops.setup_bridge(bus, type);
>  }
>  
> -void pcibios_reset_secondary_bus(struct pci_dev *dev)
> -{
> -	struct pci_controller *phb = pci_bus_to_host(dev->bus);
> -
> -	if (phb->controller_ops.reset_secondary_bus) {
> -		phb->controller_ops.reset_secondary_bus(dev);
> -		return;
> -	}
> -
> -	pci_reset_secondary_bus(dev);
> -}
> -
>  resource_size_t pcibios_default_alignment(void)
>  {
>  	if (ppc_md.pcibios_default_alignment)
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index db3370d1673c..9b9517cb6ab7 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -890,18 +890,22 @@ static int pnv_eeh_bridge_reset(struct pci_dev *pdev, int option)
>  	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
>  }
>  
> -void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
> +int pnv_pci_reset_secondary_bus(struct pci_host_bridge *host,
> +				struct pci_dev *dev)
>  {
>  	struct pci_controller *hose;
> +	int rc_hot, rc_dea;
>  
>  	if (pci_is_root_bus(dev->bus)) {
>  		hose = pci_bus_to_host(dev->bus);
> -		pnv_eeh_root_reset(hose, EEH_RESET_HOT);
> -		pnv_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
> +		rc_hot = pnv_eeh_root_reset(hose, EEH_RESET_HOT);
> +		rc_dea = pnv_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
>  	} else {
> -		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
> -		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
> +		rc_hot = pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
> +		rc_dea = pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
>  	}
> +
> +	return rc_hot ? : rc_dea ? : 0;
>  }
>  
>  static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, const char *type,
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index ae4b549b5ca0..e1b75a4bc681 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2145,6 +2145,12 @@ static void pnv_pci_ioda_fixup(void)
>  #endif
>  }
>  
> +static int pnv_pci_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	bridge->reset_slot = pnv_pci_reset_secondary_bus;
> +	return 0;
> +}
> +
>  /*
>   * Returns the alignment for I/O or memory windows for P2P
>   * bridges. That actually depends on how PEs are segmented.
> @@ -2504,7 +2510,6 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
>  	.release_device		= pnv_pci_release_device,
>  	.window_alignment	= pnv_pci_window_alignment,
>  	.setup_bridge		= pnv_pci_fixup_bridge_resources,
> -	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
>  	.shutdown		= pnv_pci_ioda_shutdown,
>  #ifdef CONFIG_IOMMU_API
>  	.device_group		= pnv_pci_device_group,
> @@ -2515,7 +2520,6 @@ static const struct pci_controller_ops pnv_npu_ocapi_ioda_controller_ops = {
>  	.enable_device_hook	= pnv_ocapi_enable_device_hook,
>  	.release_device		= pnv_pci_release_device,
>  	.window_alignment	= pnv_pci_window_alignment,
> -	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
>  	.shutdown		= pnv_pci_ioda_shutdown,
>  };
>  
> @@ -2724,6 +2728,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>  	}
>  
>  	ppc_md.pcibios_default_alignment = pnv_pci_default_alignment;
> +	ppc_md.pcibios_root_bridge_prepare = pnv_pci_root_bridge_prepare;
>  
>  #ifdef CONFIG_PCI_IOV
>  	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_iov;
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 42075501663b..44e8969c7729 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -275,7 +275,8 @@ extern struct iommu_table *pnv_pci_table_alloc(int nid);
>  
>  extern void pnv_pci_init_ioda2_phb(struct device_node *np);
>  extern void pnv_pci_init_npu2_opencapi_phb(struct device_node *np);
> -extern void pnv_pci_reset_secondary_bus(struct pci_dev *dev);
> +extern int pnv_pci_reset_secondary_bus(struct pci_host_bridge *host,
> +				       struct pci_dev *dev);
>  extern int pnv_eeh_phb_reset(struct pci_controller *hose, int option);
>  
>  extern struct pnv_ioda_pe *pnv_pci_bdfn_to_pe(struct pnv_phb *phb, u16 bdfn);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13709bb898a9..fe66d69c6429 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4980,7 +4980,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
>  }
>  
> -void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
> +static void pcibios_reset_secondary_bus(struct pci_dev *dev)
>  {
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  	int ret;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 76e977af2d52..43d952361e84 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1398,7 +1398,6 @@ int pci_probe_reset_slot(struct pci_slot *slot);
>  int pci_probe_reset_bus(struct pci_bus *bus);
>  int pci_reset_bus(struct pci_dev *dev);
>  void pci_reset_secondary_bus(struct pci_dev *dev);
> -void pcibios_reset_secondary_bus(struct pci_dev *dev);
>  void pci_update_resource(struct pci_dev *dev, int resno);
>  int __must_check pci_assign_resource(struct pci_dev *dev, int i);
>  void pci_release_resource(struct pci_dev *dev, int resno);
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

