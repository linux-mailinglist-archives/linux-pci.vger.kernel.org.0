Return-Path: <linux-pci+bounces-16836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD959CDAD4
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30412B25256
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D9718B494;
	Fri, 15 Nov 2024 08:47:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4418BBB0;
	Fri, 15 Nov 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660455; cv=none; b=eSdcZ6GkBnZ1IGUeVohx0+PpjgRQ8N6lytWnVz4gJPbC9InGElU6bz8kP6jf8BsNOsE/aijhmmUDlCiujwxzuiV9zcFJqGYUFnQskpHf+bsBp7C7AHe+EUSlswTvVRrGg13yKpoQU2RYLThtD/7U60FEF0e7XZMVre64MEkNI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660455; c=relaxed/simple;
	bh=/DsROywAvHAkFdPe88DuYC+yrn7Ej88+9wfbHxvbTrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze5YE3qbTH73XebPqVNxOEeYiPRIdYSwFITLseekTa2ySpw4p+wgHDZJQEtAw6hsZASkicJXsKxYjqKvBv6aIx1J69kZi2EdANOEq96wfvaAWQAZbCMUoHrdwLmeaN//u7cgyON9OOr3Q4A1Jp1epeLXmsXPBJ3tQBeruWJizaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 45E122800C7FC;
	Fri, 15 Nov 2024 09:47:28 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2E7BC3D0537; Fri, 15 Nov 2024 09:47:28 +0100 (CET)
Date: Fri, 15 Nov 2024 09:47:28 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Bowman, Terry" <terry.bowman@amd.com>
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
Message-ID: <ZzcKoOXTVVj3bTnE@wunner.de>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-4-terry.bowman@amd.com>
 <ZzYbHZvU_RFXZuk0@wunner.de>
 <ffd740e5-235a-4b74-8bf9-91331b619a7f@amd.com>
 <ZzYq2GIUoD2kkUyK@wunner.de>
 <e686016d-2670-4431-ad9d-3c189a48b1e4@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e686016d-2670-4431-ad9d-3c189a48b1e4@amd.com>

On Thu, Nov 14, 2024 at 11:07:26AM -0600, Bowman, Terry wrote:
> > Can you have a CXL port that is not a CXL device?
> >
> > If not, it would seem to me that checking for Flexbus DVSEC presence
> > *is* redundant.  Or do you anticipate broken devices which lack the
> > Flexbus DVSEC and that you explicitly want to exclude?
> 
> No, the CXL port device is always a CXL device per spec.
> 
> This was added to short-circuit the function by returning immediately
> if the device is _not_ a CXL device. Otherwise for PCIe Port devices,
> the CXL Port DVSEC will be searched. I was trying to avoid the unnecessary
> CXL port DVSEC search unless the other criteria are met.
> And I expect most cases will not be a CXL device.
> 
> I will remove the "if (!pcie_is_cxl(dev))" block as you suggested.

Ah, this is meant as a speed-up.  Actually that makes sense,
so feel free to keep it.

If you do remove it, I think you'll have to move the cxl_port_dvsec()
invocation up in the function, in front of the pci_pcie_type() checks.
The latter require that one first checks that the device is PCIe.
That's done implicitly by cxl_port_dvsec() because it returns 0 in
the non-PCIe case.  (Due to the "if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)"
check in pci_find_next_ext_capability().)

Another idea would be to put a "if (!pcie_is_cxl(dev)) return 0;" speed-up
in cxl_port_dvsec() so that the other caller benefits from it as well.

Thanks,

Lukas

