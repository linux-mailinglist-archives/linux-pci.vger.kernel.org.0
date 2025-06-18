Return-Path: <linux-pci+bounces-30008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D36ADE370
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 08:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4907189C790
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 06:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C8A1FF5E3;
	Wed, 18 Jun 2025 06:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV1hCvk7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA41FECC3;
	Wed, 18 Jun 2025 06:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750227136; cv=none; b=ch/ltbbc1JSjwHSR+2yAQvhRAdrixDoVUGwb+YHPF0iTBlkOXOzdxQ49SJBW4o8tGEqHUmD7VicdgCFc8AXcEUidSmq225P6+NQXABTEKI1oTaCSPm9M2bjgKtMQjQg5xA7XvbDS3a2xjMr/siTKRDlNZUtxtl54j611vGDBrY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750227136; c=relaxed/simple;
	bh=dCHN8lj1Y5uAAi5KWGc7ILPGlVHAnVA7oxcd4riH7x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU4Xd96s+1FeG5iYN9PS270FUvVkFNy7zOOsSZpECizI0EyP2Oha7x8W1gTn/yfx0Mwo1zfn5ZJhU0e2vSizWypB+SnsWGIhUcLCW+5g55WpyZt0pRfU6hp1xSVf0RsO8Y7aXicgquyJAK5YnV5mD5wouNvyXAE+a19//7E37qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV1hCvk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7640CC4CEE7;
	Wed, 18 Jun 2025 06:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750227135;
	bh=dCHN8lj1Y5uAAi5KWGc7ILPGlVHAnVA7oxcd4riH7x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eV1hCvk7nH8Xeh6rlxuQw/IC0yCVGF9SfPrnkiWQkisK5WWkAMva+qlyZx0y5ReV2
	 QV+sLCjX+dHJzEgFgtX9ch2L0lQBFHpOCyxuE/C1+OB+YV/rmp0QKIXcvp60fWKYiL
	 +wUulNyPMa0mcha8lHZfgW0Acgs+kw2DQKIYaLf+/dhqTeeGP9JdErLijlnLN/vBGq
	 qeXYjmg2xQCXPk1DpwGcR273hz64VPVD5i/FNMnK1Rg9jVjTgzz+8aDcGwZH6rFCNK
	 RUv4vJ/pOJsnbu24xBULLLpNR2Lr8ZQa0B/RIE+AlCTBXgVNc8s6mSMOmQCaD4+FXl
	 mcD9i2tKyn+1A==
Date: Wed, 18 Jun 2025 11:42:11 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, neil.armstrong@linaro.org,
	abel.vesa@linaro.org, kw@linux.com, conor+dt@kernel.org,
	kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v6 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for qcs8300
Message-ID: <aFJYu_RV86GyrkiI@vaman>
References: <20250529035635.4162149-1-quic_ziyuzhan@quicinc.com>
 <20250529035635.4162149-2-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529035635.4162149-2-quic_ziyuzhan@quicinc.com>

On 29-05-25, 11:56, Ziyue Zhang wrote:
> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
> specified in the device tree node. Hence, move the qcs8300 phy
> compatibility entry into the list of PHYs that require six clocks.
> 
> As no compatible need the entry which require seven clocks, delete it.

This fails to apply for me on phy/next, please rebase

-- 
~Vinod

