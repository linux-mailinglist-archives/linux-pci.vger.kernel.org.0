Return-Path: <linux-pci+bounces-35122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D7BB3BCF5
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA9B1BA2B0C
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8E131DD85;
	Fri, 29 Aug 2025 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG7qR2Np"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C27347B4;
	Fri, 29 Aug 2025 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756475827; cv=none; b=MdwweYw+aOTZst99LnJKQb1sygAr1HjsEf8zs7fTbl5ZQndNSsz9oYgdUF7t/A5h6SFg7LoIfds8g3NZYNYaUVt1mY156ya+BaF8bpmxyYtOLkYfA62pk46LbgeMXkqlytp5yO3gxNjM5OszPUi6O/Uq2+Hptpq51r6UPQStOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756475827; c=relaxed/simple;
	bh=TPcM7vsR5BgNayppQJ/9+eqOOaE0BLCmHtlJiHw2x00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiC7V5CJTFIcYKnE+M1+gWn6XvuqiKvY+BRHq2g4wWtmCK7uao1TSaGEAi7LsRd+xXKX3Q/OgdiSmjwBaQ9IbGRPxe/mJcZp0hecF5PPZrI+ybcb5foY3+pZ5P6Aa3eArYRIDnUy1kJiiTcuEHqxqqnuQnnxxplXefe1FJGI1b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG7qR2Np; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3EDC4CEF0;
	Fri, 29 Aug 2025 13:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756475826;
	bh=TPcM7vsR5BgNayppQJ/9+eqOOaE0BLCmHtlJiHw2x00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HG7qR2NpViDP3330Rb3+QPhGOoxUP21ucjupQwVZKBcIDr6ufqfMnR0hZ92q/tXjj
	 RmOWxxOjua0rd4S3QlxP5u55wLh0SkpxoR8gxxnjs1oSWUq9Wzv45cyjdJpj6R/x1q
	 Fqb9eIP6XcU+N5ZjhpwAm87yAyqOongAIahxeIav2dVjcbL6V1mlQQ0EM3s1NSBSfy
	 myXVVVHQeEI+43tlZF1SvT0V3sD4rfF8O9njHVkY+uD6QLq+0PMjyXEDbdDLmnNu3P
	 3Fl5/n5sqcruuH6EstM67V0Y4OPto9EUCzd5+nOaQ9TcYhk2Yc07/m71tRiZsnTTMN
	 y9f/ja0kprk1w==
Date: Fri, 29 Aug 2025 19:26:56 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v6 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <zhu77qldhrr7ovp2g2tpusl67zsacjx5oapnaasxo2ybmhfohn@io3oqqc6gtte>
References: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
 <aLC1rzdTVoN56Phc@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLC1rzdTVoN56Phc@google.com>

On Thu, Aug 28, 2025 at 01:01:51PM GMT, Brian Norris wrote:
> On Tue, Jul 15, 2025 at 07:51:03PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > Hi,
> > 
> > Currently, in the event of AER/DPC, PCI core will try to reset the slot (Root
> > Port) and its subordinate devices by invoking bridge control reset and FLR. But
> > in some cases like AER Fatal error, it might be necessary to reset the Root
> > Ports using the PCI host bridge drivers in a platform specific way (as indicated
> > by the TODO in the pcie_do_recovery() function in drivers/pci/pcie/err.c).
> > Otherwise, the PCI link won't be recovered successfully.
> > 
> > So this series adds a new callback 'pci_host_bridge::reset_root_port' for the
> > host bridge drivers to reset the Root Port when a fatal error happens.
> > 
> > Also, this series allows the host bridge drivers to handle PCI link down event
> > by resetting the Root Ports and recovering the bus. This is accomplished by the
> > help of the new 'pci_host_handle_link_down()' API. Host bridge drivers are
> > expected to call this API (preferrably from a threaded IRQ handler) with
> > relevant Root Port 'pci_dev' when a link down event is detected for the port.
> > The API will reuse the pcie_do_recovery() function to recover the link if AER
> > support is enabled, otherwise it will directly call the reset_root_port()
> > callback of the host bridge driver (if exists).
> > 
> > For reference, I've modified the pcie-qcom driver to call
> > pci_host_handle_link_down() API with Root Port 'pci_dev' after receiving the
> > LINK_DOWN global_irq event and populated 'pci_host_bridge::reset_root_port()'
> > callback to reset the Root Port. Since the Qcom PCIe controllers support only
> > a single Root Port (slot) per controller instance, the API is going to be
> > invoked only once. For multi Root Port controllers, the controller driver is
> > expected to detect the Root Port that received the link down event and call
> > the pci_host_handle_link_down() API with 'pci_dev' of that Root Port.
> > 
> > Testing
> > -------
> > 
> > I've lost access to my test setup now. So Krishna (Cced) will help with testing
> > on the Qcom platform and Wilfred or Niklas should be able to test it on Rockchip
> > platform. For the moment, this series is compile tested only.
> 
> For the series:
> 
> Tested-by: Brian Norris <briannorris@chromium.org>
> 
> I've tested the whole thing on Qualcomm SC7280 Herobrine systems with
> NVMe. After adding a debugfs node to control toggling PERST, I can force
> the link to reset, and see it recover and resume NVMe traffic.
> 
> I've tested the first two on Pixel phones, using a non-upstream
> DWC-based driver that I'm working on getting in better shape. (We've
> previously supported a custom link-error API setup instead.) I'd love to
> see this available upstream.
> 

Thanks, Brian for testing! I didn't get time to look into the report from
Niklas (which is the only blocking thing for this series). I'll try to dig into
it today/tomorrow.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

