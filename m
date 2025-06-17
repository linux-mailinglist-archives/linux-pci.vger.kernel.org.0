Return-Path: <linux-pci+bounces-29933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44AEADD062
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E27165DDC
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2D7202962;
	Tue, 17 Jun 2025 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMoD5RBj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416BA1EB1AF;
	Tue, 17 Jun 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171616; cv=none; b=OWgd+Hfy5gC/B+TfhYJ/Hq9s0YEr3WUbXecAKtjRHypliGL5OF6LR3Gtll3+w12+lamORzLQc9TCT8Ve2tY5eRwKj2/wtzCxCrQWrxJMQOfkv4mmcRUDYiNNFI86zByR0p6gt0WeGCTqetGlXG9fvcLSkulhjP5bvfkrnvzvssQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171616; c=relaxed/simple;
	bh=hWbaoenAqCzEM8b4nAI/Su+XmTfwZ/XFIdmcb0kYnF4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RpORbmRVKEd0AumIWbiSoeLUwfAMDvRsxDMKUZVJvjrvv325+++spa3PvcJkIRVr+wB7Bmr/9xhhBGb8bZr7Cir/F6FZ9uqt+CSBXgAhDbDkgrzSSIGvTh/f0C1iztZbROH2BDA7J523oblJbqQfENHcnZJCc8m3Gs//BKSFYUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMoD5RBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFAEC4CEE3;
	Tue, 17 Jun 2025 14:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750171615;
	bh=hWbaoenAqCzEM8b4nAI/Su+XmTfwZ/XFIdmcb0kYnF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pMoD5RBjg2hrWdX5GLO+dzDVRy82xhJby1ktI+4SZVGY3goUcbE1IP2pVhv2BfvYK
	 WDQSxARTsr7uRdwIu2BMt/biJmS+HH6a4JQm5J/1WoqxZl9Ag+vmcK+PvpZKti9oGW
	 LeHzcmsumGPqvV3kMkcnJ9xQ3jMBV+QeF7pC/pwuF8BGSKthP6lzerpbCK+b9ouWhV
	 0DrQSNgXdUkFwUNi1mm0jyHVaNvY6GNV3YGYxBZZWYNF51dP9grnWnluUAbAXcqSV2
	 79SjDNydKWs8PZVHWBiDMexYMWLr7rS1cFqI+pPPbBb5R72CeS/1sbRDXHz1/FtmGw
	 +igdSheqcnlVw==
Date: Tue, 17 Jun 2025 09:46:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
	"Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Subject: Re: [RESEND PATCH v7 2/2] PCI: xilinx-cpm: Add support for PCIe RP
 PERST# signal
Message-ID: <20250617144654.GA1135267@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB615826495B1A4F7DBADCEEF2CD73A@DM4PR12MB6158.namprd12.prod.outlook.com>

On Tue, Jun 17, 2025 at 04:14:37AM +0000, Musham, Sai Krishna wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Manivannan,
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > Sent: Thursday, June 12, 2025 10:49 PM
> > To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> > Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> > manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; cassel@kernel.org; linux-pci@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> > <michal.simek@amd.com>; Gogada, Bharat Kumar
> > <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> > <thippeswamy.havalige@amd.com>
> > Subject: Re: [RESEND PATCH v7 2/2] PCI: xilinx-cpm: Add support for PCIe RP
> > PERST# signal
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Mon, Apr 14, 2025 at 08:53:04AM +0530, Sai Krishna Musham wrote:
> > > Add support for handling the PCIe Root Port (RP) PERST# signal using
> > > the GPIO framework, along with the PCIe IP reset. This reset is
> > > managed by the driver and occurs after the Initial Power Up sequence
> > > (PCIe CEM r6.0, 2.2.1) is handled in hardware before the driver's probe
> > > function is called.

> > > +     if (do_reset) {
> > > +             /* Assert the PCIe IP reset */
> > > +             writel_relaxed(0x1, port->crx_base + variant->cpm_pcie_rst);
> > > +
> > > +             /*
> > > +              * "PERST# active time", as per Table 2-10: Power Sequencing
> > > +              * and Reset Signal Timings of the PCIe Electromechanical
> > > +              * Specification, Revision 6.0, symbol "T_PERST".
> > > +              */
> > > +             udelay(100);
> >
> > Are you sure that you need T_PERST here and not T_PVPERL? T_PERST
> > is only valid while resuming from D3Cold i.e., after power up,
> > while T_PVPERL is valid during the power up, which is usually the
> > case when a controller driver probes. Is your driver relying on
> > power being enabled by the bootloader and the driver just toggling
> > PERST# to perform conventional reset of the endpoint?
> 
> Thanks for pointing that out. Yes, the power-up sequence is handled
> by the hardware, and the driver relies on power being enabled by it.
> We're only toggling the PERST# signal in the driver to perform a
> conventional reset of the endpoint. So, I'm confident that T_PERST
> is the appropriate timing reference here, not T_PVPERL.
> 
> Additionally, this delay was recommended by our hardware team, who
> confirmed that the power-up sequence is managed in hardware logic,
> and that T_PERST is the appropriate timing to apply in this context.
> 
> I also checked pci.h but couldn't find a predefined macro for
> T_PERST, so I used 100.  Please let me know if there's a preferred
> macro I should be using instead.

If we need a new macro, please add it.  Include a citation to the
relevant section of the spec ("PCIe CEM r6.0, sec 2.11.2"; table
numbers don't appear in the table of contents so they're hard to
find), and include the units ("_US", I guess) in the macro name.

Given a comment at the macro definition, you don't need to repeat it
at all the uses.

Bjorn

