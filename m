Return-Path: <linux-pci+bounces-14861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723BE9A40BC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 16:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854781C25CCA
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CE31DEFE1;
	Fri, 18 Oct 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ld7pIYdK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E293955887;
	Fri, 18 Oct 2024 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260475; cv=none; b=lKaN+HgzLykv1uHzWjs9phLMtr4FjIKRKi0V9U8aiidp9hsaceWmbKTiiehvGdYa9KI/vuJt7zsOorbjS/VntNkpY8Cft5vWi9Ye5UlpvBywMNZG6z5msmlOqXbQCOy+akkvNmhypgxSB7qW8/HbDMeQYLQiq6Gc0klpWr/axPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260475; c=relaxed/simple;
	bh=KoTOyaOYxqjWuJ0H2HvnvhPl7uAzpooAhPcSM0whM7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ41bbXmjZdhTfbc3iNjSHqgGa4/qWSrbP8auKf67FPNMliaUiPajR3OcJeMqatUAiCQvgS1Kc102g72UuUzKFVXXja5jTzpJ0KkLiE5tVIeGLBotpH38AJnfbhzEn4ozwa8VW+TMkXjiivQUUWaufkyCynRTrcxcIHag+S4ImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ld7pIYdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7781FC4CEC3;
	Fri, 18 Oct 2024 14:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729260474;
	bh=KoTOyaOYxqjWuJ0H2HvnvhPl7uAzpooAhPcSM0whM7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ld7pIYdKMKPRjWV5dCBpYxSV70GUzeXMnVBpFMgbmX1x70ojqIf+w3zO3mTZvkTq2
	 7M1vJPWC/ab+LLM7v9U4rQ+nhagTCQpyJLi6nnuZaUDgvZbP7sAfxq6bvPxM6yn2mg
	 +PXzxI931GOA9aNmjYd+WZPNk19vwmQ9S4Eooa/E6HnvDB9/lGPVoOu5p2GDBE2Cg/
	 ZPFVArGMGHKlq/n55XlN3UIYuo301Itzi9Qknbh1WTMw4etkv/O+XZZzBz1IlHWIfO
	 1jTt8viuZ6lPPlHRCu6nhOwfEQBbWgBeOp9Ba65aqriGCnDc/j4iLMYXV2WGO2+bwH
	 v/M6MRvqQWsKg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t1ne8-000000007K1-2QbU;
	Fri, 18 Oct 2024 16:08:04 +0200
Date: Fri, 18 Oct 2024 16:08:04 +0200
From: Johan Hovold <johan@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	johan+linaro@kernel.org
Subject: Re: [PATCH v7 7/7] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
Message-ID: <ZxJrxDLSoQpYNtYC@hovoldconsulting.com>
References: <20241017030412.265000-1-quic_qianyu@quicinc.com>
 <20241017030412.265000-8-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017030412.265000-8-quic_qianyu@quicinc.com>

On Wed, Oct 16, 2024 at 08:04:12PM -0700, Qiang Yu wrote:
> Describe PCIe3 controller and PHY. Also add required system resources like
> regulators, clocks, interrupts and registers configuration for PCIe3.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks good to me now:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

