Return-Path: <linux-pci+bounces-24382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D18DA6C104
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 18:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F120A189C5C5
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D835F22D7A7;
	Fri, 21 Mar 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9+MXeD6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AB222D7A4;
	Fri, 21 Mar 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577201; cv=none; b=EAZnQuIO2ouLUyh75BCEhkm9dTVPwaX+H3tgY/BE7IQa+Iwab8q7mQkeN8u9Dk0gcSx/LBj70ldtTpmRxXEMLrvGf3DCIjftkyCz3sxu+klweNhvPIP0UzFDf36QjBxWb07FV1f1JJk6OFIOBkuFjOIBcT7fLJmc9eFVawTBgk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577201; c=relaxed/simple;
	bh=kYaat6L/Pu0hOXYxq2vlVmAePaN31eJnHvOYkiS3fXo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WTr9i51HjQjJrQx5pihBs4ICfjfLWqsqR4fsrn49GXgRhQy2KDxwj3xkRkob2jWV5eLDR+bvUII4EFcKCwAGD1Fvds5CGchXVo2LyThE6gkdJHU0HM5pGIcCQdDnUCcWIZsHHeHZS+UmLM/VNk9XMBmNnWtriPewte/DHCOjcno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9+MXeD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92D7C4CEE3;
	Fri, 21 Mar 2025 17:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577200;
	bh=kYaat6L/Pu0hOXYxq2vlVmAePaN31eJnHvOYkiS3fXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=u9+MXeD6ycB6Rv7lmxny18SX54uTAULdGOPJw595n5u2syIHlwmwP0OQQsu+eY2C6
	 QSIq4P/OI9v7RLHDyCftZj+mPLSPgNIIyG1/ofTs2exzdIRyaxdJLpRENAD01Y5Uwg
	 sILpwbiBkwr7fP4nGEze/hePwp86R/ZrM6wcty04OTcbbKyDkT5bVKiQiAp4ycYeQh
	 efn2FynaJsYqjffr0ZhTQ8PkExvkPujv4mpZrPfxn7sxXmow2dsjtFZYH4ZoKOPf9q
	 VkojtMX2wrAgkoA6yz3PedmQxmZnG96NyaWf4geaygnt8cBOfb5XXTtxRr7Tt0/UUU
	 TUzICWMqIU+tg==
Date: Fri, 21 Mar 2025 12:13:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Fix link speed return type
Message-ID: <20250321171319.GA1132947@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321163103.5145-1-ilpo.jarvinen@linux.intel.com>

On Fri, Mar 21, 2025 at 06:31:03PM +0200, Ilpo Järvinen wrote:
> pcie_bwctrl_select_speed() should take __fls() of the speed bit, not
> return it as a raw value. Instead of directly returning 2.5GT/s speed
> bit, simply assign the fallback speed (2.5GT/s) into supported_speeds
> variable to share the normal return path that calls
> pcie_supported_speeds2target_speed() to calculate __fls().
> 
> This code path is not very likely to execute because
> pcie_get_supported_speeds() should provide valid ->supported_speeds but
> a spec violating device could fail to synthetize any speed in
> pcie_get_supported_speeds(). It could also happen in case the
> supported_speeds intersection is empty (also a violation of the current
> PCIe specs).
> 
> Fixes: de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/bwctrl for v6.15, thanks!

> ---
>  drivers/pci/pcie/bwctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index 0a5e7efbce2c..58ba8142c9a3 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -113,7 +113,7 @@ static u16 pcie_bwctrl_select_speed(struct pci_dev *port, enum pci_bus_speed spe
>  		up_read(&pci_bus_sem);
>  	}
>  	if (!supported_speeds)
> -		return PCI_EXP_LNKCAP2_SLS_2_5GB;
> +		supported_speeds = PCI_EXP_LNKCAP2_SLS_2_5GB;
>  
>  	return pcie_supported_speeds2target_speed(supported_speeds & desired_speeds);
>  }
> 
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> -- 
> 2.39.5
> 

