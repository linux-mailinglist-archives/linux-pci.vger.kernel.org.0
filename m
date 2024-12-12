Return-Path: <linux-pci+bounces-18221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7D19EE0D4
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 09:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB7E167E68
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 08:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AA3165F01;
	Thu, 12 Dec 2024 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tf/iEPgj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE34558BA
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990658; cv=none; b=u8Q1HiyPuTSjR/12J9CYeen+VO2e85aELLvBC3UKSnRj/egP6qg2RLek7uFfmpBhOZtex1tAhJuKFfyg1aKB2BJaj+4YQhtnLEcvBW3/x0oth4HuJ8MvbnHQYRncEg/6U7m1bdMCSPOGQwEdCc6DmfreUUMXuBKwRRWA5QnMiVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990658; c=relaxed/simple;
	bh=47kCC3IaGSxh1D7BcSgs1D4JpI1pTNpXykzx+d7p8Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/cXJuDwz/fMIRo5hHTl8fl0XErtsgORo3qihqjlsgVQprpRe008uEMpKeGNzEVGcZuWFbEDbUiymvuuEwgE44idGDuXryjHNIUXw811dYsPGLuNDFeZZL2QvOLKa1qDaGt2+XdR+aTGFzn0nK7PzN3nlyAZkr7zix4f72wLjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tf/iEPgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B3EC4CECE;
	Thu, 12 Dec 2024 08:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733990657;
	bh=47kCC3IaGSxh1D7BcSgs1D4JpI1pTNpXykzx+d7p8Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tf/iEPgjcINryK5v/Jg7/FAJAr+P+m7ZQkzsS62+09HHfEz1q9iM8eS+R/qPvYQpx
	 XkMPSmjPFM1r4i6MQY7+kMA1xw0FspHRE67Dk3l8r8a7ZMaQln6dyEUUCEK+RtN0Ke
	 DiB3zMGSQ28XsfPh3qY0pOYtz7nG+eE46lCxWAfhf1Au58sBcT8zAbxTSztWYtSqBe
	 TY34yeFkt+/Tq8H/1L0ZU2/KwlFyncyh1jTYxg8k8KRW06aa6v+zDmpaZsPazupvyh
	 BtPsIZglCNret4sx6y9AmoQr6YjNrGk6VGhc2CNpTkt9WmJzhnkf+dc3avqv4FOOwu
	 SVUf1PtfU/jPA==
Date: Thu, 12 Dec 2024 09:04:12 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Enumerate endpoints based on
 dll_link_up irq in the combined sys irq
Message-ID: <Z1qY_K57lamVxqRm@ryzen>
References: <20241127145041.3531400-2-cassel@kernel.org>
 <20241211053104.7sgo5bmmjnolwvhh@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211053104.7sgo5bmmjnolwvhh@thinkpad>

On Wed, Dec 11, 2024 at 11:01:04AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Nov 27, 2024 at 03:50:42PM +0100, Niklas Cassel wrote:
> > Most boards using the pcie-dw-rockchip PCIe controller lack standard
> > hotplug support.
> > 
> > Thus, when an endpoint is attached to the SoC, users have to rescan the bus
> > manually to enumerate the device. This can be avoided by using the
> > 'dll_link_up' interrupt in the combined system interrupt 'sys'.
> > 
> > Once the 'dll_link_up' irq is received, the bus underneath the host bridge
> > is scanned to enumerate PCIe endpoint devices.
> > 
> > This commit implements the same functionality that was implemented in the
> > DWC based pcie-qcom driver in commit 4581403f6792 ("PCI: qcom: Enumerate
> > endpoints based on Link up event in 'global_irq' interrupt").
> > 
> > The Root Complex specific device tree binding for pcie-dw-rockchip already
> > has the 'sys' interrupt marked as required, so there is no need to update
> > the device tree binding. This also means that we can request the 'sys' IRQ
> > unconditionally.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks for the review!

Could this patch please be picked up?


Kind regards,
Niklas

