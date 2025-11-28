Return-Path: <linux-pci+bounces-42244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16464C91400
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 09:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 537D34E8F8F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 08:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50B32E718B;
	Fri, 28 Nov 2025 08:37:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1E52E717B;
	Fri, 28 Nov 2025 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764319061; cv=none; b=ZvgTdsw6MVzRUewKRXeyZgJ2nwRTsULqz1yLaRvAYN6iB/7Y5Cxui+6amhLa4TOAn6RZeMIGy85ULVmFrLJKUr3f3Yz1QasM/JJv7RIrtJpx9Pvyq6uzaliTD9xol8Fj/hWUeJ1xu/O4Em67o9FAJhh/G/QNV10YHwkOy5MParQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764319061; c=relaxed/simple;
	bh=LzaZPndV+LZZpptTFu16O3sbnBjDliJh2pt+/pUPrcU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FITHNorTMdObHFJDrn7YLP+VRHrAL4b1j/YkP7bCXOHg8rlnZZLylRAyjrGuK++k8/ZK1R32KRzbRDX1ajXukFb9naMyNfw0Ix2hibnavFczwZYBSKZvzk4kqYKSmat+qRdYKob8CztsI1CfIbxxsQRys1OHnsAFM92yXZnDaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 15FF392009C; Fri, 28 Nov 2025 09:37:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 0EFEF92009B;
	Fri, 28 Nov 2025 08:37:37 +0000 (GMT)
Date: Fri, 28 Nov 2025 08:37:36 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
cc: Manivannan Sadhasivam <mani@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Krzysztof Kozlowski <krzk@kernel.org>, 
    Alim Akhtar <alim.akhtar@samsung.com>, 
    Jonathan Chocron <jonnyc@amazon.com>, linux-pci@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 4/4] PCI: dwc: Support ECAM mechanism by enabling iATU
 'CFG Shift Feature'
In-Reply-To: <c7aea2b3-6984-40f5-8234-14d265dabefc@oss.qualcomm.com>
Message-ID: <alpine.DEB.2.21.2511280755440.36486@angie.orcam.me.uk>
References: <20250909-controller-dwc-ecam-v9-0-7d5b651840dd@kernel.org> <20250909-controller-dwc-ecam-v9-4-7d5b651840dd@kernel.org> <alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk> <c7aea2b3-6984-40f5-8234-14d265dabefc@oss.qualcomm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-2058476832-340985022-1764318020=:36486"
Content-ID: <alpine.DEB.2.21.2511280821060.36486@angie.orcam.me.uk>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2058476832-340985022-1764318020=:36486
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.21.2511280821061.36486@angie.orcam.me.uk>

On Fri, 28 Nov 2025, Krishna Chaitanya Chundru wrote:

> > > Designware databook r5.20a, sec 3.10.10.3 documents the 'CFG Shift
> > > Feature'
> > > of the internal Address Translation Unit (iATU). When this feature is
> > > enabled, it shifts/maps the BDF contained in the bits [27:12] of the
> > > target
> > > address in MEM TLP to become BDF of the CFG TLP. This essentially
> > > implements the Enhanced Configuration Address Mapping (ECAM) mechanism as
> > > defined in PCIe r6.0, sec 7.2.2.
> >   So this broke a parallel port on my HiFive Unmatched machine (a SiFive
> > FU740-C000 based system), the driver no longer registers the device, no
> > /dev/parport0 anymore.
> Hi Maciej, can you share us lspci -vvv o/p with working & non working case and
> also can you point us parport driver. - Krishna Chaitanya.

 I'm not sure what you mean as to the parport driver; it's standard stuff:

$ zgrep PARPORT /proc/config.gz
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
# CONFIG_PATA_PARPORT is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_USB_SERIAL_MOS7715_PARPORT is not set
$ 

I've attached output from `lspci -xxxx' so that you can decode it yourself 
however you need, though I fail to see anything standing out there.

 If you can't figure out what's going on here, then I'll try to poke at 
the driver to see what exactly it is that causes it to fail there, but I'm 
a little constrained on the resources and completely unfamiliar with the 
ECAM feature (and the lack of documentation for the DW IP does not help).

 I have no slightest idea why it should cause a regression such as this, 
it seems totally unrelated.  Yet it's 100% reproducible.  Could this be 
because it's the only device in the system that actually uses PCI/e port 
I/O?

# cat /proc/ioports
00000000-0000ffff : pcie@e00000000
  00001000-00002fff : PCI Bus 0000:01
    00001000-00002fff : PCI Bus 0000:02
      00001000-00002fff : PCI Bus 0000:05
        00001000-00002fff : PCI Bus 0000:06
          00001000-00001fff : PCI Bus 0000:07
          00001000-00001007 : 0000:07:00.0
          00001000-00001002 : parport0
          00001003-00001007 : parport0
          00001008-0000100b : 0000:07:00.0
          00001008-0000100a : parport0
          00002000-00002fff : PCI Bus 0000:08
          00002000-00002fff : PCI Bus 0000:09
          00002000-000020ff : 0000:09:01.0
          00002100-0000217f : 0000:09:02.0
# 

(Hmm, indentation does not appear correct to me for buses below 0000:07.)

  Maciej
---2058476832-340985022-1764318020=:36486
Content-Type: application/x-xz; NAME=pci-xxxx-good.log.xz
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.2511280820200.36486@angie.orcam.me.uk>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=pci-xxxx-good.log.xz

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
AARZWg==

---2058476832-340985022-1764318020=:36486
Content-Type: application/x-xz; NAME=pci-xxxx-bad.log.xz
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.2511280820201.36486@angie.orcam.me.uk>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=pci-xxxx-bad.log.xz

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
Acog5LcNALyGRZ6xxGf7AgAAAAAEWVo=

---2058476832-340985022-1764318020=:36486--

