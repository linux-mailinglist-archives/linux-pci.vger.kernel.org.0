Return-Path: <linux-pci+bounces-41948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA79C80E6E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 15:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7313A6050
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2746F1EDA02;
	Mon, 24 Nov 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/hgYIy5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF10E2A1BF;
	Mon, 24 Nov 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992977; cv=none; b=HU7BEXqHjTfT1+u53QR4RLrFXvCQbBCjF176wLqkxcJh0TVplxtxNPaEb4FsDjyNQn/ax04M/p90eurfzkDMF13OxuTkn+ZaXBCLvMmf6F62tKs0wFpBK/npSmykFyzT02VMK/vLJAdBCI4t0hK0P8rrrpmmTn2KOmChIPXMjmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992977; c=relaxed/simple;
	bh=a33jXfKWV+tqd3DAXr4TASNxV2asp4jDlbK8KxdNQOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ29CCBdZQSBtlte5faD5LU+EUI/W7Mgsn0vzGb0EsL5rlO5MYHGM275bLVh7iwHCeHHqURbfAeD7GPRCSeizwroJq9I5NVTBRQuD2Coy0yHTdVMj42IsamMAEj4i6Ff/mb5qA4Vm4fpQsAivbDWbE07FhmO6aZGmcZUrwVafuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/hgYIy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF81CC116C6;
	Mon, 24 Nov 2025 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763992976;
	bh=a33jXfKWV+tqd3DAXr4TASNxV2asp4jDlbK8KxdNQOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/hgYIy5IZoVv36JC+jRAqpdwANOi0RBMs4xIVOj7TdREitlfpOcNyp1ih6Wu+6o+
	 2Q/Cq8TiwmjUPhTdVruO8tJx7Oo4SKI30Ev7qqnSXz8tGpSumZU/E8QiYk+RFrOpyd
	 oXf/14nxkqp/kLTv4peMcyYcOdSH4bLmJnmbtspZdvLnO1CzdgnDG63+PeWfdDbjY6
	 D1/h34qRh0R4eVmBZwB8iY/7rCk/m2b48OA04YV2AnVQ4Y8fo4lxElUQnKQOfmgBS9
	 ORMBPLITDD4RodCl94oRW4fD5Syw1ax/SOHg7e2RHCr+EJJU6C3QMhogwIJ9kfYsdS
	 eyryjhyrdkoOw==
Date: Mon, 24 Nov 2025 15:02:51 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: dwc: Revert Link Up IRQ support
Message-ID: <aSRli_Mb6qoQ9TZO@ryzen>
References: <20251111105100.869997-8-cassel@kernel.org>
 <mt7miqkipr4dvxemftq6octxqzauueln252ncrcwy6i2t7wfhi@jtwokeilhwsi>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mt7miqkipr4dvxemftq6octxqzauueln252ncrcwy6i2t7wfhi@jtwokeilhwsi>

On Mon, Nov 24, 2025 at 06:07:44PM +0530, Manivannan Sadhasivam wrote:
> While I suggested to revert the link up IRQ patch for rockchip earlier, I didn't
> expect to drop the support for Qcom. The reason is, on Qcom SoCs, we have not
> seen a case where people connect a random PCIe switch and saw failures. Most of
> the Qcom usecases were around the M.2 and other proprietary connectors. There is
> only one in-house PCIe switch that is being actively used in our products, but
> so far, none of the bootloaders have turned them ON before kernel booting. So
> kernel relies on the newly merged pwrctrl driver to do the job. Even though it
> also suffers from the same resource allocation issue, this series won't help in
> any way as pwrctrl core performs rescan after the switch power ON, and by that
> time, it will be very late anyway.
> 
> So I'm happy to take the rockhip patches from this series as they fix the real
> issue that people have reported. But once the pwrctrl rework series gets merged,
> and the rockchip drivers support them, we can bring back the reverted changes.

FUKAUMI Naoki, just to confirm:

Neither my suggested approach:
https://lore.kernel.org/linux-pci/aRHdeVCY3rRmxe80@ryzen/

nor Shawn's suggested approach:
https://lore.kernel.org/linux-pci/dc932773-af5b-4af7-a0d0-8cc72dfbd3c7@rock-chips.com/

worked for you?


If so, I don't see many alternative but for Mani to apply patch 1 and
patch 2 from this series.


Kind regards,
Niklas

