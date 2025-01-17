Return-Path: <linux-pci+bounces-20031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA53A14A30
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 08:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794C43AAAAF
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1273D1E1C2B;
	Fri, 17 Jan 2025 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvZWLzNV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235E155300;
	Fri, 17 Jan 2025 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737099364; cv=none; b=qSiDblXl2smEgHUOBgIxd/9tZeBN9RzEzshU77wWNxWWxiNWl57oPWXEq6RuLq8lx5tdwvFKORwWQasAgl2QP64d9bt3kpX3mDFrAupoUd0kInM/+9OuBftU5NGzsHvJhiMousdUK/C0pra91e08JXtpc5mLsrDT/QXqgFozbGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737099364; c=relaxed/simple;
	bh=9rLx3+q2I7YhaRy+3wWC+fJ4u9j5KzJ/7HObezKZmEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nshv4DivC9yjeWydhNI3GOa01wrV4Ntt2Cum3rjmxoeuKiIZXxVONNPVx5Yn4OiIxs8Eaquegdf7NllFRuENxU6PZEXWT80pgig8L8SkHdP9Xy5bQ1Yo9CKGSgctjOKLjTGR4DVkevaR7bv6ggWn2U3sxsKP/+xuAknhS8oU5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvZWLzNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C6BC4CEDD;
	Fri, 17 Jan 2025 07:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737099363;
	bh=9rLx3+q2I7YhaRy+3wWC+fJ4u9j5KzJ/7HObezKZmEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nvZWLzNVprCTnh5J+bcC85LIvSzBxCJDK0QtqenJSMSUw1lwJk5o8myPfMLb+xVmt
	 qiTZ6rzKZ3tdrLat4HhHM6dMwO+uFpWQGF2MJsVjs34KuuEWZtzggchLrqZbMs3Wcp
	 stG8PNylJglFFiOeMRqwC65kaSw1jLxm847ni7jQUWWQm9B2+Aap0L3JqGUYyLglws
	 BhzqYn06JfXRkK7wUNx2vdLGMGWDSrmiYQlpPSgqDZeL8dQEeTnzqGsJlBkVZncSzT
	 ZI0nmOX5JW4QVEv95+0l3ekYRfNZPSxUE0PT+qS2YM7ZgmPZx1VEWdnU3lzdNtZF9j
	 pu4NI29O4yoJw==
Date: Fri, 17 Jan 2025 08:36:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	Simon Xue <xxm@rock-chips.com>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: dw: rockchip: Add rk3576 support
Message-ID: <20250117-gray-falcon-of-ampleness-03be68@krzk-bin>
References: <20250117032742.2990779-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250117032742.2990779-1-kever.yang@rock-chips.com>

On Fri, Jan 17, 2025 at 11:27:41AM +0800, Kever Yang wrote:
> rk3576 is using dwc controller, with msi interrupt directly to gic instead
> of to gic its, so
> - no its support is required and the 'msi-map' is not need anymore,
> - a new 'msi' interrupt is needed.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v5:
> - Add constraints per device for interrupt-names due to the interrupt is
> different from rk3588.


Test your patches before sending. This one has obvious syntax errors, so
you really never run a test. That's wasting our time.

Best regards,
Krzysztof


