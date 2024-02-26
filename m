Return-Path: <linux-pci+bounces-4040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940C2867DB9
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 18:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54DF1C2A06D
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB027133982;
	Mon, 26 Feb 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyIxUsKG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E612CD8E;
	Mon, 26 Feb 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966834; cv=none; b=fwK/DLwab+p0vi2JMwpnY9wOomaRbmkRqlPt8+Nu7mSEW4MtVpAAmeVZnwFda56Wyragg8Nuf3KR6yssNac1v+AUMdqXJ4I6joJ3hcmr63zgo36k7BIH6ufz/qN1IY/5mTJ56rvYJk8E9Q43Qxj9RCYlShYFHcZFR62oQOaKgto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966834; c=relaxed/simple;
	bh=o7v0UCT9OJMGkA8U7iwQfdvtLg8GUAcNkvD+ZlnbU24=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DeNNRBhSLVIRS4hJ7tlr2y4AfO4qGdsS9hHIMUmIEUmD0atQiYDQGk5bhCJzV7z+enxc4afYBeR1zQdOaEpsz171T8aKpXi9LxSjOlZxFgnRJa6FPUD4QZMED2tV6KS3r+b6Cka/QzInzOcxHeAWNsWF6aknjoTiWCA5eW329Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyIxUsKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EADC433C7;
	Mon, 26 Feb 2024 17:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708966834;
	bh=o7v0UCT9OJMGkA8U7iwQfdvtLg8GUAcNkvD+ZlnbU24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DyIxUsKGGPDAmjVcDmEACK0+SYqCLsCEN5Pvrv/hVkCVhiqVmMWpjrDX5QNXfk9dw
	 PlKm10ffgHy6JyuJpdZGm5o/ETxm+cQD+aMgYDXJMEQ4jE0IR+TwJATYJ82t1scM6b
	 mfySgmNWSO1it0+Pf8NbovTGCnx3GWcah+jCTYA06f5hLjRcEgos20ExHSyMJEU9mf
	 itmqNwDXg3F75jbwx9K3G24zgczNPR6H/JDKfXX4OSgNOTJ7gRNpqaffOrauaVFrsc
	 SIjvJTC2qxrWOCA9swBjLmVWazr7fHuYWrI10K+c5aCNkoz5RxfWI/RUDb8NNkbj6Z
	 agj0RVgmeUpiw==
Date: Mon, 26 Feb 2024 11:00:32 -0600
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
Message-ID: <20240226170032.GA202638@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY3PR18MB470764DFFE3E532B8D1851E4A05A2@BY3PR18MB4707.namprd18.prod.outlook.com>

On Mon, Feb 26, 2024 at 03:40:25PM +0000, Sai Krishna Gajula wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Wednesday, February 14, 2024 10:59 PM
> > ...
> > On Wed, Feb 14, 2024 at 06:38:53PM +0530, Sai Krishna wrote:
> > > The PCIe PTM(Precision time measurement) protocol provides precise
> > > coordination of events across multiple components like PCIe host
> > > clock, PCIe EP PHC local clocks of PCIe devices. This patch adds
> > > support for ptp clock based PTM clock. We can use this PTP device to
> > > sync the PTM time with CLOCK_REALTIME or other PTP PHC devices using
> > > phc2sys.

> > > +#define PCI_VENDOR_ID_CAVIUM			0x177d

Already defined in pci_ids.h.

> > > +static int __init ptp_oct_ptm_init(void) {
> > > +	struct pci_dev *pdev = NULL;
> > > +
> > > +	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
> > > +			      PCI_DEVID_OCTEONTX2_PTP, pdev);
> > 
> > pci_get_device() is a sub-optimal method for a driver to claim a device.
> > pci_register_driver() is the preferred method.  If you can't use that, a
> > comment here explaining why not would be helpful.
> 
> We just want to check the PTP device availability in the system as
> one of the use case is to sync PTM time to PTP.

This doesn't explain why you can't use pci_register_driver().  Can you
clarify that?

> > > +	ptm_ctl_addr = ioremap(PEMX_PTM_CTL, 8);
> > 
> > Hard-coded register addresses?  That can't be right.  Shouldn't
> > this be discoverable either as a PCI BAR or via DT or similar
> > firmware interface?
> 
> Ack, will explore the DT implementation for register addresses
> access and submit patch V3. Thanks for the review.

I assume the PCI_DEVID_OCTEONTX2_PTP device is a PCIe Endpoint, and
this driver runs on the host?  I.e., this driver does not run as
firmware on the Endpoint itself?  So if you run lspci on the host, you
would see this device as one of the PCI devices?

If that's the case, a driver would normally operate the device via
MMIO accesses to regions described by PCI BARs.  "lspci -v" would show
those addresses.

Bjorn

