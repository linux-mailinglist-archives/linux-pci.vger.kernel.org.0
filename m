Return-Path: <linux-pci+bounces-5720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F2A8983AF
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85301F228C8
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 09:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00451B7F4;
	Thu,  4 Apr 2024 09:02:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90A029D1C;
	Thu,  4 Apr 2024 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221341; cv=none; b=C7QynhsrWXYy5StxpWoC7pQWc+fOz+mGZWiSRexvPfH5H5U4JPj62QVxHHFhJJAxdRTxC1HIh+Xmhv2mCGGdo4GIOaEtgqXM+CYYhIH9Tc7nQxixPyGU/eDsfJiAgVjWZxbo/9APw1calzkegUzdeOtK/hkLr4+R+qCWONIn384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221341; c=relaxed/simple;
	bh=V54xmlTq61I+H7vqWTtsq6jt/vv1QM5zvUGjqNwtD3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQzcOJFkHMYK7iU60cbX5rAo0gkmcrYVuyRwOBQDYSUzbIFs0KkqPTSBlxqG/gxsX94abpVund/+jgJCvdg/vdcoGa92hrNAXWfZRJgIDbi5wAIgIs+c8q/f5GvcyrtOsbwFw/1tu54jj5kokMVqfe4iKH2nGJCo9PforYyQ7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id C29112800BB3F;
	Thu,  4 Apr 2024 11:02:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AC4CA1D17E; Thu,  4 Apr 2024 11:02:10 +0200 (CEST)
Date: Thu, 4 Apr 2024 11:02:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	dave@stgolabs.net, bhelgaas@google.com
Subject: Re: [PATCH v2 1/3] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <Zg5skrUCyx17fRjq@wunner.de>
References: <6605bef53c82b_1fb31e29481@dwillia2-xfh.jf.intel.com.notmuch>
 <20240402172323.GA1818777@bhelgaas>
 <660c44604f0a3_19e029497@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240403154441.00002e30@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403154441.00002e30@Huawei.com>

On Wed, Apr 03, 2024 at 03:44:41PM +0100, Jonathan Cameron wrote:
> > Bjorn Helgaas wrote:
> > > FWIW, I pinged administration@pcisig.com and got the response that
> > > "1E98h is not a VID in our system, but 1E98 has already been reserved
> > > by CXL."
> > > 
> > > I wish there were a clearer public statement of this reservation, but
> > > I interpret the response to mean that CXL is not a "Vendor", maybe due
> > > to some strict definition of "Vendor," but that PCI-SIG will not
> > > assign 0x1e98 to any other vendor.
> > > 
> > > So IMO we should add "#define PCI_VENDOR_ID_CXL 0x1e98" so that if we
> > > ever *do* see such an assignment, we'll be more likely to flag it as
> > > an issue.  
> 
> Sorry for late entry on this discussion and I'll be careful what I say
> on the history.
> 
> As you've guessed it was "entertaining" and for FWIW that text occurs
> in other consortium specs (some predate CXL).
> 
> It's reserved with agreement from the PCI SIG for a strictly defined set
> of purposes that does not correspond to those allowed for a normal ID
> granted to a vendor member. As you say CXL isn't a vendor (don't ask
> how DMTF got a vendor ID - 0x1AB4).
> 
> Hence the naming gymnastics and vague answers to avoid any chance of
> lawyers getting involved :(

Hm, I'm wondering if avoiding the term "vendor" with something like

#define PCI_CONSORTIUM_ID_CXL 0x1e98

would assuage the angst of a legal misstep? ;)

