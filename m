Return-Path: <linux-pci+bounces-33356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1332B19F88
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 12:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC4417805F
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB36C248F64;
	Mon,  4 Aug 2025 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itflykcG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C7191F92;
	Mon,  4 Aug 2025 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302516; cv=none; b=KCFpgTbjxV3t4+m9TGRKZYQkiwlRLhtA69Uue2eRmdHFVczsE7wH3dm5qPWowX1t2VY/LQuQHZlN1lG3wUC4CZ44ZQFIduZK0R6puJDeu15RjuAH4DPR3eiX4LfWgIjRpyu6stPo4nnvef3F2shwKmFDiC7LSXexIZzT+OCEd/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302516; c=relaxed/simple;
	bh=5GXyI5WQgYW0XNhorvAF6Ny+suzgD9hCJ5O0rd419ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnIRQ/DnXs2snHUShCEiSvFUlZZr0W8h7As1cHleLC2JDSDTpNW7LD7jE91nH2uIwcattoZQ6iuesj5ZhRDYoByQaMK08v5I7ukMx1pjuBHtzVDvDYBImKfGtfviuAW9GYOG7bI0GI8a8wV0MozC33n+NvS7vRercqRFHrBjMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itflykcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90028C4CEE7;
	Mon,  4 Aug 2025 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754302516;
	bh=5GXyI5WQgYW0XNhorvAF6Ny+suzgD9hCJ5O0rd419ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=itflykcG9xdsYbAzgpu/vyg/3CjW/R5SlpYTE3nXfBZ4Ds3vS6KLWn7ZV8724FkzC
	 R/BDbmArCbW6MaI2mLtCu0uywnK00/dEjie2ns9xx/o/XAbSLbwohwgopn2eLhf1zn
	 9BvhTlYKpXvkxsgsyhHjr3yMNjAp2bdDvUsex44a/m87f6ZjL7K63bnLzQhHOThTBN
	 jhZehDmW762t96uonQ4kwzyJiAoZopa/QU31WLrz6zdo9fF4i5Ck4Uiesch6aFNKKj
	 phs08UQ0MtHQE0m0qPilqX8Fx6NdrJPx9IidaCwOTbas/IeZnMvicO+uzMMvWqCFox
	 fY9vki8dGwqgQ==
Date: Mon, 4 Aug 2025 15:45:05 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, 
	sherry.sun@nxp.com, linux-pm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/3] PCI: Add support for PCIe WAKE# interrupt
Message-ID: <b6b4tzs73n63d565k52pqbep4bqhctibjv5gzm2wenbf2ji45b@npgoqscnbbpn>
References: <20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com>

On Fri, Aug 01, 2025 at 04:29:41PM GMT, Krishna Chaitanya Chundru wrote:
> PCIe WAKE# interrupt is needed for bringing back PCIe device state from
> D3cold to D0.
> 
> This is pending from long time, there was two attempts done previously to
> add WAKE# support[1], [2]. Those series tried to add support for legacy
> interrupts along with WAKE#. Legacy interrupts are already available in
> the latest kernel and we can ignore them. For the wake IRQ the series is
> trying to use interrupts property define in the device tree.
> 
> This series is using gpio property instead of interrupts, from
> gpio desc driver will allocate the dedicate IRQ.
> 
> According to the PCIe specification 6, sec 5.3.3.2, there are two defined
> wakeup mechanisms: Beacon and WAKE# for the Link wakeup mechanisms to
> provide a means of signaling the platform to re-establish power and
> reference clocks to the components within its domain. Adding WAKE#
> support in PCI framework.
> 
> According to the PCIe specification, multiple WAKE# signals can exist in a
> system. In configurations involving a PCIe switch, each downstream port
> (DSP) of the switch may be connected to a separate WAKE# line, allowing
> each endpoint to signal WAKE# independently. To support this, the WAKE#
> should be described in the device tree node of the upstream bridge to which
> the endpoint is connected. For example, in a switch-based topology, the
> WAKE# GPIO can be defined in the DSP of the switch. In a direct connection
> scenario, the WAKE# can be defined in the root port. If all endpoints share
> a single WAKE# line, the GPIO should be defined in the root port.
> 

I think you should stop saying 'endpoint' here and switch to 'slot' as that's
the terminology the PCIe spec uses while defining WAKE#.

> During endpoint probe, the driver searches for the WAKE# in its immediate
> upstream bridge. If not found, it continues walking up the hierarchy until
> it either finds a WAKE# or reaches the root port. Once found, the driver
> registers the wake IRQ in shared mode, as the WAKE# may be shared among
> multiple endpoints.
> 

I don't think we should walk the hierarchy all the way up to RP. If the slot
supports WAKE#, it should be defined in the immediate bridge node of the
endpoint (as DT uses bridge node to described the slot). Otherwise, if the slot
doesn't use WAKE#, walking up till RP may falsely assign wake IRQ to the
endpoint.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

