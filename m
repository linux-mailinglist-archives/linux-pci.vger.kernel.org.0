Return-Path: <linux-pci+bounces-38226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E3DBDEED5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC0048661D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF8325CC74;
	Wed, 15 Oct 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAPqc7Yx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7454425C809;
	Wed, 15 Oct 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537042; cv=none; b=doPQ/VJYm6pfa+ZUCcJo4SQ0nCec15i1kxjCJPyVNmpIfxImBhn+xpco/L6VLv/fIfVWWMp5ObAYOYrr5M4PTOmP0i8x1mtSN4bLb5jiSmo8r8/HQIPW+0Evg2rGk+oIden2Xdz/z0tChpDsClhKJ6pCBXLw5KLwXinvPFy4FPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537042; c=relaxed/simple;
	bh=JRihx6K2YWVxXR6jr4X/LHHVrOZgJydZa4gAD//bPbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv54wpWdkdBY7ZRnRblHy2pBX+q5HyHhVrDHACrYC4m8mgISDaOxoJdocJkWzO0GH59ndq/8cKUKH1s8BdFPF0OgHYzMqDFu1J6OqBSNIxaha+aEWqaFKzbQXNeSZhrO8ZgjNQ3YSAn3/Nz2O6KtA5BKk7PKE7GRTHztdNe0MTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAPqc7Yx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FCEC4CEF8;
	Wed, 15 Oct 2025 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760537041;
	bh=JRihx6K2YWVxXR6jr4X/LHHVrOZgJydZa4gAD//bPbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAPqc7YxvmZdDwPqlJf3X4nl1O+ke10dyw/JcWjw/ylW8Lkj5qJNdVXB6eXRT5t+K
	 ir8CZNjME/V3x16Mt708lpRzzXklkLUcllL/4lHtlAncjWCSz2yVjwajg/HpR6MQY2
	 /mBDfaQDWRHFS6wgFXpZSG4FVnXh5S8O7pt3+yU7qdoSMAfNp//QL3BtHjnCTZCCeG
	 Db1x1bFMhU6VWoTjlbB0GNHoA1UdOwTAKIS53jqxo4IKtIq0LkrhWvhVNzJ7lSYcYb
	 GPccSP6rCt+hlbF46PbI8pBiFpwO7yj/8+PJCBUdVRJCPiu4hpbxIr+naTtOFFnq1v
	 DJcavv0x4RI8w==
Date: Wed, 15 Oct 2025 19:33:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ron Economos <re@w6rz.net>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Conor Dooley <conor@kernel.org>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv <linux-riscv@lists.infradead.org>, Paul Walmsley <pjw@kernel.org>, 
	Greentime Hu <greentime.hu@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	regressions@lists.linux.dev
Subject: Re: SiFive FU740 PCI driver fails on 6.18-rc1
Message-ID: <xfpqp3oign7c3336wxo5yexgitxotttrxgkyzbfknjmfk6pmdc@drsk3ardfl5t>
References: <20251013212801.GA865570@bhelgaas>
 <bc7deb1a-5f93-4a36-bd6a-b0600b150d48@oss.qualcomm.com>
 <95a0f2a4-3ddd-4dec-a67e-27f774edb5fd@w6rz.net>
 <759e429c-b160-46ff-923e-000415c749ee@oss.qualcomm.com>
 <b203ba27-7033-41d9-9b43-aa4a7eb75f23@w6rz.net>
 <yxdwo4hppd7c7lrv5pybjtu22aqh3lbk34qxdxmkubgwukvgwq@i4i45fdgm6sw>
 <18ef2c73-fb10-47b3-838f-bc9d3fd2dbc2@w6rz.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18ef2c73-fb10-47b3-838f-bc9d3fd2dbc2@w6rz.net>

