Return-Path: <linux-pci+bounces-17040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7494F9D0EB0
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 11:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA51280194
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 10:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76924405FB;
	Mon, 18 Nov 2024 10:37:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5166192D95;
	Mon, 18 Nov 2024 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926230; cv=none; b=i/E6m6EEVIqM3qrU2NTYk9/KHEAE4Pf2eoy6ndzotQ9nOqHTCM63C7i3mff8xZraGaVIczEnkuLRrNHndaUGvnl58DAgvFqgt1KqIXjux+BqvsgUqEZm3e7wyLmEZZGUfX9F0NoPf07XE7Z9iNTXcONX0+zjpDwIpYj2yVcgNkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926230; c=relaxed/simple;
	bh=Q09DCGRa5g/ILADMYzBlOOTEbKZi1gCfF5LYvWSg8zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/eLh6KdRpi0YuhnRwkC6r9qC7Rfol3vawic3dtIXbLC4AkAuXzY1FBAShGlpw51AeFonwPxwg/wQLkUL8XQr5fUNZ9pWQxvBmJ0dVNEpjoIL5dPcJu2VjZq3Fo/GwPr8Frt7VvEmXzFSMipgBmlqnWtt30o8lFVOCbribqx2DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0A21A300034CC;
	Mon, 18 Nov 2024 11:37:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CC0C65F8FA3; Mon, 18 Nov 2024 11:37:00 +0100 (CET)
Date: Mon, 18 Nov 2024 11:37:00 +0100
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
Subject: Re: [PATCH v3 07/15] PCI/AER: Add CXL PCIe port uncorrectable error
 recovery in AER service driver
Message-ID: <ZzsYzN5QALTko_Ku@wunner.de>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-8-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113215429.3177981-8-terry.bowman@amd.com>

On Wed, Nov 13, 2024 at 03:54:21PM -0600, Terry Bowman wrote:
> Non-fatal CXL UCE errors will be treated as fatal.

Hm, I wonder why?

> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1048,7 +1048,10 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  			pdrv->cxl_err_handler->cor_error_detected(dev);
>  
>  		pcie_clear_device_status(dev);
> -	}
> +	} else if (info->severity == AER_NONFATAL)
> +		cxl_do_recovery(dev);
> +	else if (info->severity == AER_FATAL)
> +		cxl_do_recovery(dev);
>  }

Nit: Maybe use curly braces and collapse both if-block into one.

> +	cxl_walk_bridge(bridge, cxl_report_error_detected, &status);
> +	if (status)
> +		panic("CXL cachemem error. Invoking panic");

Nit: This will be prefixed by "Kernel panic - not syncing: ",
so another "Invoking panic" message seems somewhat redundant.

Thanks,

Lukas

