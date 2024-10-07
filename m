Return-Path: <linux-pci+bounces-13933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAC0992451
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 08:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8203B22E53
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC0A74C08;
	Mon,  7 Oct 2024 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDwpo/2r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E73524B4;
	Mon,  7 Oct 2024 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281548; cv=none; b=T14qoO5ElDDpU7g+TZkVzIblDj0WvUUlirVuILrP9haigm20Xj8h6gHqxLcT9Ty9F3h5nOcW9W9Z9n31i2uqCBaR251ZU+VENE9RQDUwbG2RHPqEYVnoTAwdOLqbzWO+5ku9bu+WWCYXOjfD6xZa75109/F6vFKNMcGa0bHTHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281548; c=relaxed/simple;
	bh=xRjPy8I/3kx4TadUZ1+xA+A0H7dMZA3eQSNLYv1Lvxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk4CeyZVeOTFUgzvWrnyki8BoA9vWlbeTTCZhZQwXCrCKquPUrSkh3V92dAL3Ud2JYcLX4a58UnD4SiOZFZ3Cd866e1SviztRzPsFy/MGRhclH58eK0Ftylq5fxCvedsDEoe9hMzAZ9cc+K3KMNOzDxGR17fG0Z048RzVPJyjc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDwpo/2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A45CC4CEC6;
	Mon,  7 Oct 2024 06:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728281548;
	bh=xRjPy8I/3kx4TadUZ1+xA+A0H7dMZA3eQSNLYv1Lvxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDwpo/2rr98M4mzBcVTcplW9KUbfN1xgEd81hblZ6Fb7hcnUqMzCKw6rvgqfyUmjT
	 +sHfTwAcHot7H24gOn6MVEPSSXOtfKdXptf6KQ4yDFcbxGRgwVaaw6RcbDgCBnYMyg
	 +uuROkzQ8uUWEFmT8tRo8mZ15ROs4D5vr4ZzulnugNlbHAHe76CChd/GpYECoDoExz
	 Ov2v7CgPmCUBvd4pOasG7H7l5xbGdO/TdOxw9YAeMFGaX2v6c2FP8hyP5DCLNIoauk
	 QKkPHOSf4aH7QN8p6sAmNbFg9C9P6JxFTtJlUur5oOb38EU6BUCrnWOdYPVmMv9u89
	 nEbkv6g7p8waQ==
Date: Mon, 7 Oct 2024 08:12:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Rick Wertenbroek <rick.wertenbroek@gmail.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 11/12] dt-bindings: pci: rockchip,rk3399-pcie-ep: Add
 ep-gpios property
Message-ID: <o42ki5dwipmldcpnthpfoaltpmu7ffheq627ersrvjj73xkm6x@vkqjomiznstg>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-12-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007041218.157516-12-dlemoal@kernel.org>

On Mon, Oct 07, 2024 at 01:12:17PM +0900, Damien Le Moal wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Describe the `ep-gpios` property which is used to map the PERST# input
> signal for endpoint mode.

Why "ep" for PERST signal? Looks totally unrelated name. There is
already reset-gpios exactly for PERST, so you are duplicating it. Why?

Best regards,
Krzysztof


