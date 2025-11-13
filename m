Return-Path: <linux-pci+bounces-41161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D3EC597BD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 19:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7FAC4E4AAE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A0E3596E2;
	Thu, 13 Nov 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBGgjN2+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2103590D2;
	Thu, 13 Nov 2025 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058337; cv=none; b=Qp5TJJrQYLKzvN5hHqhM0ZP7tFIodB3+YKWVCGKXrKOuBDNPskaEpRjn08Ly0En6DkXWQGZfy8/1XDwyMWA0OFKUteETGiMCD3YZe/64W/ioSOIsqD2HavfdM4Uyj0RRPLkR5OAE4wIV6zsoNFbcyMsyO2NEqUOet8T05zIQeWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058337; c=relaxed/simple;
	bh=gsxNH+9KT9ljmdwEWWaU8Ik/ecApYq3Gd/rK1eq0pfM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b21VkwfF1B9a8Nf5ZmFwc/r3GDpXOj5IkDTbe88Paug8OnYrnJuUlElL+lDRG23+nUg7RM8moMQAvg/oIGqx8lZjJVyZGl51fSslzT/9IA7vlaCV3cA3L2+yjmiivi2TXbfCnJ3hpLkYjzVfe9W0/Tbtof/sLWXo4TeUsosF2OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBGgjN2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C97C19421;
	Thu, 13 Nov 2025 18:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763058337;
	bh=gsxNH+9KT9ljmdwEWWaU8Ik/ecApYq3Gd/rK1eq0pfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CBGgjN2+OSsYjDKvKRBNNaNvimNMYlaKiUjiyTiOsQ0vJAml/gc51pEvcXJ2apIO+
	 Oa8qBf3uDqkGeMWQpKmtcEbsXXsql5mPPmrI/WWSf4xpEOWJmBPZHMdbUKSVIOneqP
	 tHZGWY3SueHe9/myJebYL4n9AJtSdL36u+5AAd4m5ruNacVn4ZyLht8G7UL3z/2hqc
	 9HedqpvbTgPyd9jZaCYlma86hjYuaFStry68xNxlCm33RJKhr2mNzYz0zrGiKtFFfX
	 ji5x7U55qZwnWREhZAL3AWudthKZIhuok76ItVfZXd4Yj2zMvCofpQFB/dsJ1Ovm/f
	 mz1b2kaSkKK/g==
Date: Thu, 13 Nov 2025 12:25:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	christian.bruel@foss.st.com, krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com, shradha.t@samsung.com,
	thippeswamy.havalige@amd.com, inochiama@gmail.com,
	fan.ni@samsung.com, cassel@kernel.org, kishon@kernel.org,
	18255117159@163.com, rongqianfeng@vivo.com, jirislaby@kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH v5 0/4] PCI: Keystone: Enable loadable module support
Message-ID: <20251113182535.GA2295551@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176241661035.23562.15419519383714568853.b4-ty@kernel.org>

On Thu, Nov 06, 2025 at 01:40:10PM +0530, Manivannan Sadhasivam wrote:
> 
> On Wed, 29 Oct 2025 13:34:48 +0530, Siddharth Vadapalli wrote:
> > This series enables support for the 'pci-keystone.c' driver to be built
> > as a loadable module. The motivation for the series is that PCIe is not
> > a necessity for booting Linux due to which the 'pci-keystone.c' driver
> > does not need to be built-in.
> > 
> > Series is based on 6.18-rc1 tag of Mainline Linux.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/4] PCI: Export pci_get_host_bridge_device() for use by pci-keystone
>       commit: 88254d46823be8563f8f81d78390a7313ae6fad7
> [2/4] PCI: dwc: Export dw_pcie_allocate_domains() and dw_pcie_ep_raise_msix_irq()
>       commit: 9acc60a5bca02351f852651c0123d9994663ec0a
> [3/4] PCI: keystone: Exit ks_pcie_probe() for invalid mode
>       commit: 7b5a5b7715c2dea2541e7fd3da15c2881fdfc553
> [4/4] PCI: keystone: Add support to build as a loadable module
>       commit: 041c2f0e34ba4823101bf307d6a6d41d98f5dac3

Just FYI, I moved these to pci/controller/keystone to separate them
from the j721e changes on pci/controller/ti.  It's a little easier for
me when each driver is on a separate topic branch.

I also reordered them so all the module-related changes are together
instead of having the invalid mode bug fix in the middle of them.

