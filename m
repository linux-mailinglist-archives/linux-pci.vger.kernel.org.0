Return-Path: <linux-pci+bounces-13252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D38D197A992
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 01:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7969CB2964D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 23:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2506215DBC1;
	Mon, 16 Sep 2024 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0v5i7vv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE98615A865;
	Mon, 16 Sep 2024 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726529409; cv=none; b=RPJfBCWA/7uFFhRe0oKYbRvz4BGtlh8fVMUEnwBWsCJlXmmFXnsLKZo9+CseOErGOpKBpHu0RaD353pP0KcwtVtKYgCZZYLKWgOtOvEmaitivuAaXepA/3B1W93HYT1dl0jiUmF3PbvCh+tRQ0E3bHvpHjmr2PW+kEXq0bVPd8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726529409; c=relaxed/simple;
	bh=TUkgaZ3dMw+kNGlchye2L7aI6kYBpyeU4zUD7YkdJtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iS5jymCaj4Eg3JEkZ1FN0UlWB1ZxPXIDZ2BuNoKIcNjmZkiGBOVhldTl3ipTNzbWoSSCoiR8JrI1pFBpGyzlfHtGHihZIVoBv5/yM67a5A14/Qh5yGwpdpMIK2ayZUag4uUs8yO33fGIcxBcYq2v6nxxA6zrjrvU+n0n+AuUGbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0v5i7vv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AF5C4CEC4;
	Mon, 16 Sep 2024 23:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726529408;
	bh=TUkgaZ3dMw+kNGlchye2L7aI6kYBpyeU4zUD7YkdJtU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D0v5i7vvo91LOBdRmrIJZ8SGGk0F8srJi5booIvIlkP+lJPrLLUJNMSxaQq7gLPFV
	 a0tih85h5eEEZJhSZI+xRu+vwsnDN6nxX46TWv7QsPRwRAJp+TzBfgIZyJMFS6i0im
	 pO6itBUdzWsY3xHRZBeWlOwev+apInk2Szt2UA1+Lyi6Eq1iI+BqqCjEVqWxRHRaRM
	 3LA5LrkFfos2h3reJ+H92m8kjaqQEhzim3ionprHIly1PeFZedyYnzNGyqTPAZoQgp
	 ns5tfsbd8Q0cVA3dwW3/SFW1Z99LuIzgzpP7f30P39Zxb1xjhjWLGABRxKq9W639my
	 w2HeAmTEE9Oeg==
Message-ID: <c4696a9d-e3f2-4ff5-8323-84f75f2f1a68@kernel.org>
Date: Tue, 17 Sep 2024 01:29:58 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] phy: qcom: qmp: Add phy register and clk setting
 for x1e80100 PCIe3
To: Qiang Yu <quic_qianyu@quicinc.com>, manivannan.sadhasivam@linaro.org,
 vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org,
 quic_msarkar@quicinc.com, quic_devipriy@quicinc.com
Cc: dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
 neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
 <20240913083724.1217691-4-quic_qianyu@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240913083724.1217691-4-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.09.2024 10:37 AM, Qiang Yu wrote:
> Currently driver supports only x4 lane based functionality using tx/rx and
> tx2/rx2 pair of register sets. To support 8 lane functionality with PCIe3,
> PCIe3 related QMP PHY provides additional programming which are available
> as txz and rxz based register set. Hence adds txz and rxz based registers
> usage and programming sequences. Phy register setting for txz and rxz will
> be applied to all 8 lanes. Some lanes may have different settings on
> several registers than txz/rxz, these registers should be programmed after
> txz/rxz programming sequences completing.
> 
> Besides, x1e80100 SoC uses QMP phy with version v6.30 for PCIe Gen4 x8.
> Add the new register offsets in a dedicated header file.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>

Konrad

