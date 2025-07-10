Return-Path: <linux-pci+bounces-31840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E2B0054C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 16:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2841C41A31
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 14:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8660D272E4C;
	Thu, 10 Jul 2025 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRzvPLgF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514BA155389;
	Thu, 10 Jul 2025 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157998; cv=none; b=OxFO0MaYdydVmICOH2ZEOAj73C5LTd90lT3dQ/0FNORM4zqd8tUKmwWZjZAPuJbNQ+ILxGCPCUJxfyKzxlkjAQ130WowPRpCeqD98FdJqwMSJ2WGix5baliDaToGXHW+fe7Z9M8THezuQsEu2YwyhM9DnLWVNZQLOynthBmPi8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157998; c=relaxed/simple;
	bh=ELRQc3uwkKFItDCmx75wbbSO3KRM0Y8LMvnQDThCfK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMVu0oC7DOaHxfhByPBeSm43X9x3h+xjXXiB3eOXIDnnaRryTg/Ey9lfPIxBydUaIxFI4Ar87Qaur7TVEdbMp9lzOaU+c+hurcg0U+YPp0RQD6D93Y7hVla/Umu84pKBjAqdlWOwJE3T5G1SZWeRi8WEcDF0stYZyJKxi7whUN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRzvPLgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2253C4CEE3;
	Thu, 10 Jul 2025 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752157996;
	bh=ELRQc3uwkKFItDCmx75wbbSO3KRM0Y8LMvnQDThCfK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRzvPLgFU0NXysFH/E2aHj3HTfCCb9P3xZP0sfcx7EPgn4Hz/B0eeFZ7jn6JcmDBq
	 5GglNdwLqZ4k6kP0dYlj0gjMzW/Za6DQF2S6o9fwIs1XlSiz+i+yzYsZ7rdVXsbPv8
	 CV+TjSLUy3IO459fh5QL3FYqG4DQ6RfjROMk5l0f6+OHKVPRpmQs57uNHdnwUkj8MY
	 4UlIcr9oGr4fBazdJcKl3JAswwk7x5uvrWu1PVFjoxYr1IVqK5cfuiADBoJb+KS0RW
	 Jcrj6NkF0ULgxCjKHsN5xn+SEyAey/cPDI85pFBcTAAqwkd6FHQZHDhcyVEEQlCcEW
	 Id3IwzxsJf5ew==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZsKj-000000005IY-1wLn;
	Thu, 10 Jul 2025 16:33:10 +0200
Date: Thu, 10 Jul 2025 16:33:09 +0200
From: Johan Hovold <johan@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
	kw@linux.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v8 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for QCS615
Message-ID: <aG_PJbA4t0wgz9b2@hovoldconsulting.com>
References: <20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com>
 <20250703095630.669044-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703095630.669044-2-ziyue.zhang@oss.qualcomm.com>

On Thu, Jul 03, 2025 at 02:56:28AM -0700, Ziyue Zhang wrote:
> QCS615 pcie phy only use 5 clocks, which are aux, cfg_ahb, ref,
> ref_gen, pipe. So move "qcom,qcs615-qmp-gen3x1-pcie-phy" compatible
> from 6 clocks' list to 5 clocks' list.
> 
> Fixes: 1e889f2bd837 ("dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS615 QMP PCIe PHY Gen3 x1")
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

