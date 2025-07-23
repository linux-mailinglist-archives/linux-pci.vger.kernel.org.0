Return-Path: <linux-pci+bounces-32820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3772AB0F56E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 16:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B7F189B90C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 14:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC732F5314;
	Wed, 23 Jul 2025 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGuCA5ca"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165682E7BBD;
	Wed, 23 Jul 2025 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281298; cv=none; b=LeKvIJtyRl4AzHV9zTFtwSU2Kx2eXxe3ZxABAUPpa7GWjzCvj7rtZIAKBvmCgFu96Z/aYpG0t/FY20aMaAE91XRfuevPo6rpVTVNPBFwcpNfmQs5w48vLvi9VjePFN2sFQoxuX/yuNENf2qUGZS/YJYFNVoCcRt+eEoQ+lhZQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281298; c=relaxed/simple;
	bh=hqQgXXO/2Sxe0qvV4ysJSFDc0vsyketKesbfM+KBHTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqXOU+UdB72JrcHmHcLOe7fd+QrRiXinxn+2xsOfh/5oS1ecOeznvNl1jGga6vHJXC3JZPjWWqGdOAyJiACN0xmRkvoeu1Q5iPU/MBe0YOcZPbdI06+xlsWCu7RVipUVBqThMxOIM5hJUdd096TAdts25FRfudjm+DqPOgAWwrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGuCA5ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D19C4CEF1;
	Wed, 23 Jul 2025 14:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753281297;
	bh=hqQgXXO/2Sxe0qvV4ysJSFDc0vsyketKesbfM+KBHTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGuCA5caY3RTuxc6BqatpaaL7WVJccOd+gLxQA/lKzjEzu/CcJ5sfCJgjkcB3p8qT
	 0HzTnwQJOYZ7Eea4+VY4e2K91DiL/S6topwdE/Cr0xMovGlvW4qcvZ/D0oTNMLcAQx
	 0WJ1EVJ8P+BA4+U1qWwpw0Ldi9iX2MwEfdZrVmbiMAZLndOgBn6CcV8R9bJ8O/QB2a
	 4XSCnK+/kLmGyGPyLeZzjPY4rQgrw48Mj1d/WFbxtSRgIsU91XkieImQVehzzzp+T9
	 EBrTWhjGqZEwUZrA5Uf8OT+oSXtdP6Y/AWI0ixHUHVlrvTYwKdE4gHeCKKji/2bZiZ
	 KMeAdnXzlINRw==
Date: Wed, 23 Jul 2025 20:04:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wenbin Yao <quic_wenbyao@quicinc.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, sfr@canb.auug.org.au, qiang.yu@oss.qualcomm.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, krishna.chundru@oss.qualcomm.com, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, quic_cang@quicinc.com
Subject: Re: [PATCH v5 1/3] PCI: dwc: enable PCI Power Control Slot driver
 for QCOM
Message-ID: <g4vti733clyly7uludeypp55s2s3ajznw4g3mjgo3segah3zdm@uixreuvty7px>
References: <20250722091151.1423332-1-quic_wenbyao@quicinc.com>
 <20250722091151.1423332-2-quic_wenbyao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722091151.1423332-2-quic_wenbyao@quicinc.com>

On Tue, Jul 22, 2025 at 05:11:49PM GMT, Wenbin Yao wrote:
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

I guess you also need 'if HAVE_PWRCTRL'

- Mani

-- 
மணிவண்ணன் சதாசிவம்

