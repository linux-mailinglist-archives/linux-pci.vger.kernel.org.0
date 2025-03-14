Return-Path: <linux-pci+bounces-23720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 484F7A60B40
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 09:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261DF88195C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 08:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02C71ACEA5;
	Fri, 14 Mar 2025 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhPbW3bA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EEC1957E4;
	Fri, 14 Mar 2025 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940610; cv=none; b=OPtV02PU/lp3G8o+UNFN1IOHxnX5PUtprPElWw8u6vBoXLjRYU/6G46a7unnmxZ05PjNMoALUgpplaZV9cHJK3X0w3kSCa2fyZjucv9a4BpfJD/VDzcyLmIGVNPSGqBOiPQUyrV8lLPpadPGgd8v42G24HATV3VCrcsYOXYGqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940610; c=relaxed/simple;
	bh=p3W9L9eQEmfvgQjAeaqE5U5MwnuqJ84k6yF4D1vFkXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHVga5E+nVJUXdIK5duSk9dUiI4RVOwHIf0YsXnzIMiswo+oplfu0QXyvzmss3BuXdjXvmC4Ll6SuBdUYDbsSrz6cg68i9G2cnMyEYRPdGBdWCqJyWUZePRfUi4AF6ywSWMkLkPLejH6pHi3/qhSeagjxSmntNhDFQ206/+Ern4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhPbW3bA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE41C4CEE3;
	Fri, 14 Mar 2025 08:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741940610;
	bh=p3W9L9eQEmfvgQjAeaqE5U5MwnuqJ84k6yF4D1vFkXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhPbW3bAUHpzxrOImQwFd0W8TpimXhBKo5pT5v3OtF6Xp2xz/W90dFsAtMtvoQHXF
	 51e/M8pYTkrv/ewLRJE+CzckeocmCPiF4zhSjOFYgFFPyrU7kkG7BKH/beQGcgUpU3
	 1R3Uwo+ott49smSNQ+LSySuNNlgAxMw0sPM9J2hpi3q2x/lrFIV6Jowu8KdVid4uE7
	 KgIWffepZPcrIqNi+G5fEgaWJXQ/y7+y652T6QyzPVUu5HFUEUh+IkElgpduSEqTXC
	 svkt4pRWez8JcZQLZTmzXqSEKu80wRIbmN/yjVZIpOk2nXOSOYY0keS+1kta7Or0Nw
	 swnunEAGCFOsw==
Date: Fri, 14 Mar 2025 09:23:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, andersson@kernel.org, 
	bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	lumag@kernel.org, kishon@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	kw@linux.com, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, robh@kernel.org, robimarko@gmail.com, 
	vkoul@kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
Message-ID: <20250314-perfect-free-oarfish-b153be@krzk-bin>
References: <DS7PR19MB8883F2538AA7D047E13C102B9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
 <20250314055644.32705-1-george.moussalem@outlook.com>
 <DS7PR19MB888366F3BFE6262375217FA69DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DS7PR19MB888366F3BFE6262375217FA69DD22@DS7PR19MB8883.namprd19.prod.outlook.com>

On Fri, Mar 14, 2025 at 09:56:43AM +0400, George Moussalem wrote:
> +			msi-map = <0x0 &v2m0 0x0 0xff8>;
> +
> +			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;

Was this tested?

Anyway, your patchset cannot be even applied due to broken threading.

We keep pointing to issues in your toolset since more than a week.
Sending is so trivial that I do not understand why you keep it having
broken:

`b4 send`
or
`git format-patch -v4 --cover-letter -6 && git send-email ./v4-*`

NAK

Best regards,
Krzysztof


