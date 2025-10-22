Return-Path: <linux-pci+bounces-39013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3DBBFC270
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 15:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15EB62028F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD44345758;
	Wed, 22 Oct 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdOkQuHj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB68B345749;
	Wed, 22 Oct 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138628; cv=none; b=fNB2PNn7jm+R38b/xJFT+BSbT47Em8vvOLxzInF74zctQZGbqxpHN1GkikRnezp2llx3IjEc6kCk1bM9kv4nHFjgq6u/KXKuO5RPU+bLScH56oId3dUDfbyjvKBqB1wElNqmAKqTWXLcz/ivv+KRBWywaJfhK17lfrzKwsNQuOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138628; c=relaxed/simple;
	bh=/Du5gzKBdKt8tqyC45JQnXFk1Z9z8QIef1GN10pPqr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIi0xQuEDyWrom0StuSjnqsGkZLtVcLfRX82TS/q8vwt7mUBslDXu2ffzrUfDo2gNdxtbKuRZ+utfYhpb/YTXfqN75rNDaFBfjWf3jW71bGfyeuh2YOf4wh0SKptIFclQDueM4TKO+V8VmEyWFv5z+UDw/xt5bLcx51xjUXvRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdOkQuHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF10C4CEE7;
	Wed, 22 Oct 2025 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761138628;
	bh=/Du5gzKBdKt8tqyC45JQnXFk1Z9z8QIef1GN10pPqr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdOkQuHjijIbrgNvUDgLeRdcApQcVl+2xdnazoVj3aGHORXg0hirLD26RyZrzLdeX
	 +wGPxukw9liYXeK8sWXd+BGoHZoLch7IYNvV/3YQErZN0mCvMSGZGHbfVs2vAnR2az
	 l51Jry+rGzyPjFiKs+kjaqkLKhZuzSYVvoSTizNShSwEbRwTYygKSk2MdsONIofIBn
	 LnfEv9ao/454CBsQUeHLhyuAGESf+S0VhrXfz2U+Qx8ZTwQV0igFfn4RW70YM138Ap
	 SIVbGaUl8sjUXCM51misK0x3Eh8FU/PtLtfMHjoB4KCXt9wfy6qMLma3iV8eMxejj3
	 JRJPuLpWRgRZg==
Date: Wed, 22 Oct 2025 18:40:16 +0530
From: "mani@kernel.org" <mani@kernel.org>
To: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
Cc: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>, 
	Stefan Roese <stefan.roese@mailbox.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	"Bandi, Ravi Kumar" <ravib@amazon.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"Simek, Michal" <michal.simek@amd.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sean Anderson <sean.anderson@linux.dev>, 
	"Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>
Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Message-ID: <je532spw436aprfqtntmffq7faa2ghpbws2ph4zjplvbf7rnaa@gmrekmta6yh4>
References: <20251021212801.GA1224310@bhelgaas>
 <ab1f7c51-bc41-4774-a0dc-850e53c412eb@mailbox.org>
 <3it5l556vmfpuu6kz5yvulwosi4ecmcgfbzcizrc5wi7ifddkh@mpzfxf2v6v3f>
 <72267a6c-13c7-40bd-babb-f73a28625ca4@mailbox.org>
 <SN7PR12MB7201CF621AF0A38AA905799D8BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
 <brekq5jmgnotwpshcksxefpg2adm4vlsbuncazdg32sdpxqjwj@annnvyzshrys>
 <SN7PR12MB7201C6B5B64F8847DD6D816D8BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
 <zuj6puxpqgjmaa3y3wwyixlru7e7locplnjev37i5fnh6zummw@72t5prkfsrpk>
 <DM4PR12MB6158ACBA7BCEDB99A55ACA03CDF3A@DM4PR12MB6158.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR12MB6158ACBA7BCEDB99A55ACA03CDF3A@DM4PR12MB6158.namprd12.prod.outlook.com>

