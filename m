Return-Path: <linux-pci+bounces-31193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA4AAF00EA
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 18:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90235170B45
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 16:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACCB27E070;
	Tue,  1 Jul 2025 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQQYq7Ah"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF4827E052;
	Tue,  1 Jul 2025 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388780; cv=none; b=Fm90SyVV07YhQT54r53ud51cx7NOYMUJ5O/Z2eVLhzasfEUuC3Fwq54PxNqOHVCL793uj6RfxrvhfOKgZ4PgbPJDLMj2JpcnRLf+ANGXMAOQCfaXl5JfXAmAVe6G+6veEQOxH+j2jtNTp1tcUNxIMQJ9oQchq/c6XQO+qTuzjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388780; c=relaxed/simple;
	bh=rPXpL0fXlhDi6bCw2uhaVToXc3jyQpgytRJQynaVkWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cAlD6s6AXFq3QnhP6EA8+vI8PKKGWAseuMLmaTBFIfcF+jzWnrWGoXdlYnU5+zlTO5SYUbXej8bg6TgAzXjwu89DzcWycq5/Iu3D7R4OflGEKlUSU25PYutv98yEaN6h+eXaVDxKp0mIxRokDwvsLpO/YJChlqZpHST0lxyM8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQQYq7Ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B616C4CEEB;
	Tue,  1 Jul 2025 16:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751388779;
	bh=rPXpL0fXlhDi6bCw2uhaVToXc3jyQpgytRJQynaVkWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bQQYq7AhslDBoztI6jabho5UCBG4e+dk9G6T01dkAKcu8GmWJDFBqRbWTOjaOnh+j
	 0UT1uVTCe9bkDBfTWDN4U2uASJ5ccA5hthNHUhYxFmNd9JeziT5t0FDl1B4kWs/4fD
	 0Yqwq5g/U9Lvcn/mTZ/GFATCDQKiFkw9k4VE2CBwDtdDKrZD7Bq1ZTG2rfM2NrQA1t
	 gMhGa0nV31fGCY+k3U2KQUSoBOA8roQyRHxSOfKvt5Hojyeni7DzepSq+JuryVQS0x
	 Rb81butnTAD/gDcu1ZfHe58y4kQs3DaCdipgUq8UZmBMQC//KdmyR8PWx04RyJi440
	 hhW16oQbItIug==
Date: Tue, 1 Jul 2025 11:52:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mayank Rana <mayank.rana@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, will@kernel.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	andersson@kernel.org, mani@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	quic_ramkri@quicinc.com, quic_shazhuss@quicinc.com,
	quic_msarkar@quicinc.com, quic_nitegupt@quicinc.com
Subject: Re: [PATCH v5 3/4] dt-bindings: PCI: qcom,pcie-sa8255p: Document
 ECAM compliant PCIe root complex
Message-ID: <20250701165257.GA1839070@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616224259.3549811-4-mayank.rana@oss.qualcomm.com>

On Mon, Jun 16, 2025 at 03:42:58PM -0700, Mayank Rana wrote:
> Document the required configuration to enable the PCIe root complex on
> SA8255p, which is managed by firmware using power-domain based handling
> and configured as ECAM compliant.

> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pci@1c00000 {
> +           compatible = "qcom,pcie-sa8255p";
> +           reg = <0x4 0x00000000 0 0x10000000>;
> +           device_type = "pci";
> +           #address-cells = <3>;
> +           #size-cells = <2>;
> +           ranges = <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>,
> +                    <0x43000000 0x4 0x10100000 0x4 0x10100000 0x0 0x40000000>;
> +           bus-range = <0x00 0xff>;
> +           dma-coherent;
> +           linux,pci-domain = <0>;
> ...

> +           pcie@0 {
> +                   device_type = "pci";
> +                   reg = <0x0 0x0 0x0 0x0 0x0>;
> +                   bus-range = <0x01 0xff>;

This is a Root Port, right?  Why do we need bus-range here?  I assume
that even without this, the PCI core can detect and manage the bus
range using PCI_SECONDARY_BUS and PCI_SUBORDINATE_BUS.

> +                   #address-cells = <3>;
> +                   #size-cells = <2>;
> +                   ranges;
> +            };
> +        };
> +    };
> -- 
> 2.25.1
> 

