Return-Path: <linux-pci+bounces-8481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 917B4900C99
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 21:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B713B286988
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 19:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7116913DBB6;
	Fri,  7 Jun 2024 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXupJrvx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC01CAB5;
	Fri,  7 Jun 2024 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717789665; cv=none; b=f5L5QWS5baqPRi/C9MUF4F+0w8WvktxL99V0SqwryXF2VRUZ6oXnNB4otsqgp8FPzU67JjNvhbQRjWWEhgGhTQKHDaD4W2F9rqMD+re+al6WwBz3b4SofOH/BSyRWOLR9G48c0GcqwgValf0lZ56nmAw0RXjzZmP01tHzqUwFbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717789665; c=relaxed/simple;
	bh=NTZmlXTtPqo/64yJt8pRksmMIHacjeI8YFNmvRh9tBg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X70pssvsfKA3CAAL/RIwv0pJsTG1PBD2WNh6PaNVcf0oyJouo0VgsIZdc9iDkpWIJj2kYio1YdqCBBlYl5Uwq3DfK0SgncwcvFPhrAnGP/D6vyLsIuHNEAZcBQ4yqhPx7xw0nA9S5KrGDBSP9owvqnobrn/ubGcx82Q9dz0OQbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXupJrvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5CFC2BBFC;
	Fri,  7 Jun 2024 19:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717789664;
	bh=NTZmlXTtPqo/64yJt8pRksmMIHacjeI8YFNmvRh9tBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WXupJrvxbx3FZTRQhsGfqh/xmfTxBf9mrGx8YB/ibh3OmXe1PmwVh6KKbV/8LV3X/
	 S92NJ0dyXi8YRevQjpWcXy7hLSx0yltvssvX6qeZA0B/3gWbuLOe6080OUEYw5oKi/
	 oiIL//yla/akXVLbI34EQjy9XOHxOmE1OyjqVithNTbv7ddlCVwDM0YIvhz4azB6iw
	 qC+WBjz8Sb7iKhK4FGCxWNkK2bpRqwX8oUTMFu14wOCmcPQu5expC9D/B3+l9QtIaG
	 SfdNc8y1GY06leQEuK4et0skSVtbWHpKgXj454CvuxG0itWz3bq7FZMxLr0tIyXvmW
	 UJDMRsBx+OCng==
Date: Fri, 7 Jun 2024 14:47:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alex Shi <alexs@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Pawel Laszczak <pawell@cadence.com>,
	Yanteng Si <siyanteng@loongson.cn>, linux-doc@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] PCI: use array for .id_table consistently
Message-ID: <20240607194742.GA857985@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240517120458.1260489-1-masahiroy@kernel.org>

On Fri, May 17, 2024 at 09:04:58PM +0900, Masahiro Yamada wrote:
> While 'x' and '&x[0]' are equivalent, most of the PCI drivers use the
> former form for the .id_table.
> 
> Update some drivers and documentation for consistency.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Applied to pci/misc for v6.11, thanks!

USB folks, let me know if you'd rather that I drop your parts.

> ---
> 
>  Documentation/PCI/pciebus-howto.rst                    | 2 +-
>  Documentation/translations/zh_CN/PCI/pciebus-howto.rst | 2 +-
>  drivers/pci/pcie/portdrv.c                             | 2 +-
>  drivers/usb/cdns3/cdnsp-pci.c                          | 2 +-
>  drivers/usb/gadget/udc/cdns2/cdns2-pci.c               | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/PCI/pciebus-howto.rst b/Documentation/PCI/pciebus-howto.rst
> index a0027e8fb0d0..f344452651e1 100644
> --- a/Documentation/PCI/pciebus-howto.rst
> +++ b/Documentation/PCI/pciebus-howto.rst
> @@ -139,7 +139,7 @@ driver data structure.
>  
>    static struct pcie_port_service_driver root_aerdrv = {
>      .name		= (char *)device_name,
> -    .id_table	= &service_id[0],
> +    .id_table	= service_id,
>  
>      .probe		= aerdrv_load,
>      .remove		= aerdrv_unload,
> diff --git a/Documentation/translations/zh_CN/PCI/pciebus-howto.rst b/Documentation/translations/zh_CN/PCI/pciebus-howto.rst
> index 65c4301f12cd..c6ffda62af21 100644
> --- a/Documentation/translations/zh_CN/PCI/pciebus-howto.rst
> +++ b/Documentation/translations/zh_CN/PCI/pciebus-howto.rst
> @@ -124,7 +124,7 @@ pcie_port_service_unregister取代了Linux驱动模型的pci_unregister_driver
>  
>    static struct pcie_port_service_driver root_aerdrv = {
>      .name		= (char *)device_name,
> -    .id_table	= &service_id[0],
> +    .id_table	= service_id,
>  
>      .probe		= aerdrv_load,
>      .remove		= aerdrv_unload,
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 14a4b89a3b83..2faca06ff67c 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -786,7 +786,7 @@ static const struct pci_error_handlers pcie_portdrv_err_handler = {
>  
>  static struct pci_driver pcie_portdriver = {
>  	.name		= "pcieport",
> -	.id_table	= &port_pci_ids[0],
> +	.id_table	= port_pci_ids,
>  
>  	.probe		= pcie_portdrv_probe,
>  	.remove		= pcie_portdrv_remove,
> diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
> index 0725668ffea4..225540fc81ba 100644
> --- a/drivers/usb/cdns3/cdnsp-pci.c
> +++ b/drivers/usb/cdns3/cdnsp-pci.c
> @@ -231,7 +231,7 @@ static const struct pci_device_id cdnsp_pci_ids[] = {
>  
>  static struct pci_driver cdnsp_pci_driver = {
>  	.name = "cdnsp-pci",
> -	.id_table = &cdnsp_pci_ids[0],
> +	.id_table = cdnsp_pci_ids,
>  	.probe = cdnsp_pci_probe,
>  	.remove = cdnsp_pci_remove,
>  	.driver = {
> diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
> index 1691541c9413..50c3d0974d9b 100644
> --- a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
> +++ b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
> @@ -121,7 +121,7 @@ static const struct pci_device_id cdns2_pci_ids[] = {
>  
>  static struct pci_driver cdns2_pci_driver = {
>  	.name = "cdns2-pci",
> -	.id_table = &cdns2_pci_ids[0],
> +	.id_table = cdns2_pci_ids,
>  	.probe = cdns2_pci_probe,
>  	.remove = cdns2_pci_remove,
>  	.driver = {
> -- 
> 2.40.1
> 

