Return-Path: <linux-pci+bounces-4738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51546878F10
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 08:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B751F224C1
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 07:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3CD69944;
	Tue, 12 Mar 2024 07:30:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5844D5788F;
	Tue, 12 Mar 2024 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710228652; cv=none; b=NCeB36N9Wzf3jN6J6FIeigM12R1cGDODQFZfIuWrnj6I0MEen2x6IFsxzZ0/e6Kvz8Lc8ntpqwnzhnMCRvmF/JGRlKYEi07oM3dgjEmqoFmDA8OakSIWaDH6IUqKsOVb7jeKuTyKhLnPJHQ6m0tKXfOve4efDZvH/JR75Wnxs0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710228652; c=relaxed/simple;
	bh=QCCZ1/d2wHZRB0KyWxVAhPBvaRMg+bl6T2DEAlkzQno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6laf2gT984/mf9a82PvB1julpEbEJzo6pH8W5h17q6AuXT/w/7SggnoUmg3EHJ5s58JgGa00NQLsX/VKtuO0sx8kRCC8y/+Wke5sGGkbdd/0qba/hfPN6u7WcPaptRUFH4DqHLhfmNh47U/EP2FW21Kh/fgA/4P7kmU6fXMyoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id D000F300002CD;
	Tue, 12 Mar 2024 08:30:37 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C944C48470; Tue, 12 Mar 2024 08:30:37 +0100 (CET)
Date: Tue, 12 Mar 2024 08:30:37 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net, bhelgaas@google.com
Subject: Re: [PATCH 1/3] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <ZfAEncKttj9qFQHw@wunner.de>
References: <20240311204132.62757-1-dave.jiang@intel.com>
 <20240311204132.62757-2-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311204132.62757-2-dave.jiang@intel.com>

On Mon, Mar 11, 2024 at 01:39:53PM -0700, Dave Jiang wrote:
> +static bool is_cxl_device(struct pci_dev *dev)
> +{
> +	return pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
> +					 CXL_DVSEC_PCIE_DEVICE);
> +}

If this was my bikeshed, I'd call it pci_is_cxl() to match pci_is_pcie().


> +static bool is_cxl_port_sbr_masked(struct pci_dev *dev)
> +{
> +	int dvsec;
> +	int rc;
> +	u16 reg;

Nit: Inverse Christmas tree?


>  static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
>  	int rc;
>  
> +	/* If it's a CXL port and the SBR control is masked, fail the SBR */
> +	if (is_cxl_device(dev) && dev->bus->self &&
> +	    is_cxl_port_sbr_masked(dev->bus->self)) {
> +		if (probe)
> +			return 0;
> +
> +		return -EPERM;
> +	}
> +

Is this also necessary if CONFIG_CXL_PCI=n?

Return code on non-availability of a reset method is generally -ENOTTY.
Or is the choice deliberate to expose this reset method despite the bit
being set and thus allow user space to unmask it in the first place?

Also, we mostly use pci_upstream_bridge(dev) in lieu of dev->bus->self.
Is the choice to use the latter deliberate because maybe is_virtfn is
never set and the device can never be on the root bus?  (What about
RCiEP CXL devices?)

Thanks,

Lukas

