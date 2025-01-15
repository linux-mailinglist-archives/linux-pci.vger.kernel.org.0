Return-Path: <linux-pci+bounces-19865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359B1A11EFD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58470164861
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 10:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6670920C494;
	Wed, 15 Jan 2025 10:12:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087971DB132;
	Wed, 15 Jan 2025 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935969; cv=none; b=Cdm7J7HKX/35iEIinl0b/CVsw2z+joAAk1ui2fjb1C+0x24SPy05n9amiKYFqNPzspXPj8Au0mbtRyxvB+twVxhMylSQZ3v8HLk8QG+zOjRJHfB1jUbcEoqbgSbQ7z3OmY2BADfG8zRlourAVMNy5xBm8c1D/ErfxrI7PusBjxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935969; c=relaxed/simple;
	bh=YzFkCHUJ9B80r9pntnjDpZDY5NnafSo0kPsq0wV4rck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RflpLnrlUZ/cv1CmN3yT4eLw5KNGWc7clQjXrijeD/JB4vyNoLwxdE0jykWK5OfHCzl06ASCQM64OQhNc1otAZftdPeAfyWmR1CWGs4jWQ72itajF3Hr3dZD3Lg8z+x9mmS4Nr9j8ntyDHuVsxo+JF+pzn3Jwqey+p0JywP9Ms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 635C33000118C;
	Wed, 15 Jan 2025 11:03:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 05356577CA6; Wed, 15 Jan 2025 11:03:11 +0100 (CET)
Date: Wed, 15 Jan 2025 11:03:10 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
	alucerop@amd.com
Subject: Re: [PATCH v5 03/16] CXL/PCI: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
Message-ID: <Z4eH3izmcBWYwynt@wunner.de>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-4-terry.bowman@amd.com>
 <6785a691b56f2_186d9b2942@iweiny-mobl.notmuch>
 <a2fc0134-5b6d-4778-aef2-4447c50eb430@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2fc0134-5b6d-4778-aef2-4447c50eb430@amd.com>

On Tue, Jan 14, 2025 at 09:19:12AM -0600, Bowman, Terry wrote:
> On 1/13/2025 5:49 PM, Ira Weiny wrote:
> > Terry Bowman wrote:
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -5036,10 +5036,23 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
> > >  
> > >  static u16 cxl_port_dvsec(struct pci_dev *dev)
> > >  {
> > > +	if (!pcie_is_cxl(dev))
> > > +		return 0;
> > > +
> > >  	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> > >  					 PCI_DVSEC_CXL_PORT);
> > >  }
> > >  
> > > +bool pcie_is_cxl_port(struct pci_dev *dev)
> > > +{
> > > +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
> > > +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
> > > +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
> > > +		return false;
> > > +
> > > +	return cxl_port_dvsec(dev);
> > 
> > Returning bool from a function which returns u16 is odd and I don't think
> > it should be coded this way.  I don't think it is wrong right now but this
> > really ought to code the pcie_is_cxl() here and leave cxl_port_dvsec()
> > alone.  Calling cxl_port_dvsec(), checking for if the dvsec exists, and
> > returning bool.
> 
> Thanks for reviewing. Is this what you are looking for here:
> 
> +bool pcie_is_cxl_port(struct pci_dev *dev)
> +{
> +	return (cxl_port_dvsec(dev) > 0);

Since cxl_port_dvsec() cannot return a negative integer,
you might as well use:

	return !!cxl_port_dvsec(dev);

However last I checked gcc generates code which implicitly turns
a number bigger than 1 into a 1 if the return type is bool.
(I had to fix a bug caused by this behavior once, see 009f8c90f571).

Thanks,

Lukas

