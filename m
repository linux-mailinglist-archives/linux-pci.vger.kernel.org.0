Return-Path: <linux-pci+bounces-32764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A4FB0E726
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 01:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2290F4E13E6
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 23:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924E928983F;
	Tue, 22 Jul 2025 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMC3OB8F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF427EFF1;
	Tue, 22 Jul 2025 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226577; cv=none; b=CECNMEkALgyI8RiQxoJHYSlUs9RmichJ4fCLJ7j5eLlceVMfoTPO1fIfiht8agLKEy+PoQ7R9xi407GVgp1RkDyyRkr5G+cma3AorPAhy+blry7y/+v/RadZuLk9kTsPeacCT03zvarTtnI47oFHw3O5UP7xDzc+CCsq7TG6UAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226577; c=relaxed/simple;
	bh=Fxj9JRMRgt+KVGsFszP71lO3c4aqgzXMRdslpFz6vdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZOYLJWfjxJO4kdmJh2iiF5zxaD2rAASaGP9mMU4zXX6zk8TTAGnJe2+yDH6mAqM5AsHYEgv2B/llZ/+v0vyisGjTP3CtkS69wBQ5E1RmsKobeuPWs4e7ViQ+c7QgeXn0WTI8sLd+yQ3pCLgnWC1z+tbcRW18jhE3ZbHazUx8Kwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMC3OB8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC49C4CEEB;
	Tue, 22 Jul 2025 23:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753226576;
	bh=Fxj9JRMRgt+KVGsFszP71lO3c4aqgzXMRdslpFz6vdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fMC3OB8F4NmhAxrF0Hlmnde1WUMyC3T+rL1fbqTk26Z7jVASLP29Sypd187BS3K9o
	 ruCivcSy4rkfTm2uzkyrcGHK2gX5GoF1LDXAm8r2WoztxGRpY6hLjj7o/jV1r73B6X
	 1iuhTqplL2F9uMjey6Pu/pepIb1JYM0YoBQVmXCDMY2CDZ2+rynDHEfhbMBGUCfRA9
	 +1wu4Xw9reVFlFXNp/VfNx4288QudK93yj/weNf6iVyEJotkoLsZikGvcmnhy5ajMV
	 4WObiiYYoovspZ4N9lftVyqsm13ucp3Q+F2pW0RC1Uo6V9vYFeJ6Eru50Ws50n3veH
	 WH926QY6PjMAw==
Date: Tue, 22 Jul 2025 18:22:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wenbin Yao <quic_wenbyao@quicinc.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, sfr@canb.auug.org.au,
	qiang.yu@oss.qualcomm.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	krishna.chundru@oss.qualcomm.com, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, quic_cang@quicinc.com
Subject: Re: [PATCH v5 1/3] PCI: dwc: enable PCI Power Control Slot driver
 for QCOM
Message-ID: <20250722232255.GA2864066@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722091151.1423332-2-quic_wenbyao@quicinc.com>

In subject:

  PCI: qcom: Enable PCI Power Control Slot driver

This is not a generic dwc change; it's specific to qcom, so I want the
subject to reflect that.

We can fix this when applying unless other changes are needed.

On Tue, Jul 22, 2025 at 05:11:49PM +0800, Wenbin Yao wrote:
> From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
> Enable the pwrctrl driver, which is utilized to manage the power supplies
> of the devices connected to the PCI slots. This ensures that the voltage
> rails of the standard PCI slots on some platforms eg. X1E80100-QCP can be
> correctly turned on/off if they are described under PCIe port device tree
> node.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
> ---
>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index ff6b6d9e1..deafc512b 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -298,6 +298,7 @@ config PCIE_QCOM
>  	select CRC8
>  	select PCIE_QCOM_COMMON
>  	select PCI_HOST_COMMON
> +	select PCI_PWRCTRL_SLOT
>  	help
>  	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
>  	  PCIe controller uses the DesignWare core plus Qualcomm-specific
> -- 
> 2.34.1
> 

