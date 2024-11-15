Return-Path: <linux-pci+bounces-16867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF21D9CDD75
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 12:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2214DB2726F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDB21ABEDF;
	Fri, 15 Nov 2024 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vyYiCeW6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A21B21BC
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670093; cv=none; b=J/C5mZzRHexpc06Zym7e3/sX8/sXE+IQy8lbiEpsM5WE/5bsMBiFffdcO+C/WP4USEi66Wv8NPQtPrQ3mVlpELc3qGIEPwTBdoaWMp9BbzkLquUaYNqejGFuezL0j9/hmCWhz6TutTXM4EMIR0aA1P2k+NQvr60QonwaUc+0qyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670093; c=relaxed/simple;
	bh=IV2FeGirkSwbOkjnkrGjm2aoKUL82ZxXZLitcxBlhJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCf+6NivQdDPLh+hPf1ZzMUrsK5zEzR6TUV/IOfzPSPgnhdqRgVlab/mI3V6cOFKeZ4JjDl07+p78Lg6DeZWfoYhX3sAOYAvsx0TzDH+vw1TITrhJlEW3CwZNuqSMg3jFWyDVYYxT/tzfx6eZTqAh7a7we5qcLSfsj4K8SyVVxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vyYiCeW6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ca388d242so18002155ad.2
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 03:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731670091; x=1732274891; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EgJfY+QhErfpT0vcHYFRI4p0UMOPmCc6NanmZ+nwutk=;
        b=vyYiCeW64FqsM6iywb+iWJdZrIaAy80WdzwHaBArJJxN1Bn21OMhqJwz4c+/jiwajw
         HN+E6H+fQ3Rq4RDvDmSBvBinGZ1rNNCxMAT4ATTagLqgqkCUruXHD+H44oMnzElJ0r8h
         AmVOedoB2TxWR95EhruTB9X9a3tfi770d3T3hHCurjaD6BERUrnRgzOir235/qOu1eDZ
         lfufGOPCZVfoxtvYWTa/JjRZ9JbCBTlR5qwZYNhUgVYsrc3mbYnkpCq0RNCMKfgd1tk0
         4RBgJXKUvWLnONnRhIeUjod77ruxgX6d+1HcCb2PtVoIsX/uFYpsEB1SGejy41UDTswB
         S/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731670091; x=1732274891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EgJfY+QhErfpT0vcHYFRI4p0UMOPmCc6NanmZ+nwutk=;
        b=sv5/UC+zMarumXJzxHsPqtCsaQ4dUDJ8uJXJTRZ/TG1NZqosmvjQWPoI3Gv/3Al8HJ
         tlc0IrRnaSGp0WKSJ0++kaKYi2kb3HYGiPDC1O5jwnxD9TBUP+YN348q1i9DTDDNERid
         5pHY8xo92p2YGXszvyLoKOvKDTR7NqWz4twdV49DDXP2YBbpUkfETW8VOcpstRYX5EJA
         73W9X2DJXGMh56LBtEZMD0LSHCqFHeSC2MiR3wqniYEA37au5qT/TRmJSl5cZrYi4co3
         W1AL2avIhVY2yX0DHibo0ESgttEe2NLRT5PW9YxUuLgi+WoIcyrIoB2HPxPrDIkHLxdg
         sCig==
X-Forwarded-Encrypted: i=1; AJvYcCVv7I2PRZW0WDGQl67alfP6xEA6PmWikLQ9Gu1C918+0UDeBMbfLz8H9MFImz/7bwP51JcF+IwmDY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5g8SqeaOi33X/wRqSRg06FqDjU4hrPs9yAiNghbvI4LKb7aNN
	2t2VM9ax4Qi/hWsBZYXjdnayrp5Z6H8ltG+DUj7qh3SQ6BhpzwFHlmHQdRasEA==
X-Google-Smtp-Source: AGHT+IFiJEdlKgYYdwr2AqQJ6vfoUhsoy9emHj8ASgn9/PxGF5E6ItzT2PUmWLKSVimkMgwkHEnlmA==
X-Received: by 2002:a17:902:e54c:b0:20f:aee9:d8b8 with SMTP id d9443c01a7336-211d0d72ac0mr22771415ad.20.1731670091084;
        Fri, 15 Nov 2024 03:28:11 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f34614sm10248035ad.163.2024.11.15.03.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:28:10 -0800 (PST)
Date: Fri, 15 Nov 2024 16:58:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: jingoohan1@gmail.com, will@kernel.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, krzk@kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_krichai@quicinc.com
Subject: Re: [PATCH v3 0/4] Add Qualcomm SA8255p based firmware managed PCIe
 root complex
Message-ID: <20241115112802.66xoxj4z5wsg4idl@thinkpad>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106221341.2218416-1-quic_mrana@quicinc.com>