On Wed, Oct 22, 2025 at 12:48:27PM +0000, Musham, Sai Krishna wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Mani,
> 
> > -----Original Message-----
> > From: mani@kernel.org <mani@kernel.org>
> > Sent: Wednesday, October 22, 2025 4:28 PM
> > To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> > Cc: Stefan Roese <stefan.roese@mailbox.org>; Bjorn Helgaas
> > <helgaas@kernel.org>; Bandi, Ravi Kumar <ravib@amazon.com>;
> > lpieralisi@kernel.org; bhelgaas@google.com; linux-pci@vger.kernel.org;
> > kwilczynski@kernel.org; robh@kernel.org; Simek, Michal
> > <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; stable@vger.kernel.org; Sean Anderson
> > <sean.anderson@linux.dev>; Yeleswarapu, Nagaradhesh
> > <nagaradhesh.yeleswarapu@amd.com>; Musham, Sai Krishna
> > <sai.krishna.musham@amd.com>
> > Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Wed, Oct 22, 2025 at 10:36:28AM +0000, Havalige, Thippeswamy wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > Hi Mani,
> > >
> > > > -----Original Message-----
> > > > From: mani@kernel.org <mani@kernel.org>
> > > > Sent: Wednesday, October 22, 2025 4:02 PM
> > > > To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> > > > Cc: Stefan Roese <stefan.roese@mailbox.org>; Bjorn Helgaas
> > > > <helgaas@kernel.org>; Bandi, Ravi Kumar <ravib@amazon.com>;
> > > > lpieralisi@kernel.org; bhelgaas@google.com;
> > > > linux-pci@vger.kernel.org; kwilczynski@kernel.org; robh@kernel.org;
> > > > Simek, Michal <michal.simek@amd.com>;
> > > > linux-arm-kernel@lists.infradead.org; linux- kernel@vger.kernel.org;
> > > > stable@vger.kernel.org; Sean Anderson <sean.anderson@linux.dev>
> > > > Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
> > > >
> > > > On Wed, Oct 22, 2025 at 10:08:44AM +0000, Havalige, Thippeswamy wrote:
> > > > > [AMD Official Use Only - AMD Internal Distribution Only]
> > > > >
> > > > > Hi Stefan,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Stefan Roese <stefan.roese@mailbox.org>
> > > > > > Sent: Wednesday, October 22, 2025 3:29 PM
> > > > > > To: mani@kernel.org
> > > > > > Cc: Bjorn Helgaas <helgaas@kernel.org>; Bandi, Ravi Kumar
> > > > > > <ravib@amazon.com>; Havalige, Thippeswamy
> > > > > > <thippeswamy.havalige@amd.com>; lpieralisi@kernel.org;
> > > > > > bhelgaas@google.com; linux-pci@vger.kernel.org;
> > > > > > kwilczynski@kernel.org; robh@kernel.org; Simek, Michal
> > > > > > <michal.simek@amd.com>; linux-arm- kernel@lists.infradead.org;
> > > > > > linux-kernel@vger.kernel.org; stable@vger.kernel.org; Sean
> > > > > > Anderson <sean.anderson@linux.dev>
> > > > > > Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
> > > > > >
> > > > > > On 10/22/25 11:55, mani@kernel.org wrote:
> > > > > > > On Wed, Oct 22, 2025 at 08:59:19AM +0200, Stefan Roese wrote:
> > > > > > >> Hi Bjorn,
> > > > > > >> Hi Ravi,
> > > > > > >>
> > > > > > >> On 10/21/25 23:28, Bjorn Helgaas wrote:
> > > > > > >>> On Tue, Oct 21, 2025 at 08:55:41PM +0000, Bandi, Ravi Kumar wrote:
> > > > > > >>>>> On Tue, Oct 21, 2025 at 05:46:17PM +0000, Bandi, Ravi
> > > > > > >>>>> Kumar
> > > > wrote:
> > > > > > >>>>>>> On Oct 21, 2025, at 10:23 AM, Bjorn Helgaas
> > > > > > >>>>>>> <helgaas@kernel.org>
> > > > > > wrote:
> > > > > > >>>>>>> On Sat, Sep 20, 2025 at 10:52:32PM +0000, Ravi Kumar
> > > > > > >>>>>>> Bandi
> > > > > > wrote:
> > > > > > >>>>>>>> The pcie-xilinx-dma-pl driver does not enable INTx
> > > > > > >>>>>>>> interrupts after initializing the port, preventing INTx
> > > > > > >>>>>>>> interrupts from PCIe endpoints from flowing through the
> > > > > > >>>>>>>> Xilinx XDMA root port bridge. This issue affects kernel
> > > > > > >>>>>>>> 6.6.0 and
> > > > later versions.
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> This patch allows INTx interrupts generated by PCIe
> > > > > > >>>>>>>> endpoints to flow through the root port. Tested the fix
> > > > > > >>>>>>>> on a board with two endpoints generating INTx interrupts.
> > > > > > >>>>>>>> Interrupts are properly detected and serviced. The
> > > > > > >>>>>>>> /proc/interrupts output
> > > > > > >>>>>>>> shows:
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> [...]
> > > > > > >>>>>>>> 32:        320          0  pl_dma:RC-Event  16 Level
> > 400000000.axi-
> > > > pcie,
> > > > > > azdrv
> > > > > > >>>>>>>> 52:        470          0  pl_dma:RC-Event  16 Level
> > 500000000.axi-
> > > > pcie,
> > > > > > azdrv
> > > > > > >>>>>>>> [...]
> > > > > > >>
> > > > > > >> First a comment on this IRQ logging:
> > > > > > >>
> > > > > > >> These lines do NOT refer to the INTx IRQ(s) but the
> > > > > > >> controller internal "events" (errors etc). Please see this
> > > > > > >> log for INTx on my Versal platform with pci_irqd_intx_xlate added:
> > > > > > >>
> > > > > > >>   24:          0          0  pl_dma:RC-Event   0 Level     LINK_DOWN
> > > > > > >>   25:          0          0  pl_dma:RC-Event   3 Level     HOT_RESET
> > > > > > >>   26:          0          0  pl_dma:RC-Event   8 Level     CFG_TIMEOUT
> > > > > > >>   27:          0          0  pl_dma:RC-Event   9 Level     CORRECTABLE
> > > > > > >>   28:          0          0  pl_dma:RC-Event  10 Level     NONFATAL
> > > > > > >>   29:          0          0  pl_dma:RC-Event  11 Level     FATAL
> > > > > > >>   30:          0          0  pl_dma:RC-Event  20 Level     SLV_UNSUPP
> > > > > > >>   31:          0          0  pl_dma:RC-Event  21 Level     SLV_UNEXP
> > > > > > >>   32:          0          0  pl_dma:RC-Event  22 Level     SLV_COMPL
> > > > > > >>   33:          0          0  pl_dma:RC-Event  23 Level     SLV_ERRP
> > > > > > >>   34:          0          0  pl_dma:RC-Event  24 Level     SLV_CMPABT
> > > > > > >>   35:          0          0  pl_dma:RC-Event  25 Level     SLV_ILLBUR
> > > > > > >>   36:          0          0  pl_dma:RC-Event  26 Level     MST_DECERR
> > > > > > >>   37:          0          0  pl_dma:RC-Event  27 Level     MST_SLVERR
> > > > > > >>   38:         94          0  pl_dma:RC-Event  16 Level     84000000.axi-pcie
> > > > > > >>   39:         94          0  pl_dma:INTx   0 Level     nvme0q0, nvme0q1
> > > > > > >>
> > > > > > >> The last line shows the INTx IRQs here ('pl_dma:INTx' vs
> > > > > > >> 'pl_dma:RC- Event').
> > > > > > >>
> > > > > > >> More below...
> > > > > > >>
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> Changes since v1::
> > > > > > >>>>>>>> - Fixed commit message per reviewer's comments
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> Fixes: 8d786149d78c ("PCI: xilinx-xdma: Add Xilinx XDMA
> > > > > > >>>>>>>> Root Port driver")
> > > > > > >>>>>>>> Cc: stable@vger.kernel.org
> > > > > > >>>>>>>> Signed-off-by: Ravi Kumar Bandi <ravib@amazon.com>
> > > > > > >>>>>>>
> > > > > > >>>>>>> Hi Ravi, obviously you tested this, but I don't know how
> > > > > > >>>>>>> to reconcile this with Stefan's INTx fix at
> > > > > > >>>>>>> https://lore.kernel.org/r/20251021154322.973640-1-
> > > > > > stefan.roese@m
> > > > > > >>>>>>> ailbox.org
> > > > > > >>>>>>>
> > > > > > >>>>>>> Does Stefan's fix need to be squashed into this patch?
> > > > > > >>>>>>
> > > > > > >>>>>> Sure, we can squash Stefan’s fix into this.
> > > > > > >>>>>
> > > > > > >>>>> I know we *can* squash them.
> > > > > > >>>>>
> > > > > > >>>>> I want to know why things worked for you and Stefan when
> > > > > > >>>>> they
> > > > > > >>>>> *weren't* squashed:
> > > > > > >>>>>
> > > > > > >>>>>    - Why did INTx work for you even without Stefan's patch.  Did you
> > > > > > >>>>>      get INTx interrupts but not the right ones, e.g., did the device
> > > > > > >>>>>      signal INTA but it was received as INTB?
> > > > > > >>>>
> > > > > > >>>> I saw that interrupts were being generated by the endpoint
> > > > > > >>>> device, but I didn’t specifically check if they were
> > > > > > >>>> correctly translated in the controller. I noticed that the
> > > > > > >>>> new driver wasn't explicitly enabling the interrupts, so my
> > > > > > >>>> first approach was to enable them, which helped the interrupts flow
> > through.
> > > > > > >>>
> > > > > > >>> OK, I'll assume the interrupts happened but the driver might
> > > > > > >>> not have been able to handle them correctly, e.g., it was
> > > > > > >>> prepared for INTA but got INTB or similar.
> > > > > > >>>
> > > > > > >>>>>    - Why did Stefan's patch work for him even without your patch.
> > > > How
> > > > > > >>>>>      could Stefan's INTx work without the CSR writes to enable
> > > > > > >>>>>      interrupts?
> > > > > > >>>>
> > > > > > >>>> I'm not entirely sure if there are any other dependencies
> > > > > > >>>> in the FPGA bitstream. I'll investigate further and get back to you.
> > > > > > >>>
> > > > > > >>> Stefan clarified in a private message that he had applied
> > > > > > >>> your patch first, so this mystery is solved.
> > > > > > >>
> > > > > > >> Yes. I applied Ravi's patch first and still got no INTx
> > > > > > >> delivered to the nvme driver. That's what me triggered to dig
> > > > > > >> deeper here and resulted in this v2 patch with pci_irqd_intx_xlate added.
> > > > > > >>
> > > > > > >> BTW:
> > > > > > >> I re-tested just now w/o Ravi's patch and the INTx worked.
> > > > > > >> Still I think Ravi's patch is valid and should be applied...
> > > > > > >
> > > > > > > How come INTx is working without the patch from Ravi which
> > > > > > > enabled INTx routing in the controller? Was it enabled by default in the
> > hardware?
> > > > > >
> > > > > > Yes, this is my best guess right now. I could double-check here,
> > > > > > but IMHO it makes sense to enable it "manually" as done with
> > > > > > Ravi's patch to not rely on this default setup at all.
> > > > > Hardware doesn't enable this bits by default, INTx didn't work
> > > > > since there is a
> > > > miss match in the DT property which doesn't require pci_irqd_intx_xlate.
> > > > >
> > > > > interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
> > > > > <0 0 0 2 &pcie_intc_0 1>,
> > > > > <0 0 0 3 &pcie_intc_0 2>,
> > > > > <0 0 0 4 &pcie_intc_0 3>;
> > > > >
> > > >
> > > > Ok. This makes me believe that we do not need Stefan's patch [1] and
> > > > need just this patch from Ravi.
> > > >
> > > > - Mani
> > > >
> > > > [1] https://lore.kernel.org/linux-pci/20251021154322.973640-1-
> > > > stefan.roese@mailbox.org/
> > >
> > > We even don’t need ravi patch, as we have tested this at our end it
> > > works fine by just updating interrupt-map Property. We need to now understand the
> > difference in design.
> >
> > Ok, please let us know with your findings. In the meantime, I'll keep Ravi's patch in
> > tree, as it seems to be required on his setup.
> >
> 
> We tested on Linux version 6.12.40 without applying either Stefan's or Ravi's patches.

Please test with v6.18-rc1 kernel.

Any clue on what is going wrong with Ravi's setup?
https://lore.kernel.org/linux-pci/467D7D30-DC05-4612-87BA-7E980A9C0A4A@amazon.com/

- Mani

-- 
மணிவண்ணன் சதாசிவம்

