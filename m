Return-Path: <linux-pci+bounces-42016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21BCC83BB6
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 08:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A66F3AD0B9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 07:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E962D7801;
	Tue, 25 Nov 2025 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl03/4zI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1832C21F0;
	Tue, 25 Nov 2025 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055830; cv=none; b=bb5N5ZnNhF74XQHl/tFqxr4WAPmSUn1HXD7SYOFhYpA+5DbTY9JEDqvYtlVYecQezkT1rmwB7vQO0/BIYHYnf+M9yHXIU7WOKhe0om6SWBOqDQNTbcj0VlEe5ch6jNw9+gmr59juXiF085wSUz0g46p7r70oDLNRvBkNfvmSSfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055830; c=relaxed/simple;
	bh=G5cHV7FU8AKaez3Yc9DzyMnPiAJI7iFMx5Z27yQIueU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InqMfjK1Y7jZZHJQPghy6NPfdfl6akcfrxxpCwH4bRjE4/RKP4yYK5V4Sj3AXLTmtwd4nPm0+KM7JQEa+8sSz8wlRspdRvVm1XpFe7GxlcaNvckm7veYjFiuz0sprbGHgv8zTVQ8zFo6k/whGKUoBjiDf9Wl+WEgdJ5802jEdZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl03/4zI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AFDC116D0;
	Tue, 25 Nov 2025 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764055829;
	bh=G5cHV7FU8AKaez3Yc9DzyMnPiAJI7iFMx5Z27yQIueU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nl03/4zIvtR5oeNNLp199Gt21LfuwNtoogX5Z2A0AQudj4GRT6yPcxerOhwRWpuws
	 DxxS0fkyfBjqnbuW3urA/lj5rk/cqih8Wyefewu5DCqs8szzg8wor6LtrLtN0kNG+e
	 idclFWZIyhXva31M5fC7L4j/sjERM+MNgB5W6TPe1YvukkkttILZhB6a2F24uiUM96
	 2Rr+Tb/7kjdEroc535jWeZaRqE3224jAY5/dxqGB3SEexsIsGySg+n/qszo4G3VMPf
	 qHmXvoKfhggWfbOqK3m1nYRy75+Ftl2lw1n3zRNrZ40CPL1m3vJVip0TMk67f2lFJd
	 gcu2AZH1CIEPw==
Date: Tue, 25 Nov 2025 13:00:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>
Subject: Re: [PATCH 5/5] PCI/pwrctrl: Switch to the new pwrctrl APIs
Message-ID: <psoxseoptnrqzwv55jymidi3uus6zrckxj4kmi4fp4naeduuz7@w47sok3th6gi>
References: <20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com>
 <20251124-pci-pwrctrl-rework-v1-5-78a72627683d@oss.qualcomm.com>
 <CAGXv+5FnL_uvz2F6WDLwY-cwdQAqFicRTt26Pnqo-nqAhf4ikg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5FnL_uvz2F6WDLwY-cwdQAqFicRTt26Pnqo-nqAhf4ikg@mail.gmail.com>

On Tue, Nov 25, 2025 at 03:18:12PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 25, 2025 at 3:15 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@oss.qualcomm.com> wrote:
> >
> > Adopt the recently introduced pwrctrl APIs to create, power on, destroy,
> > and power off pwrctrl devices. In qcom_pcie_host_init(), call
> > pci_pwrctrl_create_devices() to create devices, then
> > pci_pwrctrl_power_on_devices() to power them on, both after controller
> > resource initialization. Once successful, deassert PERST# for all devices.
> >
> > In qcom_pcie_host_deinit(), call pci_pwrctrl_power_off_devices() after
> > asserting PERST#. Note that pci_pwrctrl_destroy_devices() is not called
> > here, as deinit is only invoked during system suspend where device
> > destruction is unnecessary. If the driver becomes removable in future,
> > pci_pwrctrl_destroy_devices() should be called in the remove() handler.
> >
> > At last, remove the old pwrctrl framework code from the PCI core, as the
> > new APIs are now the sole consumer of pwrctrl functionality. And also do
> > not power on the pwrctrl drivers during probe() as this is now handled by
> > the APIs.
> >
> > Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c   | 22 ++++++++++--
> >  drivers/pci/probe.c                      | 59 --------------------------------
> >  drivers/pci/pwrctrl/core.c               | 15 --------
> >  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  5 ---
> >  drivers/pci/pwrctrl/slot.c               |  2 --
> >  drivers/pci/remove.c                     | 20 -----------
> >  6 files changed, 20 insertions(+), 103 deletions(-)
> 
> [...]
> 
> > @@ -66,7 +47,6 @@ static void pci_destroy_dev(struct pci_dev *dev)
> >         pci_doe_destroy(dev);
> >         pcie_aspm_exit_link_state(dev);
> >         pci_bridge_d3_update(dev);
> > -       pci_pwrctrl_unregister(&dev->dev);
> >         pci_free_resources(dev);
> >         put_device(&dev->dev);
> 
> This hunk has a minor conflict with
> 
>     079115370d00 PCI/IDE: Initialize an ID for all IDE streams
> 
> already in linux-next.
> 

This series in based on v6.18-rc1, so there might be conflicts when applied to
-next. I'm not targeting v6.19 anyway as we are pretty close to merge window. We
have also merged a new pwrctrl driver for v6.19 recently and that too needs some
work, but shouldn't impact non-Qcom QCS6490 platforms.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

