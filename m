Return-Path: <linux-pci+bounces-21473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD55A361F6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 16:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159473AFAF3
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 15:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487E726738C;
	Fri, 14 Feb 2025 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMPULBJm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18565267386;
	Fri, 14 Feb 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547621; cv=none; b=Uo0zJGUD/X9DZexRbP3FSMU6ZzCn/LlfhZHDE+bI2Du+rmUAU4Z5MJ5GiVNiXk6fGFKDUIsChagm635QBMWO2ee82yVttBcZjQSrACrbAd51DJut58FiBFeHH4TlCxSNZOWc20zmb6hCmnp1yv97C9opzOLLLdf4VNzvYdPEV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547621; c=relaxed/simple;
	bh=ZmFVd3RnYnzDSs3ms2xTw+3eLFGGQODuc+T/0hggx64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDH6nf7i+yUqaQHnD1HYyUkjgf+PcWFuz2lzd5vp4UIqkqxmXzYr7+ZpR1avaJl527b1mF4XpVdNEVSZ6PqVc+QMPxnZdkzWWfTqbWcS5CI5WJcqiucCsB9Hci6ueqDQGYFOGYRzTHXOFg+QzUebadJXWSQiw6h4bb78xUubyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMPULBJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E6CC4CED1;
	Fri, 14 Feb 2025 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739547620;
	bh=ZmFVd3RnYnzDSs3ms2xTw+3eLFGGQODuc+T/0hggx64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMPULBJmv/NQyU/5KlaRx0K/kG0HVVayBeZQuQWyti5oqhFuqUh596B1ELKhrGzKE
	 StUPzbeGTkdMWiaTFdKhDUW1t8BVE4V3amffOR3LNTyHEXfg65gXaVWgfNAAjEEAP4
	 TfYFk/NEzYm+BsQcieQUMJ3qceWR8YX9QoeecEBt6YL0sk2waCQNj/qRzizxnB6wyo
	 CDisN6Fv5jhVyEKcAfBszQ1uJWGAarqFF3uC262Jk6K3SHO1pU7VNGysI1St8xURP3
	 5NCNaIJC0A04EfSBOwZZcfjNFEv7zvqIG1NOJMSyEPgw57nv+8ylQnky5zRd5deWEU
	 01/QZ/DnADX2g==
Date: Fri, 14 Feb 2025 21:10:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] PCI: endpoint: Remove API devm_pci_epc_destroy()
Message-ID: <20250214154007.tg3bzi5berkk45wk@thinkpad>
References: <20250210-remove_api-v1-1-8ae6b36e3a5c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210-remove_api-v1-1-8ae6b36e3a5c@quicinc.com>

On Mon, Feb 10, 2025 at 08:39:53PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Static devm_pci_epc_match() is only invoked by API devm_usb_put_phy(), and

devm_usb_put_phy()? Did you mean to say 'devm_pci_epc_destroy()'?

> the API has not had callers since 2017-04-10 when it was introduced.
> 
> Remove both the API and the static function.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

With above fixup,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/PCI/endpoint/pci-endpoint.rst |  7 +++----
>  drivers/pci/endpoint/pci-epc-core.c         | 25 -------------------------
>  include/linux/pci-epc.h                     |  1 -
>  3 files changed, 3 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
> index 35f82f2d45f5ef155b657e337e1eef51b85e68ac..599763aa01ca9d017b59c2c669be92a850e171c4 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
> @@ -57,11 +57,10 @@ by the PCI controller driver.
>     The PCI controller driver can then create a new EPC device by invoking
>     devm_pci_epc_create()/pci_epc_create().
>  
> -* devm_pci_epc_destroy()/pci_epc_destroy()
> +* pci_epc_destroy()
>  
> -   The PCI controller driver can destroy the EPC device created by either
> -   devm_pci_epc_create() or pci_epc_create() using devm_pci_epc_destroy() or
> -   pci_epc_destroy().
> +   The PCI controller driver can destroy the EPC device created by
> +   pci_epc_create() using pci_epc_destroy().
>  
>  * pci_epc_linkup()
>  
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 9e9ca5f8e8f860a57d49ce62597b0f71ef6009ba..cf2e19b80551a2e02136a4411fc61b13e1556d7a 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -25,13 +25,6 @@ static void devm_pci_epc_release(struct device *dev, void *res)
>  	pci_epc_destroy(epc);
>  }
>  
> -static int devm_pci_epc_match(struct device *dev, void *res, void *match_data)
> -{
> -	struct pci_epc **epc = res;
> -
> -	return *epc == match_data;
> -}
> -
>  /**
>   * pci_epc_put() - release the PCI endpoint controller
>   * @epc: epc returned by pci_epc_get()
> @@ -931,24 +924,6 @@ void pci_epc_destroy(struct pci_epc *epc)
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_destroy);
>  
> -/**
> - * devm_pci_epc_destroy() - destroy the EPC device
> - * @dev: device that wants to destroy the EPC
> - * @epc: the EPC device that has to be destroyed
> - *
> - * Invoke to destroy the devres associated with this
> - * pci_epc and destroy the EPC device.
> - */
> -void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
> -{
> -	int r;
> -
> -	r = devres_release(dev, devm_pci_epc_release, devm_pci_epc_match,
> -			   epc);
> -	dev_WARN_ONCE(dev, r, "couldn't find PCI EPC resource\n");
> -}
> -EXPORT_SYMBOL_GPL(devm_pci_epc_destroy);
> -
>  static void pci_epc_release(struct device *dev)
>  {
>  	kfree(to_pci_epc(dev));
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index e818e3fdcded95ca053db074eb75484a2876ea6b..82a26945d038d3e45e2bbbfe3c60b7ef647f247a 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -257,7 +257,6 @@ __devm_pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>  struct pci_epc *
>  __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>  		 struct module *owner);
> -void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc);
>  void pci_epc_destroy(struct pci_epc *epc);
>  int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
>  		    enum pci_epc_interface_type type);
> 
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250210-remove_api-9cf1ea95901e
> 
> Best regards,
> -- 
> Zijun Hu <quic_zijuhu@quicinc.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

