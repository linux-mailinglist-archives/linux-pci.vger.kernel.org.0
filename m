Return-Path: <linux-pci+bounces-13066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEDD976103
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 08:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8231C22DF7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 06:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69EF188931;
	Thu, 12 Sep 2024 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR+X1+RV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9953254765;
	Thu, 12 Sep 2024 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726121321; cv=none; b=hc801QCSz2HZbQ2DVn9RV8xqNgdfdJNCOGad/FEwUIqUpCs3MMtOd1yc7JLp4zb7lkChbpwUs7jyqN/hzHqK2HPQlGagdjR45ng8/bs1YDo25pPx8/EwDQ5zshg8Ex51OkemJFNzvPUVURp1wAaGykA8AAVjfdLo9Qj3jTxKeuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726121321; c=relaxed/simple;
	bh=CY+w8MGLCF1lNDY9i5VuksfT3MLxRmKIvyYXHo83aqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ublZwImcLi+HYrBigZVLmP5lrk7vdneZSthXB+lnOGXIkkQT87KcIrU2p2cb9GehQF2cnyNx+mwMfu48RgRw0jwZVgJ89gW1W7FKS6ON2qL8eB3BR5PcK9NAgMEfvBguMP511Q37fNzAdaCZqz7lGcDGQFCyxnV+ak5pfXnZSPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR+X1+RV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1913AC4CEC6;
	Thu, 12 Sep 2024 06:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726121321;
	bh=CY+w8MGLCF1lNDY9i5VuksfT3MLxRmKIvyYXHo83aqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bR+X1+RVqQQ2F2cyE8P03ue21ERSFfflNLx1E8Zo8/RZMs+aifnS5jUOcqrGsi3tK
	 ko2onP43JX4lTJnb81zWYR3IYJaAV07azvxb0T/Lw68GjLetFlPG+C/tpzcp2R8QAr
	 k8hqPsNcImUIu4+yXpFxcD6pXXx7LroBvtMgKlvl+rJEQX4W6KvdaMXxdSZsxBrRqB
	 PODjFDAitdH1sop5wNHQYXwHA50vFoWAMGIZZcjaOthAwwUICaTDy6BNXudRhsInt8
	 OYdu+FOMoBjSueXdNxuQY2FEfKz9ndERcaXUugvBfK5QtAxXuMNC7f00hLMGJdV0j0
	 lvi4sGzYbCDSw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sod0l-000000004gw-0JHU;
	Thu, 12 Sep 2024 08:08:59 +0200
Date: Thu, 12 Sep 2024 08:08:59 +0200
From: Johan Hovold <johan@kernel.org>
To: manivannan.sadhasivam@linaro.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, abel.vesa@linaro.org,
	johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 3/4] PCI: qcom: Add equalization settings for 16.0 GT/s
Message-ID: <ZuKFe6XvZwQOjBJ8@hovoldconsulting.com>
References: <20240911-pci-qcom-gen4-stability-v7-0-743f5c1fd027@linaro.org>
 <20240911-pci-qcom-gen4-stability-v7-3-743f5c1fd027@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-pci-qcom-gen4-stability-v7-3-743f5c1fd027@linaro.org>

On Wed, Sep 11, 2024 at 08:56:28PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> 
> During high data transmission rates such as 16.0 GT/s, there is an
> increased risk of signal loss due to poor channel quality and interference.
> This can impact receiver's ability to capture signals accurately. Hence,
> signal compensation is achieved through appropriate lane equalization
> settings at both transmitter and receiver. This will result in increased
> PCIe signal strength.
> 
> While at it, let's also modify the pcie-tegra194 driver to make use of the
> common GEN3_EQ_CONTROL_OFF definitions in pcie-designware.h.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> [mani: dropped the code refactoring and minor changes]
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

