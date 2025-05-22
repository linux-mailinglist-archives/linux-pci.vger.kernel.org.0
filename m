Return-Path: <linux-pci+bounces-28260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B67A6AC07C6
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 10:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AA0189F3BB
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A9C231849;
	Thu, 22 May 2025 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLUmHKsX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEFC2F41;
	Thu, 22 May 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903978; cv=none; b=RQH0RdzVOTHYKmGIaCk497DKKpPKS7dpgHq4u1l4YhEJxGxHTdcFlnlXO9h79NgYQ4vGHzn4VDsomiR7GFW+4loHwIdPNXt/kPmUsYKhQx627oMu67z52BoQwzTvSOp0rzI9sxH6Fo4a4tvhrgvxkgyoKjCEpuMrACF4YHedJ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903978; c=relaxed/simple;
	bh=lX/+6YlfcbnVorPLWGNaprlNutFeJRekSg9nyekPQFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJOTY1eRfV5nRW8TaNrhFDJdwdSDvaBmmCmmJdDCMv60HrOLwUI70qaC5H5iyxB0lNUKhcE4z8ojdtjkezy+mi1y4frQUjMazYWVMEiY6th0CjecG4i3xmWfPWFBW6htgB2Dhv/9Ftl6TV8MCwgezqwVBtBaNbFkyEkku/iP/ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLUmHKsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54C4C4CEF2;
	Thu, 22 May 2025 08:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747903977;
	bh=lX/+6YlfcbnVorPLWGNaprlNutFeJRekSg9nyekPQFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uLUmHKsX6biD+JwKfkQ8Wi95o18YIuIVdm6m7S2zeIs/6qtLiaoSZRwuz6qq5fJ5R
	 UWGl6/LF45zDWhrdmryc/OPedHg4ghiJ7mwW4YYfAm2k3gZUQJJ1eHZ62UbT04Yfv3
	 fFa3wtD7Te6qozIQO+z1L/VqU5aSezKhuoa6T0Lzkae9oDnWbcvxCSWcZ70HpSincF
	 vOaaVusOWyza49IxVsD6Gq46Cg3SffV+MiUPVwv2j/keLMOPEe2yfsfpuvMSIweLbn
	 xjb0rvJIOXDiB9fwcJhxBe/7YEvmRmxcmeHVXb6+sG62NELhMFtREfV6VhDUEzXqGe
	 kZ6956d90LYXA==
Date: Thu, 22 May 2025 11:52:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: grwhyte@linux.microsoft.com
Cc: linux-pci@vger.kernel.org, shyamsaini@linux.microsoft.com,
	code@tyhicks.com, Okaya@kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Reduce delay after FLR of Microsoft MANA devices
Message-ID: <20250522085253.GN7435@unreal>
References: <20250521231539.815264-1-grwhyte@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521231539.815264-1-grwhyte@linux.microsoft.com>

On Wed, May 21, 2025 at 11:15:39PM +0000, grwhyte@linux.microsoft.com wrote:
> From: Graham Whyte <grwhyte@linux.microsoft.com>
> 
> Add a device-specific reset for Microsoft MANA devices with the FLR
> delay reduced from 100ms to 10ms. While this is not compliant with the pci
> spec, these devices safely complete the FLR much quicker than 100ms and
> this can be reduced to optimize certain scenarios
> 
> Signed-off-by: Graham Whyte <grwhyte@linux.microsoft.com>
> ---
>  drivers/pci/pci.c    |  3 ++-
>  drivers/pci/pci.h    |  1 +
>  drivers/pci/quirks.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9cb1de7658b5..ad2960117acd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1262,7 +1262,7 @@ void pci_resume_bus(struct pci_bus *bus)
>  		pci_walk_bus(bus, pci_resume_one, NULL);
>  }
>  
> -static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
> +int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  {
>  	int delay = 1;
>  	bool retrain = false;
> @@ -1344,6 +1344,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(pci_dev_wait);

pci.c and quirks.c can't built as independent modules. There is no need
in EXPORT_SYMBOL_GPL here.

Thanks

