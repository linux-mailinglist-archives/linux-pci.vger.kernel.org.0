Return-Path: <linux-pci+bounces-8691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 115EC905CAB
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 22:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF2C1F235FA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 20:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCDA84A4C;
	Wed, 12 Jun 2024 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qay0gEo/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488B55C08;
	Wed, 12 Jun 2024 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223645; cv=none; b=nvVBnlGLbmKspsqTj8Fb+9vSoWmwk39KRL1jBb3MLPiCUmTNLiGhWE86HLvKdS6H2GP4w5QGAYrnETRXk5TyqyBt0eXypAV7eFD6W+xmOTCz344k6lk3f+1gz8262r++IAO1fayeu+dj9N6z1CvlDaGW4LQA9EqJQ5uXJg0Wk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223645; c=relaxed/simple;
	bh=XBpigFK488BpUSYT5s0FHcdoB1pg3lKFZCYWjmNb4HE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rmBS4LFDQ7ZbT3GFPjvoKfc4TDav3OS/AGcRJYzuFPDugguGK9rYsFGyuj108T3CivUg5pUtsgU58Pj0M6eNzob4kX6ykeDL2ie0Mxgw4u0aowyTmEy+rCP4hlYYm5/MPusP6jToxzhbX3onDa+YdYZ9oz9/hn9lezhML41WxC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qay0gEo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A6AC116B1;
	Wed, 12 Jun 2024 20:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718223645;
	bh=XBpigFK488BpUSYT5s0FHcdoB1pg3lKFZCYWjmNb4HE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qay0gEo/8xVWF2qx7h5/bZgKFxIXuRDfY+jnZjFGBOao8JMYCdEA8s92G88jmUCL0
	 HhE9h/xcewebQkwro0bn+p/yJh1tpBZBiMguZ43ENdRw5sNDMiMyJsGV9wwL4q3amf
	 qQ1Q37k3TF8z+Frnv4q3PV1bxMKT/LWqBBBxW16JcpS46Uylu7LssxO/OUYUcLdYgM
	 dmzzG9LRbskjsSD6TJI6pXwh0nOblvIex4oddYFzmGaiHS5DyNvzIO30Pr1wONu6VL
	 Fq32FRflwqmZul30ZvV0OPuVb978f/Xf+J9fcz/6p3K7Mq1cdcbT0mt5ldyrVqtpf/
	 E8VxPwCcmi1OA==
Date: Wed, 12 Jun 2024 15:20:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: endpoint: make pci_epc_class constant
Message-ID: <20240612202043.GA1036897@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024061011-citable-herbicide-1095@gregkh>

On Mon, Jun 10, 2024 at 10:20:12AM +0200, Greg Kroah-Hartman wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, we should make all 'class' structures declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at runtime.
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Kishon Vijay Abraham I <kishon@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied to pci/endpoint for v6.11, thanks!

> ---
>  drivers/pci/endpoint/pci-epc-core.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 47d27ec7439d..ed038dd77f83 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -14,7 +14,9 @@
>  #include <linux/pci-epf.h>
>  #include <linux/pci-ep-cfs.h>
>  
> -static struct class *pci_epc_class;
> +static const struct class pci_epc_class = {
> +	.name = "pci_epc",
> +};
>  
>  static void devm_pci_epc_release(struct device *dev, void *res)
>  {
> @@ -60,7 +62,7 @@ struct pci_epc *pci_epc_get(const char *epc_name)
>  	struct device *dev;
>  	struct class_dev_iter iter;
>  
> -	class_dev_iter_init(&iter, pci_epc_class, NULL, NULL);
> +	class_dev_iter_init(&iter, &pci_epc_class, NULL, NULL);
>  	while ((dev = class_dev_iter_next(&iter))) {
>  		if (strcmp(epc_name, dev_name(dev)))
>  			continue;
> @@ -867,7 +869,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>  	INIT_LIST_HEAD(&epc->pci_epf);
>  
>  	device_initialize(&epc->dev);
> -	epc->dev.class = pci_epc_class;
> +	epc->dev.class = &pci_epc_class;
>  	epc->dev.parent = dev;
>  	epc->dev.release = pci_epc_release;
>  	epc->ops = ops;
> @@ -927,20 +929,13 @@ EXPORT_SYMBOL_GPL(__devm_pci_epc_create);
>  
>  static int __init pci_epc_init(void)
>  {
> -	pci_epc_class = class_create("pci_epc");
> -	if (IS_ERR(pci_epc_class)) {
> -		pr_err("failed to create pci epc class --> %ld\n",
> -		       PTR_ERR(pci_epc_class));
> -		return PTR_ERR(pci_epc_class);
> -	}
> -
> -	return 0;
> +	return class_register(&pci_epc_class);
>  }
>  module_init(pci_epc_init);
>  
>  static void __exit pci_epc_exit(void)
>  {
> -	class_destroy(pci_epc_class);
> +	class_unregister(&pci_epc_class);
>  }
>  module_exit(pci_epc_exit);
>  
> -- 
> 2.45.2
> 

