Return-Path: <linux-pci+bounces-1550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C6981FFE2
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 15:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6F61F21D80
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0601171E;
	Fri, 29 Dec 2023 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3QogoUf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6EC11717;
	Fri, 29 Dec 2023 14:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF6BC433C7;
	Fri, 29 Dec 2023 14:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703858671;
	bh=RS++/zZD9ZVNCSWO024B7JK3uQdHY2c+T89L2z3zj+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3QogoUfFZCzvI/yftP9iQyhZgN8Z5VsKv5pR+rMkj74Ng5Nt+gFzKIGgGXDjfIGk
	 1ml/0SFgVtp5/BAwag704Y2bXXuFk81ZBd9u+n1RDiKHu6pWvue1Mxo86w6qPFEOKR
	 dFOWynnCyjq7o3U2XEBr5j2ijo0Er6XDkPECk2vnHc7BxefqySKJo+ABTTgV0T/1S3
	 HUewrhFdMSvMoAIRLDJbbqsXZgjYnamu/TJY5dI8ZFb1BM97wgssfS4tQXzAgEwiSO
	 lNJPCkjsOBRZfc2E5hphdK3pbVo2cWpN4rO2IrHTvO7lhypl82C/XYtPKxHcUjmiWT
	 h9V3KPX0JZmkg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rJDTL-0000Oa-2L;
	Fri, 29 Dec 2023 15:04:23 +0100
Date: Fri, 29 Dec 2023 15:04:23 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Vinod Koul <vkoul@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: qcom: Reshuffle reset logic in 2_7_0 .init
Message-ID: <ZY7R581pgn3uO6kk@hovoldconsulting.com>
References: <20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org>
 <20231227-topic-8280_pcie-v1-1-095491baf9e4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227-topic-8280_pcie-v1-1-095491baf9e4@linaro.org>

On Wed, Dec 27, 2023 at 11:17:19PM +0100, Konrad Dybcio wrote:
> At least on SC8280XP, if the PCIe reset is asserted, the corresponding
> AUX_CLK will be stuck at 'off'.

No, this path is exercised on every boot without the aux clock ever
being stuck at off. So something is clearly missing in this description.
 
> Assert the reset (which may end up being a NOP if it was previously
> asserted) and de-assert it back *before* turning on the clocks to avoid
> such cases.
> 
> In addition to that, in case the clock bulk enable fails, assert the
> RC reset back, as the hardware is in an unknown state at best.

This is arguably a separate change, and not necessarily one that is
correct either, so should at least go in a separate patch if it should
be done at all.

> Fixes: ed8cc3b1fc84 ("PCI: qcom: Add support for SDM845 PCIe controller")

I think you're being way to liberal with your use of Fixes tags. To
claim that this is a bug, you need to make a more convincing case for
why you think so.

Also note Qualcomm's vendor driver is similarly asserting reset after
enabling the clocks.

That driver does not seem to reset the controller on resume, though, in
case that is relevant for your current experiments.

Johan

