Return-Path: <linux-pci+bounces-5939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767CD89DBCF
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FA61F2437A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A59312F5AE;
	Tue,  9 Apr 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwUUnW3o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E97F7D0;
	Tue,  9 Apr 2024 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671822; cv=none; b=vFRqSbkXBkBD4PN680Vw994Lxn+t+gqAJ2tsGzNC4ZUP+nDlSDbH3TCCawCtG4ZeO6jM0C1FhYCo+e4fWrbG1xke2jr7BcOl5GU5cMzDvxm37uwhMcW0Vv4maJAzMtJFOX+RBINkcWy8adNUtmghBvRkpibZw0pVkjHb5qT7wYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671822; c=relaxed/simple;
	bh=RtpKssQ7PYeiAJ3GEdNaHrSqA0HBGDmGov7ORnE8Nc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2owo+sw63GVmRKk1+uVNjQaC/WRUBmUbCqYXPWNvrAqPmLbpuS261hzBROOyCa1g7Qp4wWLxitR5RcVdg3epHw3el8vNJakzfCpRUBlnwk1F38gVgcsTzwQWmrExOjzANBAVLmzHMRdqwarFIOy0G9zJ+TLWIpUYXcooD+Dr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwUUnW3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D895C433F1;
	Tue,  9 Apr 2024 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712671821;
	bh=RtpKssQ7PYeiAJ3GEdNaHrSqA0HBGDmGov7ORnE8Nc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwUUnW3ojXNgYPkYLjqkiICz7zyDcbZlhxHBdBEAjwXXEsy+ZQ4kNm7EjQH+1zCQW
	 AcLTpaLJxI2IZM8w1Yc3sHDJ4QX1iz5hj8/NHuV8/xaZb5z0JYi+apWiZtlUv1XIXe
	 iEYsvDUneoZ7BUeqCknL4aEm0S9QKJiVSYF6/hffwQp+3B00LhI4knFXKp4ScI5MLf
	 wq3gdCZ4+CbUM6NiF7cK/zjKeTHTttMGDjF1gIQV9bdhlZdFCNb85qOregvr1yJsym
	 UbivM4QkWGiljuyBAYHF3ZdqJktEen+xi6PQJVTNjbv8iZ8tZRw2qqMn1TYVV7WTG1
	 lNALSH57MswfA==
Date: Tue, 9 Apr 2024 09:10:19 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rockchip@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: rockchip,rk3399-pcie: add missing
 maxItems to ep-gpios
Message-ID: <171267181723.1101239.8302716507213877317.robh@kernel.org>
References: <20240401100058.15749-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401100058.15749-1-krzysztof.kozlowski@linaro.org>


On Mon, 01 Apr 2024 12:00:58 +0200, Krzysztof Kozlowski wrote:
> Properties with GPIOs should define number of actual GPIOs, so add
> missing maxItems to ep-gpios.  Otherwise multiple GPIOs could be
> provided which is not a true hardware description.
> 
> Fixes: aa222f9311e1 ("dt-bindings: PCI: Convert Rockchip RK3399 PCIe to DT schema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!


