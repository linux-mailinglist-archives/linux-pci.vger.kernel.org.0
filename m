Return-Path: <linux-pci+bounces-9337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC349194E3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 21:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC271F23342
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 19:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C739517D365;
	Wed, 26 Jun 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnQ/uhCv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02E17C22A;
	Wed, 26 Jun 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428644; cv=none; b=Avch9p6zkHc4sn+tvbyHJAn1S4ZZNYq+X/3MXg2tSuQ9RneGA77FB4ScrdPtNkg68NyQHY3HGM8TNSDj0rCKx1LELtbK1alkTdwGNkO2E0VLV8WyD0mNrhAKwpo2wVGPNQs6Mp6oFpED/qP2h6+Bwp9q0dY55eGVv8db8RYzZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428644; c=relaxed/simple;
	bh=p3XYPWeJ5vWy755pwk4qlysB95s+FcjpaEBY1UpmIRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEutwNYmRy45RYwysfUZPpozU+jJcM6nweT4A1TXS/bGyU593JyP57KIH1osnEtIZDJZwev06Hbj1j5muH44PI9CMpzHOk0UWhjFsN77QleR1rHXETXzBNpJFGKpkan9e5H8JqRh841hhxeDDxGZR81r+VdJ2bHxMlhDS+Xr8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnQ/uhCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4167FC32789;
	Wed, 26 Jun 2024 19:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719428644;
	bh=p3XYPWeJ5vWy755pwk4qlysB95s+FcjpaEBY1UpmIRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BnQ/uhCvJZm6OlKDq5Q7p+ZwCZ57vUYhKs5hgyLhfyHuM3fxFBQRowmP2XxoGrbre
	 f6zeAQSLRf2j5OWhV31rKDOBfgyfcxunOOElfDFpdzBVem4PgwCxvFGdDc0rrLTm0X
	 LlPN9PBMu8x4cD4MhOKU4nz21Eu8D+cpluBSnuxBEuTjQx80LJybhjXZnMV09TiEMV
	 75dx4XfV0i4kI5ioQ2xG6R2QplOHRnLwjdVO0n9+fo7MiCaWVgyeGdO2jE8Wc8Tye8
	 1cCYepmOozNqWvragpi5x6qHXJ9TWaYWBYI9PT5Rmts58T0YRnn8lz8kbf07VhPHPF
	 gAsMcGXdyHN5Q==
Date: Wed, 26 Jun 2024 21:03:56 +0200
From: Niklas Cassel <cassel@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [pci:controller/rockchip 10/11]
 drivers/pci/controller/dwc/pcie-designware-ep.c:26:undefined reference to
 `pci_epc_init_notify'
Message-ID: <ZnxmHFkIvm-qTfiD@ryzen.lan>
References: <202406270250.k2esVVnL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406270250.k2esVVnL-lkp@intel.com>

On Thu, Jun 27, 2024 at 02:23:38AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
> head:   246afbe0f6fca433d8d918b740719170b1b082cc
> commit: 9b2ba393b3a659a4695691794dc030b6f7744b23 [10/11] PCI: dw-rockchip: Add endpoint mode support
> config: loongarch-randconfig-r081-20240626 (https://download.01.org/0day-ci/archive/20240627/202406270250.k2esVVnL-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240627/202406270250.k2esVVnL-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406270250.k2esVVnL-lkp@intel.com/
>

Hello Krzysztof,

> All errors (new ones prefixed by >>):
> 
>    loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_init_notify':
> >> drivers/pci/controller/dwc/pcie-designware-ep.c:26:(.text+0x1e4): undefined reference to `pci_epc_init_notify'

Seeing that it is pcie-designware-ep.c that fails to build, I can see the error.
I have forgotten to do:

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 9c4fb8ba7573..4c38181acffa 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -329,6 +329,7 @@ config PCIE_ROCKCHIP_DW_EP
        bool "Rockchip DesignWare PCIe controller (endpoint mode)"
        depends on ARCH_ROCKCHIP || COMPILE_TEST
        depends on OF
+       depends on PCI_ENDPOINT
        select PCIE_DW_EP
        select PCIE_ROCKCHIP_DW
        help

(The .config in this build has PCIE_ROCKCHIP_DW_EP selected, but not PCI_ENDPOINT,
which should not be allowed...)

This is my fault, all the other endpoint drivers have a depends on PCI_ENDPOINT.
Will send a patch for this shortly. I'm truly sorry for this mistake.




Looking more closely at the pci/controller/rockchip branch,
I can also see that we have another potential problem:

Commit 7a847796e509 ("PCI: endpoint: Introduce 'epc_deinit' event and notify the EPF drivers"),
which is on branch: pci/endpoint
has introduced a stub (dummy definition) for pci_epc_init_notify.
However, if the test robot builds the pci/controller/rockchip branch with PCIE_ROCKCHIP_DW_HOST
selected, and not PCIE_ROCKCHIP_DW_EP selected, we could get a failure that pci_epc_init_notify()
does not have a stub...

This problem can be solved by cherry-picking 7a847796e509 ("PCI: endpoint: Introduce 'epc_deinit'
event and notify the EPF drivers") to the pci/controller/rockchip branch, or by rebasing the
pci/controller/rockchip branch on top of the pci/endpoint branch... I'm sorry for this too.


Kind regards,
Niklas

