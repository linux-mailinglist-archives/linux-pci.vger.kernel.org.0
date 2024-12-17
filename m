Return-Path: <linux-pci+bounces-18648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EE39F507B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 17:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F690170DE1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D15C1FBEB5;
	Tue, 17 Dec 2024 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7NQexlbe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E781F76C0;
	Tue, 17 Dec 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451034; cv=none; b=JF/ccnTFtow6DOdjljdWK6vKUxOTslXf2BZayvG3huE9wcdbu/oJ6XgdmfJEag8u0n8EUHS8isdtK+p9SkIhzq1NOAFEiuafHovBETdi9KnRoj7zcORn4xZXVBK3rSmQ0cKA60d5wTPxqgbjni3HeuSxPxvlsm22WrRuyTtvWl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451034; c=relaxed/simple;
	bh=/MmuCsb0Bx/C8hEyi1WpLxVrpg9+UPiKHWpNphU9Wj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rRKN4NNbDIPW9RMl9FPqwlO6gwImoIJIDvvGipJADObnrjaIrcq6Ih1rtsp8lh65tFKIsy49apzhVhybgmBPyU/4iJnRu7EU+2P5OhVqcgNAILnyxzNfhAV26yPhKuZZaX4KKu1aPVD5j3Bdc0ox5sZ746Otj7a7ECGZhhSrmFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7NQexlbe; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHFCWv3017128;
	Tue, 17 Dec 2024 16:56:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	kDmS9Ambq1maXFpKniL040Nqs3Zdh9aLWBYPyXwJm2U=; b=7NQexlbe5zKhhrpU
	N2ofTiGRp+mreCoG4VCHgGu6UaeETr5Bv6hR8B5EXga7t6lsKfxM5hVr/KgHc3OD
	wJGwr2ErWIVvW+zfyiE1NQpCxurX6yV5mxinLY+OVYMCBEyqZ3m91/JOaP6Grg3e
	14GemyeQ+cR0n9qrnV2lfn29TuA1wFw3jMULYMZZBYJBi+zhnYn6Bn8Vyvn+vKL0
	8qavgJkB7Jh7MfgRPut7h1DGnFoMsUXGbBX0Qnu6eJOxZX2nIOoxJ6JhCf7T/iw6
	FmYSwrwyqmSxlIOAGb8TjkFXUMeN+z8TSXoR7FBjNRSGeuWoKJCbPB/nEoOnH3lg
	itsBDg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43kbr683r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 16:56:24 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DB36640050;
	Tue, 17 Dec 2024 16:54:59 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E6BF9276678;
	Tue, 17 Dec 2024 16:53:49 +0100 (CET)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 17 Dec
 2024 16:53:49 +0100
Message-ID: <d976d74c-80c0-4446-bb9b-960a990c552b@foss.st.com>
Date: Tue, 17 Dec 2024 16:53:48 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: PCI: Add STM32MP25 PCIe root complex
 bindings
To: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <bhelgaas@google.com>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <cassel@kernel.org>,
        <quic_schintav@quicinc.com>, <fabrice.gasnier@foss.st.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241205172022.GA3053765@bhelgaas>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <20241205172022.GA3053765@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01


> Makes sense.  What about phys, resets, etc?  I'm pretty sure a PHY
> would be a per-Root Port thing, and some resets and wakeup signals
> also.
> 
> For new drivers, I think we should start adding Root Port stanzas to
> specifically associate those things with the Root Port, e.g.,
> something like this?
> 
>    pcie@48400000 {
>      compatible = "st,stm32mp25-pcie-rc";
> 
>      pcie@0,0 {
>        reg = <0x0000 0 0 0 0>;
>        phys = <&combophy PHY_TYPE_PCIE>;
>        phy-names = "pcie-phy";
>      };
>    };
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml?id=v6.12#n111
> is one binding that does this, others include apple,pcie.yaml,
> brcm,stb-pcie.yaml, hisilicon,kirin-pcie.yaml.
> 

On a second thought, moving the PHY to the root-port part would 
introduce a discrepancy with the pcie_ep binding, whereas the PHY is 
required on the pcie_ep node.

Even for the pcie_rc, the PHY is needed to enable the core_clk to access
the PCIe core registers,

So that would make 2 different required PHY locations for RC and EP:

     pcie_rc: pcie@48400000 {
       compatible = "st,stm32mp25-pcie-rc";

       pcie@0,0 {
         reg = <0x0000 0 0 0 0>;
         phys = <&combophy PHY_TYPE_PCIE>;
         phy-names = "pcie-phy";
       };
     };

     pcie_ep pcie@48400000 {
       compatible = "st,stm32mp25-pcie-ep";
       phys = <&combophy PHY_TYPE_PCIE>;
       phy-names = "pcie-phy";
     };

Simplest seems to keep the PHY required for the pcie core regardless of 
the mode and keep the empty root port to split the design

     pcie_rc: pcie@48400000 {
       compatible = "st,stm32mp25-pcie-rc";
       phys = <&combophy PHY_TYPE_PCIE>;
       phy-names = "pcie-phy";

         pcie@0,0 {
         reg = <0x0000 0 0 0 0>;
       };
     };

     pcie_ep: pcie@48400000 {
       compatible = "st,stm32mp25-pcie-ep";
       phys = <&combophy PHY_TYPE_PCIE>;
       phy-names = "pcie-phy";
     };

But I have no experience with multiple root-port systems, I'm open for 
the best :)

Thanks

Christian

