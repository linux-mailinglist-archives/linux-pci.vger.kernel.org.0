Return-Path: <linux-pci+bounces-40029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B22EC280B4
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 15:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DCF3A5E31
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7E51D5CC6;
	Sat,  1 Nov 2025 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG48ZwOs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B17DA66;
	Sat,  1 Nov 2025 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762006870; cv=none; b=boIKPhT+RGdP9Ya9ZgnKnPD/LeH9UJtJCZxSqERdyxuJCG0qJuShijZzQFLEZkSCw44Xs5zfgcEFCUfv9/o3ZZAb6ePdJcJpWF6gPvJJ0agEV21L9q+qPhqQUuZpbQCbUip7YdX+En1A1fCwbV6IIKoigLh8r4zzwRzyKSvy3N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762006870; c=relaxed/simple;
	bh=Gvf1mYIDAEuIXGTcNGdXvQgYVAM627aH5dsUdJvMLwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNE65yC5vgj2+yBCgP1JA72ibNTkDvufhPg7XSrkYYNVuuoaDBrxfDIaNlgrQoUtYy2uGm0cXSCt0gGk/6lWFvedqolVY74VBqAZ+SXSuOsJTzeIZhmAjHWaUUkiJcc07t3TrTHxkD9o9hVbEk3jhKUK93hD+7pt0aGs3AMNJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG48ZwOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB40C4CEF1;
	Sat,  1 Nov 2025 14:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762006870;
	bh=Gvf1mYIDAEuIXGTcNGdXvQgYVAM627aH5dsUdJvMLwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nG48ZwOsmf7ywyIGxFuAKUMJaoY0VGESkpv/4qfZ/KTJNA6A2yFpJYCOkpKtiQL3p
	 MwqeckBV20eo0FzheXg09WpWb8CJ/4Qkx2OAcUGcGGtx0NA1P+bi2JffRjGJmI9+bp
	 5CJcGRHKTC/tknYmstKlskizDI2wkbBuzf89hPe5acIc/W6IqYgngxX0YC0LU+qFtx
	 ZUVmaw1kczjP+C9CvW38D//14rynREuHAONkC0ZqFBmXtXikwPUH/q4ofymafDb/Tz
	 NCExRsF/0TC/fuwYqUkoC1aVQ3rIn4lxdpD0HeJHvYlr+uE1I3ogVeulX/p2qIuBCc
	 yU7Fs4Bv+fErw==
Date: Sat, 1 Nov 2025 19:50:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Jingoo Han <jingoohan1@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Subject: Re: [PATCH v4 9/9] PCI: dwc: support missing PCIe device on resume
Message-ID: <qlil44i7ywwxurdfovkbqvvjff7dey53uy5hzq4zbmvg7jg54o@zdg27w4q26gr>
References: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
 <20251029-rockchip-pcie-system-suspend-v4-9-ce2e1b0692d2@collabora.com>
 <dc230a62-bd31-450a-9acd-fa654f694b3a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc230a62-bd31-450a-9acd-fa654f694b3a@oss.qualcomm.com>

On Thu, Oct 30, 2025 at 11:07:19AM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 10/29/2025 11:26 PM, Sebastian Reichel wrote:
> > When dw_pcie_resume_noirq() is called for a PCIe root complex for a PCIe
> > slot with no device plugged on Rockchip RK3576, dw_pcie_wait_for_link()
> > will return -ETIMEDOUT. During probe time this does not happen, since
> > the platform sets 'use_linkup_irq'.
> > 
> > This adds the same logic from dw_pcie_host_init() to the PM resume
> > function to avoid the problem.
> > 
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >   drivers/pci/controller/dwc/pcie-designware-host.c | 13 ++++++++++---
> >   1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index e92513c5bda5..f25f1c136900 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -1215,9 +1215,16 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
> >   	if (ret)
> >   		return ret;
> > -	ret = dw_pcie_wait_for_link(pci);
> > -	if (ret)
> > -		return ret;
> > +	/*
> > +	 * Note: Skip the link up delay only when a Link Up IRQ is present.
> > +	 * If there is no Link Up IRQ, we should not bypass the delay
> > +	 * because that would require users to manually rescan for devices.
> > +	 */
> 
> In the resume scenario, we should explicitly wait for the link to be up,
> there is no IRQ support at this resume phase

This could be fixed if the PM handlers are moved to non-no_irq ones.

> and secondly after controller resume pm framework will start resuming the
> bridges & endpoints. what happens
> if the link is not up by the time endpoint is resume is called. And entire
> save & restore states might also gets messed up.
> There will be no way to recover from this.
> 

This is true if there were any devices connected to the bus during suspend. If
there were no devices, then it is fine to skip waiting for the link to be up.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

