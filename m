Return-Path: <linux-pci+bounces-16779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B509C907A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 18:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB4C9B28F63
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C25674E;
	Thu, 14 Nov 2024 16:52:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8421E433C4;
	Thu, 14 Nov 2024 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603167; cv=none; b=G+1lWligXN+vc++/JsEDcrjzmzPVO1FWjF/L+nFklmlUfrtpdLRf0quQEolVVCcUYe3yGbWVrh1lJzRmBAIgy7AhxShMfs2Bfw8fg3HDFmGbbhHwxVqVHwPqjiW+fh5DUXRiWPWecvx1hVkL1bA/zzizI0Xm5vjphW8yQBqaI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603167; c=relaxed/simple;
	bh=bsuMuwD42+4FRialWnLB2AnsZc+bTh1ZxNGzuNKBLeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wig6LNjgVHvMHuV8UbZMo2BNgZRaZMEvcjPZk+HYALHK4WnbJCiRk4EB9Od2AKNhutYlh60Tq/kOnMxcUg4wm+LLYm7tFOMcwF3uwBhzrHXyzCv2mYMbe1sf0mX3Hmod1aQYuohT0Ji8MvaL3q3tAFq7PiwZpoLp6DII3QvZV0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 82F5F100DECB0;
	Thu, 14 Nov 2024 17:52:40 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 59F652F7900; Thu, 14 Nov 2024 17:52:40 +0100 (CET)
Date: Thu, 14 Nov 2024 17:52:40 +0100
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
Message-ID: <ZzYq2GIUoD2kkUyK@wunner.de>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-4-terry.bowman@amd.com>
 <ZzYbHZvU_RFXZuk0@wunner.de>
 <ffd740e5-235a-4b74-8bf9-91331b619a7f@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd740e5-235a-4b74-8bf9-91331b619a7f@amd.com>

On Thu, Nov 14, 2024 at 10:45:39AM -0600, Bowman, Terry wrote:
> On 11/14/2024 9:45 AM, Lukas Wunner wrote:
> > On Wed, Nov 13, 2024 at 03:54:17PM -0600, Terry Bowman wrote:
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -5038,6 +5038,20 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
> > >  					 PCI_DVSEC_CXL_PORT);
> > >  }
> > >  
> > > +bool pcie_is_cxl_port(struct pci_dev *dev)
> > > +{
> > > +	if (!pcie_is_cxl(dev))
> > > +		return false;
> > > +
> > > +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
> > > +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
> > > +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
> > > +		return false;
> > > +
> > > +	return cxl_port_dvsec(dev);
> > > +}
> > > +EXPORT_SYMBOL_GPL(pcie_is_cxl_port);
> > 
> > The "!pcie_is_cxl(dev)" check at the top of the function is identical
> > to the return value "cxl_port_dvsec(dev)".  This looks redundant.
> > However one cannot call pci_pcie_type() without first checking
> > pci_is_pcie().  So I'm wondering if the "!pcie_is_cxl(dev)" check
> > is actually erroneous and supposed to be "!pci_is_pcie(dev)"?
> > That would make more sense to me.
> 
> I see pcie_is_cxl(dev) is different than cxl_port_dvsec(dev).
> They check different DVSECs.

Ah, sorry, I missed that.

> CXL flexbus DVSEC presence is cached in pci_dev::is_cxl and returned by
> pcie_is_cxl(). This is used for indicating CXL device.
> 
> cxl_port_dvsec(dev) returns boolean based on presence of CXL port DVSEC to 
> indicate a CXL port device.
> 
> I don't believe they are redundant if you consider you can have a CXL
> device that 
> is not a CXL port device.

Can you have a CXL port that is not a CXL device?

If not, it would seem to me that checking for Flexbus DVSEC presence
*is* redundant.  Or do you anticipate broken devices which lack the
Flexbus DVSEC and that you explicitly want to exclude?

Thanks,

Lukas