On Tue, Oct 14, 2025 at 03:41:39PM -0700, Ron Economos wrote:
> On 10/14/25 09:25, Manivannan Sadhasivam wrote:
> > On Mon, Oct 13, 2025 at 10:52:48PM -0700, Ron Economos wrote:
> > > On 10/13/25 22:36, Krishna Chaitanya Chundru wrote:
> > > > 
> > > > On 10/14/2025 10:56 AM, Ron Economos wrote:
> > > > > On 10/13/25 22:20, Krishna Chaitanya Chundru wrote:
> > > > > > 
> > > > > > On 10/14/2025 2:58 AM, Bjorn Helgaas wrote:
> > > > > > > [+cc FU740 driver folks, Conor, regressions]
> > > > > > > 
> > > > > > > On Mon, Oct 13, 2025 at 12:14:54AM -0700, Ron Economos wrote:
> > > > > > > > The SiFive FU740 PCI driver fails on the HiFive
> > > > > > > > Unmatched board with Linux
> > > > > > > > 6.18-rc1. The error message is:
> > > > > > > > 
> > > > > > > > [    3.166624] fu740-pcie e00000000.pcie: host bridge
> > > > > > > > /soc/pcie@e00000000
> > > > > > > > ranges:
> > > > > > > > [    3.166706] fu740-pcie e00000000.pcie:       IO
> > > > > > > > 0x0060080000..0x006008ffff -> 0x0060080000
> > > > > > > > [    3.166767] fu740-pcie e00000000.pcie:      MEM
> > > > > > > > 0x0060090000..0x007fffffff -> 0x0060090000
> > > > > > > > [    3.166805] fu740-pcie e00000000.pcie:      MEM
> > > > > > > > 0x2000000000..0x3fffffffff -> 0x2000000000
> > > > > > > > [    3.166950] fu740-pcie e00000000.pcie: ECAM at [mem
> > > > > > > > 0xdf0000000-0xdffffffff] for [bus 00-ff]
> > > > > > > > [    3.579500] fu740-pcie e00000000.pcie: No iATU regions found
> > > > > > > > [    3.579552] fu740-pcie e00000000.pcie: Failed to
> > > > > > > > configure iATU in ECAM
> > > > > > > > mode
> > > > > > > > [    3.579655] fu740-pcie e00000000.pcie: probe with
> > > > > > > > driver fu740-pcie
> > > > > > > > failed with error -22
> > > > > > > > 
> > > > > > > > The normal message (on Linux 6.17.2) is:
> > > > > > > > 
> > > > > > > > [    3.381487] fu740-pcie e00000000.pcie: host bridge
> > > > > > > > /soc/pcie@e00000000
> > > > > > > > ranges:
> > > > > > > > [    3.381584] fu740-pcie e00000000.pcie:       IO
> > > > > > > > 0x0060080000..0x006008ffff -> 0x0060080000
> > > > > > > > [    3.381682] fu740-pcie e00000000.pcie:      MEM
> > > > > > > > 0x0060090000..0x007fffffff -> 0x0060090000
> > > > > > > > [    3.381724] fu740-pcie e00000000.pcie:      MEM
> > > > > > > > 0x2000000000..0x3fffffffff -> 0x2000000000
> > > > > > > > [    3.484809] fu740-pcie e00000000.pcie: iATU: unroll
> > > > > > > > T, 8 ob, 8 ib, align
> > > > > > > > 4K, limit 4096G
> > > > > > > > [    3.683678] fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
> > > > > > > > [    3.883674] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
> > > > > > > > [    3.987678] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
> > > > > > > > [    3.988164] fu740-pcie e00000000.pcie: PCI host
> > > > > > > > bridge to bus 0000:00
> > > > > > > > 
> > > > > > > > Reverting the following commits solves the issue.
> > > > > > > > 
> > > > > > > > 0da48c5b2fa731b21bc523c82d927399a1e508b0 PCI: dwc:
> > > > > > > > Support ECAM mechanism by
> > > > > > > > enabling iATU 'CFG Shift Feature'
> > > > > > > > 
> > > > > > > > 4660e50cf81800f82eeecf743ad1e3e97ab72190 PCI: qcom:
> > > > > > > > Prepare for the DWC ECAM
> > > > > > > > enablement
> > > > > > > > 
> > > > > > > > f6fd357f7afbeb34a633e5688a23b9d7eb49d558 PCI: dwc:
> > > > > > > > Prepare the driver for
> > > > > > > > enabling ECAM mechanism using iATU 'CFG Shift Feature'
> > > > > > > As Conor pointed out, we can't fix a code regression with a DT change.
> > > > > > > 
> > > > > > > #regzbot introduced: f6fd357f7afb ("PCI: dwc: Prepare the
> > > > > > > driver for enabling ECAM mechanism using iATU 'CFG Shift
> > > > > > > Feature'")
> > > > > > Hi Conor,
> > > > > > 
> > > > > > Can you try with this patch and see if it is fixing the issue.
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-fu740.c
> > > > > > b/drivers/pci/controller/dwc/pcie-fu740.c
> > > > > > index 66367252032b..b5e0f016a580 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-fu740.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> > > > > > @@ -328,6 +328,8 @@ static int fu740_pcie_probe(struct
> > > > > > platform_device *pdev)
> > > > > > 
> > > > > >          platform_set_drvdata(pdev, afp);
> > > > > > 
> > > > > > +       pci->pp.native_ecam = true;
> > > > > > +
> > > > > >          return dw_pcie_host_init(&pci->pp);
> > > > > >   }
> > > > > > 
> > > > > > - Krishna Chaitanya.
> > > > > > 
> > > > > I've already tried it. It doesn't work. Same error message as before.
> > > > Can you share us dmesg logs for this change.
> > > > 
> > > > - Krishna Chaitanya.
> > > [    3.159763] fu740-pcie e00000000.pcie: host bridge /soc/pcie@e00000000
> > > ranges:
> > > [    3.159853] fu740-pcie e00000000.pcie:       IO
> > > 0x0060080000..0x006008ffff -> 0x0060080000
> > > [    3.159916] fu740-pcie e00000000.pcie:      MEM
> > > 0x0060090000..0x007fffffff -> 0x0060090000
> > > [    3.159953] fu740-pcie e00000000.pcie:      MEM
> > > 0x2000000000..0x3fffffffff -> 0x2000000000
> > > [    3.160039] fu740-pcie e00000000.pcie: ECAM at [mem
> > > 0xdf0000000-0xdffffffff] for [bus 00-ff]
> > > [    3.571421] fu740-pcie e00000000.pcie: No iATU regions found
> > > [    3.571472] fu740-pcie e00000000.pcie: Failed to configure iATU in ECAM
> > > mode
> > > [    3.571529] fu740-pcie e00000000.pcie: probe with driver fu740-pcie
> > > failed with error -22
> > > 
> > > Same as before the change. The entire log is here:
> > > 
> > > https://www.w6rz.net/dmesg.txt
> > > 
> > Weird that the driver still creates ECAM even after skipping it using the flag.
> > The flag is not meant for that purpose, but it should've worked anyway.
> > 
> > Can you try this diff and share the dmesg log?
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 20c9333bcb1c..58080928df9f 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -523,8 +523,12 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
> >          pp->cfg0_size = resource_size(res);
> >          pp->cfg0_base = res->start;
> > 
> > +       dev_info(dev, "%s: %d native_ecam: %d", __func__, __LINE__,
> > +pp->native_ecam);
> > +
> >          pp->ecam_enabled = dw_pcie_ecam_enabled(pp, res);
> >          if (pp->ecam_enabled) {
> > +               dev_info(dev, "%s: %d ECAM ENABLED", __func__, __LINE__);
> >                  ret = dw_pcie_create_ecam_window(pp, res);
> >                  if (ret)
> >                          return ret;
> > @@ -533,6 +537,7 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
> >                  pp->bridge->sysdata = pp->cfg;
> >                  pp->cfg->priv = pp;
> >          } else {
> > +               dev_info(dev, "%s: %d ECAM DISABLED", __func__, __LINE__);
> >                  pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
> >                  if (IS_ERR(pp->va_cfg0_base))
> >                          return PTR_ERR(pp->va_cfg0_base);
> > 
> > - Mani
> > 
> After testing with this patch, I must have transferred the wrong image to
> the target when testing before. The "pci->pp.native_ecam = true;" patch to
> pcie-fu740.c does work.

Thanks! However, it was not a proper fix. The issue seems to be due the
assumption that the whole DBI space (Root Port + misc registers) lies at the
start of the ECAM region. This is true for Qcom, but not for all DWC glue
platforms.

Krishna is working on a patch that decouples the DBI region from ECAM so that
the driver will continue using DBI for accessing Root Port config space and ECAM
for bus > 0.

This is one step backwards for ECAM since the driver is supposed to use ECAM for
accessing all devices starting from the Root Port. But since DWC has clubbed
non-Root Port specific registers in the DBI space, we have to live with this
limitation as ECAM is supposed to access only Root Port specific registers.

The patch will be posted after internal validation asap.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

