Return-Path: <linux-pci+bounces-5607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998D68968C8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 10:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC7EB2E5D9
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369036024A;
	Wed,  3 Apr 2024 08:26:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE1144C8C;
	Wed,  3 Apr 2024 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132812; cv=none; b=vCwqe3iHkPSz/YkZTUdH5wVIF152H7qhtXSopO6Eg/cR9vhni5YMKBUKtsXYSvVTV6iTyiLovE62yGosTmSGBhGqxlhS86zc4JN+pib6bLTkKNsOPkxuQfkT0hlj8WPrGYMAeQBotbRIBjpfl6vLRedpS4oRqJyulB4DTUsURoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132812; c=relaxed/simple;
	bh=yUTp1G/Lq7j75an/uSCyH3m1dcwhYDtemzjPOw63OIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0gWJ9/fKKnJogxsxMT0Gicq/lQE0wuPHlTd4cpWxiiDWLLT6pXiyhkUPTkOKcbHn15gaPd+GzCJXn2Ym90dVegzOk8Wx9K2pS9rbqhaXSgFJ5cuP7Ayp0aqYEI3ORerVtZ2tdUevEx/OOPEIP3RVrbySFzs19s0xxi+6R6Ac98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id E03072800B3D1;
	Wed,  3 Apr 2024 10:26:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CCE3698F814; Wed,  3 Apr 2024 10:26:40 +0200 (CEST)
Date: Wed, 3 Apr 2024 10:26:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net, bhelgaas@google.com
Subject: Re: [PATCH v3 2/4] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <Zg0SwGmelNpY__5f@wunner.de>
References: <20240402234848.3287160-1-dave.jiang@intel.com>
 <20240402234848.3287160-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402234848.3287160-3-dave.jiang@intel.com>

On Tue, Apr 02, 2024 at 04:45:30PM -0700, Dave Jiang wrote:
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4927,10 +4927,55 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>  }
>  
> +static int cxl_port_dvsec(struct pci_dev *dev)
> +{
> +	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					 PCI_DVSEC_CXL_PORT);
> +}

Hm, seems a bit odd that this returns an int even though
pci_find_dvsec_capability() returns a u16 and all the callers
of cxl_port_dvsec() seem to assign the return value to a u16
as well.  Is the "int" on purpose?

Thanks,

Lukas

