Return-Path: <linux-pci+bounces-32518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC86B0A041
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 12:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFE5172716
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 10:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4384429B23D;
	Fri, 18 Jul 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf39+wID"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFF1F0992;
	Fri, 18 Jul 2025 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832931; cv=none; b=mX8cWJEu202YsY9/6fiYzi0f+jm/fFk+inJ50gL9NBh5Ucl9UXWi6Lk0EpqHtz9G+kLcHWxOYD0NNN9FHMQK0bASGhwhW+XzB/VdgINyLxfXq9qHusFm5QwjcX14ke2E6lwqwE6jRjv0faqw2rQRIp+izbeYZSkloOJ6q3CZM9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832931; c=relaxed/simple;
	bh=YEshVgIRVJe+FIOG30qXtz98FkUKcdC9CfphVOWVuSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxUOESyKufFU6t3PLkHG57E+5Y/9COd0IXDRVQMZ4WFaPirl6QfUPwr7YDOEb41k8GbnVfFnfW+uDiIDMaNFpg0hlfS6zUJbhBUzh5Htwzh439UGag4FP5ZCFerIr8FbQZIgG035j+AouvBkZXd7Z+3hIONne+/4fdN4N2LkYAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf39+wID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E111C4CEEB;
	Fri, 18 Jul 2025 10:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752832930;
	bh=YEshVgIRVJe+FIOG30qXtz98FkUKcdC9CfphVOWVuSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xf39+wIDVK1OrrUxHmnLa08tKZQKbOEqtKMGVgrb3TjHC9YqGMPRAqqNXtlQfaeDx
	 sx1ohGFwFJ3yf0+xooCXClBpS+W+V+J+DakSfW8mYu7ExRihyfjEyUBD1IfwZ3HQWE
	 In9Tg9NMT5no4VPOV2Iu7MkwBuhowaCSgJH5ZBSOQZxDyNDondyfrX4yLZrq/7SPlz
	 m9lwkwzZewspGNC1M5nxlKZegUDYcUnpqJ+P87Ucopt3D8/hzXMxsvt6vWRhlFjpCD
	 VxHEyuwgqc2zwTFqqPMW4JD9HfrYqNcQw4Blln+V9HYzaQxTw1iBQf0RMS0H+yFhZf
	 DXzLEyPANX4UQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uchuk-000000007sE-1z1R;
	Fri, 18 Jul 2025 12:02:02 +0200
Date: Fri, 18 Jul 2025 12:02:02 +0200
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
Subject: Re: [PATCH v5 3/4] arm64: dts: qcom: sa8775p: remove aux clock from
 pcie phy
Message-ID: <aHobmsHTjyJVUtFj@hovoldconsulting.com>
References: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
 <20250718081718.390790-4-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718081718.390790-4-ziyue.zhang@oss.qualcomm.com>

On Fri, Jul 18, 2025 at 04:17:17PM +0800, Ziyue Zhang wrote:
> gcc_aux_clk is used in PCIe RC and it is not required in pcie phy, in
> pcie phy it should be gcc_phy_aux_clk, so remove gcc_aux_clk and
> replace it with gcc_phy_aux_clk.

Expanding on why this is a correct change would be good since this does
not yet seem to have been fully resolved:

	https://lore.kernel.org/lkml/98088092-1987-41cc-ab70-c9a5d3fdbb41@oss.qualcomm.com/

Looks like you're missing a Fixes tag here too.

> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>

Johan

