Return-Path: <linux-pci+bounces-27449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27098AAFEF7
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 17:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C940916458C
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCF1279789;
	Thu,  8 May 2025 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI9z3Qbv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14826279780;
	Thu,  8 May 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717287; cv=none; b=exBm1mXlBOymB3lWUmvbCjz5SkLOBdtc1Wrzc+JVVw8qAMZXYKDhq0hiIXzufWzihWsQr3texbcycIVpyFNpKE9UOEWQcdAvDpfseIzrc5zagQlkHjX5yE3E1Eg5L1hDZstsnuD2vz+hW7rHFcO0eyKIKuaAM+aRcEZkuoU+RTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717287; c=relaxed/simple;
	bh=5GbhSPNq/qJPJlLzO0yWtxUcuqFGx1Ov0ZOnA/53Rfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isLSIryc8PhaJy8FiLWR/KEp60MEsmNvBTldthKQFqanzqm2u5jblVlfo6lxz8XJxLVhUXANUmT277skwsZMrSmgJjycmrQPHSeSPF4a5UOHXVl3TxmQSk28gMoy+rELfXSIL3W1sqnDaZFNfRfc7/+ov8CXIOepZodLXJ1wt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI9z3Qbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E94BC4CEF5;
	Thu,  8 May 2025 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746717286;
	bh=5GbhSPNq/qJPJlLzO0yWtxUcuqFGx1Ov0ZOnA/53Rfo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kI9z3Qbvw98g27dsgFOK3zQX3gzGczplOYI1Ierb67F5F6UeQph6Elsb7ESCm8HzR
	 brTqBV7vHG6NSP6JZGlAODmIsd4P8i+dAC71GcMJUV+LkAbchg26B0wD5l744AeA0A
	 aqY/TEApooaosdJV4/gu6TVK1KP3KrPHiKYbL3hCKeyRIVVkXmVmy5XJzNZLlRx27b
	 mNthc/t2+y2meJdgLRciCh9qag/Wc+i5N6VP3w5s8/siCAVcz8nzsV4nUGaMp/zl7q
	 BDlG67xPIzfMx2OQK4Mc/TmPICMsydZu4xgkgdqPxbaGNTlq87DG2tGFd0DqhkC0Do
	 nlL88d+4BwapA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3BC91CE076F; Thu,  8 May 2025 08:14:46 -0700 (PDT)
Date: Thu, 8 May 2025 08:14:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Remove also pcie_bwctrl_lbms_rwsem
Message-ID: <35df30c5-5066-4933-b414-1f6c918a20e3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250508090036.1528-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508090036.1528-1-ilpo.jarvinen@linux.intel.com>

On Thu, May 08, 2025 at 12:00:36PM +0300, Ilpo Järvinen wrote:
> The commit 0238f352a63a ("PCI/bwctrl: Replace lbms_count with
> PCI_LINK_LBMS_SEEN flag") remove all code related to
> pcie_bwctrl_lbms_rwsem but forgot to remove the rwsem itself.
> Remove it and the associated info from the comment now.
> 
> Fixes: 0238f352a63a ("PCI/bwctrl: Replace lbms_count with PCI_LINK_LBMS_SEEN flag")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> 
> Bjorn, this should be folded into the original commit I think.
> 
>  drivers/pci/pcie/bwctrl.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index fdafa20e4587..f31fbbd51490 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -45,15 +45,7 @@ struct pcie_bwctrl_data {
>  	struct thermal_cooling_device *cdev;
>  };
>  
> -/*
> - * Prevent port removal during LBMS count accessors and Link Speed changes.
> - *
> - * These have to be differentiated because pcie_bwctrl_change_speed() calls
> - * pcie_retrain_link() which uses LBMS count reset accessor on success
> - * (using just one rwsem triggers "possible recursive locking detected"
> - * warning).
> - */
> -static DECLARE_RWSEM(pcie_bwctrl_lbms_rwsem);
> +/* Prevent port removal during Link Speed changes. */
>  static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
>  
>  static bool pcie_valid_speed(enum pci_bus_speed speed)
> 
> base-commit: 0238f352a63a075ac1f35ea565b5bec3057ec8bd
> -- 
> 2.39.5
> 

