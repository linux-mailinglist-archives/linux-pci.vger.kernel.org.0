Return-Path: <linux-pci+bounces-40502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58547C3AE9D
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 13:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF621A46238
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 12:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A08932B9BA;
	Thu,  6 Nov 2025 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDLURHzO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA332B9AA;
	Thu,  6 Nov 2025 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432715; cv=none; b=ZCcC6rcRjT+B5EREIE6s7hFyP8rD/uf4tYiyN4yrcsnJsry5BLNfRY7mggJuVJsRgEXqgGo6iu0mWrkhA9Nj31S5jOKXIYqJEgbrFZwcHH3Tv3TsWQwe8gkV/kxEv0w5EuZMabjlSr+IFxCI5LR9TH3pMGASmEslpm1en8BhR2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432715; c=relaxed/simple;
	bh=j7l1faYDgiI5rdvtFtW/C9APjJ+R5Y/cEE6wcGabBnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8465l99quANdNRszOglbn7npXpp8CVNR+5v3Xhj3WNVrBaDGeAgx0Gig/isS9By0w73YIauaqp5Kw8znZ9MVKcSBJ2VWB750f8KjTKxm/lEt2QRKC+u1708JA2KkPmcxlK2JWLK8i7ttffGufAq6UEGCh2F64YaOQUCRRIKBnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDLURHzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FD3C4CEFB;
	Thu,  6 Nov 2025 12:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762432714;
	bh=j7l1faYDgiI5rdvtFtW/C9APjJ+R5Y/cEE6wcGabBnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VDLURHzOR018PiJbhLxzTGW6Qlkzr6lEpYHw3gOT5vbVXx9km5LTaZuntiZvFv1jY
	 yuOe/vedJRPfPQEwt8w33+NZSW5PkCREGsfysQkDRxizm4jHnDtHG0xXRoysjcojR1
	 ff6sDJMFf1VZc3XY8lT57Wy7EnjeMLUIj76UoH7A5rZArpdasX95Txvnoj/geEARHd
	 QBTKvnBlZ1a9N//4/VAhuM4WyUmIZITapljdgaEHcBj1b7xnvgVIKTxyx1dqeC/Lac
	 u8SaFHCexMTFU4pFyAx0bzJtPZGLImKljiiHbTkSNxhcezfozK5DVALtux3JhsjKH2
	 u0HruD9kqyvyw==
Date: Thu, 6 Nov 2025 18:08:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: andersson@kernel.org, robh@kernel.org, 
	manivannan.sadhasivam@linaro.org, krzk@kernel.org, helgaas@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com, 
	conor+dt@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com
Subject: Re: [PATCH] schemas: pci: Document PCIe T_POWER_ON
Message-ID: <7v5bmbke37qy7e5qns7j7sjlcutdu53nbutgfo6tn47qkojxjy@phwcchh5gs5q>
References: <20251106113951.844312-1-krishna.chundru@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106113951.844312-1-krishna.chundru@oss.qualcomm.com>

On Thu, Nov 06, 2025 at 05:09:51PM +0530, Krishna Chaitanya Chundru wrote:
> From PCIe r6, sec 5.5.4 & sec 5.5.5 T POWER_ON is the minimum amount

T_POWER_ON

You should provide reference to the Table 5-11, where T_POWER_ON is described.

> of time

"(in us)"

> that each component must wait in L1.2.Exit after sampling CLKREQ#
> asserted before actively driving the interface to ensure no device is ever
> actively driving into an unpowered component and these values are based on
> the components and AC coupling capacitors used in the connection linking
> the two components.
> 
> Certain controllers may need to program this before enumeration, such
> controllers can use this property to program it.
> 

I'd remove this statement and just mention that this property should be used to
indicate the T_POWER_ON for each Root Port.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

