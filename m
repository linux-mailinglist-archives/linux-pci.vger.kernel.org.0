Return-Path: <linux-pci+bounces-6427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4B08A9ABF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 15:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3F81C21A5B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 13:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1731649D1;
	Thu, 18 Apr 2024 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5M0Sa66"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AFA1442E3;
	Thu, 18 Apr 2024 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445210; cv=none; b=kkJznhcrI83mEdCrCSUJC49UMl3SO/mg8+zKoKgvEJtJXYyd2kcW1P/sephszdjLKPSf0ysguGsgNjVoAZuJGA4YkEmrYLeCfwDfmGwoHdCSYZGd7lnGFsWUdIKeWafNprsjnDyjXNlbyYSBtxd6qdf2EVYIwSc0VJ26yXg5dXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445210; c=relaxed/simple;
	bh=vm4bIQBAxi4Xoz63tgQyruT6TXicEBFDFLnbQKnXuB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHjHeNE8JELTsFmaCL7m8zLSENQijE5x1SFqqDdIe/0PcifQs3/s/H62/TZZ6Hy0lHXs7zff8Qgyn+sTUc8DCsaq1liuOGzNKwNCoUsv1LuXxWxHSBNp13kCOH5RxvD6oQ7otm4XNyX8UzTD/gKjVPCDyu6rbKH22YSYy+L2zt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5M0Sa66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8061EC113CC;
	Thu, 18 Apr 2024 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713445209;
	bh=vm4bIQBAxi4Xoz63tgQyruT6TXicEBFDFLnbQKnXuB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5M0Sa66zBazmQ0plp4CTA+za6eXf+bzoRotQB3uGFF8urAF1j9Cynhefyw7gxrpu
	 7cUPh/a+S5trV+8m1PE9SDLXn6G0km5qKpPQ5Z1RVa/cyttP8+nTZAYE7zVhn6tURM
	 lqurX97CHbjQ7wJJYWfnzCm+WaEOj4XFRw043MWFHpH96v6G2k6Zw+kdZY7bPI89Jb
	 mwUtWpzwSHgg11xyEOqezng+rb+wmPFFDqPTKTxDZE2W6fvp8uZ2zuGFKPMFzAtUrc
	 jRFKTCPWumPF/zDUyibBqpq4dGfDFVG8I/3vjFQ94RnHsPcFbSG7sqwABoLfaIu+YT
	 w9dJ6pSoOvebA==
Date: Thu, 18 Apr 2024 08:00:07 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 5/7] dt-bindings: phy: qcom,ipq8074-qmp-pcie: add
 ipq9574 gen3x2 PHY
Message-ID: <171344517596.1015522.2277492006177883527.robh@kernel.org>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
 <20240415182052.374494-6-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415182052.374494-6-mr.nuke.me@gmail.com>


On Mon, 15 Apr 2024 13:20:50 -0500, Alexandru Gagniuc wrote:
> The IPQ9574 gen3x2 PHY is very similar to IPQ6018. It requires two
> extra clocks named "anoc" and "snoc". Document this, and add a
> new compatible string for this PHY.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        | 36 ++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


