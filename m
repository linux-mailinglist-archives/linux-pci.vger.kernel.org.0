Return-Path: <linux-pci+bounces-25717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D2CA86EA8
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 20:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BEE19E29E2
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 18:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0925B20E700;
	Sat, 12 Apr 2025 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQKkqdjF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3FA1A23B1;
	Sat, 12 Apr 2025 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744481512; cv=none; b=p17H8u2SKvZiQZclMlOCVUxrLn04DyVIFqVZx/AyDROryC0/WAZV66Slbqu8NsW6IZGYnOyUYxk5iUoL/v22ULi1fQs22ajN5L219W/j2TOqlgHs0dbVBVTQIeQ7izjYkc9lPvsP6SdJBx6l9mJBg1KqzTvjrjYBZHUBQn/t2HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744481512; c=relaxed/simple;
	bh=Q6nJWiAgaLLt3sM9/J4br6bIcdSMELZhvALVMehVIJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCbDGaFyP5dqfFUTRWLFicn4JruGskWEfOAxzfOluI4N2TARDctz4HGmnXlfhYEVlZem3P4xYD8nCdpRnFnW4muuad3VET4noVSGLKmRePVBRb0qGw58h/4IQfVwgEEkmgQdigSApju7pKwg/Nt/pdvYloOGagkxYTiui5GrAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQKkqdjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F7AC4CEE3;
	Sat, 12 Apr 2025 18:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744481512;
	bh=Q6nJWiAgaLLt3sM9/J4br6bIcdSMELZhvALVMehVIJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQKkqdjFc9B3xAX+ovk5LQliJO7E5IUvVxDJXT7krWWc33U3LrQoFbyo1fSZ5M8GL
	 WC22G2DIQDVvySnLAhaH6JFZJ16C4xYr3TIT11eurjwRpLKAHqpupsZixONBePDVbe
	 MzBSLpgdEoP9TNpDK/tOgVVMDO17gredUR1OtscZ+pA9w/OtkIR4ZtNJsCsXa8islk
	 OSm6RlUg9hSS5PCiOxr/gyX1fBhfhKkerSNHmV8q9Zw1xJ2yLJoEH3Vb4PkeUhWaig
	 xBjG8EuFcc5h3/Q0msh1Zz5y0gxXiSCa72n8DMXdvum5qH2vsO6jfvSTJg/qa3hxh6
	 xXnSSwGSICqbw==
Date: Sat, 12 Apr 2025 13:11:51 -0500
From: Rob Herring <robh@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
	amitk@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v5 7/9] PCI: PCI: Add pcie_link_is_active() to determine
 if the PCIe link is active
Message-ID: <20250412181151.GA1417992-robh@kernel.org>
References: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
 <20250412-qps615_v4_1-v5-7-5b6a06132fec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412-qps615_v4_1-v5-7-5b6a06132fec@oss.qualcomm.com>

On Sat, Apr 12, 2025 at 07:19:56AM +0530, Krishna Chaitanya Chundru wrote:
> Introduce a common API to check if the PCIe link is active, replacing
> duplicate code in multiple locations.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/hotplug/pciehp.h      |  1 -
>  drivers/pci/hotplug/pciehp_ctrl.c |  7 ++++---
>  drivers/pci/hotplug/pciehp_hpc.c  | 33 +++------------------------------
>  drivers/pci/pci.c                 | 26 +++++++++++++++++++++++---
>  include/linux/pci.h               |  4 ++++
>  5 files changed, 34 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 273dd8c66f4eff8b62ab065cebf97db3c343977d..acef728530e36d6ea4d7db3afe97ed31b85be064 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -186,7 +186,6 @@ int pciehp_query_power_fault(struct controller *ctrl);
>  int pciehp_card_present(struct controller *ctrl);
>  int pciehp_card_present_or_link_active(struct controller *ctrl);
>  int pciehp_check_link_status(struct controller *ctrl);
> -int pciehp_check_link_active(struct controller *ctrl);
>  void pciehp_release_ctrl(struct controller *ctrl);
>  
>  int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index d603a7aa74838c748f6ac2d22ffb8b8cfe64e469..36468a9c31d669ec916e867ecfb7a8220cfab157 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -230,7 +230,8 @@ void pciehp_handle_disable_request(struct controller *ctrl)
>  
>  void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  {
> -	int present, link_active;
> +	bool link_active;
> +	int present;
>  
>  	/*
>  	 * If the slot is on and presence or link has changed, turn it off.
> @@ -260,8 +261,8 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	/* Turn the slot on if it's occupied or link is up */
>  	mutex_lock(&ctrl->state_lock);
>  	present = pciehp_card_present(ctrl);
> -	link_active = pciehp_check_link_active(ctrl);
> -	if (present <= 0 && link_active <= 0) {
> +	link_active = pcie_link_is_active(ctrl->pcie->port);
> +	if (present <= 0 && !link_active) {
>  		if (ctrl->state == BLINKINGON_STATE) {
>  			ctrl->state = OFF_STATE;
>  			cancel_delayed_work(&ctrl->button_work);
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 8a09fb6083e27669a12f1a3bb2a550369d471d16..278bc21d531dd20a38e06e5d33f5ccd18131c2c3 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -221,33 +221,6 @@ static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
>  	pcie_do_write_cmd(ctrl, cmd, mask, false);
>  }
>  
> -/**
> - * pciehp_check_link_active() - Is the link active
> - * @ctrl: PCIe hotplug controller
> - *
> - * Check whether the downstream link is currently active. Note it is
> - * possible that the card is removed immediately after this so the
> - * caller may need to take it into account.

You've lost this somewhat important comment that still exists after this 
patch.

Rob

