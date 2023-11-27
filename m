Return-Path: <linux-pci+bounces-187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7567FA801
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 18:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86489281824
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 17:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F093D381DD;
	Mon, 27 Nov 2023 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXI7RxKK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD5726AC3;
	Mon, 27 Nov 2023 17:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F028CC433C7;
	Mon, 27 Nov 2023 17:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701106377;
	bh=BgbaDnMC2tbzXy23qRFkhrncnNLb4XGkV4S41F/p7Yo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=DXI7RxKKeHC0GXYGmZOGMuRiMzmNk9RZRAk9d6TgCRObIqhjmUKxd7gpN9k7M15C6
	 BPzw40RPJFMcJeMtdcbsa0yuQTewyQVevXDa88g95ZwmFlqabn9uk2nkWA26ALdEOz
	 QSrvkAgaJVIHtFw3E1X4kpmAUQMdy+l9Qvui2ArtIPxgcc/6WEv8lRAXbUHD0E2gIc
	 aXRSzPbd+ltAAmFemcwCSxQJsj5kH1BChAxnwpKAta+d3AUMERGy55J6Jl8pdQcyME
	 JF3FG4ZxnUykx2HLRGmqbPeWFlt8V9xyPNUUnt/WN62CPMKOLuo+ercwqq3n4VfIhR
	 vnWXMyo3dhZfQ==
Message-ID: <b711a36c58455deeef5e1caa6669f546.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231124092121.16866-1-krzysztof.kozlowski@linaro.org>
References: <20231124092121.16866-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: correct white-spaces in examples
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 27 Nov 2023 09:32:54 -0800
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2023-11-24 01:21:21)
> Use only one and exactly one space around '=3D' in DTS example.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

