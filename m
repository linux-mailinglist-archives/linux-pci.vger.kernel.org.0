Return-Path: <linux-pci+bounces-39263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECAAC0622E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 14:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E7C1A07830
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 12:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5913081A5;
	Fri, 24 Oct 2025 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSe3k1NF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C467483;
	Fri, 24 Oct 2025 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307200; cv=none; b=YhwALlILQDTWZbVxZpOxCJbOlcM3DTaij6r0BOKGdddyhIDAwGFvCOCyy/V3n90kGdlLYKiFnvJoZ1I9pYqAw8nT2Y6XDzgATAsopfTFU29yWRJzc/tHKSZokLzb4KqRn/c4owfgFegVOR9FxCOcBIvb8wnozO958A5fVvkLSH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307200; c=relaxed/simple;
	bh=mwXxLlHwcTHyM39SvUYMrdYLE2o4P2lXhNWijwv5uq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Noebst2DWrp6ItuTvYTwH0yESXN2GUQy3pu4mMJ0S2QUC8GqMkTmej7BlmmzYKyyOgFYsWqhP1fcutjlzXHZ83X8XxSXmZSDjO+3x5cyhyDbjvjUw4lyuRBhWWhY+xDErGSpW9Rm8pjO39UcBFcCxUBxaG/EotiQTuAHfw/jj3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSe3k1NF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5EFC4CEF1;
	Fri, 24 Oct 2025 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761307200;
	bh=mwXxLlHwcTHyM39SvUYMrdYLE2o4P2lXhNWijwv5uq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSe3k1NFXHPKQGhrD1pTPUz+eNo4YkXPh1bOXFukxY8C2TvbOhEbdv2AoPs2Qsbne
	 NJkHZUvDBmKLslbfnBN3JgTveIzXRuroLurG3kH9dqPSJofu8F36qGRGI7coUoNyhf
	 tQlpocd4JqT620SXPVx6TD/uk7fFHGVPZS8HcrGoi5ZQ0GJ/rxTGqzU12CPKL+g0jD
	 bzsuNV+BeSGM4r5wcZVQj7U+EigEXJOVExaRGYfg1W/ZEnmTlT7skjPl2R33OLdK4X
	 QnWboqn7EkTChJauIZ2+HqhnzHJwOQFV8M7yMuKfA+QGyx9+7Geoa4lhQEaP447R8+
	 OxFCsgPjUJYew==
Date: Fri, 24 Oct 2025 17:29:45 +0530
From: "mani@kernel.org" <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Stefan Roese <stefan.roese@mailbox.org>, 
	"Musham, Sai Krishna" <sai.krishna.musham@amd.com>, "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>, 
	"Bandi, Ravi Kumar" <ravib@amazon.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"Simek, Michal" <michal.simek@amd.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sean Anderson <sean.anderson@linux.dev>, 
	"Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>
Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Message-ID: <ykzvrzxjv4pyosmz6nus4h35hpwcjt3kemugo3m5zl5g3xwbhb@ugcy2exwshi5>
References: <9c7e43c3-24e9-4b08-a6ce-2035b50226f4@mailbox.org>
 <20251023161100.GA1297651@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251023161100.GA1297651@bhelgaas>

On Thu, Oct 23, 2025 at 11:11:00AM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 23, 2025 at 09:03:07AM +0200, Stefan Roese wrote:
> > On 10/23/25 08:35, Musham, Sai Krishna wrote:
> > > > -----Original Message-----
> > > > From: Stefan Roese <stefan.roese@mailbox.org>
> > > > On 10/22/25 14:48, Musham, Sai Krishna wrote:
> > ...
> 
> > > > > > > We even don’t need ravi patch, as we have tested this at
> > > > > > > our end it works fine by just updating interrupt-map
> > > > > > > Property. We need to now understand the difference in
> > > > > > > design.
> > > > > > 
> > > > > > Ok, please let us know with your findings. In the meantime,
> > > > > > I'll keep Ravi's patch in tree, as it seems to be required
> > > > > > on his setup.
> > > > > 
> > > > > We tested on Linux version 6.12.40 without applying either
> > > > > Stefan's or Ravi's patches.  Instead, we applied only the
> > > > > following interrupt-map property change (entries 0,1,2,3) and
> > > > > verified that legacy interrupts are working correctly.
> > > > > 
> > > > > interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
> > > > > <0 0 0 2 &pcie_intc_0 1>,
> > > > > <0 0 0 3 &pcie_intc_0 2>,
> > > > > <0 0 0 4 &pcie_intc_0 3>;
> > > > > 
> > > > > 38:       1143          0  pl_dma:RC-Event  16 Level     80000000.axi-pcie
> > > > > 39:       1143          0  pl_dma:INTx   0 Level     nvme0q0, nvme0q1
> > > > 
> > > > Okay. Same here. I don't need Ravi's patch for the INTx bit
> > > > enabling.
> > > > 
> > > > I understand that you want us to change the interrupt map in the
> > > > auto- generated device-tree from Vivado. Which is IMHO a bit
> > > > "suboptimal".
> > > > 
> > > > I would prefer to have a solution which works out-of-the-box,
> > > > w/o the need to manually change DT properties. Is it planned to
> > > > change / fix this interrupt map in pl.dtsi generated with a
> > > > newer version of Vivado?
> > > 
> > > Yes Stefan, this will be fixed in the newer versions and the
> > > auto-generated device tree will include the correct interrupt-map
> > > property entries.
> > 
> > Understood. And thanks the update on this.
> > 
> > @Bjorn & Mani, this patch can be dropped then.
> 
> Just to confirm, we can drop both of these patches:
> 
>   https://patch.msgid.link/20250920225232.18757-1-ravib@amazon.com
>   https://patch.msgid.link/20251021154322.973640-1-stefan.roese@mailbox.org
> 
> AND there are no DTs in the field that will need to be updated for
> things to work?
> 

There are no upstream DTs making use of this driver. Also, the upstream binding
example seems to be correct:

            interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
                            <0 0 0 2 &pcie_intc_0 1>,
                            <0 0 0 3 &pcie_intc_0 2>,
                            <0 0 0 4 &pcie_intc_0 3>;

Moreover, if any DTs were using different 'interrupt-map' property, then INTx
wouldn't be working for them. So most likely they were all using MSIs as we
haven't received any reports up until now.

Hence, IMO we should be good to ignore the patch from Stefan. Though, I still
have a concern on whether the hardware is enabling INTx by default or not [1].
Until that is concluded, we should keep Ravi's patch.

- Mani

[1] https://lore.kernel.org/linux-pci/DM4PR12MB6158C6E6D6CC8BBCD5F6C3B1CDF0A@DM4PR12MB6158.namprd12.prod.outlook.com/

-- 
மணிவண்ணன் சதாசிவம்

