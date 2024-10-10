Return-Path: <linux-pci+bounces-14243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2189E999541
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 00:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE181F245EC
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 22:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B41C6888;
	Thu, 10 Oct 2024 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP3HnD+p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A261A2645;
	Thu, 10 Oct 2024 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599792; cv=none; b=UV4kwxfxWdEqJvcTHy/fUzV9M8DEgkAwa8sxND8yz357IQDSLolcmPN+HsTl7hPC7sKnBeQ9QSvtZs0GYlkNXhZAG58UGYODf+45wiVQ7JAlKF07xv1Ny/xRurcfIbQP13wFmJ73tYPnMWDZv7KJbOtVUhR3qOmVetiClQQJs9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599792; c=relaxed/simple;
	bh=2mWGKo67DpHVHlPBRBwjISoktypQVqAGgZpcasr0OFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uC/J+Wi1xnWs+rKsczaZHhNezikwi4zyq4L3N+2VbvByZ1+8BPSVlY0BVGFNTZUsgqVKflkv5ARGQQygYUyeskg3C/P2i56L91IbSfURq/2FY+FEQOvV0yTMxLPdnReTZA9qMyyAJNK8TzAsRW+c14F1r1tlV6kXYmsViSyUzjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP3HnD+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B96C4CEC5;
	Thu, 10 Oct 2024 22:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728599791;
	bh=2mWGKo67DpHVHlPBRBwjISoktypQVqAGgZpcasr0OFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kP3HnD+p/ALWJIne5QXQB/acHwiuepBOQfXYzd0eCGXIH+jnCCXUf2G7b523XVZX0
	 IGwHkPQ2zrO/Lr1kb9JILZpLncYkVhiA0gD0ANREITE1HH00nC9Jkj2UUqioBL/n+w
	 3OvEynB80KcyGi4AxPrFhdmXRppzgxAiMc21IgRRfdjo4L/Yyf9M8WajB7O4y3hN7U
	 4+nzrzQ+9hRg8KNQRDj5KR3AoZ4vgLxyxyiy04xPtcMD4TtPjt8RVNHBtaCy31nAPE
	 OKbN47yZg2InzUH5/D8q+KMQxPK0Bcf6md8/An7y4yB+WEddn4LpTTw88iwbHIZcHn
	 /Pi4LCFAC/W1A==
Date: Thu, 10 Oct 2024 17:36:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH v3 3/5] PCI: Allow IOV resources to be resized in
 pci_resize_resource
Message-ID: <20241010223629.GA581425@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010103203.382898-4-michal.winiarski@intel.com>

On Thu, Oct 10, 2024 at 12:32:01PM +0200, Michał Winiarski wrote:
> Similar to regular resizable BAR, VF BAR can also be resized.
> The structures are very similar, which means we can reuse most of the
> implementation. See PCIe r4.0, sec 9.3.7.4.

Add blank line between paragraphs.

Add "()" after function name in subject.

Add what the patch does in the commit log, not just what can be done.

>  static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
>  {
> +	int cap = PCI_EXT_CAP_ID_REBAR;
>  	unsigned int pos, nbars, i;
>  	u32 ctrl;
>  
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> +#ifdef CONFIG_PCI_IOV
> +	if (pci_resource_is_iov(bar)) {
> +		cap = PCI_EXT_CAP_ID_VF_REBAR;
> +		bar -= PCI_IOV_RESOURCES;
> +	}
> +#endif

Personal preference, but I'd rather set "cap" directly here instead of
setting a default and then overriding it in some cases.  Setting it
here means both settings are in the same place.

> +	pos = pci_find_ext_capability(pdev, cap);
>  	if (!pos)
>  		return -ENOTSUPP;

>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index c55f2d7a4f37e..e15fd8fe0f81f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -584,6 +584,8 @@ static inline bool pci_resource_is_iov(int resno)
>  {
>  	return resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END;
>  }
> +void pci_iov_resource_set_size(struct pci_dev *dev, int resno, resource_size_t size);
> +bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev);
>  extern const struct attribute_group sriov_pf_dev_attr_group;
>  extern const struct attribute_group sriov_vf_dev_attr_group;
>  #else
> @@ -607,6 +609,12 @@ static inline bool pci_resource_is_iov(int resno)
>  {
>  	return false;
>  }
> +static inline void pci_iov_resource_set_size(struct pci_dev *dev, int resno,
> +					     resource_size_t size) { }
> +static inline bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_PCI_IOV */
>  
>  #ifdef CONFIG_PCIE_PTM
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index e2cf79253ebda..95a13a5fa379c 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -425,13 +425,37 @@ void pci_release_resource(struct pci_dev *dev, int resno)
>  }
>  EXPORT_SYMBOL(pci_release_resource);
>  
> +static bool pci_resize_is_memory_decoding_enabled(struct pci_dev *dev, int resno)

Wrap this (and others) to fit in 80 columns like the rest of the file.

Bjorn

