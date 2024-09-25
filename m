Return-Path: <linux-pci+bounces-13506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BF1985543
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 10:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77891F23F3A
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 08:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BECE15A864;
	Wed, 25 Sep 2024 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcA53Ysv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB592148849;
	Wed, 25 Sep 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727252087; cv=none; b=HJX/lYDyAzdicN6SM92lRSmKGFb9pRtK10mQS3qCq+YL86eWnRbtlzWo3eZgzrLfrcEyK06546O7yfJLm5DSk73VMOysgft589gT77QzlfvNtos+eEA8nMHb+bjwL7OhATzj2mmKdOjyOS7pURUew/UE/CBsMLEMWBDa/Rp7daw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727252087; c=relaxed/simple;
	bh=FgyJaMf+udJs61Oebn2XB8BHj/lhCR104SBb9JsLSw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJ4qMqkVx1c0xwhj2y0Rj/0CGg9GhKHydXvSp8QXu/S+8+zLF4jzPWepuC8UBh9sI7rBYxnsjBIu5sHUJXhyb4Ju/gAEqwtwI1Tk2GfFsfkwIL30bqPH3twmVLfgpI2j6iTG8OH5lNciYnWN+6W0fJrin6O4yt3GO3OpnM3xHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcA53Ysv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582D6C4CEC3;
	Wed, 25 Sep 2024 08:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727252087;
	bh=FgyJaMf+udJs61Oebn2XB8BHj/lhCR104SBb9JsLSw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AcA53YsvfCo9m8w9ji1QV5Lmm/Lc2HRphqg6nANVhqdPaXhQiPRvtW3/dPWgkJJMz
	 pSwsRBsnUVNZa1WJAipdt4wOvzp9Q7kDQBZFEv4V2Vhixj+7JFciU/hwLsHyR78r/a
	 hxmjzst/RVjP4yxB9m8XlfR8SOoEDMVXWh1P30zY5byXK9Ne2QfaL0SslZHH8VRMKc
	 wRcDSIzFzBorneBLhpufk5PoMg8GDM2h2v/StzE/rRaEwJUvGsyGtIi2kQ+e3Ak5Eh
	 FCP4P1pwZJElGNlDGVCYkxumj2DQgMmOcYWyORnqRkxiinZlJFy08rtk2USCXlYw3O
	 KawhRLRM0g8Xw==
Received: from johan by theta with local (Exim 4.98)
	(envelope-from <johan@kernel.org>)
	id 1stNAZ-000000000c9-3ZrB;
	Wed, 25 Sep 2024 10:14:43 +0200
Date: Wed, 25 Sep 2024 10:14:43 +0200
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
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 3/6] phy: qcom: qmp: Add phy register and clk setting
 for x1e80100 PCIe3
Message-ID: <ZvPGc_pPkUfLp6hi@hovoldconsulting.com>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-4-quic_qianyu@quicinc.com>
 <ZvLXjdpBpUS3lLn-@hovoldconsulting.com>
 <3d4a8243-5c2f-41c4-85ce-6e072331f4f3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d4a8243-5c2f-41c4-85ce-6e072331f4f3@quicinc.com>

On Wed, Sep 25, 2024 at 11:38:46AM +0800, Qiang Yu wrote:
> 
> On 9/24/2024 11:15 PM, Johan Hovold wrote:
> > On Tue, Sep 24, 2024 at 03:14:41AM -0700, Qiang Yu wrote:
> > > Currently driver supports only x4 lane based functionality using tx/rx and
> > > tx2/rx2 pair of register sets. To support 8 lane functionality with PCIe3,
> > > PCIe3 related QMP PHY provides additional programming which are available
> > > as txz and rxz based register set. Hence adds txz and rxz based registers
> > > usage and programming sequences.
> > > Phy register setting for txz and rxz will
> > > be applied to all 8 lanes. Some lanes may have different settings on
> > > several registers than txz/rxz, these registers should be programmed after
> > > txz/rxz programming sequences completing.

> > Please expand and clarify what you mean by this.

> PCIe3 supports 8 lanes, so in general, we have to program 8 pairs tx/rx
> registers. However, most of tx/rx registers of different lanes have
> same settings, so the configuration for all 8 lanes tx/rx registers is
> a little repetitive.
> 
> Hence, txz/rxz registers are included. The values programmed into txz/rxz
> registers by software will be "broadcasted" to all 8 lanes by hardware.
> Some lanes may have different settings on several registers than txz/rxz.
> In order to ensure the different values take effect, they need to be
> programmed after txz/rxz programming sequences completing.

Thanks for clarifying. This is how I interpreted it, but please include
(some or all of of) what you just wrote to make this more clear in the
commit message.

Johan

