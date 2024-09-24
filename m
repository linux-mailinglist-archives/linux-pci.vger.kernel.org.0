Return-Path: <linux-pci+bounces-13440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9CA9847B6
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 16:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DDF28535C
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DA91AAE08;
	Tue, 24 Sep 2024 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0OVsaR5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B43F3FE55;
	Tue, 24 Sep 2024 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188280; cv=none; b=hanQU/G1BgFD225xdRMEUoDKT35GoOpgRmbhAhNYZcKznWJOA9QJDuioDDDtKH8fXLvW8OoEM+W7UF3k6tMQWreHq9+9Y52npp1ptp7X+4haQjaWFSlGG4IiVqlqrKF/xJw+L0RXCuEVsfFAzcU0AuQpGWRfV9DgmfmHgNM0Vss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188280; c=relaxed/simple;
	bh=5aZ5BJkhz9VvfCW7OSzBayQ+gI23u/HVPkIKrLIgxIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCVaG8Aio+cJ48SIh1FzNAIzbqP45ROUsiLaotx+jqDMIeX1S9rvSonY5o7lRYa/4sVHczxIEI/dhx15/B3DlA25AUrR/by/70MlhEcrhs6gdXo6onJ+M5A2GKQom6X23yLsdAWuEKU/leXyoC8554Wnxc1NB1nbNW24NE0MxBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0OVsaR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2211EC4CEC4;
	Tue, 24 Sep 2024 14:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727188280;
	bh=5aZ5BJkhz9VvfCW7OSzBayQ+gI23u/HVPkIKrLIgxIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0OVsaR5W4N0lfWfXwiwXABAxWDDIia45bJhxX9+ShI4rhIR8vL93ZsA3i/Ih4RGU
	 Zc6kBCpN0+QbFP9E4KHVvTKd8dmuaTjIUjkySjBWxWpqW0ePuIa9bd0L2NRV6GuxSW
	 UZzTZqiZOnh2Oq8nutZk5tl2jNKnj0ahiwSw3Jw1KNw+uOAlyPv7eZjHJ2l8BWWKSe
	 g7FtufRGFmYs6shRN8gg/YNBdRvK8lQ9KvZJX5zrUDzEEGd87AUotaVX5PUhqcX4RF
	 RhyMhERHvJU0cDlOsbshSkjYUAg1BFUoRIZFjhvKFByzs7K4BNMjUZjHaDQQoa0pRz
	 MBM2F6w9hyJUQ==
Received: from johan by theta with local (Exim 4.98)
	(envelope-from <johan@kernel.org>)
	id 1st6ZQ-0000000011b-0tHV;
	Tue, 24 Sep 2024 16:31:16 +0200
Date: Tue, 24 Sep 2024 16:31:16 +0200
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
	Mike Tipton <quic_mdtipton@quicinc.com>
Subject: Re: [PATCH v4 4/6] clk: qcom: gcc-x1e80100: Fix halt_check for
 pipediv2 clocks
Message-ID: <ZvLNNDCOy68nK2B5@hovoldconsulting.com>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-5-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924101444.3933828-5-quic_qianyu@quicinc.com>

On Tue, Sep 24, 2024 at 03:14:42AM -0700, Qiang Yu wrote:
> The pipediv2_clk's source from the same mux as pipe clock. So they have
> same limitation, which is that the PHY sequence requires to enable these
> local CBCs before the PHY is actually outputting a clock to them. This
> means the clock won't actually turn on when we vote them. Hence, let's
> skip the halt bit check of the pipediv2_clk, otherwise pipediv2_clk may
> stuck at off state during bootup.
> 
> Suggested-by: Mike Tipton <quic_mdtipton@quicinc.com>
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>

Looks like this one is missing a Fixes and CC stable tag. With that
added:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan

