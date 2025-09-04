Return-Path: <linux-pci+bounces-35460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4519BB4426D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 18:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEC154E5D61
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4362F3C0C;
	Thu,  4 Sep 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBu3SAFq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4092DD60E;
	Thu,  4 Sep 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002490; cv=none; b=XndrU1cVZGg4wOM40ed6hAlfoT3Vu9kRcnsuFDCB3H1SIv1T63axOxkJDBsQ5TBV5UP4Cb2PxM17IUzPZJZhIHzRW3mVOnhFDDuz+1rTmg7ARZVHdHOnkYIX5jfgHW/J11ZJY+5wsAsI9QKt7Gy9+3oNqwL9nIDvCze9CK89y7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002490; c=relaxed/simple;
	bh=rEMEwwiqX71jcWwIKg4FqSuCHtmTX8Sm6z7xLdJeohA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Qt8/msuHJBRaJDypVVc6X+t2IwpRnHZocrqjHFWHzXBjw6SdsJONQKOPTAZTMGDOZvXOB74TDfZ3AM5EVQ+r26W7ZVXdkzMObBLvuTrwb2x/y+3VCKY+N5w7pewnk2DCLdGhE/MGitUqo9fLC49cnJv76sAHVC4g46JnCzgS3/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBu3SAFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEB2C4CEF0;
	Thu,  4 Sep 2025 16:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757002489;
	bh=rEMEwwiqX71jcWwIKg4FqSuCHtmTX8Sm6z7xLdJeohA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LBu3SAFqqnRZNJy0wmMXB8N1fWO3P+KG8YnKIoLXdFC3rvCnrAnWUIgtr+5j3SYC4
	 h6IiRYnflaajuAfo+q08qeTM6Uncn6B0HOHW8CXSWBKkGPpxQyStX6e+4cCE/4prHk
	 J1iKBglX59vHRPrRkDDha6xlBGtVElxGjz5NP/gigH1i0npkbvCmkOt0olNslkFMo/
	 znCpV9nwhiNc9gF26DVqos5ypl1vczW+F4+n3K/U2iDAwXvMe8Q8lfoBaga5xSQI6B
	 mIfYJTScp3Ws02O/hnB60sEllOvxjlYkccFv/SxBV1ukGPKiTZ1jIdPM/Hrfk0mpC2
	 Itqcji/NBlo4g==
Date: Thu, 4 Sep 2025 11:14:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH v6 1/3] PCI: qcom: Add equalization settings for 8.0 GT/s
 and 32.0 GT/s
Message-ID: <20250904161448.GA1265317@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904065225.1762793-2-ziyue.zhang@oss.qualcomm.com>

On Thu, Sep 04, 2025 at 02:52:23PM +0800, Ziyue Zhang wrote:
> Add lane equalization setting for 8.0 GT/s and 32.0 GT/s to enhance link
> stability and avoid AER Correctable Errors reported on some platforms
> (eg. SA8775P).
>
> 8.0 GT/s, 16.0 GT/s and 32.0 GT/s require the same equalization setting.
> This setting is programmed into a group of shadow registers, which can be
> switched to configure equalization for different speeds by writing 00b,
> 01b and 10b to `RATE_SHADOW_SEL`.
> 
> Hence program equalization registers in a loop using link speed as index,
> so that equalization setting can be programmed for 8.0 GT/s, 16.0 GT/s
> and 32.0 GT/s.
> 
> Fixes: 489f14be0e0a ("arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes")
> 

Drop this blank line.

> Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>

> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c

> +	for (speed = PCIE_SPEED_8_0GT; speed <= pcie_link_speed[pci->max_link_speed]; ++speed) {

Use "speed++" when there's no need for preincrement to follow typical
drivers/pci/ usage.

No need to repost for these.

