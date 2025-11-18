Return-Path: <linux-pci+bounces-41534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03092C6BA87
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 21:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22E1A4E9877
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 20:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1162F6907;
	Tue, 18 Nov 2025 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUKNJTdr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB22F6590;
	Tue, 18 Nov 2025 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763498201; cv=none; b=O8ZiuDzKszkdsEk/tkI5yEyu0Ocxs4Wa8QXiNe3ve9QrWksyN2CgfJoZ2O1Lz3muKNLunp9aChoOx49H4/i7oy/seE6ggNlkHLMJfILts4GygvuTBuaDkRG2BYqMsSEiKLRLfb9SRXZzNKV7Bfnu1X9Y8ixD/7yuUIJ14HuNfQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763498201; c=relaxed/simple;
	bh=7+fzDFu+Xsrqk+asVMqRrwMUh6tY3yPTNkgieoOI/zM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qqyzUqHrf54v8S1mFL32FIaNyD/aMQvJfsr0iuyo306itEFFloDvEBx3URQBeHbSUNTHo1y8gQqzRNuWBi6/MOFMDK7BZ6M05+97btZV5ZP4V5BN4192jd45d0ZOljF2nFHXJrZYqRmQdgYW4UzwBqvBVT70tIf+9JxRV9422CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUKNJTdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB59DC4AF0B;
	Tue, 18 Nov 2025 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763498201;
	bh=7+fzDFu+Xsrqk+asVMqRrwMUh6tY3yPTNkgieoOI/zM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YUKNJTdrgbSbMX3k+HhtPzZK7EHha3KqXakAdqfJuSLs3e1EuenP2tifpMHMuz+//
	 60L/jEi9R9dpl8wIyag9yLxPtGq0zTZpKEgLH6hXcMG0qZbrpU5/EJQdr/oWBnMSdD
	 Y5jrD4k4lBA0NE+z2nITN35iYooT8yy8YWTL4N9Elww8UNhtZOdhcEPpOzpCW5vUvK
	 Po4zHQQQEzU12iE+do16kxdomaLNC5Q03u19JQrcG4D6V4woIP7u2chMFlEK8QfJBT
	 5/sb9D1QRKk3MjjoVmBZSt6RA2AlSYOBCgdHf6q9TsCgelGKrQA3/os3D0WExgOB+Q
	 4i3wUV1L9RXCw==
Date: Tue, 18 Nov 2025 14:36:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.li@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hans Zhang <hans.zhang@cixtech.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@pengutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/4] PCI: dwc: Advertise L1 PM Substates only if driver
 requests it
Message-ID: <20251118203638.GA2591575@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRRDzKFVTFTIuvvh@ryzen>

On Wed, Nov 12, 2025 at 09:22:36AM +0100, Niklas Cassel wrote:
> On Tue, Nov 11, 2025 at 04:16:08PM -0600, Bjorn Helgaas wrote:
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -1060,6 +1060,8 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> >  		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> >  	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
> >  
> > +	dw_pcie_config_l1ss(pci);
> 
> The name dw_pcie_config_l1ss() sounds like we are enabling l1ss.
> 
> I know naming is hard.
> 
> Perhaps dw_pcie_disable_unsupported_l1ss() ?
> 
> Or something similar.

"disable" sounds like something we do with a control register, and
here we want to remove the advertised support from the capabilities
register.

Maybe dw_pcie_hide_unsupported_l1ss()?

Bjorn

