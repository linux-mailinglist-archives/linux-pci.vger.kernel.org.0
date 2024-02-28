Return-Path: <linux-pci+bounces-4191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C07A86B432
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 17:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9957C1C21A1D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E045F15D5C8;
	Wed, 28 Feb 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeH1tbkF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B363115CD6E;
	Wed, 28 Feb 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136539; cv=none; b=r9eF1SSzPGKvJrdTHND2AM1CKxMIgMmKce7698JGfoN52Hpxuqgnvok/GE80HDoWgc4VcTmQ0PRSYJ8FH2pyAdf4PlKBUEoHjWZFLJ3rYWhmTf9NRlUso5AMxJC/27eMZ8rze+qxGBX2lSEIG138L+V9imt7+s/xcFnNd5MZAhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136539; c=relaxed/simple;
	bh=9vrbwp+q8XKbdPzBRfbaUnKUvH7i4vZKGrKWdjzBE5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eBnVaS9813iHAtpCu/KAJnb6YINxMvDkTqY77eMJRM5U1/5Zp4Iftl/i6R3XGfHQUAdcMAxJHEjijhqASpsh7a8e4gz00v1DM8lrqSfPYsTuiAsNUbhXAv8xY5jCH3vWV0a+3lLRl/1FOFFAZJE2Fb/OI9M0w7gzaNANPrZRz2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeH1tbkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9B0C43390;
	Wed, 28 Feb 2024 16:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709136539;
	bh=9vrbwp+q8XKbdPzBRfbaUnKUvH7i4vZKGrKWdjzBE5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FeH1tbkFba5gPho1BM/W4ztL6g9/2PRyRgoT66iPVwBraKwUcRFuh99Q9v+PqXhI9
	 gU5TRJ8pYOTffyDzgKIOfK8gdmtkfEVkz16/HCCVcBqZB3u4707ASMNpnz52M2cHdF
	 aI9NgQ0sl6r5i2kseo/dFPkeNYLFZzwPtOa2V+zGe4Z7bz1rrKPkS0/AetmJlLJ1Sj
	 pq4Kg0EOhmyeImROeXbifZgoDcYc+Mh9iHbTiOiFPgcdhXBfpBrsbL2zG0bwbkvudm
	 IkpcLrq9jStlymI5uny+OQObCYmGmdgOqg9W3+y/HqQFbzXlaP1+9jQPCJlfyLUH+n
	 xQjpbbpApm2Vg==
Date: Wed, 28 Feb 2024 10:08:57 -0600
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
Message-ID: <20240228160857.GA272997@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY3PR18MB4707DBB80B5949EA26F7ABECA0582@BY3PR18MB4707.namprd18.prod.outlook.com>

On Wed, Feb 28, 2024 at 12:37:02PM +0000, Sai Krishna Gajula wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Monday, February 26, 2024 10:31 PM
> ...
> > On Mon, Feb 26, 2024 at 03:40:25PM +0000, Sai Krishna Gajula wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > Sent: Wednesday, February 14, 2024 10:59 PM ...
> > > > On Wed, Feb 14, 2024 at 06:38:53PM +0530, Sai Krishna wrote:
> > > > > The PCIe PTM(Precision time measurement) protocol provides precise
> > > > > coordination of events across multiple components like PCIe host
> > > > > clock, PCIe EP PHC local clocks of PCIe devices. This patch adds
> > > > > support for ptp clock based PTM clock. We can use this PTP device
> > > > > to sync the PTM time with CLOCK_REALTIME or other PTP PHC devices
> > > > > using phc2sys.

> > > > > +static int __init ptp_oct_ptm_init(void) {
> > > > > +	struct pci_dev *pdev = NULL;
> > > > > +
> > > > > +	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
> > > > > +			      PCI_DEVID_OCTEONTX2_PTP, pdev);
> > > >
> > > > pci_get_device() is a sub-optimal method for a driver to claim a device.
> > > > pci_register_driver() is the preferred method.  If you can't use
> > > > that, a comment here explaining why not would be helpful.
> > >
> > > We just want to check the PTP device availability in the system as one
> > > of the use case is to sync PTM time to PTP.
> > 
> > This doesn't explain why you can't use pci_register_driver().  Can
> > you clarify that?
> 
> This is not a PCI endpoint driver.  This piece of code is used to
> identify the silicon version.  We will update the code by reading
> the silicon version from Endpoint internal BAR register offsets.

> > I assume the PCI_DEVID_OCTEONTX2_PTP device is a PCIe Endpoint,
> > and this driver runs on the host?  I.e., this driver does not run
> > as firmware on the Endpoint itself?  So if you run lspci on the
> > host, you would see this device as one of the PCI devices?
> > 
> > If that's the case, a driver would normally operate the device via
> > MMIO accesses to regions described by PCI BARs.  "lspci -v" would
> > show those addresses.
> 
> This driver don't run on Host but runs on the EP firmware itself.

The "endpoint driver" terminology is a bit confusing here.  See
Documentation/PCI/endpoint/pci-endpoint.rst for details.

If this driver actually runs as part of the Endpoint firmware, it
would not normally see a hierarchy of pci_devs, and I don't think
pci_get_device() would work.

So I suspect this driver actually runs on the host, and it looks like
it wants to use the same device (0x177d:0xa00c) as these two drivers:

  drivers/net/ethernet/cavium/common/cavium_ptp.c:#define PCI_DEVICE_ID_CAVIUM_PTP        0xA00C
  drivers/net/ethernet/marvell/octeontx2/af/ptp.c:#define PCI_DEVID_OCTEONTX2_PTP                 0xA00C

It seems like maybe it should be integrated into them?  Otherwise you
have multiple drivers thinking they are controlling a single device.

Bjorn

