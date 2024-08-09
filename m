Return-Path: <linux-pci+bounces-11562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C8094D7B9
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 21:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C431F21EDF
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 19:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3120D16133E;
	Fri,  9 Aug 2024 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeYHHjhY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031DA22EE3;
	Fri,  9 Aug 2024 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723233299; cv=none; b=LWSehGklk1XrXpT/mfHBBRHpFyAwnMh965K5KzZeVw58gj/SH8koz5K3tQcLNWAFhLxIqHyn/QnarBe2/U9ELhUXiZOLp/ZXnayG90qGp1eEvS0Cynod5DT9Do/iPXRzbUO9jAxxV73hWz0/O3Lxv/pKchfk4LreriYkhsAi8h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723233299; c=relaxed/simple;
	bh=yxgNLA1ilMmp2a3RrpUb2yDEIuTC6qQGtGFDKIQ4FGU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hRxLi3O+lY1eUb8b6OHEPSyBqBkQ8v9ZOmzZelvo4a7gTBYw46go2u8O7LkwRauHmYHd/CQsAHlTOgJ2rVcPKVL4wuYtO2IOotAZ5org1ONiBz3J6MNmdwRDbiEL/PIRP7PgSdHxteu/MRK+xdSKHL9TxynS46830mV1vT8fHl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeYHHjhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35633C32782;
	Fri,  9 Aug 2024 19:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723233298;
	bh=yxgNLA1ilMmp2a3RrpUb2yDEIuTC6qQGtGFDKIQ4FGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EeYHHjhYyIZf+kA1NCpAC+AgGWlSp4TXAbDOgVzRkGv7AGPs1aNQ7h4PYFzUra8Xd
	 w5kEv+iu3L80j/ZYBnvjhVpoMzQ9rmcKkIWy5Oyei4zPRyrAwn+JOfdYBaA7pQHASy
	 VpBfISBg3C1/VqJAsbLsf2vRrc1qoIdf8TVfXbn/acz4UbAxQEU2rEDqi1BjI/aX5K
	 bDFy/ALq1lKp10QFZBdmBKlueCJopfEebRH3mhFJMMDw6a8CxSKVlYaPjP6q/armsg
	 8TRmY7HwKZc93qUk5qezpJTPsAwKqSHl3nht9JVYDI27z6g8GMDSwWfZCbCCz6HiUS
	 PcXDoHew5zdUA==
Date: Fri, 9 Aug 2024 14:54:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/7] PCI: xilinx-nwl: Add phy support
Message-ID: <20240809195455.GA209828@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531161337.864994-1-sean.anderson@linux.dev>

On Fri, May 31, 2024 at 12:13:30PM -0400, Sean Anderson wrote:
> Add phy subsystem support for the xilinx-nwl PCIe controller. This
> series also includes several small fixes and improvements.
> 
> Changes in v4:
> - Clarify dt-bindings commit subject/message
> - Explain likely effects of the off-by-one error
> - Trim down UBSAN backtrace
> - Move if to after pci_host_probe
> - Remove if in err_phy
> - Fix error path in phy_enable skipping the first phy
> - Disable phys in reverse order
> - Use dev_err instead of WARN for errors
> 
> Changes in v3:
> - Document phys property
> - Expand off-by-one commit message
> 
> Changes in v2:
> - Remove phy-names
> - Add an example
> - Get phys by index and not by name
> 
> Sean Anderson (7):
>   dt-bindings: pci: xilinx-nwl: Add phys property
>   PCI: xilinx-nwl: Fix off-by-one in IRQ handler
>   PCI: xilinx-nwl: Fix register misspelling
>   PCI: xilinx-nwl: Rate-limit misc interrupt messages
>   PCI: xilinx-nwl: Clean up clock on probe failure/removal
>   PCI: xilinx-nwl: Add phy support

Applied the above to pci/controller/xilinx for v6.12, thanks!

I assume the DTS update below should go via some other tree, but let
me know if I should pick it up.

>   arm64: zynqmp: Add PCIe phys
> 
>  .../bindings/pci/xlnx,nwl-pcie.yaml           |   7 +
>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |   1 +
>  drivers/pci/controller/pcie-xilinx-nwl.c      | 139 +++++++++++++++---
>  3 files changed, 124 insertions(+), 23 deletions(-)

