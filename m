Return-Path: <linux-pci+bounces-16680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24B09C79BA
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 18:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8F428482F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 17:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8DB201106;
	Wed, 13 Nov 2024 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MH9uZI/t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC71632CF
	for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731518126; cv=none; b=Muc082Th2KyH147eM+IYCi/OMPH6AjiIr58rDV67h2mJK6bYvuCaF7pTF+h/FOYbT5wvpspzBhIdN+epWD+rU9O28f3YLsSV6E2kEUhvBYoi+yBFaC0x9WVmpCiFdLvcMKcu6R9obTY1nKjMUSJ4Bs/IT4U4NXtDYYEOy2X2DH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731518126; c=relaxed/simple;
	bh=WERDNI0LGwVY3RbweBxSs7T16pb32PWza3c0CSA8vS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hg26Z+cnB5X2OxL+nEkXA3E17q1UBhdaIxBJtXAwVxosxD32vfJHr4kFwp6lKe9wRRdhgMihSk5fgQL8R2DqK8Nzymfy/H1QqK57sK/2zwxZ8UbHgyHdwOb8nNMXnR/t1au4d4bhR+T4J6ClMBVilucsO2UbxsqIjERQY93FqVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MH9uZI/t; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cb7139d9dso68598495ad.1
        for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 09:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731518123; x=1732122923; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TmnyoVBogdAY8x4kmLAsg1HFi2F5M2VCC5E3t36HwWM=;
        b=MH9uZI/tahjLauBLF+d2t8/dNLtsBKbR3fDLESbPtmjWNvqJYKb8m7kdNFTQ7lG4zB
         XJb9N8ZnDtUltO9N8UOx/pTsFIB/kI8MOnOZ/vktrnu4yGgVUn+R4SMf4b6yZm6c9q2/
         AK4qxGbHoQ/lx2hM6jF0TTighBs9CJYnb4i5CjLc3/tg3SJp+r2QqvnYQ3X/6yb0wE0G
         lLeKD2VQzc6gbwcWRmOoPBtaZwudQy4HZVkVd7eJ4ShbZFIs9HbiFlbhJwrF11s1j6nP
         /1TugoTFnjTQX4rf5Mpci7hrcI18ykOjmgLxVUQVaHyC3wHhPZwUMrnuFT/Rpr0kc/3c
         NnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731518123; x=1732122923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmnyoVBogdAY8x4kmLAsg1HFi2F5M2VCC5E3t36HwWM=;
        b=E0nn4dJDJOGmT6zM3hQNqkJ1kDLFcIXVKZytFXLUYsdWpRfcXt8GyyccmFkYveG0FD
         wBMIcuVNlxV4znYexYNOKLSj0iNAr1T1qdAOFYTnUVqGVYBWcY9TPvk9XCPTl1LIDeus
         ElP+0h4Mw0Yca2uF2br6Wv3gCD+/htgwgEXe6eWYNHwKv77bdmke0rtPJlagd38xMMza
         6tl5ELwoYb/MwoYGs0gIU/o0sNVWazqS07HeW32E8Csu3xt05ClAcEVThTXppExfTUgI
         HXY5pTUOmd0jdp0njplLpTlJ+J7M7Fx5EN59gdrM3JCBvdKj3PXEBaer2yxMKHx6Bti/
         zZjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlauUvT5Hy0/huB5qdKl9bNuxJF03M/0aVXZgyph9Jli002l7wfxm0QwqvuAxCNia3LdAY8tVZeCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtSBYFkcXExqpiRSs/k4Z4jIV7BoNSElYlR95TK9CtlxX4/cuW
	LOWlFGzgmSjmP8ZlYAGLOP+QywgviU92YnXvVdxetsyN3gzMVXZEbpb5S32dww==
X-Google-Smtp-Source: AGHT+IHzuQZcyCrKEu2zhDf6vGWpfQpSsivZTFz9ERjtI5rVRvb2nqfyzm+YGxn9leeh1yDA8kfSug==
X-Received: by 2002:a17:903:41ca:b0:20b:9f8c:e9de with SMTP id d9443c01a7336-21183cff8a2mr257327955ad.13.1731518123010;
        Wed, 13 Nov 2024 09:15:23 -0800 (PST)
