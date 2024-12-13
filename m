Return-Path: <linux-pci+bounces-18385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DDE9F0F5F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646D72833CD
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252251E1C0F;
	Fri, 13 Dec 2024 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvWfF3Zj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71F1E25FC;
	Fri, 13 Dec 2024 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100742; cv=none; b=hW1xLkfIMtI15NDmQQUwdJcuGlzdxFQaDOk7uHAA0A6IYIfYLFQAjNiNw1DWSZtQUxlkE4BkRJ3mohMU9X9myoaFodEgQAR2STN4JHHMHcAaH42oIu0tN1Tp3pisE8rB2I0BDg+Kva2gTvKuPZEwHlnHgLUUBzit+BoGkrCHdOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100742; c=relaxed/simple;
	bh=ZppmVRpWe2yG+cY2drkddKHwv3IDtev7H6+KRmZH7j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lya5/gQY9vkxv1+k6U5lXXoF4nNf+4mkGGtTUkQu3zDSFiuEEpJSrhVE6wSuxnbCd6+jsBSWlPj2NZ3YThbvq3oVrpxm2cgyqpwMgZS0rmRehZ1tLVwnI46NdtAd/hlEHk7IUbf09YGnIrr/PeeiJlB7KODmCvz780pL2AE6cjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvWfF3Zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5203C4CED0;
	Fri, 13 Dec 2024 14:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734100741;
	bh=ZppmVRpWe2yG+cY2drkddKHwv3IDtev7H6+KRmZH7j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TvWfF3ZjT0DTeg22F6ilYKR5s6ww7PdvJ+bBo4WbVV/9d+s/SwrYaicT4w9l7FpN1
	 cyLcDZtiPEFrtXehvMsq2xhdufTRPukSzAVPNjbgGc/boFPGeDlTZEyWgifg2x62lg
	 BapaluwLDu61aYBbAaqiVTtRqyaeH7ouxxMLx6MasPNULcEZqKO5deZzaWjyla5EHH
	 BLQ/l+nOTdiLGmK9ZyuN1CF5aqYXhxhmWuvIPsE4MUyZdtQM0EeKc3pM6EU4qmB5FF
	 y27ytALx5lmwtLx8yv2haNVwKCqicY5+6rVxK7itUyW7ToKGanqI+bLIjFUcQlalAx
	 v3LKfJUZXikxw==
Date: Fri, 13 Dec 2024 15:38:56 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/6] PCI: dwc: ep: iATU registers must be written
 after the BAR_MASK
Message-ID: <Z1xHAOSiNssDBz3N@ryzen>
References: <20241127103016.3481128-9-cassel@kernel.org>
 <20241204173352.GA3006363@bhelgaas>
 <Z1w364da43KCOIGY@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1w364da43KCOIGY@ryzen>

Hello Bjorn,

On Fri, Dec 13, 2024 at 02:34:35PM +0100, Niklas Cassel wrote:
> > 
> > And I guess the problem is that the previous code does:
> > 
> >   dw_pcie_ep_inbound_atu        # iATU
> >   dw_pcie_ep_writel_dbi2        # BAR_MASK (?)
> >   dw_pcie_ep_writel_dbi
> > 
> > and the new code basically does this:
> > 
> >   if (ep->epf_bar[bar]) {
> >     dw_pcie_ep_writel_dbi2      # BAR_MASK (?)
> >     dw_pcie_ep_writel_dbi
> >   }
> >   dw_pcie_ep_inbound_atu        # iATU
> >   ep->epf_bar[bar] = epf_bar
> > 
> > so the first time we call dw_pcie_ep_set_bar(), we write BAR_MASK
> > before iATU, and if we call dw_pcie_ep_set_bar() again, we skip the 
> > BAR_MASK update?
> 
> The problem is as described in the commit message:
> "If we do not write the BAR_MASK before writing the iATU registers, we are
> relying the reset value of the BAR_MASK being larger than the requested
> size of the first set_bar() call. The reset value of the BAR_MASK is SoC
> dependent."

Re-reading this commit message, I can see that it is a bit confusing.

I re-wrote the commit messages for patch 1/2 and patch 2/6 in this series,
based on your feedback. (I also updated the code comment in patch 2/6.)

I hope that it slightly clearer now :)

Please review:
https://lore.kernel.org/linux-pci/20241213143301.4158431-8-cassel@kernel.org/T/#u


Kind regards,
Niklas

