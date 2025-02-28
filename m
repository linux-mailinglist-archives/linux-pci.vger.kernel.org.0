Return-Path: <linux-pci+bounces-22667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4636EA4A491
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 22:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8541702C2
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 21:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33091D14FF;
	Fri, 28 Feb 2025 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twIcFnDO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5701CAA9E;
	Fri, 28 Feb 2025 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777124; cv=none; b=lsTQiIahonn/DMrvY4J9YXpcKn2WPcBVlSafBI6xSlxKBmhVYW9TP108rQJfUIzRF3KtrXPnxsbXqb2qv7vDZocnduK852bVhe3+0k305/Pf4rVntGU43TXiqSnrC/n+yUlnPAun96giFwniTJj0hCq9+MFnvZcQEc08/VWotOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777124; c=relaxed/simple;
	bh=gM7sIw14k30KY0Gu36PcdGRPGiBYjI3pgIvj/9DYrbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g36bZpr0TKVLD3SI53y1rhdbXBTEYAClq8DA4J9+miFy+Tp8ufJvJV4c0Y3lDCbmbat0LKaDAT1ZerAoxHzvlRmcbaLXcclBNl51wN68Yz6T+HlrvcLttAuQgJlfbsCCUM4nACX/HENWrXyKn0/1rNITIizI6j7F85IyZuOcVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twIcFnDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE618C4CED6;
	Fri, 28 Feb 2025 21:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777124;
	bh=gM7sIw14k30KY0Gu36PcdGRPGiBYjI3pgIvj/9DYrbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twIcFnDOgupCjF5q+cifGeZJJH9j5raF2N4rhFNMiA+ppM5PvK9X7IBFMlFOz7x1w
	 QUdbILKTsy0N8J5hQJtSyWSrpaZbuJwc/ZzPbfWuJ6IO+J81NURcXim31nAp7tO5RF
	 O0NITIdFvAfjERuNdi0qd/XxkJx4z7rf1UZOHLdb0Sm086iwbyeGkp86ztRgaarvTq
	 qAEE0F6uKJGTfrP9bLYsugIsyq5J6WK6sFy8tPHix7Em4odZ0f7XQSq4HZqlu+vC4Y
	 aHQDZJhSlYDzGeMvDODPosrUP5FRJ14iRQxfgzuedwPY8YhhUVaWoOYzgGG1TKRWHa
	 p2qEbb+JDdSMA==
Date: Fri, 28 Feb 2025 15:12:02 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 03/23] dt-bindings: PCI: qcom,pcie-sm8250: Add 'global'
 interrupt
Message-ID: <174077712184.3726002.15192773029259333440.robh@kernel.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-3-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-pcie-global-irq-v1-3-2b70a7819d1e@linaro.org>


On Thu, 27 Feb 2025 19:10:45 +0530, Manivannan Sadhasivam wrote:
> 'global' interrupt is used to receive PCIe controller and link specific
> events.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


