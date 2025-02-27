Return-Path: <linux-pci+bounces-22531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC715A47AA1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 11:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B1317354B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 10:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532A322AE65;
	Thu, 27 Feb 2025 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nn6cMXto"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBE722A7E9;
	Thu, 27 Feb 2025 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653036; cv=none; b=WgFFu84f2JsuXSLB5dDRbYIewMI69STWUCYVfX4HeQJmqaHkRe147hoSNVqfDKvUx0onR5gnFwz7GHkMqSNSCBXSqN2HCWq1+6Vxw7lp1CDR9R+5DkLCvNzD1X7rZAZXdZtx4UM+YlmOSUhf2oLDiMtmHBeGEtDhReR2vn10fLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653036; c=relaxed/simple;
	bh=0Lg/vXMZjg3lT/2iTcOSysv91kBpkG77PhCcvzs0T+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qguaeDMZAQ4j/9lQhO7pwz+Njkd7uyLP9IRaapeARTNOZOzyeUhZttvRe3gUyqjtRxkLJURodtuHl4QjX4bV/p152HDqfIULFTqhFqbLXClq9xfkRlXs5j8oTvyv6PF2p7/STj41eNkoWKngTglS7+FKMyZbO/jSO8mOaPpMNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nn6cMXto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C20FC4CEE4;
	Thu, 27 Feb 2025 10:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740653035;
	bh=0Lg/vXMZjg3lT/2iTcOSysv91kBpkG77PhCcvzs0T+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nn6cMXto432+r1+NVzAt/LihInVYdsTz7mRbET+YaMuhfhQ4nlpASHjSANa5kvSi3
	 h4dgr+XIVXf4jcnNOGUKg/oMBhnX60sxBR4sP+yxfHjZ+tatl32nilS8gwCvm8JgiF
	 fdKvA/JjrHxK0eb4sLHgIakEyEkGDC0jfRRywVd8Y5jFgoW3ExO5jfSORAOdxWe/uL
	 +taRW8N1IwwdBq59nkw++mmIYObbmnF7gBXuESbLZvkOFngID/TPR1g7Salo7751/K
	 /O+jcjEW00Gf144maH0vdjVUtw7wea6rnABSEuUErQ5FoWegbHrEyGHCOalV75ymrl
	 RdEN4lZg+exrA==
Date: Thu, 27 Feb 2025 19:43:53 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [pci:controller/dwc 6/8]
 drivers/pci/controller/dwc/pcie-designware-debugfs.c:561:undefined reference
 to `dw_ltssm_sts_string'
Message-ID: <20250227104353.GA961034@rocinante>
References: <202502270336.4xpaTVPE-lkp@intel.com>
 <ef04f32a-593f-437d-8465-1634c12567ae@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef04f32a-593f-437d-8465-1634c12567ae@163.com>

Hello,

> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
> > head:   b9d6619b0c3ef6ac25764ff29b08e8c1953ea83f
> > commit: d4dc748566221bfdd0345c282ec82d3eee457f39 [6/8] PCI: dwc: Add debugfs property to provide LTSSM status of the PCIe link
> > config: sparc64-randconfig-001-20250227 (https://download.01.org/0day-ci/archive/20250227/202502270336.4xpaTVPE-lkp@intel.com/config)
[...]
> sparc64-randconfig-001-20250227:
> 
> #
> # DesignWare-based PCIe controllers
> #
> CONFIG_PCIE_DW=y
> CONFIG_PCIE_DW_DEBUGFS=y
> CONFIG_PCIE_DW_EP=y
> 
> 
> Since this config is not configured with CONFIG_PCIE_DW_HOST, and the
> dw_ltssm_sts_string function is in the pci-designware-host.c, the following
> compilation error occurs.

No worries.  Thank you for having a look!

> Can you help move the dw_ltssm_sts_string function to pci-designware.c or
> pci-designware-debugfs.c?

Have a look at the following:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=02001ce4ff42bd85be3ed8b4a0a2580156f032a0

And let me know if this is OK with you.
 
> Or should I resubmit v6 patch?

No, need.  Thank you anyway, though.

	Krzysztof

