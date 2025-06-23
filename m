Return-Path: <linux-pci+bounces-30363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06746AE3D87
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206C43A8808
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 10:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCE615689A;
	Mon, 23 Jun 2025 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOWRX/WM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82402566A;
	Mon, 23 Jun 2025 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676290; cv=none; b=TZkOPruHrfKN+ezKb6Cez0WPcwx5nxj8OSjRj2AHrc5jHYFHP7FGXk0/Oyg5q3sMlp8YJc85mmJtxbQltH9zu/kozCNvA9Er0+kwZcfbL0x1VfyIkXh8ecZE3S6Q+oRvaBtJcZOdh8iUNkbztt0rY431qljFif84QJJkFMPjCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676290; c=relaxed/simple;
	bh=KQEP5ij24VEA8YmbYKGHIizffbrpTimsVDgCFJ93uCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpGhCUcuI8m3I4WkLB1Pl/l1RrBd9PrdMfWEB0HIz4k0/3er9EVx/793eMee4bPwlgP3vVtcFY6AvhBXYEQvxlGCT8AmaHJBM8Uyzaefl0OHlw0UZvigvHYvVyNpM1sJxzy3l5AWKSN7Eknt5ggXKAx6C02T0koqr+e7GEWC9Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOWRX/WM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6401AC4CEF2;
	Mon, 23 Jun 2025 10:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750676290;
	bh=KQEP5ij24VEA8YmbYKGHIizffbrpTimsVDgCFJ93uCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZOWRX/WM6ATuFay5qVBF3U6yDvYFbsL3dgLTVha1A3bEeH7hijXd05KUo/J5ZjMyc
	 rwjOiaWuHyBKQnQ5OFzoCFYklqOMIg0XNCmfSVOSdDZe+JVnHTME+pdagvTLqQipBm
	 weVAhIE3pZ52YocrXvvyhMyBG/7Z6osMkG01ct9z9wZHyApZd2gDCSn5XT+ahyD3Cn
	 LGOL9JWJfS4auNvI7mXtG6ra8xdVhbS9Mvgn2ZtLovJUoBBisQiRkVfC6lM0sEVkZW
	 UyFybkR+AX5MPihNsp9J7iIsqb2qWAIp5iih0UcoB0h1h/gP/GzL+U4rCTxrMwmMJA
	 r0qkmqWOv9qdw==
Date: Mon, 23 Jun 2025 04:58:08 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
	heiko@sntech.de, yue.wang@amlogic.com, pali@kernel.org, neil.armstrong@linaro.org, 
	robh@kernel.org, jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v5 1/2] PCI: Configure root port MPS during host probing
Message-ID: <qxbedjehrhddc627lukpxvxje6dze6nxfjztlbexp5hap327ac@ojo564izhttk>
References: <20250620155507.1022099-1-18255117159@163.com>
 <20250620155507.1022099-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250620155507.1022099-2-18255117159@163.com>

On Fri, Jun 20, 2025 at 11:55:06PM +0800, Hans Zhang wrote:
> Current PCIe initialization logic may leave root ports operating with
> non-optimal Maximum Payload Size (MPS) settings. While downstream device
> configuration is handled during bus enumeration, root port MPS values
> inherited from firmware or hardware defaults might not utilize the full
> capabilities supported by the controller hardware. This can result in
> suboptimal data transfer efficiency across the PCIe hierarchy.
> 
> During host controller probing phase, when PCIe bus tuning is enabled,
> the implementation now configures root port MPS settings to their
> hardware-supported maximum values. Specifically, when configuring the MPS
> for a PCIe device, if the device is a root port and the bus tuning is not
> disabled (PCIE_BUS_TUNE_OFF), the MPS is set to 128 << dev->pcie_mpss to
> match the Root Port's maximum supported payload size. The Max Read Request
> Size (MRRS) is subsequently adjusted through existing companion logic to
> maintain compatibility with PCIe specifications.
> 
> Note that this initial setting of the root port MPS to the maximum might
> be reduced later during the enumeration of downstream devices if any of
> those devices do not support the maximum MPS of the root port.
> 
> Explicit initialization at host probing stage ensures consistent PCIe
> topology configuration before downstream devices perform their own MPS
> negotiations. This proactive approach addresses platform-specific
> requirements where controller drivers depend on properly initialized
> root port settings, while maintaining backward compatibility through
> PCIE_BUS_TUNE_OFF conditional checks. Hardware capabilities are fully
> utilized without altering existing device negotiation behaviors.
> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Hans Zhang <18255117159@163.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/probe.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..9f8803da914c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2178,6 +2178,16 @@ static void pci_configure_mps(struct pci_dev *dev)
>  		return;
>  	}
>  
> +	/*
> +	 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all),
> +	 * start off by setting root ports' MPS to MPSS. Depending on the MPS
> +	 * strategy, and the MPSS of the devices below the root port, the MPS
> +	 * of the root port might get overridden later.
> +	 */
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +	    pcie_bus_config != PCIE_BUS_TUNE_OFF)
> +		pcie_set_mps(dev, 128 << dev->pcie_mpss);
> +
>  	if (!bridge || !pci_is_pcie(bridge))
>  		return;
>  
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

