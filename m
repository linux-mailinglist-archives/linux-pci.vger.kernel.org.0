Return-Path: <linux-pci+bounces-11986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2710195AFE7
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 10:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EF81C21ACC
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 08:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8BB167265;
	Thu, 22 Aug 2024 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDzgfopQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D62165F11;
	Thu, 22 Aug 2024 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314158; cv=none; b=Wk66eYR5uJqRPmjz33+jimhWdjbsI6pYe1/vOTWBa5liRLTyfF2AUcMlMpyb7MFPW2p+l/IjIR7Z4NMStVrkasmyBm5nhF66ycDUuChXR7prckdoIvHXGQnt/7+XvrhVB+1C1hW+O1Cai6qQmjKGye08K7miL8/4MqUfY0unYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314158; c=relaxed/simple;
	bh=lqPiXovzU04WP0iImiYWLMlNdH5JWKB0cqCqceyTwTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS5+Q/9nyU5FWeQK997I0cvV9qh9lgjCaaDwJZVoGDiXSK9aNoWV1G4HrfBfL/Yp4uSfsUrCN4QoOLZyWxqIhNlV7e98LXJtgIAMhFr3BXX4XKx1YGWVt9x+h+bk19h1OijhSg6ODU15tovIHY/Hfi85s1fXQGiKLYlrIik67nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDzgfopQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B639C4AF0B;
	Thu, 22 Aug 2024 08:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724314158;
	bh=lqPiXovzU04WP0iImiYWLMlNdH5JWKB0cqCqceyTwTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDzgfopQV1bu5vscZ3YDxfTMX75n0XXwoHg6G0BGT0iwCuA+q6F2Ejri8J+zYtW4V
	 WVBeotTbHp0IiE2uyomM2xN3HNj2K6p3wAS27wAr7ljTYl+Z5wAzcz2loQm9ilsl8S
	 /cGgMyvbHGEfcjebZofta5QbI6iJhaEgy1xGt0w5z2zN6P98K8UoxpusGAFJv2hFIC
	 CUvUBRNexbSBnpaWaXWDjZNr0r3AUP+YMeUfPEh9skLZuzEuolnwWw81A/Ylmv0vdE
	 hd2h+wBS/+Yd31+PM/gq97wVo8K8rVLLQxcxiPEtZT+tYPDNmLxm4j02g/5z4WP5cB
	 MIZCjZyF8ehwg==
Date: Thu, 22 Aug 2024 10:09:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: marek.vasut+renesas@gmail.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4M
 compatible
Message-ID: <h5qgiwqxl7dlxulljtzls4eool2xecx64n6sdp6znvnmamdo2e@nbymndt2ffch>
References: <20240822064459.1133748-1-yoshihiro.shimoda.uh@renesas.com>
 <20240822064459.1133748-3-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822064459.1133748-3-yoshihiro.shimoda.uh@renesas.com>

On Thu, Aug 22, 2024 at 03:44:59PM +0900, Yoshihiro Shimoda wrote:
> Document bindings for R-Car V4M (R8A779H0) PCIe endpoint module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


