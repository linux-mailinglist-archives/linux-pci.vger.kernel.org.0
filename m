Return-Path: <linux-pci+bounces-18407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492459F1533
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 19:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6B92846D1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 18:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834BC18CBE1;
	Fri, 13 Dec 2024 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVdhsT39"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5E51547CA;
	Fri, 13 Dec 2024 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115623; cv=none; b=dNKVHBqqeENdOoREsak+sFXlE3XuHQL8KfHUo2R0aDgWAMReGQdkeAY+PA/AiLSnFbWCngaGfdJrqFYVNmI+vXMJjj6GJfaxkO5vRWy08kV8pIr+S5Y9OTVLKkiYp+ZnQP89Csr7wVVeHNFA7iJ0vjTx/XY5dlep6UjLKvuEhHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115623; c=relaxed/simple;
	bh=OuLMV0zQ/jHtlcGfTN3vBPecDjzPfA1i/m3/mOtyIuo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Huf9PpQRQ06C3+8erw5xp4abNvocfz9OxXRt0KEDF0939AKGTLgW4esPQtOY2+5n15lXffMoic7t0GLsY3EAatIzveuQ3IOhGNxLphBoiikIs/vv2JJPfhzyNs4tY9LHJJjFEmgY3NsEEc0WuGVehn/2sBmP0MBygtoAcyRu5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVdhsT39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D1FC4CED0;
	Fri, 13 Dec 2024 18:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734115622;
	bh=OuLMV0zQ/jHtlcGfTN3vBPecDjzPfA1i/m3/mOtyIuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZVdhsT39/TZC+Zh4x0dWRAtjVN6TbVoxYEejZerqchVETr+7d7qoVXYLXmbOjEtP3
	 dPnCRKFfOLbF9TpbJfWsJGWoqRWrba5+1vfD5+fa8JukRYd31n80BMgqAqFdXCGIi3
	 M06Wd9s08IBdyDOtZF1awvl9H+kUubHpUIpDKl8t2QPu7GmwyCMRwASu4b6WJ74CXz
	 f/rZfHlHajIcS7433HAHhxQNp70nEo4zSTkXoieDHD0iaht99mvBnDiHz8i1oIu/+c
	 JqqBG3Li6td9Olizp+JUEB6AzLdAN2ytemdzukv9kjDNSFopHm7ASHKkR5S9ow/Rns
	 S5DLHQ6fvhHiQ==
Date: Fri, 13 Dec 2024 12:47:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] PCI : Fix pcie_flag_reg in set_pcie_port_type
Message-ID: <20241213184700.GA3423791@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213070241.3334854-1-gthiagarajan@marvell.com>

[+cc Mika, Andy]

On Fri, Dec 13, 2024 at 12:32:41PM +0530, Gowthami Thiagarajan wrote:
> When an invalid PCIe topology is detected, the set_pcie_port_type function 
> does not set the port type correctly. This issue can occur in 
> configurations such as:
> 
> 	Root Port ---> Downstream Port ---> Root Port
> 
> In such cases, the topology is identified as invalid and due to the
> incorrect port type setting, the extended configuration space of the
> child device becomes inaccessible.

From reading the code, it looks like the underlying problem is
components that advertise the wrong PCIe Device/Port Type.

set_pcie_port_type() already detects that incorrect Port Type and
tries to correct it, but it puts the corrected type in bits [3:0]
instead of [7:4] where it belongs.

This looks like a bug from ca78410403dd ("PCI: Get rid of
dev->has_secondary_link flag").  If so, we should add a Fixes: tag for
that and possibly a stable tag.

This looks like a clear bug.  What system tripped over this?  It's
useful to have bread crumbs like that in case we see other issues
caused by hardware/firmware defects like this.

> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> ---
> v1->v2:
> 	Updated commit description
> 
>  drivers/pci/probe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4f68414c3086..263ec21451d9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1596,7 +1596,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		if (pcie_downstream_port(parent)) {
>  			pci_info(pdev, "claims to be downstream port but is acting as upstream port, correcting type\n");
>  			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
> +			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM << 4;
>  		}
>  	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
>  		/*
> @@ -1607,7 +1607,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
>  			pci_info(pdev, "claims to be upstream port but is acting as downstream port, correcting type\n");
>  			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
> +			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM << 4;
>  		}
>  	}
>  }
> -- 
> 2.25.1
> 

