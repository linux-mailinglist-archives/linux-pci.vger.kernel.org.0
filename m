Return-Path: <linux-pci+bounces-35497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8ACB44CE2
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 06:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559133A4B04
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 04:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AC0220F37;
	Fri,  5 Sep 2025 04:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsjcrEMK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC7163;
	Fri,  5 Sep 2025 04:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047783; cv=none; b=JIKvu8vpfoNvK/BlOl6jNCgpo6qzS+l6rvyaOKxpspFrMMBt0wVYFgb5li4su966nDsMqjtt9oT4ad/5ePTmt6vZTZjsqoVdk1XOcsqx9H6p1uRfp4I9rrjaj0XSnZE+VFf98k3qywKRU3AXC4aIWzW9/XocWDGBzuXSlWELEdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047783; c=relaxed/simple;
	bh=NkpSfKm2erUGFO6gXufpAnnnPYdXKxwB0jgZPdom6OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqQXNPeiY6/UGwiaGFc4D2MXnlBRph927/pYLondRa15Sw/49PGTv7em0pbl4aW+pgqe4adc/tLXcbR98U65FFLaUA6LnJfbYGUeeiVrQN64hLhGPGrOBjf3pY8qvXNGFGHbn20COJlAfcmdk6EWVxRb9OC/l2faPjS9/WX2E5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsjcrEMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F9FC4CEF5;
	Fri,  5 Sep 2025 04:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757047782;
	bh=NkpSfKm2erUGFO6gXufpAnnnPYdXKxwB0jgZPdom6OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZsjcrEMKYG2Is6dS8xoziwQTKf17vw4v0Ozx7cUETrkA3VjCTKPgTsahd9fFcF8Is
	 IYNJwop+ZTHK4Lc/wf/2kSKRRRPpg45bTGXCPmIDhShhD5kxLyGisAjgVZra0vtoFS
	 pCOkp/hi02kGWFzzH5cE5ToGsta/gljcbDyLXf2fZhef8u40Vt1CvZHW2KnwZNYq42
	 qW9YRm6J+fzg5r6J+AmL7GvHgukMo/EZXffADMc+VfXfzDnxGa3fHqIkcOjUnzrX8y
	 fGYYn7ZqJPuc8sziveEIPTu84g8duIDHocKg+KWK2+n4wOAh5RmkKI76jRLjdLWSgc
	 Nxb5yq4PjR2Rg==
Date: Fri, 5 Sep 2025 10:19:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>, 
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 5/5] PCI: qcom: Allow pwrctrl core to toggle PERST#
 for new DT binding
Message-ID: <bopnxvhphvkq63pgcxb42yznshlaok5vgobgwh4jydej6jgdjp@yuzepkkdzggm>
References: <20250903-pci-pwrctrl-perst-v2-5-2d461ed0e061@oss.qualcomm.com>
 <202509041110.4DgQKyf1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202509041110.4DgQKyf1-lkp@intel.com>

On Thu, Sep 04, 2025 at 11:19:30AM GMT, kernel test robot wrote:
> Hi Manivannan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 8f5ae30d69d7543eee0d70083daf4de8fe15d585]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/PCI-qcom-Wait-for-PCIE_RESET_CONFIG_WAIT_MS-after-PERST-deassert/20250903-151623
> base:   8f5ae30d69d7543eee0d70083daf4de8fe15d585
> patch link:    https://lore.kernel.org/r/20250903-pci-pwrctrl-perst-v2-5-2d461ed0e061%40oss.qualcomm.com
> patch subject: [PATCH v2 5/5] PCI: qcom: Allow pwrctrl core to toggle PERST# for new DT binding
> config: i386-buildonly-randconfig-002-20250904 (https://download.01.org/0day-ci/archive/20250904/202509041110.4DgQKyf1-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250904/202509041110.4DgQKyf1-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509041110.4DgQKyf1-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/controller/dwc/pcie-qcom.c: In function 'qcom_pcie_host_init':
> >> drivers/pci/controller/dwc/pcie-qcom.c:1405:23: error: 'struct pci_host_bridge' has no member named 'toggle_perst'
>     1405 |         pci->pp.bridge->toggle_perst = qcom_pcie_toggle_perst;
>          |                       ^~
> 
> 

We can ignore this error since CONFIG_PWRCTRL_SLOT will be selected by default
with this commit: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/qcom&id=add7b05aeeb417c86239e6731a168e6c46b83279

- Mani

-- 
மணிவண்ணன் சதாசிவம்

