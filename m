Return-Path: <linux-pci+bounces-24897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB9DA74221
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 02:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C47189F77A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 01:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A990C1C6FF8;
	Fri, 28 Mar 2025 01:47:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A91157A6B;
	Fri, 28 Mar 2025 01:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743126438; cv=none; b=PqILUP4tnaNydBWy9TwoIurFlyetlYyQq6bJ44/5K6rxyTXHcopNmwTitqCguMHNjO5b5EDKRrbyi7tKTanKuJX+OIf++YeS1cggXDO53uLAuUl22ubGqFGaDTaLlYUo8yJv76V15ub2R+5Qu4S0WcSJnZwmWk8oXlShCsPY+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743126438; c=relaxed/simple;
	bh=0fG1vjWwRu801A+LB8ALUjJbXxkbE4MyLBH7IZHG3q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sB5OVRSetHccKu+L+Ney7idSgbdDoeC5AyGM1RTItiGiJ7MjLyjvk2R50FgSzUhOh6jNJQQsO0lTt1U4ynW9XRnIAG6o6QFwdrJD5ac+x2AMua+yIxBl8YA4BKoxqvD4rIRSpA7lV7GwVyxSdn8vqCuOy8/9k7VwNvS7ptQp4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: bizesmtpsz5t1743126386tw23d56
X-QQ-Originating-IP: tKHlUoSpxt75h6MwjgWYv0l4jZfQJOF2u/XvujKvZ/A=
Received: from localhost ( [103.233.162.252])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Mar 2025 09:46:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5407386532826325501
Date: Fri, 28 Mar 2025 09:46:24 +0800
From: Yibo Dong <dong100@mucse.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add MUCSE vendor ID to pci_ids.h
Message-ID: <3DA9F11AA98928B5+20250328014624.GA500031@nic-Precision-5820-Tower>
References: <1835B10BD36E99AC+20250327112426.GB468890@nic-Precision-5820-Tower>
 <20250327133757.GA1432088@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250327133757.GA1432088@bhelgaas>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NDtUtlvFer7vl4dEv32+S4lUWKowORwLTaYDBZebED/b0zWh5Hp6L9Q/
	xowcy0J6ZzErojd7E725CzEjGvALMpn2FdFY7Y0MpJjOcV205Mi+923Hkex+MvpCTSWY1Qw
	nIf20sA61SzCENrZrSpWgCPX6Jh9ufXUV7kAgWIARH0Dr28633DOyGasUz7Kxjd4do64uMY
	BLSaapUSpO5aNw/1Ub09n6Mh8RJyMO5TgAeHikDsGd3GyakIbowOJ7t8pVYhKBBXTFEMzx0
	BdV1h0v/2vlOJ0/v9MejOeZirFY1pDsaeqfEVan4vWtLmJA88qBdTmam4TbxfsY+GvxjRb9
	dlCtQd/irrDaHYwZnb5aUmzdUcr/RcO9w+iZDhA8eOmrf2vNWjj4cDBhG5fk5XeTG6474uZ
	4G4FbTonBf8sjI44lRIVaefCzlhaafObv6aTm3Rv5CbBwqeDnFMt4/5sv832+vXsuejq6LH
	93nwP0MOz0eDkuJVOjvVHlFjhK3bL+KxHLLAbqxuINzjYf/54+hJ0wOwVBxjVmIIV9lI9uD
	qGfAkdlGWROiwmVac+aYc8KdSNiXh1EAzyYNHMVzozUW/Q8Vp7ih1MhwyFYhGgGukccTBgX
	kLHJegChjwHRFFX0wjxp/HZgbOp1OeQSY7EMhLLVllXjNfu+4vSTtchBc4BpygkGnSz4ppc
	rCWE+Ve7XJdS5eYzKqVtxheGOnD+lL+0LEI5RZXEuGsMRlkLUoZkLKgyz3w63ZYgeEj+S3r
	AjQsoLx1aDkfb/CCOv9B+ZTBQbpciAPDHBV32KvLK1oSLGRFEa2ocXdmyr3NRnH5GuMhHx+
	zWCwxEG2gdZUe6m0Wk6py4MdGnCJnLkhG2oEWLhbKRbgPngK2qWkNjpcrdquXPX0gkcu72u
	yuSqGkvPQXkxJ0UiZqpaMkOkxEn7P51MD6Wf++wUF5pyy4VlaLxVJUEUivipmHULO3h5uzq
	xCu4=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Thu, Mar 27, 2025 at 08:37:57AM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 27, 2025 at 07:24:26PM +0800, Yibo Dong wrote:
> > On Wed, Mar 26, 2025 at 11:57:28AM -0500, Bjorn Helgaas wrote:
> > > On Tue, Mar 25, 2025 at 02:57:18PM +0800, Yibo Dong wrote:
> > > > Add MUCSE as a vendor ID (0x8848) for PCI devices so we can use
> > > > the macro for future drivers.
> > > > 
> > > > Signed-off-by: Yibo Dong <dong100@mucse.com>
> > > 
> > > Please post this in the series where you add the future drivers.
> > > 
> > > We don't add new things to pci_ids.h unless they are actually used by
> > > more than one driver because it complicates life for people who
> > > backport things (there's a note at the top of the file about this).
> > 
> > Thanks for the reminder; the drivers maybe use 'the define' are
> > netdev drivers, so, I should first send patches to netdev subsystem,
> > and re-send this patch to pci subsystem after my patches is applied
> > by netdev subsytem? or I should send this to netdev subsystem along
> > with the drivers?
> 
> Just include it with your netdev series and cc me.  I'll ack it and
> the whole series can be merged together via netdev.
> 

Ok, I got it, thanks. 

> > > > +#define PCI_VENDOR_ID_MUCSE		0x8848
> > > 
> > > https://pcisig.com/membership/member-companies?combine=8848 says this
> > > Vendor ID belongs to:
> > > 
> > >   Wuxi Micro Innovation Integrated Circuit Design Co.,Ltd
> > > 
> > > I suppose "MUCSE" connects with that somehow.
> > > 
> > > It's nice if people can connect PCI_VENDOR_ID_MUCSE with a name used
> > > in marketing the product.  Maybe "MUCSE" is the name under which
> > > Wuxi Micro Innovation Integrated Circuit Design Co.,Ltd markets
> > > products?
> > 
> > Yes, MUCSE is just abbreviation for “Wuxi Micro Innovation Integrated Circuit
> > Design Co.,Ltd”
> 
> Perfect.  I see you've already added it to the lspci database along
> with several devices:
> 
>   https://admin.pci-ids.ucw.cz/read/PC/8848
> 
> All looks good!  I'll watch for your netdev patches.
> 
> Bjorn
> 

Nice, I'm preparing the patches, but it may take some times. 

