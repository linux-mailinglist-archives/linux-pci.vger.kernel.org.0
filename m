Return-Path: <linux-pci+bounces-44272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAEDD0210F
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 11:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECBB631844F9
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 10:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A9F3ACA69;
	Thu,  8 Jan 2026 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diuT7vHS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11823A9637;
	Thu,  8 Jan 2026 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866376; cv=none; b=Qff06X620lTbST6jLBmlqmZ/MTd8ma7I8nY2U8Zk7/nYheY4ptv+zni7yEARDcRlEpBuWLRaEO03mDa8OJdCchVp2bfxVedcKujJE0OSguc8DWrH9kipjdmGR+ymUCk1XvOWfjCikcAbed4+cTw+J2bKBdpLQjT68vOtWNVQWaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866376; c=relaxed/simple;
	bh=KRhU4nFpzJVnAAE7oemevk+LKm8z+dwR+AvlSU8/9Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhxiTuTSSx5VbAWV+hSkHgOAMV47IiXVXJjrqTZWXobsIQfSxCSjCG/CTmwO41I/zqlfhCfp9eBbYkNrs97bzvyqtnxcdnlU8R6pjTJu1cFep83uDcnfN0cJKykYL/JwJbm8f/R5zYSYYYd0sWIfW7PyQn2npOunguD9m5HPR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diuT7vHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769CBC116C6;
	Thu,  8 Jan 2026 09:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767866375;
	bh=KRhU4nFpzJVnAAE7oemevk+LKm8z+dwR+AvlSU8/9Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=diuT7vHSUUcxWScM+8U8vhwEbNA49LADj+9Zoa9tYgmisey3xGBSCbnOCupaqIhRV
	 ZnwdmCMHnCbUuiVGWtr0M97ofxaJ445TyGenIBTEU5EslTiSz049PWU4Nk7RHhyU7e
	 whZVN0iSo3fEBCaNtnbgc1kOo8MWrpMO8M9uFO2d3ZX9agi+TaE4DARBZDo3Jfu/L6
	 LprCBtj3XxMZfOil0HWhIcEJ0Kr83wQx3n/DFATZt8UkqwUORntt/wIicJxD74Tic9
	 7a9BaCs752l7s5IQBPM5yiBFsZQ5M/jjqcCbhAom+otVuC1GQU39VlCCd/EsrJV7f7
	 fNIcU1QkVfgjQ==
Date: Thu, 8 Jan 2026 10:59:30 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: endpoint: Add BAR subrange mapping support
Message-ID: <aV-AApRHXLOTEwm3@ryzen>
References: <20260108044148.2352800-1-den@valinux.co.jp>
 <20260108044148.2352800-2-den@valinux.co.jp>
 <aV9638ebwqc4bsbd@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV9638ebwqc4bsbd@ryzen>

On Thu, Jan 08, 2026 at 10:37:35AM +0100, Niklas Cassel wrote:
> The memcpy in dw_pcie_ep_get_features() is a bit ugly.
> I guess the alternative is to change all the DWC based glue drivers
> to return a "struct pci_epc_features*" instead of a "const struct pci_epc_features*"
> such that dw_pcie_ep_get_features() can simply set subrange_mapping = true in the
> struct pci_epc_features returned by the glue driver.

I think the best way it probably to create another patch,
that will be patch 2 out of 3 in the series, which changes:
https://github.com/torvalds/linux/blob/v6.19-rc4/drivers/pci/controller/dwc/pcie-designware.h#L449

from:
const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);

to:
struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);

and which does the equivalent change in all the DWC based glue drivers.

That way, dw_pcie_ep_get_features() can simply set subrange_mapping = true
in the struct pci_epc_features returned by the glue driver.



Note that the function dw_pcie_ep_get_features() itself should still return:
"static const struct pci_epc_features*"

(Since this represents the DWC midlayer driver level.)

It is only the DWC based glue drivers (lower level drivers) that should drop
the const.


Kind regards,
Niklas

