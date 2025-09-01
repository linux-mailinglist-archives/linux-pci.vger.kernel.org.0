Return-Path: <linux-pci+bounces-35268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19720B3E3B4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 14:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3925170FE0
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 12:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AC932C314;
	Mon,  1 Sep 2025 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKVPwZO3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C552B32C307;
	Mon,  1 Sep 2025 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731134; cv=none; b=n1kJT3VNUfqsg0pv2yAQS54g4SDt+Kt5BtPgMuUgzzGUUfwyIBe9QDBmFMJJ73uIcIoSqmOjQCiwIWe0aoLEcR4SDWeRM/J2wDz1seSSkfjaXHQ5ga1p6Hq8S8JKVLCHWDOiAiENr9RTaZBoySGEVHxdhQaGmbQ/qt99LkrgNfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731134; c=relaxed/simple;
	bh=6oykOQVnSFjlaoM30zb7WQOqn4wmhZDz7YN75qgADsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxE1Hn9+K9pEJSstu7/NGdQJPEzxR3xR5jLPcBvIZRg8o2gMkX8PmrDmK59TxhscsqGBj1IldpL9hGppX8j8qsL9gqGkHT3Fpv3pRtxpd4+dOhYCTLqqI2vLdOL+hdgR7HExkU1URgGWXlLYO+opsx47Tt0SgaWfqgrVHp9wPVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKVPwZO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089CFC4CEF0;
	Mon,  1 Sep 2025 12:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756731134;
	bh=6oykOQVnSFjlaoM30zb7WQOqn4wmhZDz7YN75qgADsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKVPwZO3LsI1mp6cA0/p6Vo1rmkTjSLHlW9GYyXM3eMlqGO9wVms93FypuADclP88
	 RB7zurIDv89qgk3glss3z0CLkivJzGtXCAGKUipJrd58sKyz/rEhFQiUy2F4Gd4bC+
	 obytQDZH7BlR5fpNKoDm90FkXv+DyS3WRffyHdTc+/b3pl+RE67i3yj6keg/abserj
	 48xX6EzQWe9N+9UpMjkt7Qupt5+o3/j8/asBqfAiFPwq3XERRxkAWk4mddtdk2rHHd
	 omro3b5Vrn5ySQ9HfCrrc0G1tnTzYinqTsBA8qebGqCWJ6D/J+ACfIOLDcEihP27b3
	 E3BHDR/d6vSeQ==
Date: Mon, 1 Sep 2025 18:22:10 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, kishon@kernel.org,
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v11 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for qcs8300
Message-ID: <aLWW-izvybTo52VN@vaman>
References: <20250826091205.3625138-1-ziyue.zhang@oss.qualcomm.com>
 <20250826091205.3625138-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826091205.3625138-2-ziyue.zhang@oss.qualcomm.com>

On 26-08-25, 17:12, Ziyue Zhang wrote:
> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
> specified in the device tree node. Hence, move the qcs8300 phy
> compatibility entry into the list of PHYs that require six clocks.
> 
> Removed the phy_aux clock from the PCIe PHY binding as it is no longer
> used by any instance.

This does not apply for me

> Fixes: e46e59b77a9e ("dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS8300 QMP PCIe PHY Gen4 x2")

Not sure why is this deemed a fix, also no empty lines here

-- 
~Vinod

