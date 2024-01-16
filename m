Return-Path: <linux-pci+bounces-2219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276D082F457
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 19:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B849C28597A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 18:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88951C6AD;
	Tue, 16 Jan 2024 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKtlOPFq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9513FE5;
	Tue, 16 Jan 2024 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430118; cv=none; b=lfMypQDfvaxK/CXiPd0Tscc1oBtIAZXTWFNieoyckyT8tplwI9J3Qva6m8chSK1hEtsVj/voiQvkRSDi1ybdfERZe+cTVq2Lt59phoCxhvRvP+XA6wLRbUElY4OKTJnAZAqYp5E7drL3ViuuOKKzCNlCfcrqLdXwMII05RfYBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430118; c=relaxed/simple;
	bh=MnY2gVubEGri9ggkfjnpG/sTnNx4BdvXPjR2PSZ83GE=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=ZEFieGH8UrS6A4ocYAORHs6VGGa78yKFqQCJ66q/03mfreZKRw23ai/G2bOJA6aX0TljSK2ggB2Q7u/86B4n3FcYLXL8KBRREbCwUsF4vDPEqgVvC10cC4rL/nDvVSHg6kYLDUYv6R+zsusS9j0JyrqBLoe+LR5woi266lQA2DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKtlOPFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A09C433C7;
	Tue, 16 Jan 2024 18:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705430118;
	bh=MnY2gVubEGri9ggkfjnpG/sTnNx4BdvXPjR2PSZ83GE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iKtlOPFqFaAmH1K/7wOYsOyKeMSUCGDMwgk42s0cLKwHQqKxXxyXfCYNB29supvRu
	 lxMM/8gNABx8D8EG1w2Kw6Cn64lBlbWD4PBfKqihB3SXSNxOOazlhcv58mZDz1SrPc
	 whI157N2nOgTtOzEIgp332p44e+vjwsXduG5IANcIivFsg79jF77pVzcvclKrhhbNN
	 jUQDLi1u+uwWAFjw4ddjRpN2/7hIzFpFmrzbU0Yl5PNucgdthNjRiBUp1xQ5aa/daj
	 jUU13N7bJwOO8S4VBFEHMTKci0a4DM4GNNmvw0tRFb6cU/AZyMPuW4JnSy/As8ofsP
	 LV9qr1N44b3ZQ==
Date: Tue, 16 Jan 2024 12:35:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 07/10] pci: devres: give mwi its own callback
Message-ID: <20240116183516.GA101535@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115144655.32046-9-pstanner@redhat.com>

On Mon, Jan 15, 2024 at 03:46:18PM +0100, Philipp Stanner wrote:
> managing mwi with devres can easily be done with its own callback,
> without the necessity to store any state about it in a device-related
> struct.

s/managing/Managing/

s/mwi/MWI/ since this is an initialism.  Also in subject (but would be
even better if it could mention an actual function name).

> Remove the mwi state from the devres-struct.
> Make the devres-mwi functions set a separate devres-callback.

Wrap to fill 75 columns (or add blank lines if you intend multiple
paragraphs).

s/devres-struct/struct pci_devres/ to make this greppable.

s/the devres-mwi functions/pcim_set_mwi()/ similarly.

> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/pci/devres.c | 23 +++++++++++------------
>  drivers/pci/pci.h    |  1 -
>  2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index de8cf6f87dd7..911c2037d9fd 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -378,24 +378,26 @@ void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
>  }
>  EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
>  
> +static void __pcim_clear_mwi(void *pdev_raw)
> +{
> +	struct pci_dev *pdev = pdev_raw;
> +
> +	pci_clear_mwi(pdev);
> +}
> +
>  /**
>   * pcim_set_mwi - a device-managed pci_set_mwi()
> - * @dev: the PCI device for which MWI is enabled
> + * @pdev: the PCI device for which MWI is enabled
>   *
>   * Managed pci_set_mwi().
>   *
>   * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
>   */
> -int pcim_set_mwi(struct pci_dev *dev)
> +int pcim_set_mwi(struct pci_dev *pdev)
>  {
> -	struct pci_devres *dr;
> -
> -	dr = find_pci_dr(dev);
> -	if (!dr)
> -		return -ENOMEM;
> +	devm_add_action(&pdev->dev, __pcim_clear_mwi, pdev);
>  
> -	dr->mwi = 1;
> -	return pci_set_mwi(dev);
> +	return pci_set_mwi(pdev);
>  }
>  EXPORT_SYMBOL(pcim_set_mwi);
>  
> @@ -405,9 +407,6 @@ static void pcim_release(struct device *gendev, void *res)
>  	struct pci_dev *dev = to_pci_dev(gendev);
>  	struct pci_devres *this = res;
>  
> -	if (this->mwi)
> -		pci_clear_mwi(dev);
> -
>  	if (this->restore_intx)
>  		pci_intx(dev, this->orig_intx);
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3d9908a69ebf..667bfdd61d5e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -811,7 +811,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
>  struct pci_devres {
>  	unsigned int orig_intx:1;
>  	unsigned int restore_intx:1;
> -	unsigned int mwi:1;
>  };
>  
>  struct pci_devres *find_pci_dr(struct pci_dev *pdev);
> -- 
> 2.43.0
> 

