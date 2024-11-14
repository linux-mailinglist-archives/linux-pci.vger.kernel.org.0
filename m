Return-Path: <linux-pci+bounces-16769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F359C8FE1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 17:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91830B37BD4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 15:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00EF194A4B;
	Thu, 14 Nov 2024 15:45:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A6017084F;
	Thu, 14 Nov 2024 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599146; cv=none; b=pIZ8G909HCLk/wGw7LAawYqc1tx4Mxv/cscZJQNpe76vf1zU4+LWkXpL8bstKe5FXPM3STqEx+devqcv4f3+aVLwh524Ke/o+eRQ9fCxULLSG3M5C03LVC4MkZb7y/SGxFkN+QwYZbpZOzryakaTz7ZqQWRG9lgiwdMR9b0oUpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599146; c=relaxed/simple;
	bh=9Z4M8hzYU/w6zX+l0vhoSq1ALisl/iiI9Bc2iEjZblk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3C1RMqIxOsDr2UUyafsCf+h2Xs7lxQAQzD9ZRZ1OuEnohC2pnjbE6IgQcYimh16I45/+tbK78WcR//OTlRiKwcKwHCret7t7F0gXDANYVg/Zbbv9Pv5/BCZiYltn+00MrJTbkLMl0VSsac8xuHhuHfOGpe4u1cWILQF/1oIoHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6453A100FC22E;
	Thu, 14 Nov 2024 16:45:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 25FC33C4907; Thu, 14 Nov 2024 16:45:33 +0100 (CET)
Date: Thu, 14 Nov 2024 16:45:33 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
	oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v3 03/15] cxl/pci: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
Message-ID: <ZzYbHZvU_RFXZuk0@wunner.de>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-4-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113215429.3177981-4-terry.bowman@amd.com>

On Wed, Nov 13, 2024 at 03:54:17PM -0600, Terry Bowman wrote:
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5038,6 +5038,20 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
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

This doesn't need to be exported because the only caller introduced
in this series is in drivers/pci/pcie/aer.c (in patch 05/15), which
is dependent on CONFIG_PCIEAER, which is bool not tristate.

The "!pcie_is_cxl(dev)" check at the top of the function is identical
to the return value "cxl_port_dvsec(dev)".  This looks redundant.
However one cannot call pci_pcie_type() without first checking
pci_is_pcie().  So I'm wondering if the "!pcie_is_cxl(dev)" check
is actually erroneous and supposed to be "!pci_is_pcie(dev)"?
That would make more sense to me.

Alternatively, just return true instead of "cxl_port_dvsec(dev)".
That would probably be the simplest solution here.


> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -443,6 +443,7 @@ struct pci_dev {
>  	unsigned int	is_hotplug_bridge:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> +	unsigned int	is_cxl:1;               /* CXL alternate protocol */

I suspect the audience consists mostly of CXL-unaware PCI developers,
so spelling out Compute Express Link here (and omitting "alternate
protocol" if it doesn't fit) might be more appropriate.

Thanks,

Lukas

