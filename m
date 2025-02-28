Return-Path: <linux-pci+bounces-22669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B202A4A49A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 22:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480C01898362
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 21:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C921CB51F;
	Fri, 28 Feb 2025 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxijmUgB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CF01C54B2;
	Fri, 28 Feb 2025 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777171; cv=none; b=uuQy2d8E/wxpXhjW10uCrumD2YFcNt2GWAEJnjPY2YG5imyGXvN9reDlE8Z3WQJd1HJsjlaNZtPgLOEDmJkBRzmykb8e79e9Ms92QVk6YJLfWRTtzTGXfmRMUw4CQO1AB9EXjnqMh4H7vbvXkLgQBg1f4D7/usy8rEQ3IEXTKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777171; c=relaxed/simple;
	bh=xeijTBhtGGm96m/We3ECkgqihRSlfnA+KN5eDuV7GhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nw8Be6y5sL86lHz7aTaZ+icLamAlon1anHjw3LQHlolZHCWnXVMShnNoULoGyzVUfQLkp6WkAt0LaZwKrnwyooUMSw77FMtm1hyK6/9pCNcDAehORe9gWek3JqH8np7+pNQAmvYfJVMyWZB/zOJj5kys8UEq4ByJz9FyEceeYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxijmUgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BF1C4CEE2;
	Fri, 28 Feb 2025 21:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777171;
	bh=xeijTBhtGGm96m/We3ECkgqihRSlfnA+KN5eDuV7GhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxijmUgBEjIwBEc2kGu7GOk9K++dsY455+JjpFs4HgmQrV3iQ8vkseIvICROOrGiV
	 on9botSpfxC8ILAU/h6+92ktFoKtIkoPjcGQSBPMIK+fG+sE+5NGkwEq1ERCJO22xG
	 +rWB7TcPWCdIowNbums1/AxyX9T5CWJrvpOFU9yahLSPyllOSRTdZVceYmt53RDW/U
	 gK93YdtY6IP99WAHWiGBMA7QRaWIbuj6HjXVLBaVu9STqKCDU9zLcLzrEpyaoU8Fed
	 h4Jp5iXeiHdjX2++Jtbes1x0NXcIMo1hlh46o1BXdPyip6UpFSDiJypQpyZbf7GDqT
	 WC2J4qu+TzCYg==
Date: Fri, 28 Feb 2025 15:12:49 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 07/23] dt-bindings: PCI: qcom,pcie-sa8775p: Add 'global'
 interrupt
Message-ID: <174077716888.3727205.10943660493272665365.robh@kernel.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-7-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-pcie-global-irq-v1-7-2b70a7819d1e@linaro.org>


On Thu, 27 Feb 2025 19:10:49 +0530, Manivannan Sadhasivam wrote:
> 'global' interrupt is used to receive PCIe controller and link specific
> events.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