Received: from thinkpad ([117.213.102.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc8f25sm112819815ad.22.2024.11.13.09.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:15:22 -0800 (PST)
Date: Wed, 13 Nov 2024 22:45:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v5 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Message-ID: <20241113171511.6d4gh3x27nej55qw@thinkpad>
References: <20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com>
 <20241104-imx95_lut-v5-1-feb972f3f13b@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104-imx95_lut-v5-1-feb972f3f13b@nxp.com>

On Mon, Nov 04, 2024 at 02:22:59PM -0500, Frank Li wrote:
> Some PCIe host bridges require special handling when enabling or disabling
> PCIe Endpoints. For example, the i.MX95 platform has a lookup table to map
> Requester IDs to StreamIDs, which are used by the SMMU and MSI controller
> to identify the source of DMA accesses.
> 
> Without this mapping, DMA accesses may target unintended memory, which
> would corrupt memory or read the wrong data.
> 
> Add a host bridge .enable_device() hook the imx6 driver can use to
> configure the Requester ID to StreamID mapping. The hardware table isn't
> big enough to map all possible Requester IDs, so this hook may fail if no
> table space is available. In that case, return failure from
> pci_enable_device().
> 
> It might make more sense to make pci_set_master() decline to enable bus
> mastering and return failure, but it currently doesn't have a way to return
> failure.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Change from v4 to v5
> - Add two static help functions
> int pci_host_bridge_enable_device(dev);
> void pci_host_bridge_disable_device(dev);
> - remove tags because big change
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Tested-by: Marc Zyngier <maz@kernel.org>
> 
> Change from v3 to v4
> - Add Bjorn's ack tag
> 
> Change from v2 to v3
> - use Bjorn suggest's commit message.
> - call disable_device() when error happen.
> 
> Change from v1 to v2
> - move enable(disable)device ops to pci_host_bridge
> ---
>  drivers/pci/pci.c   | 36 +++++++++++++++++++++++++++++++++++-
>  include/linux/pci.h |  2 ++
>  2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 67013df89a694..4735bc665ab3b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2055,6 +2055,28 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
>  	return pci_enable_resources(dev, bars);
>  }
>  
> +static int pci_host_bridge_enable_device(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
> +	int err;
> +
> +	if (host_bridge && host_bridge->enable_device) {
> +		err = host_bridge->enable_device(host_bridge, dev);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void pci_host_bridge_disable_device(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
> +
> +	if (host_bridge && host_bridge->disable_device)
> +		host_bridge->disable_device(host_bridge, dev);
> +}
> +
>  static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  {
>  	int err;
> @@ -2070,9 +2092,13 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  	if (bridge)
>  		pcie_aspm_powersave_config_link(bridge);
>  
> +	err = pci_host_bridge_enable_device(dev);
> +	if (err)
> +		return err;
> +
>  	err = pcibios_enable_device(dev, bars);
>  	if (err < 0)
> -		return err;
> +		goto err_enable;
>  	pci_fixup_device(pci_fixup_enable, dev);
>  
>  	if (dev->msi_enabled || dev->msix_enabled)
> @@ -2087,6 +2113,12 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  	}
>  
>  	return 0;
> +
> +err_enable:
> +	pci_host_bridge_disable_device(dev);
> +
> +	return err;
> +
>  }
>  
>  /**
> @@ -2270,6 +2302,8 @@ void pci_disable_device(struct pci_dev *dev)
>  	if (atomic_dec_return(&dev->enable_cnt) != 0)
>  		return;
>  
> +	pci_host_bridge_disable_device(dev);
> +
>  	do_pci_disable_device(dev);
>  
>  	dev->is_busmaster = 0;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a17edc6c28fda..5f75c30f263be 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -596,6 +596,8 @@ struct pci_host_bridge {
>  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>  	int (*map_irq)(const struct pci_dev *, u8, u8);
>  	void (*release_fn)(struct pci_host_bridge *);
> +	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
> +	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>  	void		*release_data;
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

