Return-Path: <linux-pci+bounces-13447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F69298486A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 17:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB601C22772
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F811CFB6;
	Tue, 24 Sep 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTT+d6+a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1172B14012;
	Tue, 24 Sep 2024 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191043; cv=none; b=UK+KIieDXJWfV9kJm0pjI4zWqTZuInntM1sTsQWdVTrGi3Qo9fTPfscEIVOigK+elOqChP4LXd73jRxl373MydZVnfFRGYQ5l5gEWVOt+wnv+YJifT40PRpcNexZwcmCBU7wg/KZsZCQ0B+TA92vn+afOu9l9MkI9V/kFAfokVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191043; c=relaxed/simple;
	bh=K45iTz1RzuouoCG+1FPCQaMpH4ux1cedGX96IMVXfDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Doq+/pFqkt/+9NsmdE2RHWu/RwG6k30JHXSDWvF7DpHulNKHAZMA3RwNdhayIFZZ8BpzLEcGjxficJ6AO8k+xaBM63EQAYA/yXKJR3ST4P9Vx7Sr0n3SsbWpT9n9YzyODdsRCfkMNPAtXOezegySDpAuf1ggeWf9ogJE7FpcsEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTT+d6+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82513C4CEC4;
	Tue, 24 Sep 2024 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727191042;
	bh=K45iTz1RzuouoCG+1FPCQaMpH4ux1cedGX96IMVXfDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pTT+d6+anhV0SAGbGLH6jxitdEhE8CRPa/T3338wYjxKN8j1ZLOwsid9k1oekodLB
	 AbtwjIvLw8xQlWucy9eWzydHLXhj2D3hnzXm1ug2mEz3YIPoRUC6z5ZBDvcdJb6gF7
	 ME+mqSt0evhwN45iTDLGK6oUl/FAHPKrtZqryCTaGikwgRTyMmiMWEaUAd6AZ0Alhb
	 ym5l9EH+nii/homxqmaNf/b2XhRTjEf5qvgz+cjlavZ6fuLOFthyQTvCJiultaiFsE
	 JuYgRYXrar3lpnQrfnFaGmDZ7seDpC3JEVkLGorY7CJsOb7mY9ZNIFRd7jphhYb4UL
	 upOtRWgOUBJhw==
Received: from johan by theta with local (Exim 4.98)
	(envelope-from <johan@kernel.org>)
	id 1st7Hz-0000000028G-0Gw4;
	Tue, 24 Sep 2024 17:17:19 +0200
Date: Tue, 24 Sep 2024 17:17:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 5/6] PCI: qcom: Add support for X1E80100 SoC
Message-ID: <ZvLX_wkh7_y7sjPZ@hovoldconsulting.com>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-6-quic_qianyu@quicinc.com>
 <20240924135021.ybpyoahlpuvedma5@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924135021.ybpyoahlpuvedma5@thinkpad>

On Tue, Sep 24, 2024 at 03:50:21PM +0200, Manivannan Sadhasivam wrote:
> On Tue, Sep 24, 2024 at 03:14:43AM -0700, Qiang Yu wrote:
> > X1E80100 has PCIe ports that support up to Gen4 x8 based on hardware IP
> > version 1.38.0.
> > 
> > Currently the ops_1_9_0 which is being used for X1E80100 has config_sid
> > callback to config BDF to SID table. However, this callback is not
> > required for X1E80100 because it has smmuv3 support and BDF to SID table
> > will be not present.
> > 
> > Hence add support for X1E80100 by introducing a new ops and cfg structures
> > that don't require the config_sid callback. This could be reused by the
> > future platforms based on SMMUv3.
> > 
> 
> Oops... I completely overlooked that you are not adding the SoC support but
> fixing the existing one :( Sorry for suggesting a commit message that changed
> the context.
> 
> For this, you can have something like:
> 
> "PCI: qcom: Fix the ops for X1E80100 SoC
> 
> X1E80100 SoC is based on SMMUv3, hence it doesn't need the BDF2SID mapping
> present in the existing cfg_1_9_0 ops. This is fixed by introducing new ops
> 'ops_1_38_0' and cfg 'cfg_1_38_0' structures. These are exactly same as the
> 1_9_0 ones, but they don't have the 'config_sid()' callback that handles the
> BDF2SID mapping in the hardware. These new structures could also be used by the
> future SoCs making use of SMMUv3."

Don't we need something like this for sc8280xp and other platforms using
SMMUv3 as well?

Johan

