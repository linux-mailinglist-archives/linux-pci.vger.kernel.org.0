Return-Path: <linux-pci+bounces-41455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F41AC6633B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 22:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 26719294B3
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 21:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B702C312812;
	Mon, 17 Nov 2025 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um4sNS3A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42280320CA7;
	Mon, 17 Nov 2025 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413687; cv=none; b=Nu04F3H43Yx7pPzp07OVic5qLTlnL6S6FHjjoesJlexfs07TolhpNt1IhdBs3JFLrv1w4Vw28kL/Ge8wUHt8d4uHT/DbvJ0u5krZEoOe319Eqec3w6jGM5B4oX8FFZdaASlawntoLI1+kmGuJ41xwMnvc/inCll4dCFaywhPAqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413687; c=relaxed/simple;
	bh=m5wXR+WzgIyBK//SH3KOITSdxcJXjtkopPA3gaeKiC4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UC8OqhH1Gbjzjqb506ZcXMvTZjYpJCZczUJ+Bkzy5KUH9HodJbCjmklEP502lKmov+z8vbZdwWULrEJ8dtfPPYqFEzh89OkXYPe/VvlEik0qJ4p9sO/VhVFh77djOKo8Rn6lFntyY7qbBTM/zsPs4LdwO+He5pVPnf6UJnZf+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um4sNS3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF94DC4CEF1;
	Mon, 17 Nov 2025 21:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763413687;
	bh=m5wXR+WzgIyBK//SH3KOITSdxcJXjtkopPA3gaeKiC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=um4sNS3AR4SMtN8GCGTbXzamEq/vK6yBeTIWEKbkXnw1Xi0Q3mKaAn8Ib0v9MLbkf
	 4E3sHqItyy8xhgty//iUXUNPPPsaIsDx53T9EWGtSHquxw7/RsXEQWm1TpWXzKBk29
	 IpmRbG4mwyV2PI9ZljT0pudYiCCv1yHG50bFR0YOocfg+oymUKNsEualZOc6x2CfO7
	 FPl8UA13eVutpZUpmeGFTQa7oyVw5VZCWs3JmswSBVJ26iQ0Ig++1FJd+WSoJhlDdA
	 MFKmX+laWpREQiUnCnwImAxSM1tJXaTW89rgOCIFa7bUNzASm1/mZruk9uvmgVFHrK
	 Fp3B+sN+N++cw==
Date: Mon, 17 Nov 2025 15:08:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
	fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 04/10] PCI: cadence: Add support for High Perf
 Architecture (HPA) controller
Message-ID: <20251117210805.GA2531096@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108140305.1120117-5-hans.zhang@cixtech.com>

On Sat, Nov 08, 2025 at 10:02:59PM +0800, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Add support for Cadence PCIe RP configuration for High Performance
> Architecture (HPA) controllers. The Cadence High Performance
> controllers are the latest PCIe controllers that have support for DMA,
> optional IDE and updated register set. Add register definitions for High
> Performance Architecture (HPA) PCIe controllers.

>  /**
>   * struct cdns_pcie - private data for Cadence PCIe controller drivers
>   * @reg_base: IO mapped register base
>   * @mem_res: start/end offsets in the physical system memory to map PCI accesses
> + * @msg_res: Region for send message to map PCI accesses
>   * @dev: PCIe controller
>   * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
>   * @phy_count: number of supported PHY devices
> @@ -45,16 +85,20 @@ struct cdns_pcie_ops {
>   * @link: list of pointers to corresponding device link representations
>   * @ops: Platform-specific ops to control various inputs from Cadence PCIe
>   *       wrapper
> + * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
>   */
>  struct cdns_pcie {
> -	void __iomem		*reg_base;
> -	struct resource		*mem_res;
> -	struct device		*dev;
> -	bool			is_rc;
> -	int			phy_count;
> -	struct phy		**phy;
> -	struct device_link	**link;
> -	const struct cdns_pcie_ops *ops;
> +	void __iomem		             *reg_base;
> +	void __iomem                         *mem_base;

  $ DIR=drivers/pci/
  $ find $DIR -type f -name \*.[ch] | xargs scripts/kernel-doc -none 2>&1
  Warning: drivers/pci/controller/cadence/pcie-cadence.h:101 struct member 'mem_base' not described in 'cdns_pcie'

Can you supply text for this doc?  We can amend the commit to include
it.

