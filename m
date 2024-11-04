Return-Path: <linux-pci+bounces-15964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A37979BB79E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 15:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C0B2826A5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB58717B428;
	Mon,  4 Nov 2024 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDkIXJjU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6C714D2B1;
	Mon,  4 Nov 2024 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730263; cv=none; b=bZNrxAsG/DRPdOr56A5q88ymT0w9Av7/xkgPIo9yieQebQmArqo8mdGyPwJXkZrAmRAEdiT7BKccjipM/mXCrxCY9VbBuyqzSkYbZlAVepro7lrGtjIaxW2dXxK20+ewSqH535KzaGg6mh0Prul1gZVN+xpykliDYvTub2DvFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730263; c=relaxed/simple;
	bh=xu/jVyvAFcaTT86i2w/CmQDbYhthYBNARz5ujHg8xP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMV+JrksVruosNouttEFJyzppa+H5m8bibEBd1d1grnWq8Mdf1yKFsWJK5kU1a3vrveVHzdROay/vLmegDsgu1XyadHPHthkpUW24FmMfuNLd8R1Ffj2hK8A7F8ydPZb2JuM4sb/iIrj9AuRSDIq9NQPu+pAUyfC+IyhcYBenSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDkIXJjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033FCC4CED0;
	Mon,  4 Nov 2024 14:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730730263;
	bh=xu/jVyvAFcaTT86i2w/CmQDbYhthYBNARz5ujHg8xP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDkIXJjUqI8v65KuM7S0M3PNEJPSnroUHZ06u2jFVG4lS5fEazbocaYJ4NOqQS0g0
	 7yCtHwOzd1De1r+WB/6AX7+giDketoP1aVZ10dWwC5eBy2u26VQxxaJhY0mTG4w7OF
	 p6HwSLWMwbhdPwzoxZHDeuNz5kP4602+FPHb8lN7RnixdW01ddfYvQY69SvPOiGBZd
	 KH+WXeeX46KbPW8sb4hLI6WnLk3qCmRhuAUkactaqXuIsXDdz/hLFcv3SyEi5IA7GL
	 DjXa8ynJmuEUszLbxL4evzBfakrMG2xgl8O7d/dIdYv6xi3d23GFaaJiyFUS8Irna5
	 9smLFvnEwr3Qg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t7y0B-000000007zq-2QQ4;
	Mon, 04 Nov 2024 15:24:20 +0100
Date: Mon, 4 Nov 2024 15:24:19 +0100
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
Subject: Re: [PATCH v8 3/5] PCI: qcom: Remove BDF2SID mapping config for
 SC8280X family SoC
Message-ID: <ZyjZE-U_7YZhScfG@hovoldconsulting.com>
References: <20241101030902.579789-1-quic_qianyu@quicinc.com>
 <20241101030902.579789-4-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101030902.579789-4-quic_qianyu@quicinc.com>

On Thu, Oct 31, 2024 at 08:09:00PM -0700, Qiang Yu wrote:
> The SC8280XP PCIe devicetree nodes do not specify an 'iommu-map' so the
> config_sid() callback is effectively a no-op. Hence introduce a new ops

Would have been good to say something about why there are no 'iommu-map'
properties on sc8280xp (e.g. since it uses an SMMUv3) as Bjorn
suggested.

> struct, namely ops_1_21_0 which is same as ops_1_9_0 except that it
> doesn't have config_sid() callback to clean it up.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I see that this patch has been picked up now. The above is already much
better and I guess this is good enough for now:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

