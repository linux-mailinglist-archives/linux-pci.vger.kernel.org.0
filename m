Return-Path: <linux-pci+bounces-22663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534DFA4A3BE
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 21:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E522177A5C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 20:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C8B2517B7;
	Fri, 28 Feb 2025 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGSJVYQe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D75D2517AF;
	Fri, 28 Feb 2025 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773514; cv=none; b=Ohsn/EqeKFuE2v7oEsJ/8+wGf/JYDQ4UBuU3r16cEbl07J1XZ85mOATvMt6+swakWFEXBSZvn6zYhiI51L8tp1gIWTLkj+w1avngtaA39ktUq03tYo35hmlFDML//6qav5zQ8BWQARutuPKNKDHAU7xeizyenCNd2kFKTB1hXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773514; c=relaxed/simple;
	bh=LQsJDstkxtElAiCGOGeiQuO6nIrsIZNsGdbOQX7SOh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwMqBmmnVZ4Uyy0yXjn2Vm2IEuXsAY6TGwJxeDMgC9UpRbaLh6aMrPgGXWRSmzbA+f4MUfHPXbzlWSSmpmgCto8o9xlI4/+uUahe40JWbqV9XULTv9YDcZuQwKc7pOh9ueFAsY261hKwToH9Ipus8T/8w7xCjlRmMiOvhfRVybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGSJVYQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42051C4CED6;
	Fri, 28 Feb 2025 20:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740773514;
	bh=LQsJDstkxtElAiCGOGeiQuO6nIrsIZNsGdbOQX7SOh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DGSJVYQep/MefGALVYWjcRJDSFo/1tqOlYoo7cQ37ROrU4OauDU5cFyZnhLQcljdH
	 HCEVU5JwN4Okst/HU6FZhZRPwviOmTFMNDLVvu/4/zpdbDwwwXoMIWoo79rzVBRyxO
	 TyBI/+o4BaK9IMx/kridDvL+CRzBcTJ72JHXR23+M3po2BJ47guvqDQe4k6KjJ9Y9y
	 YmJvZDfvcogBcU8Vy8uTH0eJE0PrzxS0EODpaUONylhjNY2s0jLoJ8M8w9//mMXZLt
	 Zpn/upccseshhGN4Ch0o4YqNIRM7SGD7kaUqW/P7YNmTWst28V2Qp2hEafneY0k3lj
	 oE15PcY4Rndrg==
Date: Fri, 28 Feb 2025 14:11:52 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, heiko@sntech.de,
	linux-pci@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 01/15] dt-bindings: PCI: dwc: rockchip: Add rk3562
 support
Message-ID: <174077351138.3532182.7064020347463101186.robh@kernel.org>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
 <20250227111913.2344207-2-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227111913.2344207-2-kever.yang@rock-chips.com>


On Thu, 27 Feb 2025 19:18:59 +0800, Kever Yang wrote:
> rk3562 is using the same dwc controller as rk3576.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v3:
> - Rebase the change base on rk3576 pcie patches
> 
> Changes in v2: None
> 
>  .../devicetree/bindings/pci/rockchip-dw-pcie.yaml        | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


