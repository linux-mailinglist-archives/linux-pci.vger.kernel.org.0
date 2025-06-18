Return-Path: <linux-pci+bounces-30010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EE2ADE3E9
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 08:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A53189D033
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 06:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A374A211A2A;
	Wed, 18 Jun 2025 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDL7wT/0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7353220C480;
	Wed, 18 Jun 2025 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750228998; cv=none; b=YsFayTfmG7CoDGuWXVT3wfImsuleRA7+s1aJYfW0ShL2AN3/yvgMh2dbbxIiJFbpWI6PfJ5PBIjXykvFQ8QRcsrTT5BnMHIW0mxkDvA4dG5G9hcFzR13D7P6PQ/fZJz9U04eu0rO2f/q4BGMUWI7gVd/Nqil6yy7RFOnl9A15HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750228998; c=relaxed/simple;
	bh=fd+2ts9YZSqCMtTtB+KJGnMfppJyTCgdswl9cDa/m24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET4BI1W0S/2OxowQ02DgznDUdPcgzfp5uMgIaddcAJDQh3loyPoCviTt6YuZhF4DRwzI1OW2jQXmBQ0vYcth94YO8i1bgBTqVrnau9cRgQ/5pW28sbg0KwZQiS0YrX1KgbU8e5GU1r2U/sS+NECkqATsLCzoZHOwbdYYd/tnfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDL7wT/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC384C4CEE7;
	Wed, 18 Jun 2025 06:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750228998;
	bh=fd+2ts9YZSqCMtTtB+KJGnMfppJyTCgdswl9cDa/m24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gDL7wT/0CxbYwfzBUEP+pw7diIEWwhOuEIhAUeQfknVUdSTLNLx01GTqe8zmew6ds
	 AqpS0DmT395GVjVuE2qVIbcKLupHH+KFruP8FnIMVErWIaoZwUOChOwwjhhvkgf1AH
	 PSq7l93fucwtm63T6jTwOEg0wnVCE7FCfX1taLcRnLozhev0fDWQBrHHr+HDBOLdmj
	 Y/bG4xsKFQbYNFwp6bRwIPSciv+HehhabjCfertganPAQmrz/nSZiX+xQFcOc/EYaR
	 Nl/5E1g0Ev90jBl0+Wl6qq1+rNa+woV0tESFZdud1phcMpjYGwfPN8iwf6DCkxt9h9
	 w38qqNl8hakew==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uRmVv-0000000022u-2Juh;
	Wed, 18 Jun 2025 08:43:16 +0200
Date: Wed, 18 Jun 2025 08:43:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, neil.armstrong@linaro.org,
	abel.vesa@linaro.org, kw@linux.com, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_qianyu@quicinc.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v6 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for qcs8300
Message-ID: <aFJgA2NmHzBI4hF_@hovoldconsulting.com>
References: <20250529035635.4162149-1-quic_ziyuzhan@quicinc.com>
 <20250529035635.4162149-2-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529035635.4162149-2-quic_ziyuzhan@quicinc.com>

On Thu, May 29, 2025 at 11:56:30AM +0800, Ziyue Zhang wrote:
> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
> specified in the device tree node. Hence, move the qcs8300 phy
> compatibility entry into the list of PHYs that require six clocks.

Ok, so here you fix also qcs8300, good.
 
> As no compatible need the entry which require seven clocks, delete it.

You still leave the bogus "phy_aux" clock under clock-names, that one
should also be dropped. And you should update clocks maxItems as well.

And please include a Fixes tag pointing out the commits that added this:

Fixes: e46e59b77a9e ("dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS8300 QMP PCIe PHY Gen4 x2")
Fixes: Fixes: fd2d4e4c1986 ("dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe PHY")

Johan

