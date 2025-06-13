Return-Path: <linux-pci+bounces-29660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62DEAD87E0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 11:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0223F173652
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 09:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A93258CDC;
	Fri, 13 Jun 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po2FjRUB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56D279DA1;
	Fri, 13 Jun 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807004; cv=none; b=IJvoL7WiwklFtv9CemS4QBhupejntMB0HQ1EDiINlOx1N+ID5GP8Kx8uhGltfm0Mz6hKtD/BoEaN7rMX6WL8LSD5eSt09efxhqnaGZCBg/2ugngay76sh+BW8dkBjx6Q1fAMMbNCk6N91qqSLQ28kw0yrcJoVuMH+GSmABR0DG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807004; c=relaxed/simple;
	bh=jb+kljA3XGy8Fy36FVMmKKUspEeqQQdHLJELzixxi38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpPogIGYu8Aax7pkdSS8ebvHUqDuScNqpHiUditMfKt13JIUbKPogP5yPeqOiMMUxTwcZQSODVFyRNoBbgpF32i9qcUqbT5OzKg1Q2mkZqHItlgELusVNXyyxLnS4ZnwRKXt9xcm+vFRxa9GSOHcBMGbPYp7cSs/IJyekOPEEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po2FjRUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE1DC4CEE3;
	Fri, 13 Jun 2025 09:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749807003;
	bh=jb+kljA3XGy8Fy36FVMmKKUspEeqQQdHLJELzixxi38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Po2FjRUBdL1BvA7Ty9pQhn/QwoqIl1psVIDf+4HGcX25rl/oL1Q50ee/0iF4vj8cL
	 KebCFVCLYqLgkDn61NWO1hvEyF5Wc20POPebpgGzJFfdHPRhWjRmhPNIXb6GZdFtJF
	 ff7iqEuXt7sBDP42YlSv8XOYMecSKv91J3K+lCp3JUUGCT30R5ur/cJB2xLPNgDqE9
	 LfVrhh+gz6Z5w3g9zda/V/wH+Y3yeR459Ma2eMnprStd9n40KdiLljTwqELUGGtv/i
	 FpFFLSShbH69p5iODxjfj0vwVV0Xp0D0BFKCXw8Ck7XvRDwU7GcZ9sHSUKE5Vros1A
	 Q1T6n3LzOQSeg==
Date: Fri, 13 Jun 2025 14:59:53 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Mayank Rana <mayank.rana@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, andersson@kernel.org, 
	manivannan.sadhasivam@linaro.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com, 
	quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com, quic_nitegupt@quicinc.com
Subject: Re: [PATCH v4 0/4] Add Qualcomm SA8255p based firmware managed PCIe
 root complex
Message-ID: <4yscxqds72lsrdld7tadnlcuk7q6hir3t6mwliu35aljn34veb@hme5q4dpind7>
References: <20250522001425.1506240-1-mayank.rana@oss.qualcomm.com>
 <584d217a-e8df-4dbe-ad70-2c69597a0545@oss.qualcomm.com>
 <683bc42f-2810-4d8f-8712-80f933c4b8ad@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <683bc42f-2810-4d8f-8712-80f933c4b8ad@oss.qualcomm.com>

On Thu, Jun 12, 2025 at 02:24:04PM -0700, Mayank Rana wrote:
> Hi Mani
> 
> Gentle reminder for review.
> 

These patches are not applying on top of v6.16-rc1. Please post the rebased
version.

- Mani

