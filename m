Return-Path: <linux-pci+bounces-6670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A41DF8B25BE
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 17:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D721F20F0E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BF414C580;
	Thu, 25 Apr 2024 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJUBjZJm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E2D14B08F;
	Thu, 25 Apr 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060538; cv=none; b=FAuHZSJdQwo7LKtOwiK2z7hGgjqxmnCzxHII4A5M8ClNncCh8S6V67lh3R6XxXg4XICL/h04AmLRFZPejajdmQF9b6xJB9fHQFwBTkYmrNS0Pnh0uuQjK2UAx3z/MlGOhbyxGuzyVknyvNxa50682ibPSQMGdczvPENVY/J11L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060538; c=relaxed/simple;
	bh=woh34Zfh+hR5xYcV0RBcFR/VdR4WG15pJy+WqY/T65g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mm0+5Nk85wmCm8yTAiKokgNxMPfWjZSCNESKDKI24CQg1NLr5wDt90QRGFhRmJUk/ZOs/CXrj3C0K9LvYc0fzl+iSBTspiL2BFIo3vbTLFAV960gtekgVpdT4lTI6tUHhErcQlHlxpLjeui6lmVhbzM/oPAMvkLd+krs/aM9yLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJUBjZJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C753C113CC;
	Thu, 25 Apr 2024 15:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714060537;
	bh=woh34Zfh+hR5xYcV0RBcFR/VdR4WG15pJy+WqY/T65g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJUBjZJmQV10nx1Wgg0QbBr6zvJkxRVyF9PNWm4gv0r6XQZ5UNUzgRyhSV0ac/Aeo
	 3PMaKOBEe8YJT78zf53yWbdK927FNknXGm47HEa7WT9JEumUc9T8HzkWtSUjNfKabS
	 DoNR4skzi2bR7IH54O95JCmA3dUBMshw5c20wuUVapUmEI0FwrrFUv1+/AGl69qhUS
	 OGv1Bf1sXRTtwdf98UhFbN503k5JGsKCZdsy9qCZLAHqrKgOnm/Kv9YSeWmL2GG9RT
	 /JyjIIqhTGIH51jCc7fW50x0iz792OF89aphkydMthb+1zPgHNSzsS24Zc+5q0SUTq
	 YWDXsmh4RVtqw==
Date: Thu, 25 Apr 2024 10:55:35 -0500
From: Rob Herring <robh@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	devicetree@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-rockchip@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, Simon Xue <xxm@rock-chips.com>
Subject: Re: [PATCH 02/12] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor
 specific interrupt-names
Message-ID: <171406052389.2613162.7451488705380361367.robh@kernel.org>
References: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
 <20240424-rockchip-pcie-ep-v1-v1-2-b1a02ddad650@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-rockchip-pcie-ep-v1-v1-2-b1a02ddad650@kernel.org>


On Wed, 24 Apr 2024 17:16:20 +0200, Niklas Cassel wrote:
> Considering that some drivers (e.g. pcie-dw-rockchip.c) already use the
> interrupt-names "sys", "pmc", "msg", "err" for the device tree binding in
> Root Complex mode (snps,dw-pcie.yaml), it doesn't make sense that those
> drivers should use different interrupt-names when running in Endpoint mode
> (snps,dw-pcie-ep.yaml).
> 
> Therefore, since "sys", "pmc", "msg", "err" are already defined in
> snps,dw-pcie.yaml, add them also for snps,dw-pcie-ep.yaml.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


