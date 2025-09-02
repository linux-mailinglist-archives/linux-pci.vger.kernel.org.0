Return-Path: <linux-pci+bounces-35302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52664B3F70E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 09:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9D0485045
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710292E719E;
	Tue,  2 Sep 2025 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw/QA4iu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381AE2E62D4;
	Tue,  2 Sep 2025 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799588; cv=none; b=Ke9XHAiQPNXEBVO4bOkbH5OusUPypy7u1mZCvmMJ6DoXKdWiXJNXyH93p8rN/hxOy7Y4ZlC8iaS0Krait5mJTMhLjLQSIEyB89ekzibVmY6p+TfBbHqpetQlX8z5WkZJH4dXfGabppYYOi2Z4VfanVQtxtuP8JESjm3NkH98PtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799588; c=relaxed/simple;
	bh=riQZiJZ4exUI8JW+1R+cAI/RIVX8pPtYIePY0YIjLsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOTwxq/AIgoaV83Jh/o/oXCZbEUTIqlkl8MGZCrGpeFbUY0fCwc1QtVzK+PHh/bVI2BaOgTWFyg9LUUAp0P4SSBoTf1R5toaSx+xheqT7V1J9NVrNDAmSn5qeqaXrUBNIx58tM+Ds8TtOhs5frsCITLOkIZC2wERV7BfjfNsep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw/QA4iu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64829C4CEED;
	Tue,  2 Sep 2025 07:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756799588;
	bh=riQZiJZ4exUI8JW+1R+cAI/RIVX8pPtYIePY0YIjLsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dw/QA4iuLCsV2GfTsBLU+q7zXIGmkBCLfJNQC89MvqZra4FPAbOmsMl6Q7Iz8cwbw
	 4PDHfFYokehXrp8huzoiWiL6X6NJiXL/tCtfpnCERdi2Xic4+ba+JytNJpPcFin6ba
	 hjnW014cTeZC8WsmPlrK5WBpG16uS3T6mEVdQje6SWzma+XO8yszw95Bi1ZPsYRum3
	 F3tKcY5MTYL1DZurIQ6lDBhuSidLFORmn4YzXz99wOfGYwwmiveWWlmlVEYBwgg40M
	 h0V+3lnpTJt+VLmCTB1GvWF3+z3f6SNinTHJ3U63jeOwLF16/YLaJlOXRvX/ibuBwH
	 gjdEiFRUpVF2g==
Date: Tue, 2 Sep 2025 09:53:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bhelgaas@google.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, vkoul@kernel.org, 
	kishon@kernel.org, linus.walleij@linaro.org, p.zabel@pengutronix.de, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-phy@lists.infradead.org, openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 04/10] dt-bindings: pinctrl: aspeed,ast2600-pinctrl:
 Add PCIe RC PERST# group
Message-ID: <20250902-wakeful-sepia-gecko-eeba05@kuoka>
References: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
 <20250901055922.1553550-5-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250901055922.1553550-5-jacky_chou@aspeedtech.com>

On Mon, Sep 01, 2025 at 01:59:16PM +0800, Jacky Chou wrote:
> Add PCIe PERST# group to support for PCIe RC.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml     | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