On Wed, Nov 06, 2024 at 02:13:37PM -0800, Mayank Rana wrote:
> Based on received feedback, this patch series adds support with existing
> Linux qcom-pcie.c driver to get PCIe host root complex functionality on
> Qualcomm SA8255P auto platform.
> 
> 1. Interface to allow requesting firmware to manage system resources and
> performing PCIe Link up (devicetree binding in terms of power domain and
> runtime PM APIs is used in driver)
> 
> 2. SA8255P is using Synopsys Designware PCIe controller which supports MSI
> controller. Using existing MSI controller based functionality by exporting
> important pcie dwc core driver based MSI APIs, and using those from
> pcie-qcom.c driver.
> 
> Below architecture is used on Qualcomm SA8255P auto platform to get ECAM
> compliant PCIe controller based functionality. Here firmware VM based PCIe
> driver takes care of resource management and performing PCIe link related
> handling (D0 and D3cold). Linux pcie-qcom.c driver uses power domain to
> request firmware VM to perform these operations using SCMI interface.
> --------------------
> 
> 
>                                    ┌────────────────────────┐                                               
>                                    │                        │                                               
>   ┌──────────────────────┐         │     SHARED MEMORY      │            ┌──────────────────────────┐       
>   │     Firmware VM      │         │                        │            │         Linux VM         │       
>   │ ┌─────────┐          │         │                        │            │    ┌────────────────┐    │       
>   │ │ Drivers │ ┌──────┐ │         │                        │            │    │   PCIE Qcom    │    │       
>   │ │ PCIE PHY◄─┤      │ │         │   ┌────────────────┐   │            │    │    driver      │    │       
>   │ │         │ │ SCMI │ │         │   │                │   │            │    │                │    │       
>   │ │PCIE CTL │ │      │ ├─────────┼───►    PCIE        ◄───┼─────┐      │    └──┬──────────▲──┘    │       
>   │ │         ├─►Server│ │         │   │    SHMEM       │   │     │      │       │          │       │       
>   │ │Clk, Vreg│ │      │ │         │   │                │   │     │      │    ┌──▼──────────┴──┐    │       
>   │ │GPIO,GDSC│ └─▲──┬─┘ │         │   └────────────────┘   │     └──────┼────┤PCIE SCMI Inst  │    │       
>   │ └─────────┘   │  │   │         │                        │            │    └──▲──────────┬──┘    │       
>   │               │  │   │         │                        │            │       │          │       │       
>   └───────────────┼──┼───┘         │                        │            └───────┼──────────┼───────┘       
>                   │  │             │                        │                    │          │               
>                   │  │             └────────────────────────┘                    │          │               
>                   │  │                                                           │          │               
>                   │  │                                                           │          │               
>                   │  │                                                           │          │               
>                   │  │                                                           │IRQ       │HVC            
>               IRQ │  │HVC                                                        │          │               
>                   │  │                                                           │          │               
>                   │  │                                                           │          │               
>                   │  │                                                           │          │               
> ┌─────────────────┴──▼───────────────────────────────────────────────────────────┴──────────▼──────────────┐
> │                                                                                                          │
> │                                                                                                          │
> │                                      HYPERVISOR                                                          │
> │                                                                                                          │
> │                                                                                                          │
> │                                                                                                          │
> └──────────────────────────────────────────────────────────────────────────────────────────────────────────┘
>                                                                                                             
>   ┌─────────────┐    ┌─────────────┐  ┌──────────┐   ┌───────────┐   ┌─────────────┐  ┌────────────┐        
>   │             │    │             │  │          │   │           │   │  PCIE       │  │   PCIE     │        
>   │   CLOCK     │    │   REGULATOR │  │   GPIO   │   │   GDSC    │   │  PHY        │  │ controller │        
>   └─────────────┘    └─────────────┘  └──────────┘   └───────────┘   └─────────────┘  └────────────┘        
>                                                                                                             

Thanks a lot for working on this Mayank! This version looks good to me. I've
left some comments, nothing alarming though.

But I do want to hold up this series until we finalize the SCMI based design.

- Mani

> ----------
> Changes in V3:
> - Drop usage of PCIE host generic driver usage, and splitting of MSI functionality
> - Modified existing pcie-qcom.c driver to add support for getting ECAM compliant and firmware managed
> PCIe root complex functionality
> Link to v2: https://lore.kernel.org/linux-arm-kernel/925d1eca-975f-4eec-bdf8-ca07a892361a@quicinc.com/T/
> 
> Changes in V2:
> - Drop new PCIe Qcom ECAM driver, and use existing PCIe designware based MSI functionality
> - Add power domain based functionality within existing ECAM driver
> Link to v1: https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@quicinc.com/T/                                                                                                      
> 
> Tested:
> - Validated NVME functionality with PCIe0 on SA8255P-RIDE platform
> 
> Mayank Rana (3):
>   PCI: dwc: Export dwc MSI controller related APIs
>   PCI: qcom: Add firmware managed ECAM compliant PCIe root complex
>     functionality
>   dt-bindings: PCI: qcom,pcie-sa8255p: Document ECAM compliant PCIe root
>     complex
> 
>  .../devicetree/bindings/pci/qcom,pcie-sa8255p.yaml | 100 +++++++++++++++++++++
>  drivers/pci/controller/dwc/Kconfig                 |   1 +
>  drivers/pci/controller/dwc/pcie-designware-host.c  |  38 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h       |  14 +++
>  drivers/pci/controller/dwc/pcie-qcom.c             |  69 ++++++++++++--
>  5 files changed, 199 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
> 
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

