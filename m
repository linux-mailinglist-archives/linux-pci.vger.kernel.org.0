Return-Path: <linux-pci+bounces-9390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 597D191B338
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 02:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102A2283BA2
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 00:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A087E37B;
	Fri, 28 Jun 2024 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNXnLQxO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F9193;
	Fri, 28 Jun 2024 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719533536; cv=none; b=jGG/iQ6fP8pX1uCdsmvJxCaXZBMQPL111/kVFaEbMdlhPzgrw0S9exvEF7BcLIxXxyhbnXehQ08+zByuRa0wI0+WkORk+rF6coBwI+VSpDnG7rvlN69382IDIo4B4myzTZGwv/mi0qIKkM9DY9y21ONKJP70cTga0vjCQctg2bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719533536; c=relaxed/simple;
	bh=H/fT+DfVxtbUufv1/xpK7cKBSC3jOJ7umsudl9tb1SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCTEOEQIC+b3+5rXyAcR+B/dveLwNyRIAzhxrSWnyRt6TOKn+/XbXOmMhbYGxE2YcHOq+LBH2WNvJLJ9TYMKlIAGoH/zIwLncLZYKyqaX2u8BniEuz4lr18KIZMF7dBXzPyql3JBIDHwAiSvwFaFzBVzUqB+OLgo7ZZzqHYV5cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNXnLQxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDDFC2BBFC;
	Fri, 28 Jun 2024 00:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719533535;
	bh=H/fT+DfVxtbUufv1/xpK7cKBSC3jOJ7umsudl9tb1SQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZNXnLQxO9x7FvxiWuWl0GmxpFP0HzE2hIN0JHFzfH02/WUqqUOE5VkAuXViyDcCRZ
	 bdE+CeX5eYRlUgHauWhVdSCuW93uyTwPEN7QLMnT+v2lIU+YzHTsDJtJ/85irzt81c
	 NG7jtZJhBErsi8FyuvWXl4u/56eaR1e+Hr1N/Knnz74qQE/uyiq9SkeylaY7zHHNzz
	 CRRbmWMeifSqCJwoInuP0f6eyGlYbk0IygqMIcezv7/xRvZDXxaXxeRAJ/1ziWoQ0M
	 r3VRU7RBADP9x5Fnz8i6BiRx2XOLxKovbhW5EBSEKiE7cZneuHyA6uZkXXFtaTzVYk
	 ttoD0SY43fvCQ==
Date: Fri, 28 Jun 2024 09:12:14 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [pci:controller/rockchip 10/11]
 drivers/pci/controller/dwc/pcie-designware-ep.c:26:undefined reference to
 `pci_epc_init_notify'
Message-ID: <20240628001214.GB2060184@rocinante>
References: <202406270250.k2esVVnL-lkp@intel.com>
 <ZnxmHFkIvm-qTfiD@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnxmHFkIvm-qTfiD@ryzen.lan>

Hello,

[...]
> > All errors (new ones prefixed by >>):
> > 
> >    loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_init_notify':
> > >> drivers/pci/controller/dwc/pcie-designware-ep.c:26:(.text+0x1e4): undefined reference to `pci_epc_init_notify'
> 
> Seeing that it is pcie-designware-ep.c that fails to build, I can see the error.
> I have forgotten to do:
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 9c4fb8ba7573..4c38181acffa 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -329,6 +329,7 @@ config PCIE_ROCKCHIP_DW_EP
>         bool "Rockchip DesignWare PCIe controller (endpoint mode)"
>         depends on ARCH_ROCKCHIP || COMPILE_TEST
>         depends on OF
> +       depends on PCI_ENDPOINT
>         select PCIE_DW_EP
>         select PCIE_ROCKCHIP_DW
>         help
> 
> (The .config in this build has PCIE_ROCKCHIP_DW_EP selected, but not PCI_ENDPOINT,
> which should not be allowed...)
> 
> This is my fault, all the other endpoint drivers have a depends on PCI_ENDPOINT.
> Will send a patch for this shortly. I'm truly sorry for this mistake.

No worries.  Thank you for a quick fix!  Much appreciated.

	Krzysztof

