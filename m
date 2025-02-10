Return-Path: <linux-pci+bounces-21067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43557A2E75A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 10:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AD2167A9C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68571C54BE;
	Mon, 10 Feb 2025 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLGpwxYl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122D1C4A3D;
	Mon, 10 Feb 2025 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739178499; cv=none; b=IBivMbR27Ru8umrQTjnRkDOux3CtOuKagTJ3Yg3pEmxFW7YuZZgthFYQKJ61hQ5CQlYiTyMcnb9S3fx4pQQDWNrn7jv0mDtyUsPtLaD1SPYmkqYcMIvTpppY1mVzD/DGW2ZsLG3gk3heM4V3iJc7ImTWDw+ymFckYEqMIjRJ2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739178499; c=relaxed/simple;
	bh=xzHZVMaf1W1TKFNs3KpAf71ZQa9DAIJ9yzgaWnrymkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4N6jCZB+fqZcJr1wbB6SUVwFj23N4r/P59mBnbZjfnb2Dq4nbIOs5tZ+T0slCu0MpFPiPeXv+QxwG+fvuFf2LQ4y2eA9K53xP0+/T18CdLFIti79Q4PbKZYBfdrbWnI+Pm4EZPfDpO1vtWdtxUTXny6ZwD127nMSiKXNSa4lBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLGpwxYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81ADC4CED1;
	Mon, 10 Feb 2025 09:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739178498;
	bh=xzHZVMaf1W1TKFNs3KpAf71ZQa9DAIJ9yzgaWnrymkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLGpwxYlTc0aHoqbF89ONJXLINmLx9IbGAmNXhE/oe8mJzlfoCJxuYSSFHEB/cWdd
	 lHKCJv1r+SOeRERqKO8spHwsjy8HBHv+Qi9QoQ9LX7OqIbrWV3KWDkU8DpvluMIr/Z
	 WT3xbZTRGYXSGCKHFukLkA4p6FETgwsFpMHyEs+udFoUSBprCFIlRgaQCV+1i6aXT4
	 UEXKyFEoQC64ATpNwEFKDXFPQnMEO2mDbjPCheo70Jvsx9mQ4HK4P/8WL4Fs8QAvTE
	 rj4sE7emwRMtbPu9T48nFhfuyU+41WlnX3LY0Aiz537Y38Er7aFE0HMq33xA7lDQ/A
	 nhMQaWwibdIaA==
Date: Mon, 10 Feb 2025 10:08:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v10 5/7] dt-bindings: PCI: qcom: Document the IPQ5332
 PCIe controller
Message-ID: <20250210-festive-silver-ringtail-a3abda@krzk-bin>
References: <20250206121803.1128216-1-quic_varada@quicinc.com>
 <20250206121803.1128216-6-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250206121803.1128216-6-quic_varada@quicinc.com>

On Thu, Feb 06, 2025 at 05:48:01PM +0530, Varadarajan Narayanan wrote:
> Document the PCIe controller on IPQ5332 platform. IPQ5332 will use IPQ9574
> as the fall back compatible.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v10: Remove unnecessary ipq5332 constraint in 'power domains' not required
>      constraint
>      Fix maxItems for interrupts contstraint of sdm845

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


