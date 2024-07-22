Return-Path: <linux-pci+bounces-10626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CA7939726
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 01:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049C61C210B6
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 23:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A0560DCF;
	Mon, 22 Jul 2024 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRCutqOx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2BC4C619;
	Mon, 22 Jul 2024 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721692312; cv=none; b=csRgqyrXLs2HnzoFBfm6tqUk6M209m2PtZ6rTBoIDgCGPwPy/+KX6Z3xjXky0xdxl+63NLqT66RYE7tMZD6z4IVPlkc4ExIXF5mddq+hkhWnebsxmYHuHCjAFsyJBqMaFJtpJ21OpBfrGwAPpZ8ZrsiktCQwYHEtBzj1W8ntFgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721692312; c=relaxed/simple;
	bh=9D7J2ZzdIFRHvR/AWXwjAKbD76gfAx54r5u0TgYCc48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPHBQmTcEmsVOdAddRpTs4N31AJpMzjBdxqAHpQNO8fBtmrYMWcntDzIkBwbqNWnMHGMfSHgsMxeWmNIaJ3LcHBQV9frhNKjpMTgaife3VYolOPtA/8n54n+KJlNheUJtd3vHFD7jo4FUvL2OPQPysaPjI/BFusFHqb6DjIcn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRCutqOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1919BC116B1;
	Mon, 22 Jul 2024 23:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721692312;
	bh=9D7J2ZzdIFRHvR/AWXwjAKbD76gfAx54r5u0TgYCc48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pRCutqOxCCsii4q4vId7SJIVaBI/g3QiZJK/ek8hyz2eiQQHXYwhGmvgJQNUDuBjL
	 G6ss5Q61OiNSl7ddc92VpExYqcpNPznriPuxhHG4wvHn+nLw0WAPzdPZy1tBwclWS7
	 5KKIg7vEXHWcTE5X8zRdvTMs2Rue4u6uocU0t019N94K9n3MElE2M51CeTZO64l9Px
	 oq9YHEvnjG1eRm95e2QEVQt3qgFH7o/o0JNiU2ubJ9MG91evyWeXJbaApns5ytI0sz
	 TbEEEojkWKeOgZ5nHZ8TgPp2HroSZsfxXTPqDoeYum4nND3VP3xJRBkB3Jj9jEbNrK
	 bYFBS70e+Xivg==
Date: Mon, 22 Jul 2024 17:51:44 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 04/14] dt-bindings: PCI: pci-ep: Document
 'linux,pci-domain' property
Message-ID: <20240722235144.GB378287-robh@kernel.org>
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
 <20240715-pci-qcom-hotplug-v1-4-5f3765cc873a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-pci-qcom-hotplug-v1-4-5f3765cc873a@linaro.org>

On Mon, Jul 15, 2024 at 11:03:46PM +0530, Manivannan Sadhasivam wrote:
> 'linux,pci-domain' property provides the PCI domain number for the PCI
> endpoint controllers in a SoC. If this property is not present, then an
> unstable (across boots) unique number will be assigned.
> 
> Devicetrees can specify the domain number based on the actual hardware
> instance of the PCI endpoint controllers in the SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/pci-ep.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

