Return-Path: <linux-pci+bounces-719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA1980AFA6
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 23:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECD61C20B96
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB73159B67;
	Fri,  8 Dec 2023 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR8r8WfJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A798B1EB24;
	Fri,  8 Dec 2023 22:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F0DC433C8;
	Fri,  8 Dec 2023 22:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702074479;
	bh=GeJ8jPpWnuk5wFJ1Qh8x+xE86n20BfQfexL29S2dxSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jR8r8WfJoWWbjMTcWJMOYjLsiELGL8CtkpmzLE+WMtMYtB9mPJY1Epy1GANz1dAYQ
	 1Y1Y3klNDCiRaiFmfbKu57Ft8qdpsOa8CSXRNi26TFDFp+ShHfCrojvz7+uBXbMsJg
	 h9wnGZIzCGrt/8X0Bl3I9qmMXKuqk3KrkPlkR++VaZ9TDTXSLMd2HwOdBaOb+aBpEx
	 yk4C2Y3keM80kAH/+VImWWG50PKyc3G3bMDXEw05NzaD1UApwIHzeskr0sH5JjzEi9
	 +CSpRoJa8qKnufe1vmDFMmb3AHug/Sds98vopQ5CcuHp9K7i7+t5MjjvQbolzaxg6r
	 ydh+5zZ2PtRZg==
Date: Fri, 8 Dec 2023 16:27:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, Sherry Sun <sherry.sun@nxp.com>,
	hongxing.zhu@nxp.com, lpieralisi@kernel.org, kw@linux.com,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: imx6q-pcie: Add host-wake-gpio property
Message-ID: <20231208222757.GA834524@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208205545.GA2675840-robh@kernel.org>

On Fri, Dec 08, 2023 at 02:55:45PM -0600, Rob Herring wrote:
> ...

> And they should start going into root port nodes rather than the 
> host bridge node because it's the root ports that correspond to slots 
> rather than the host bridge. We've just taken shortcuts because many 
> host bridges only have 1 root port.
> 
> Note that I'm in the middle of splitting pci-bus.yaml into host bridge, 
> PCI-PCI bridge (and RP), and common device schemas.

Hooray!  Thanks for working on that; the conflation of host bridge and
Root Port is a real annoyance.

Bjorn

