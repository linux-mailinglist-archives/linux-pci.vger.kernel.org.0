Return-Path: <linux-pci+bounces-31736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB246AFDD04
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 03:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF90916C4EB
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 01:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BECC18DB03;
	Wed,  9 Jul 2025 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cC0cBfqY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE111898F8
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 01:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025182; cv=none; b=i8tr6cNkxkpeRLEBEMuOzEuKRNX5jZM3o19TmoFtexU7OSgyF1bwIvLHOQZdSj/8yFKASkuSr9e1sng2YLXv0MBoDx6WpZ9sokbgpnn03KWgoHNg6uiq95j5kimMwPmpgeMn85NBFb0lr0xXuq4o8UNoKExx3uKkIUaUdu7+A8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025182; c=relaxed/simple;
	bh=cfQvOO93gT1yWwp38vFt3eomGLDhN8GKqCZ4v7CxTrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=es6yBNHJhQAXaBsmmA/jSytyDuVvguQDk1UWtJs1EDSqNduwNGIFSp20Gy8jHoU3tfWU8oL2FBW2MSm+mHoCdtqEP2LFLLxd2xBJ3W8Ax5W4NijdXubegWqw/37GEJhBIbFDbH8VrFBbvBhF+k5x9q3MkxGzGfTsuvJ/GCh9RAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cC0cBfqY; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b34a8f69862so4097356a12.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Jul 2025 18:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752025180; x=1752629980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htnHWZGI9fIS7XwrIq+zQy0mwVLPTrPAsgueyzjswCc=;
        b=cC0cBfqYHfV6tX331CN9xYKbZKgsPt/5o4AHrlhLZtDE9gZWgS2bqg5N3+KsyRtUzI
         PXmaFrHGnFwvMt8HVgNExa2sD1Z8Yt0Wyma0YtHEGYpYiSiuxYGWnqLL/vo6eQCj/93f
         NDPaTW/kz3INaY5DSA9IrXKmrAjFy1/TOT7s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752025180; x=1752629980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htnHWZGI9fIS7XwrIq+zQy0mwVLPTrPAsgueyzjswCc=;
        b=PebwCdTuckyNlEC1XMTZCMR7B9qJ25wrj/JehFTz1cmqez9JrPc/dXYuWyZVIm8zBL
         SezP/Y9V0R9nnObLQ4O7lpAeZlPX4w4+qpmyOS9AjJ5wMpNDufUw0Pq/xMhHCQ/6FPjj
         j+AON6AcXcIy/TLcAwH+DYDsEVtYCJeGpKOvAJ30n0zEYwnNEb+h8qNgc+PFY+VvcuIP
         NMcDhinJU5uPNxyT2Ogusj8VOSDg1FATXljjwb4JfRbc7TP4imI0EBkOov0DDUiPdHbz
         lLhwEdqwDWZ8BO82ZsqYac59nRbyzQD8mH1ZaTvdvDJa2aSEmlYPOsJnCHBirMUQkHGC
         YvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFi0eMcH2ioJk+A5G9zgdo5mBYkwlzE2ekd3NJEJFOa8j/EC88mZD+Qy3sDPDK+tTa+yNGb5yIous=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZro5NP3rBCWayM1f3UnhT/hl5ppY3CvqP8E5TdMu0IjUkxNj
	+eLiB6o6ICmpDnZA0db/e1swMqTIjUD6MaaWkNxsrY7amcNBAcMC674ktIxR8A3DuA==
X-Gm-Gg: ASbGncu0pUljV5qiSzdbYvfP9Yn6VuKFuiz/+r3p+SgE6BbVFPd50VJ0LlyE0Bf1lFe
	fHdhPUXO3FEq2yk2DPN5nKUVSIUy0cJtqXlW/vI8csX2aIxGklrZsW/sbv1g9uPD7TYh1tw8H4K
	+o6jt9Ur5IPzbOmmSxfWZoxacZDqrYe2iPr/Nw5v7yQus1/njfQkDw8+MWv/nzV2jxrw71TnA2m
	KNYi44W9dWKnkzyfrcOEqg4RWV6CJsobvoaBFHUhdPkJomHEqXOFU4X+LF6KdpFKI+IrVyVRXJ+
	jvSJRfohrrE5WQ0jbqLLo1mjkr5QQMZahHB7LsHCTWpgL2/ejHs4exOph/NjlnS8MQfMn7MRYKz
	XEQSOxndJ4EqcFV2FTdckma+A
X-Google-Smtp-Source: AGHT+IGNv/8lu2iKMttdeX9zxtTiNTqDGBTpXUKF4kCeatPVs+bc/uNNgvY0zM3Nhyt31LcQCKDxvQ==
X-Received: by 2002:a17:903:19f0:b0:236:6e4f:d439 with SMTP id d9443c01a7336-23ddb1bb9bfmr10397815ad.23.1752025179989;
        Tue, 08 Jul 2025 18:39:39 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:9b88:4872:11ac:8ccb])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c84582333sm120188935ad.186.2025.07.08.18.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 18:39:39 -0700 (PDT)
