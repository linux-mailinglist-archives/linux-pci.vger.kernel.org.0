Return-Path: <linux-pci+bounces-14860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEC69A40AC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 16:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE9A281115
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D1B1DFD9B;
	Fri, 18 Oct 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uem0mUIV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9471D9A41;
	Fri, 18 Oct 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260389; cv=none; b=AIMMNWsDFsP9f+YitjnF7c+rWbO0kuB1jnqFdfxJ+YM0hk9TdBN3dzcsoC1lWAhr4UmbHn8CZmGynn0yZRlPWzOMtHdgKvr3Gyx3k+gYwRhYYbUXlwnBZl3k3sO973H0267gpnfNEPr1sjTRgkTcbKE6kFojo2hpiOCJISKbmSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260389; c=relaxed/simple;
	bh=Mj/iyexBxfRCuYiXVkHqPW+rtTdpj3ONOaTfeF67GFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYa8CDIa28KJ2Vp2FRAyh53ORE7hhj/uem5+Tevi5ah4Eh+pAzvM+5ScaFRchwoT4LWZ0HTyLPOJOEudjgUsVvlnj0GdxICOeMMVTRrpE3JnkIm4mT+dnDAXQ3T/bzrH4lxlPaXkz0xGGuJYOXd8+fYz/30FUH3vP5qzIGQpqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uem0mUIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A22C4CED8;
	Fri, 18 Oct 2024 14:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729260388;
	bh=Mj/iyexBxfRCuYiXVkHqPW+rtTdpj3ONOaTfeF67GFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uem0mUIV9hqy8k5GJ0b1jautXF5iivKVCytpLXjKVdhgdRubFgE9dzSnTDs1EqrPO
	 GFxkDurBDxlLefU2zdEuklxFegbnjyUgb8KUUt6asrNZgZZ2MKr+WQ9xG2G5lDY7cs
	 KeV/c+8V9/tajfRmQuBg9jTekO/WX774JKiH9E8UUO/MDzRzEg7t1EJTBFxhSxks+z
	 rOCEOcm8msrF9nt5XrnOwB4Tl0ooAeDHoTWI8ZpTydWGGSJj/2Aki8cAfrXPRGcbY3
	 aOsKMF+1a+m6BDNrmPaHxt+xy7zKrcG9jRSH9+U+3WWi9UMkpGNrOy6ts+ljVVqF0M
	 vuQatNbbK1fKQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t1ncI-000000007Hw-00MJ;
	Fri, 18 Oct 2024 16:06:10 +0200
Date: Fri, 18 Oct 2024 16:06:09 +0200
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
	johan+linaro@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 6/7] PCI: qcom: Disable ASPM L0s and remove BDF2SID
 mapping config for X1E80100 SoC
Message-ID: <ZxJrUQDGMDw3wI3Q@hovoldconsulting.com>
References: <20241017030412.265000-1-quic_qianyu@quicinc.com>
 <20241017030412.265000-7-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017030412.265000-7-quic_qianyu@quicinc.com>

Please use a more concise subject (e.g. try to stay within 72 chars)
than:

	PCI: qcom: Disable ASPM L0s and remove BDF2SID mapping config for X1E80100 SoC

Here you could drop "SoC", maybe "ASPM" and "config" for example.

On Wed, Oct 16, 2024 at 08:04:11PM -0700, Qiang Yu wrote:
> Currently, the cfg_1_9_0 which is being used for X1E80100 has config_sid
> callback in its ops and doesn't disable ASPM L0s. However, as same as
> SC8280X, PCIe controllers on X1E80100 are connected to SMMUv3, hence don't
> need config_sid() callback and hardware team has recommended to disable
> L0s as it is broken in the controller. Hence reuse cfg_sc8280xp for
> X1E80100.

Since the x1e80100 dtsi, like sc8280xp, do not specify an iommu-map,
that bit is effectively just a cleanup and all this patch does is to
disable L0s.

Please rephrase to make this clear. This will also allow you to make the
Subject even shorter (no need to mention the SID bit in Subject).

Also say something about how L0s is broken so that it is more clear what
the effect of this patch is. On sc8280xp enabling L0s lead to
correctable errors for example.

> Fixes: 6d0c39324c5f ("PCI: qcom: Add X1E80100 PCIe support")
> Cc: stable@vger.kernel.org

Johan

