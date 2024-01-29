Return-Path: <linux-pci+bounces-2719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B0C840523
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 13:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7B21F22479
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8616860EFD;
	Mon, 29 Jan 2024 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd3QBaAd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253F6166D;
	Mon, 29 Jan 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531969; cv=none; b=ARerNhFYJbIi2dBHu7XXSLQm6qnvPtVcpr6IaLebwEsge7FB1/J0Jb4MAogFbXPnHKumY9WLV9wvMZAjJEOltCpVUGPRS23ftcBUagjy5u5t+3Q45N6PIPMUm7b1YFKLJjgLmqnMWmn2liUkDpUxA65OBCCCRTudbPm0LXEFBS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531969; c=relaxed/simple;
	bh=4vsq0jGRemPIenPEeylBuokXHeP6HZCyOf/KheuJU4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FE2UdjkfQedtSQUuU+aUNOdP+932nLSSZp2hBZT5xQQ28uDm7FNW6Bwm7IF2m270snqKqgLZLzAfR64dCCspHP2D9Vrf4ttlzZloAyVDyQPuYnh+nX/OO+Bl3oju/paHk1mHUDElr65hbOKfHcuDPOpcTACltvbfctnwYfA/rbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd3QBaAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92373C433C7;
	Mon, 29 Jan 2024 12:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706531968;
	bh=4vsq0jGRemPIenPEeylBuokXHeP6HZCyOf/KheuJU4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hd3QBaAdKcV2IDgDwKRpUKY7YipRrrIB4zunykNwepqBUiz9io6CvwAh92Q5ob9DS
	 765eZjZv0Zlg271R8GIrZHAoKkqPVz95UoPGyxD6vJWTNGj36FAe07T1C/cyFnQUln
	 80v/PlT1GUJBtHFmRKYBLJaz1+WMqAxJr3cvVGehlobyCLgfgwckafiXghcPNjk8uK
	 udeejD4j4A+yax/aDN8WTKStZ0bfSOuwcZywy2iuonYHCCwaylLSONfxA0+itdkk0J
	 e6OYL89f26/lvC3IeT3AC/m1lmb/89PBQnGQOZEM8EpP4NGlFCdljSmQp7WTfLevGQ
	 O3vEB7smUahkA==
Date: Mon, 29 Jan 2024 18:09:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	dmitry.baryshkov@linaro.org, robh@kernel.org,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	quic_parass@quicinc.com, quic_schintav@quicinc.com,
	quic_shijjose@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v9 0/5] arm64: qcom: sa8775p: add support for EP PCIe
Message-ID: <20240129123909.GB22617@thinkpad>
References: <1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com>
 <pm2emx3nnypdtfo63f6vly4guybl3pguqe3djgeqgiojxgqttl@oainfndei3qa>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pm2emx3nnypdtfo63f6vly4guybl3pguqe3djgeqgiojxgqttl@oainfndei3qa>

On Sat, Jan 27, 2024 at 08:58:17PM -0600, Bjorn Andersson wrote:
> On Fri, Dec 01, 2023 at 05:36:11PM +0530, Mrinmay Sarkar wrote:
> > This series adds the relavent DT bindings, new compatible string,
> > add support to EPF driver and add EP PCIe node in dtsi file for
> > ep pcie0 controller.
> > 
> 
> Waiting for the driver changes to be picked up, so that I can merge
> patch 5 through the qcom tree. Are there any unresolved issues that I'm
> failing to spot?
> 

No, there are no issues. But they fail to catch the eye of maintainers during
the last merge window. I really hope that these will get picked for 6.9.

- Mani

> Regards,
> Bjorn
> 
> > v8 -> v9:
> > - update author in "Add pci_epf_mhi_ prefix to the function" patch.
> > - add ack by and reviewed by tag in commit message.
> > 
> > v7 -> v8:
> > - Add new patch PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the function
> >   names
> > - Update PCI: epf-mhi: Add support for SA8775P patch on top of the new
> >   patch and update commit message.
> > 
> > v6 -> v7:
> > - add reviewed by tag in commit message in all patches.
> > - update commit message in patch 2 as per comment.
> > - update reason for reusing PID in commit message.
> > 
> > v5 -> v6:
> > - update cover letter.
> > 
> > v4 -> v5:
> > - add maxItems to the respective field to constrain io space and
> >   interrupt in all variants.
> > 
> > v3 -> v4:
> > - add maxItems field in dt bindings
> > - update comment in patch2
> > - dropped PHY driver patch as it is already applied [1]
> > - update comment in EPF driver patch
> > - update commect in dtsi and add iommus instead of iommu-map
> > 
> > [1] https://lore.kernel.org/all/169804254205.383714.18423881810869732517.b4-ty@kernel.org/
> > 
> > v2 -> v3:
> > - removed if/then schemas, added minItems for reg,
> >   reg-bnames, interrupt and interrupt-names instead.
> > - adding qcom,sa8775p-pcie-ep compitable for sa8775p
> >   as we have some specific change to add.
> > - reusing sm8450's pcs_misc num table as it is same as sa8775p.
> >   used appropriate namespace for pcs.
> > - remove const from sa8775p_header as kernel test robot
> >   throwing some warnings due to this.
> > - remove fallback compatiable as we are adding compatiable for sa8775p.
> > 
> > v1 -> v2:
> > - update description for dma
> > - Reusing qcom,sdx55-pcie-ep compatibe so remove compaitable
> >   for sa8775p
> > - sort the defines in phy header file and remove extra defines
> > - add const in return type pci_epf_header and remove MHI_EPF_USE_DMA
> >   flag as hdma patch is not ready
> > - add fallback compatiable as qcom,sdx55-pcie-ep, add iommu property
> > 
> > 
> > Manivannan Sadhasivam (1):
> >   PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the function names
> > 
> > Mrinmay Sarkar (4):
> >   dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
> >   PCI: qcom-ep: Add support for SA8775P SOC
> >   PCI: epf-mhi: Add support for SA8775P
> >   arm64: dts: qcom: sa8775p: Add ep pcie0 controller node
> > 
> >  .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 64 +++++++++++++++++++++-
> >  arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 46 ++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c          |  1 +
> >  drivers/pci/endpoint/functions/pci-epf-mhi.c       | 21 ++++++-
> >  4 files changed, 128 insertions(+), 4 deletions(-)
> > 
> > -- 
> > 2.7.4
> > 

-- 
மணிவண்ணன் சதாசிவம்

