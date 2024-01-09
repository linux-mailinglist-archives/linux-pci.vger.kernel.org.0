Return-Path: <linux-pci+bounces-1948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A9D828C98
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 19:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FD01F29E36
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 18:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3A13C097;
	Tue,  9 Jan 2024 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk3E2PiB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442F3C463;
	Tue,  9 Jan 2024 18:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2D5C433F1;
	Tue,  9 Jan 2024 18:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704824869;
	bh=2R4M6Lfu/XsHSF+bpume9EhYMFZuUpbn8jz498yVd8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fk3E2PiBjnRlXuUNT3Rc7hTVbhuEhTkEQWZ3oQNozgcaIWiDZiFxT9LI04B0z1mV/
	 WLNLizdbaJnTOH62gZfndpAKFsrCDTpJSHzwlC88Uui6uLNohJb+M3wWVQmXSUX1a7
	 aoBJPsaC6dCic6B0ARGIJ3YCssbZEUXWSH5yedRWoPFL2vNf0u5MPeDvHdgM+y/0m7
	 ioJR7jSwnNEDogrxxS6Ru+0oV5uEop/pLnT0T9okwJEEuDzW5zeR9kLoZSMxeXJ6OB
	 XgfXyDXkf59E8V7Z2huO615hsHo6I08EzTuWkh5hrfx0s3qGbminWqpdPEA0erAa7T
	 iPyNPbikNa8aw==
Received: (nullmailer pid 2905219 invoked by uid 1000);
	Tue, 09 Jan 2024 18:27:25 -0000
Date: Tue, 9 Jan 2024 12:27:25 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: krzysztof.kozlowski@linaro.org, bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org, kw@linux.com, l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v8 11/16] dt-bindings: imx6q-pcie: Add imx95 pcie
 compatible string
Message-ID: <20240109182725.GA2903219-robh@kernel.org>
References: <20240108232145.2116455-1-Frank.Li@nxp.com>
 <20240108232145.2116455-12-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108232145.2116455-12-Frank.Li@nxp.com>

On Mon, Jan 08, 2024 at 06:21:40PM -0500, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
> Add "atu" and "app" to reg-names.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v6 to v7
>     - Added my sign off
>     
>     Change from v5 to v6
>     - move atu and app after config
>     
>     Change from v2 to v3
>     - Remove krzy's ACK tag
>     - Add condition check for imx95, which required more reg-names then old
>     platform, so need Krzy review again,
>     
>     Change from v1 to v2
>     - add Krzy's ACK tag
> 
>  .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  1 +
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>

