Return-Path: <linux-pci+bounces-8866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 156BE90A800
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 10:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F163B277B2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 08:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B4C4962D;
	Mon, 17 Jun 2024 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klsYUveL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E54256A;
	Mon, 17 Jun 2024 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611233; cv=none; b=OYpNT6cDBH5/fpR0m/w4p2Jgv76Sr7lzkb3FioRHQafrYe5I5lFO/zXMTqe+pFLhF7a/sZqxoypbBgUSijf1DX2j22JqtBnayk8tu2ot0f2EWaZhDSJIfv00btQ3zJ/UmJ0Pdp2EwGLTtDoX+h9vWCFTgt0gDDOfYEQmEPPpB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611233; c=relaxed/simple;
	bh=uV9MpsrDI3F3OJ/6TsLxAXJsBp+2RFNu+1nGc5NktBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYvIlFlM8mhc6T6wZ8jB/HfLS6iYTskjjbtzecQdiSQfU9ubI7b7xDWjKB1ZZIA1kaPbE5Gs6lUlHBBxJ8Oq+MY/3ZebuAIpA54ZS+A4WcjAmXH/HLdy1pJRWOyOJXE7850M3bidLfoYZQZXd7UMvswuaZy1g5PHoTLfeUisAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klsYUveL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79517C2BD10;
	Mon, 17 Jun 2024 08:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718611233;
	bh=uV9MpsrDI3F3OJ/6TsLxAXJsBp+2RFNu+1nGc5NktBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klsYUveLquhL1BuiQ1Vdtl2kLHyzicEazwfIMeCjVQj/GeAGO530gpLmZI8AJCvBa
	 leQ3+LJP79Nw4WMaymPePQkC8ow61VtmUyoXGxs7p5CvcDB71l0+mVLbuR+R9ZGUYU
	 s3OjJXE8c7pziBwME3h8RGltHLf7Rt0iZ2AmRxum4XC8TtA+iKxP6pjRX46c1N9/wY
	 s7V5IP+zBnD20WZjK5/M6n+nt07VdrVLzXZFWTqmxfUjAYStvXxlAbRNAAJ180ckIB
	 QyNlVLlAIxXwXb/Pf3KoZqiTSeSIinEq1jGR6S7aVXRnEIfSYjZgujX0X3swp0I/o3
	 JhVWSj0vO7Erw==
Date: Mon, 17 Jun 2024 10:00:26 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 00/13] PCI: dw-rockchip: Add endpoint mode support
Message-ID: <Zm_tGknJe5Ttj9mC@ryzen.lan>
References: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>

On Fri, Jun 07, 2024 at 01:14:20PM +0200, Niklas Cassel wrote:
> Hello all,
> 
> This series adds PCIe endpoint mode support for the rockchip rk3588 and
> rk3568 SoCs.
> 
> This series is based on: pci/next
> (git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git)
> 
> This series can also be found in git:
> https://github.com/floatious/linux/commits/rockchip-pcie-ep-v5
> 
> Testing done:
> This series has been tested with two rock5b:s, one running in RC mode and
> one running in EP mode. This series has also been tested with an Intel x86
> host and rock5b running in EP mode.

(snip)

Hello PCI maintainers,

If there is anything more I can do to get this picked up, please tell me.


Kind regards,
Niklas

