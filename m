Return-Path: <linux-pci+bounces-16853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C519CDBB2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3972838C9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1E418FC90;
	Fri, 15 Nov 2024 09:35:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1DB189F39;
	Fri, 15 Nov 2024 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663319; cv=none; b=GJ4ENXaNZbYg7pavTwsSHmEEQeZMBMiKxYiz0oMHTMrkvSt9eE3gPh21g1GisiwNWDVhtiX55/lvOIvE87IRyIqPw5WwUJJLavXJYyqiBc/VpU/elYzPyNeYBUjqPL7r1NjboQhxaP4HZAUNMO1Rtx1Ed+T+JSIXfzchJ1mMRYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663319; c=relaxed/simple;
	bh=FqFc6TLGuxk07hm5TrVP+dHDlEr4YWXsWODFt2U9+xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdtvirYAg/aLai3XSQV94yUsN3fvH5Sw47q0QH5xnywyhkG2q/HLpe7wINrG1ibPqrzXsbC0/ycbQETmJvZ9wy4w4bU35Za7Mpg1wPO+Xy6RnCS749D4jr8m+VPjPhS+Xwp/oA2gob7zNtgcPxfHAT2ccJQsn/svl/5AZfwA4DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 905D43000A0D2;
	Fri, 15 Nov 2024 10:35:10 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7E4703D0A00; Fri, 15 Nov 2024 10:35:10 +0100 (CET)
Date: Fri, 15 Nov 2024 10:35:10 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
	oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 06/15] PCI/AER: Change AER driver to read UCE fatal
 status for all CXL PCIe port devices
Message-ID: <ZzcVzpCXk2IpR7U3@wunner.de>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-7-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113215429.3177981-7-terry.bowman@amd.com>

On Wed, Nov 13, 2024 at 03:54:20PM -0600, Terry Bowman wrote:
> The AER service driver's aer_get_device_error_info() function doesn't read
> uncorrectable (UCE) fatal error status from PCIe upstream port devices,
> including CXL upstream switch ports. As a result, fatal errors are not
> logged or handled as needed for CXL PCIe upstream switch port devices.
> 
> Update the aer_get_device_error_info() function to read the UCE fatal
> status for all CXL PCIe port devices. Make the change to not affect
> non-CXL PCIe devices.
> 
> The fatal error status will be used in future patches implementing
> CXL PCIe port uncorrectable error handling and logging.
[...]
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1250,7 +1250,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>  	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
>  		   type == PCI_EXP_TYPE_RC_EC ||
>  		   type == PCI_EXP_TYPE_DOWNSTREAM ||
> -		   info->severity == AER_NONFATAL) {
> +		   info->severity == AER_NONFATAL ||
> +		   (pcie_is_cxl(dev) && type == PCI_EXP_TYPE_UPSTREAM)) {
>  
>  		/* Link is still healthy for IO reads */
>  		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,

Just a heads-up, there's another patch pending by Shuai Xue (+cc)
which touches the same code lines.  It re-enables error reporting
for PCIe Upstream Ports (as well as Endpoints) under certain
conditions:

https://lore.kernel.org/all/20241112135419.59491-3-xueshuai@linux.alibaba.com/

That was originally disabled by Keith Busch (+cc) with commit
9d938ea53b26 ("PCI/AER: Don't read upstream ports below fatal errors").

There's some merge conflict potential here if your series goes into
the cxl tree and Shuai's patch into the pci tree in the next cycle.

Thanks,

Lukas

