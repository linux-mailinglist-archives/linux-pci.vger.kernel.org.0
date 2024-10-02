Return-Path: <linux-pci+bounces-13714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9021598D394
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 14:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476521F21E15
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 12:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC56F1CF5F8;
	Wed,  2 Oct 2024 12:46:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5B5184;
	Wed,  2 Oct 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873189; cv=none; b=nc0dgPl0F1m16EZrynnfG5jsbfajBOg4JUQVskivbBYQXYj0oA0gQ1kXqkbTcnt5PerjNV1X2+3StFmaSs6vzNWPef3P0DNsRnMFCXIY/bs/pB/W51R847+Pa9fFWUJqC6Yurxgwy1dql+oCtwjcHOOa6FkGaiwL+s9FYbOj56s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873189; c=relaxed/simple;
	bh=ORbtBUx+hRQJ6X1DoV6ZgX4krqJv0QpPvICn9HruO9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMpaPaYpUnD5zXL6q4lfKUywdB8bo3S4kvY63P9mA8AyOcJIfqs+1pyL+5dXZ9ggrrDU26HuQjhymacUDb3VqoTKIB7QW+CzM6V/BHOzIE53c2NlPTxC+Lqk0ej6HfyD91zeXN/O+QcTht3Iy3+KJuAth4teW2kJAcciakLI/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9F9C03000008D;
	Wed,  2 Oct 2024 14:46:17 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8DA8A4B78AC; Wed,  2 Oct 2024 14:46:17 +0200 (CEST)
Date: Wed, 2 Oct 2024 14:46:17 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com, paul.e.luse@intel.com, jing2.liu@intel.com
Subject: Re: [PATCH V6 1/5] PCI: Add TLP Processing Hints (TPH) support
Message-ID: <Zv1AmfxGMw_F0nN1@wunner.de>
References: <20240927215653.1552411-1-wei.huang2@amd.com>
 <20240927215653.1552411-2-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927215653.1552411-2-wei.huang2@amd.com>

On Fri, Sep 27, 2024 at 04:56:49PM -0500, Wei Huang wrote:
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -173,6 +173,16 @@ config PCI_PASID
>  
>  	  If unsure, say N.
>  
> +config PCIE_TPH
> +	bool "TLP Processing Hints"
> +	default n

Nit: "n" is already the default, so this line can be omitted.

Thanks,

Lukas