Date: Tue, 8 Jul 2025 18:39:37 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 0/3] PCI/pwrctrl: Allow pwrctrl framework to control
 PERST# GPIO if available
Message-ID: <aG3IWdZIhnk01t2A@google.com>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>

Hi Manivannan,

Thanks for tackling this!

On Mon, Jul 07, 2025 at 11:48:37PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series is an RFC to propose pwrctrl framework to control the PERST# GPIO
> instead of letting the controller drivers to do so (which is a mistake btw).
> 
> Right now, the pwrctrl framework is controlling the power supplies to the
> components (endpoints and such), but it is not controlling PERST#. This was
> pointed out by Brian during a related conversation [1]. But we cannot just move
> the PERST# control from controller drivers due to the following reasons:
> 
> 1. Most of the controller drivers need to assert PERST# during the controller
> initialization sequence. This is mostly as per their hardware reference manual
> and should not be changed.
> 
> 2. Controller drivers still need to toggle PERST# when pwrctrl is not used i.e.,
> when the power supplies are not accurately described in PCI DT node. This can
> happen on unsupported platforms and also for platforms with legacy DTs.
> 
> For this reason, I've kept the PERST# retrieval logic in the controller drivers
> and just passed the gpio descriptors (for each slot) to the pwrctrl framework.

How sure are we that GPIOs (and *only* GPIOs) are sufficient for this
feature? I've seen a few drivers that pair a GPIO with some kind of
"internal" reset too, and it's not always clear that they can/should be
operated separately.

For example, drivers/pci/controller/dwc/pci-imx6.c /
imx_pcie_{,de}assert_core_reset(), and pcie-tegra194.c's
APPL_PINMUX_PEX_RST. The tegra case especially seems pretty clear that
its non-GPIO "pex_rst" is resetting an endpoint.

> This will allow both the controller drivers and pwrctrl framework to share the
> PERST# (which is ugly but can't be avoided). But care must be taken to ensure
> that the controller drivers only assert PERST# and not deassert when pwrctrl is
> used. I've added the change for the Qcom driver as a reference. The Qcom driver
> is a slight mess because, it now has to support both new DT binding (PERST# and
> PHY in Root Port node) and legacy (both in Host Bridge node). So I've allowed
> the PERST# control only for the new binding (which is always going to use
> pwrctrl framework to control the component supplies).
> 
> Testing
> =======
> 
> This series is tested on Lenovo Thinkpad T14s laptop (with out-of-tree patch
> enabling PCIe WLAN card) and on RB3 Gen2 with TC9563 switch (also with the not
> yet merged series [2]). A big take away from this series is that, it is now
> possible to get rid of the controversial {start/stop}_link() callback proposed
> in the above mentioned switch pwrctrl driver [3].

This is a tiny bit tangential to the PERST# discussion, but I believe
there are other controller driver features that don't fit into the
sequence model of:

1. start LTSSM (controller driver)
2. pwrctrl eventually turns on power + delay per spec
3. pwrctrl deasserts PERST#
4. pwrctrl delays a fixed amount of time, per the CEM spec
5. pwrctrl rescans bus

For example, tegra_pcie_dw_start_link() notes some cases where it needs
to take action and retry when the link doesn't come up. Similarly, I've
seen drivers with retry loops for cases where the link comes up, but not
at the expected link rate. None of this is possible if the controller
driver only gets to take care of #1, and has no involvement in between
#3 and #5.

(Yes, I acknowledge that DWC's .start_link() is being abused in
tegra_pcie_dw_start_link(). But it's still reality, with a
seemingly-good use case.)

Brian

> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/Z_6kZ7x7gnoH-P7x@google.com/
> [2] https://lore.kernel.org/linux-pci/20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com/ 
> [3] https://lore.kernel.org/linux-pci/20250412-qps615_v4_1-v5-4-5b6a06132fec@oss.qualcomm.com/
> 
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
> Manivannan Sadhasivam (3):
>       PCI/pwrctrl: Move pci_pwrctrl_init() before turning ON the supplies
>       PCI/pwrctrl: Allow pwrctrl core to control PERST# GPIO if available
>       PCI: qcom: Allow pwrctrl framework to control PERST#
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c |  1 +
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  drivers/pci/controller/dwc/pcie-qcom.c            | 26 ++++++++++++++-
>  drivers/pci/pwrctrl/core.c                        | 39 +++++++++++++++++++++++
>  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c          |  4 +--
>  drivers/pci/pwrctrl/slot.c                        |  4 +--
>  include/linux/pci-pwrctrl.h                       |  2 ++
>  include/linux/pci.h                               |  2 ++
>  8 files changed, 74 insertions(+), 5 deletions(-)
> ---
> base-commit: 00f0defc332be94b7f1fdc56ce7dcb6528cdf002
> change-id: 20250707-pci-pwrctrl-perst-bdc6e36a335c
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <mani@kernel.org>
> 

