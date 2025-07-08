Return-Path: <linux-pci+bounces-31702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DF7AFD535
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8D0560361
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100F32E6131;
	Tue,  8 Jul 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA34ANRf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC6CF9E8;
	Tue,  8 Jul 2025 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995292; cv=none; b=gOpylJdEvBrEYRqTYK4sd/Hhg5e2bPaxDZvLEVWDivdt9XRD8ztlAUwL9D4dCR5VAsHD/zCMf5z0LA8ArsiQMEE/548lYI88606NQd9GQ4YVjCdR6EVDkXj7WmFAUmPeIn6G8OwPvLTsO9Hg5dBFPwmgp68VQXnUKe9I07jgSg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995292; c=relaxed/simple;
	bh=0jKN9yLyuUzZoTSKclNzmjrqBtw7qPEn82fZPQz9HdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzTpEIAinnGRoyFh4/yR5zD+U/ZhMmd0JzgLQxxt3nUNpwoVKDrqD5Mo3UsbxN9P8HIwOC3LULIgxhzsQumaK+e3iH49Tb67n4xg5RLmoUGvmzLCqc8lgWv9C4tnha0XIkpLLWWEVeUjlIEVFE8Xkp/c+sSfqMc43xouqoHbEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA34ANRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A893C4CEF0;
	Tue,  8 Jul 2025 17:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751995291;
	bh=0jKN9yLyuUzZoTSKclNzmjrqBtw7qPEn82fZPQz9HdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AA34ANRfTjhjbg9q1k9s5CXv3MmUQBbwaX4ag5QailbUXF93dj+cjrejTe8+l20jP
	 JK3jGVwK9BGQrSuYcyTiK9NqDZ6ZNMJ+i2fDDWzwJqoOw+Xjk29uyxEqiN9LRuk3mF
	 Doybj0JlarxxsEtsYQ6XCPzS/3OQKlUg9ZJRIY1BDKzAW0l7PDqpLCSCzElvcldLXk
	 eiHuzfKkNsy167itNA2bmUhxgGHIq8T7Ichki/V5QYs14K7KfhH7ncfTGbcApjWmFq
	 dfnB2nuA71QeywH9imBEjhsar1A145rgb7Vyp5Ic5KtdHA5Q83JyAjN3vh/wJgnMaY
	 22NYZrmTmc87A==
Date: Tue, 8 Jul 2025 22:51:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 10/11] PCI: Add function to convert lnkctl2speed to
 pci_bus_speed
Message-ID: <rb6hftwnewb5qv7vvimlve6mdofe4yqzmnvhpmypmt3v2n4eka@wm2eihy3wpu2>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-10-3faa8fe92b05@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-mhi_bw_up-v4-10-3faa8fe92b05@qti.qualcomm.com>

On Mon, Jun 09, 2025 at 04:21:31PM GMT, Krishna Chaitanya Chundru wrote:
> Add a exported function to convert lnkctl2speed to enum pci_bus_speed,
> so that other kernel drivers can use it.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/pci.c   | 12 ++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e9448d55113bdfd2263d8e2f6b3ec802f56b712e..8950e88826e27accfe699e31fba8f4077c26296f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6018,6 +6018,18 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL(pcie_link_speed_mbps);
>  
> +/**
> + * pci_lnkctl2_bus_speed - convert lnkctl2 speed to pci_bus_speed

nit: pci_linkctrl2_to_bus_speed()?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

