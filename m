Return-Path: <linux-pci+bounces-35465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D243FB443B5
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 18:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F99A1727D5
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E652D6630;
	Thu,  4 Sep 2025 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRds77gt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA76161302;
	Thu,  4 Sep 2025 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004993; cv=none; b=uU8jWjdhfA7OE28mSAEjYyKfFW9ilmOsqtGlaaatrEMse8z4hIAhMs8UhKd3+nNVMEE+dZZPStwSuWJsQoj46G8pZqSq/aNRz6z3qagE2EM/XF5d0eKQAhqANO3paBNKg92y7lh5/LT5dxk1IqdpbAXexhLc+jc8e93VVs7/ajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004993; c=relaxed/simple;
	bh=ImW7nHIDuggd5SOCEFLJtg//+l9EU7YE2MdTLZBVX0U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CLglbMRCyhiGL9zszxaG9dWReC2hM69HQMj/XgIujTRyaIs0XxxZAFG1mVMmzExYDIBnW8G3Z1jwckl1urctaKyYKsuVVkfHKCFyeT5nieVZxv5GFIeUrl7XZzn00vG3CSNCgCNr5CBBv9vQXagHOnCkoLVQxdf36I879lupfiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRds77gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F2BC4CEF0;
	Thu,  4 Sep 2025 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757004992;
	bh=ImW7nHIDuggd5SOCEFLJtg//+l9EU7YE2MdTLZBVX0U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MRds77gtY9/UIeTs6xJ1na4Y+fEwwHKz8RbrhEw05lVhJg2qjBU4jA/gd/Qt20PoL
	 RQ8373z6Ew8Y8Ec9JEdo8yzm6XYY0LjgG82cnO22GjbgDKIgSoqQkkmhFDtO89odxl
	 ArtVUrFmn3bXv1307ZupGQg9x2VOZWj2DEt6pxhJnIrQFX3KJVoIUtXs7c9kca/frT
	 TqIFEa3XwwHkQem7GIEupiMkUEdS4EvBGTR3Mq0+nlqbcjDi/BY0K/D1FTumqTUprj
	 fFKtAJTPeUSeUVhX0ltlGOIF8y6mkKPG3cq8rynmAq2E0MjQC7rLFu9QxLM+EKKSwd
	 q2vYvZlEY+SZw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, 
 lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
 johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
 neil.armstrong@linaro.org, abel.vesa@linaro.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
 quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
In-Reply-To: <20250904065225.1762793-1-ziyue.zhang@oss.qualcomm.com>
References: <20250904065225.1762793-1-ziyue.zhang@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v6 0/3] Add Equalization Settings for 8.0 GT/s
 and 32.0 GT/s and Add PCIe Lane Equalization Preset Properties for 8.0
 GT/s and 16.0 GT/s
Message-Id: <175700498544.244191.11713819385906991702.b4-ty@kernel.org>
Date: Thu, 04 Sep 2025 22:26:25 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 04 Sep 2025 14:52:22 +0800, Ziyue Zhang wrote:
> This series adds add equalization settings for 8.0 GT/s and 32.0 GT/s,
> and add PCIe lane equalization preset properties for 8.0 GT/s and
> 16.0 GT/s for sa8775p ride platform, which fix AER errors.
> 
> While equalization settings for 16 GT/s have already been set, this
> update adds the required equalization settings for PCIe operating at
> 8.0 GT/s and 32.0 GT/s, including the configuration of shadow registers,
> ensuring optimal performance and stability.
> 
> [...]

Applied, thanks!

[1/3] PCI: qcom: Add equalization settings for 8.0 GT/s and 32.0 GT/s
      commit: 37bf0f4e39de9b53bc6f8d3702b021e2c6b5bae3
[2/3] PCI: qcom: fix macro typo for CURSOR
      commit: ea5fbbc15906abdef174c88cecfec4b2a0c748b9

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


