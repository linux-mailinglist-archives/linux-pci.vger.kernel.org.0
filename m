Return-Path: <linux-pci+bounces-4262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E8A86CC50
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 16:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6AE1F23818
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 15:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3634886275;
	Thu, 29 Feb 2024 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOpNTBTn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0603C7E564;
	Thu, 29 Feb 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219021; cv=none; b=oVvDPzXq1aQIJrnJsqMOVQZR1nAbBD5XObup6ZEwIJM+zFJVOpJL7XfclOr1aaGiDJPL7dXSflA3tNXWdxdi4zKvl4sial5+CwaBZK7oi0VbxTieUVecT+Ned2GqrrS6ytSB4Yq24ZVEkPSnhrrbtKg+ATPyX9uYCO9bBv3INh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219021; c=relaxed/simple;
	bh=LZyjh65EolwbZ2yy1NV5Vd1hxzz8NX2wmok/ryDrasw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I1MBJK4WE7dJJBkigFYbSAudNjzwHzB663fFAzZMjZkQc6Teu8emHBQybzy50imNCf6ygQaAa+Hs1+Y2rGK/cyFgZ25ZrV8q1PSS4sRrx+T0ru8qPlBj1iqAoF/5y19BiEYqGqHX4VG30TZbGp+m2yWCdKhHXKMb1MAl42lifdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOpNTBTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDDEC43399;
	Thu, 29 Feb 2024 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709219020;
	bh=LZyjh65EolwbZ2yy1NV5Vd1hxzz8NX2wmok/ryDrasw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VOpNTBTnUOMsO0iiVZcMcn0pkYsuEGgP7ncm8HJmdoLrYLsvFBw6HuPeLXms4TuPx
	 O1WzqRJiDlmKuB7Ib8OZ8RS2aFeJJ+K18/Uoi5sW7PXLZUoQemT8JUfg2xzrF3pRpg
	 81JITgMKQhmKprGUx88Tw0HfnqQqoYl34rthxijgxI+gQq31xaZR4J+4XLXvWK4srA
	 lnUDdznBlOE3VrUZa0r55K+tA26q7RIg15ewbXS5fdeYlGgSzT6f2G52WnURg/0Wn6
	 AZuvqSJGntiMqKrB2zhhq57yTIBg+YT+EQ6TddaAI+ItUsNylym2TFCiee8SLIH1o0
	 PwGtyrVyavwnw==
Date: Thu, 29 Feb 2024 09:03:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"vinicius.gomes@intel.com" <vinicius.gomes@intel.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH v2] octeontx2: Add PTP clock driver for Octeon
 PTM clock.
Message-ID: <20240229150338.GA342557@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY3PR18MB4707E7764D59DF25C57CCB58A05F2@BY3PR18MB4707.namprd18.prod.outlook.com>

On Thu, Feb 29, 2024 at 04:57:26AM +0000, Sai Krishna Gajula wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Wednesday, February 28, 2024 9:39 PM
> > To: Sai Krishna Gajula <saikrishnag@marvell.com>
> > Cc: bhelgaas@google.com; linux-pci@vger.kernel.org;
> > richardcochran@gmail.com; horms@kernel.org; vinicius.gomes@intel.com;
> > vadim.fedorenko@linux.dev; davem@davemloft.net; kuba@kernel.org;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> > Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> > <gakula@marvell.com>; Linu Cherian <lcherian@marvell.com>; Hariprasad
> > Kelam <hkelam@marvell.com>; Subbaraya Sundeep Bhatta
> > <sbhatta@marvell.com>; Naveen Mamindlapalli <naveenm@marvell.com>
> > Subject: Re: [net-next PATCH v2] octeontx2: Add PTP clock driver for
> > Octeon PTM clock.
> > 
> > On Wed, Feb 28, 2024 at 12:37:02PM +0000, Sai Krishna Gajula wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > Sent: Monday, February 26, 2024 10:31 PM
> > > ...
> > > > On Mon, Feb 26, 2024 at 03:40:25PM +0000, Sai Krishna Gajula wrote:
> > > > > > -----Original Message-----
> > > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > > Sent: Wednesday, February 14, 2024 10:59 PM ...
> > > > > > On Wed, Feb 14, 2024 at 06:38:53PM +0530, Sai Krishna wrote:
> > > > > > > The PCIe PTM(Precision time measurement) protocol provides
> > > > > > > precise coordination of events across multiple components like
> > > > > > > PCIe host clock, PCIe EP PHC local clocks of PCIe devices.
> > > > > > > This patch adds support for ptp clock based PTM clock. We can
> > > > > > > use this PTP device to sync the PTM time with CLOCK_REALTIME
> > > > > > > or other PTP PHC devices using phc2sys.
> > 
> > > > > > > +static int __init ptp_oct_ptm_init(void) {
> > > > > > > +	struct pci_dev *pdev = NULL;
> > > > > > > +
> > > > > > > +	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
> > > > > > > +			      PCI_DEVID_OCTEONTX2_PTP, pdev);
> > > > > >
> > > > > > pci_get_device() is a sub-optimal method for a driver to claim a
> > device.
> > > > > > pci_register_driver() is the preferred method.  If you can't use
> > > > > > that, a comment here explaining why not would be helpful.
> > > > >
> > > > > We just want to check the PTP device availability in the system as
> > > > > one of the use case is to sync PTM time to PTP.
> > > >
> > > > This doesn't explain why you can't use pci_register_driver().  Can
> > > > you clarify that?
> > >
> > > This is not a PCI endpoint driver.  This piece of code is used to
> > > identify the silicon version.  We will update the code by reading the
> > > silicon version from Endpoint internal BAR register offsets.
> > 
> > > > I assume the PCI_DEVID_OCTEONTX2_PTP device is a PCIe Endpoint, and
> > > > this driver runs on the host?  I.e., this driver does not run as
> > > > firmware on the Endpoint itself?  So if you run lspci on the host,
> > > > you would see this device as one of the PCI devices?
> > > >
> > > > If that's the case, a driver would normally operate the device via
> > > > MMIO accesses to regions described by PCI BARs.  "lspci -v" would
> > > > show those addresses.
> > >
> > > This driver don't run on Host but runs on the EP firmware itself.
> > 
> > The "endpoint driver" terminology is a bit confusing here.  See
> > Documentation/PCI/endpoint/pci-endpoint.rst for details.
> > 
> > If this driver actually runs as part of the Endpoint firmware, it would not
> > normally see a hierarchy of pci_devs, and I don't think
> > pci_get_device() would work.
> > 
> > So I suspect this driver actually runs on the host, and it looks like it wants to
> > use the same device (0x177d:0xa00c) as these two drivers:
> > 
> >   drivers/net/ethernet/cavium/common/cavium_ptp.c:#define
> > PCI_DEVICE_ID_CAVIUM_PTP        0xA00C
> >   drivers/net/ethernet/marvell/octeontx2/af/ptp.c:#define
> > PCI_DEVID_OCTEONTX2_PTP                 0xA00C
> > 
> > It seems like maybe it should be integrated into them?  Otherwise you have
> > multiple drivers thinking they are controlling a single device.
> 
> Though this device does not appear as a PCI device on EP firmware,
> but there are some other internal PCI devices that will be
> enumerated. 
>
> We will remove the dependency of reading the PTP device to check the
> SoC versions, instead we will read the config space of this PCI
> device itself.
>
> I hope this clears your doubt whether this driver is running on Host
> or EP device.

It does not.  But I don't maintain this area and I'm not making any
progress on understanding how this works, so I don't think I can
give any useful advice here.

Bjorn