> Regards
> Mayank
> 
> On 6/4/2025 10:38 AM, Mayank Rana wrote:
> > Hi Mani
> > 
> > As we discussed previously, I resumed working on this functionality.
> > Please help with reviewing this patchset.
> > 
> > Regards,
> > Mayank
> > On 5/21/2025 5:14 PM, Mayank Rana wrote:
> > > Based on received feedback, this patch series adds support with existing
> > > Linux qcom-pcie.c driver to get PCIe host root complex functionality on
> > > Qualcomm SA8255P auto platform.
> > > 
> > > 1. Interface to allow requesting firmware to manage system resources and
> > > performing PCIe Link up (devicetree binding in terms of power domain and
> > > runtime PM APIs is used in driver)
> > > 
> > > 2. SA8255P is using Synopsys Designware PCIe controller which
> > > supports MSI
> > > controller. Using existing MSI controller based functionality by
> > > exporting
> > > important pcie dwc core driver based MSI APIs, and using those from
> > > pcie-qcom.c driver.
> > > 
> > > Below architecture is used on Qualcomm SA8255P auto platform to get ECAM
> > > compliant PCIe controller based functionality. Here firmware VM
> > > based PCIe
> > > driver takes care of resource management and performing PCIe link related
> > > handling (D0 and D3cold). Linux pcie-qcom.c driver uses power domain to
> > > request firmware VM to perform these operations using SCMI interface.
> > > --------------------
> > > 
> > > 
> > >                                     ┌────────────────────────┐
> > >                                     │                        │
> > >    ┌──────────────────────┐         │     SHARED MEMORY
> > > │            ┌──────────────────────────┐
> > >    │     Firmware VM      │         │
> > > │            │         Linux VM         │
> > >    │ ┌─────────┐          │         │
> > > │            │    ┌────────────────┐    │
> > >    │ │ Drivers │ ┌──────┐ │         │
> > > │            │    │   PCIE Qcom    │    │
> > >    │ │ PCIE PHY◄─┤      │ │         │   ┌────────────────┐
> > > │            │    │    driver      │    │
> > >    │ │         │ │ SCMI │ │         │   │                │
> > > │            │    │                │    │
> > >    │ │PCIE CTL │ │      │ ├─────────┼───►    PCIE
> > > ◄───┼─────┐      │    └──┬──────────▲──┘    │
> > >    │ │         ├─►Server│ │         │   │    SHMEM       │   │
> > > │      │       │          │       │
> > >    │ │Clk, Vreg│ │      │ │         │   │                │   │
> > > │      │    ┌──▼──────────┴──┐    │
> > >    │ │GPIO,GDSC│ └─▲──┬─┘ │         │   └────────────────┘   │
> > > └──────┼────┤PCIE SCMI Inst  │    │
> > >    │ └─────────┘   │  │   │         │
> > > │            │    └──▲──────────┬──┘    │
> > >    │               │  │   │         │
> > > │            │       │          │       │
> > >    └───────────────┼──┼───┘         │
> > > │            └───────┼──────────┼───────┘
> > >                    │  │             │
> > > │                    │          │
> > >                    │  │
> > > └────────────────────────┘                    │          │
> > >                    │
> > > │                                                          
> > > │          │
> > >                    │
> > > │                                                          
> > > │          │
> > >                    │
> > > │                                                          
> > > │          │
> > >                    │
> > > │                                                           │IRQ
> > > │HVC
> > >                IRQ │
> > > │HVC                                                       
> > > │          │
> > >                    │
> > > │                                                          
> > > │          │
> > >                    │
> > > │                                                          
> > > │          │
> > >                    │
> > > │                                                          
> > > │          │
> > > ┌─────────────────┴──▼───────────────────────────────────────────────────────────┴──────────▼──────────────┐
> > > │                                                                                                          │
> > > │                                                                                                          │
> > > │
> > > HYPERVISOR                                                         
> > > │
> > > │                                                                                                          │
> > > │                                                                                                          │
> > > │                                                                                                          │
> > > └──────────────────────────────────────────────────────────────────────────────────────────────────────────┘
> > >    ┌─────────────┐    ┌─────────────┐  ┌──────────┐   ┌───────────┐
> > > ┌─────────────┐  ┌────────────┐
> > >    │             │    │             │  │          │   │           │
> > > │  PCIE       │  │   PCIE     │
> > >    │   CLOCK     │    │   REGULATOR │  │   GPIO   │   │   GDSC    │
> > > │  PHY        │  │ controller │
> > >    └─────────────┘    └─────────────┘  └──────────┘   └───────────┘
> > > └─────────────┘  └────────────┘
> > > -----------------
> > > Changes in v4:
> > > - Addressed provided review comments from reviewers
> > > Link to v3: https://lore.kernel.org/lkml/20241106221341.2218416-1-
> > > quic_mrana@quicinc.com/
> > > 
> > > Changes in v3:
> > > - Drop usage of PCIE host generic driver usage, and splitting of MSI
> > > functionality
> > > - Modified existing pcie-qcom.c driver to add support for getting
> > > ECAM compliant and firmware managed
> > > PCIe root complex functionality
> > > Link to v2: https://lore.kernel.org/linux-arm-
> > > kernel/925d1eca-975f-4eec-bdf8-ca07a892361a@quicinc.com/T/
> > > 
> > > Changes in v2:
> > > - Drop new PCIe Qcom ECAM driver, and use existing PCIe designware
> > > based MSI functionality
> > > - Add power domain based functionality within existing ECAM driver
> > > Link to v1: https://lore.kernel.org/all/d10199df-5fb3-407b-b404-
> > > a0a4d067341f@quicinc.com/T/
> > > 
> > > Tested:
> > > - Validated NVME functionality with PCIe1 on SA8255P-RIDE platform
> > > 
> > > Mayank Rana (4):
> > >    PCI: dwc: Export dwc MSI controller related APIs
> > >    PCI: host-generic: Rename and export gen_pci_init() API to allow ECAM
> > >      creation
> > >    dt-bindings: PCI: qcom,pcie-sa8255p: Document ECAM compliant PCIe root
> > >      complex
> > >    PCI: qcom: Add Qualcomm SA8255p based PCIe root complex functionality
> > > 
> > >   .../bindings/pci/qcom,pcie-sa8255p.yaml       | 103 ++++++++++++++++
> > >   drivers/pci/controller/dwc/Kconfig            |   1 +
> > >   .../pci/controller/dwc/pcie-designware-host.c |  38 +++---
> > >   drivers/pci/controller/dwc/pcie-designware.h  |  14 +++
> > >   drivers/pci/controller/dwc/pcie-qcom.c        | 114 ++++++++++++++++--
> > >   drivers/pci/controller/pci-host-common.c      |   5 +-
> > >   include/linux/pci-ecam.h                      |   2 +
> > >   7 files changed, 248 insertions(+), 29 deletions(-)
> > >   create mode 100644
> > > Documentation/devicetree/bindings/pci/qcom,pcie- sa8255p.yaml
> > > 
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

