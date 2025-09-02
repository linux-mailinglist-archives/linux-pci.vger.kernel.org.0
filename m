Return-Path: <linux-pci+bounces-35335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F20AB40C67
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 19:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9121B219DC
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA52730C36D;
	Tue,  2 Sep 2025 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpgiDiHI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5A232F761;
	Tue,  2 Sep 2025 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835310; cv=none; b=K4HFxX13WMWOfor8wh3wVMXbxwyjNlMn56p6l03ki00qoODV5bhdTz4Uolmvzxe9i2E7OvCvnAy6/ohB55eKSzEZCpQBXBZZcVEmSafA7cRby4GCrjeNgJHVO+5Z6MtXMFuovLFi7U9UkjfDLACanu3N2MGt4FjgO5V95sM6mO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835310; c=relaxed/simple;
	bh=Ml5xDwIj2ou2yj2DtWoHvojD3g+Fyp27UWcuuPsZx30=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Oyvv5GO6mR1xh32kcRn5Zfn1y06guTxtftmNLKkTO5Nzfc4PiHOq3If4s3odkk55YxYHIPCAK5nK2SLtRQnmYL7FySzwgih4sJPeeBFpBvR9OghW6QD1oIjU/Piaw5myKQaQN/QD6vmRajocZ25b7rvNBG+EO+0F5z5qYPBhpcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpgiDiHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B832C4CEED;
	Tue,  2 Sep 2025 17:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756835310;
	bh=Ml5xDwIj2ou2yj2DtWoHvojD3g+Fyp27UWcuuPsZx30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VpgiDiHIzDRjLEPSlhTvW8AjxfDsKuQE4Ar7rjQicUnXODvJeZ41RJ+LppU5vwSuU
	 K8qGjkNpw1qFDxJnNzZvYBc70U9C71dbTP/DLqYceHZuNFvfB14g9spGiLkmmw8Jcf
	 DMznEoe3YYXsuGT5+WYNjofzk2zqkGeAFIKBjRPTJ7eMobvVP1j7z7eK8WfyN7n2hf
	 xiMaDMHewuZ16HSj/lXJUTU5Sj847GIDrNK3qHS/CjHacl2Ud6yTaeHcolYR0u/WwB
	 OhvnrJiaZOXBbr2QsG38HCoIrFKje9afPMVrqbes7OpiR+eFs4LFi3zHYO9IRYL1JN
	 IXvExVf8LLogA==
Date: Tue, 2 Sep 2025 12:48:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, mani@kernel.org, yue.wang@amlogic.com,
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v5 1/2] PCI: Configure root port MPS during host probing
Message-ID: <20250902174828.GA1165373@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620155507.1022099-2-18255117159@163.com>

On Fri, Jun 20, 2025 at 11:55:06PM +0800, Hans Zhang wrote:
> Current PCIe initialization logic may leave root ports operating with
> non-optimal Maximum Payload Size (MPS) settings. While downstream device
> configuration is handled during bus enumeration, root port MPS values
> inherited from firmware or hardware defaults ...

Apparently Root Port MPS configuration is different from that for
downstream devices?

> might not utilize the full
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

This last paragraph seems kind of like marketing without any real
content.  Is there something important in there?

Nits:
s/root port/Root Port/

Reword "implementation now configures" to be clear about whether "now"
refers to before this patch or after.

Update the MRRS "to maintain compatibility" part.  I'm dubious about
there being a spec compatibility issue with respect to MRRS.  Cite the
relevant section if there is an issue.

> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Hans Zhang <18255117159@163.com>
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

