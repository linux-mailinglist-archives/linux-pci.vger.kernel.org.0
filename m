Return-Path: <linux-pci+bounces-29617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BD6AD7D89
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 23:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70197189ACFA
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 21:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E421531E3;
	Thu, 12 Jun 2025 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBaMKN7q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9542DECDD;
	Thu, 12 Jun 2025 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749763574; cv=none; b=oT9l+1KjcpiHrJStexK2Uyj7bgIJ33TfKMOD4dI41Wy86hPJpzgK0xd3KRnUSt/v+smThvAai3IflCObODOKeDtIhxAhNp+jvdjyXITUTgGhiGgWm0n0GF4sxQIIcnEqXeLaqrO25+xh/7mSX3yxg8lRlCjyHI+rujABc7suA1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749763574; c=relaxed/simple;
	bh=6LN6fAd/m/I9fNEg7TgOenHz2E9XCA7dKBTgHZOBjA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OexydmSrLlVsIn6YwIEU661YKnUhS+WQskZCtLqtq+YuHy1B90aDuKltMH3Hxa1uxAoBJxATBa3/0J8MQSQN0WlZ42nERLinb4n1oVbZxmoE5QZo9Pjz8l14n9r4hpERrtON14Pk9+28KcIkSRhK0ZD8XIS+rJm1pK31COB9Htw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBaMKN7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC57BC4CEEA;
	Thu, 12 Jun 2025 21:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749763574;
	bh=6LN6fAd/m/I9fNEg7TgOenHz2E9XCA7dKBTgHZOBjA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RBaMKN7q88dt2SCpxiQd0GEzWLoqZ3LCGCt9XYhCziHo3YTanavefSp3NTXwZoNYZ
	 m5de7yzQyI5k/vHv0PIBgllwvEpY/fsvmLgb0AI2ad+czensyPXFO8i1hT9JU3/cbT
	 X0zRj+iLUNTXEdGCgdRoW8aOo9FEx4b6KOZ9C1/WB92PFTWmrHWM04U3uBbibYYaUF
	 OY2LHGIBxnedMxi7F6cIK5ENto+BNsECzamLjIMVFZ/NSxxkHVkxUvQ2hKa4bvIWOC
	 lMQQ/y+Wu7gJgliZ7GfR2Z/cn7/rKnKvapr87pGvvL2zEw9078jcOjvCWL2meKHGrG
	 4T3R31JTy0F8A==
Date: Thu, 12 Jun 2025 16:26:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/4] PCI: pcie-rockchip: add Link Control and
 Status Register 2
Message-ID: <20250612212612.GA930681@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEs9daeceXkePg7y@geday>

On Thu, Jun 12, 2025 at 05:49:57PM -0300, Geraldo Nascimento wrote:
> On Wed, Jun 11, 2025 at 02:42:59PM -0500, Bjorn Helgaas wrote:
> > I would do a pure conversion patch of the existing #defines.  Then I
> > suspect you wouldn't need a patch to add the Link 2 registers at all
> > because you could just use the #defines from pci_regs.h.
> 
> Hi Bjorn,
> 
> I've hit roadblock, maybe you can help?
> 
> PCIE_RC_CONFIG_DCR_CSPL_LIMIT is defined as 0xff...
> 
> I'd like to kill that define too, since it will be
> orphaned.
> 
> But hardcoding 0xff seems like illegible solution.
> 
> Perhaps there is another standard define that
> maps to 0xff that I can use? Anyone comes
> to your mind?

Maybe FIELD_MAX(PCI_EXP_DEVCAP_PWR_VAL)?

