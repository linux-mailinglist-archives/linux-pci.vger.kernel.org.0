Return-Path: <linux-pci+bounces-34079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65660B2710C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 23:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA565E709C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 21:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E8B279DC5;
	Thu, 14 Aug 2025 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmgDesE/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB32319878;
	Thu, 14 Aug 2025 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755208125; cv=none; b=uTNiQRciHNa9ezKhyjOEStMotJZfIdobMR/rLQMF8NwzZ7KSxXdTkuTj+tjcRHDVEsx91UfJ3TdyMQHU40IiycSdW5fnrnVmH1vjTaiCk+5bzYMNfAsIEeyo1+Nr0ZOGsUomVAK0OiSrtYWatkdcqr/6GS/QYex+8AsvdAtSGlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755208125; c=relaxed/simple;
	bh=i7gYdC8+ofPGXu/bQm5zz/OH1Xi7L0/pQfV+Eto7wmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NzvWeAOr/HnATrWhB48cJinLfZxwM/de4ZdE2G7tL5B2aJyMpVW9kieeqU6dKuzZ6mtCZPuv4MnYsjscrQi/OJeXLEfv3fdGnBSRTqU92AuE/yROuvKd+J2IRQzRE0s3MO7O1DbvsGuYeyhcnbcXO6/HfCNJKI3xaE9EicPXlfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmgDesE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9170EC4CEED;
	Thu, 14 Aug 2025 21:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755208124;
	bh=i7gYdC8+ofPGXu/bQm5zz/OH1Xi7L0/pQfV+Eto7wmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mmgDesE/8rkZVRkshbTU71TXVGj+nSBXQ1B1vfpHDVT4T2JPt8YTgr9xkK+P/W4a2
	 1B7uUdN6u2m9HghoUN3MvrOQm88VFPQrwQsWGfUszL7ab3HyapAI4gw0HA2cal64VW
	 hN/ZzisB0FVr4aC+G9zjsITnQtstHDVYkyd3JDRGWyBiRGN0P5pb3R4C0vafam0DSf
	 VGnSfIZZRjshnEnbzn2ctW9z3esz8+8ND5dfFdE5aH+NMUa8Z7LWacbJprTkoDvn9o
	 w0/MEg71A7Wrr0DmbcT4dXBgBdWyq4Tt7Ou4IlIJ6st8C8OY8C80czcDo76BpTOJvL
	 S6weVTdA4PhTQ==
Date: Thu, 14 Aug 2025 16:48:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
	fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/13] PCI: cadence: Split PCIe RP support into common
 and specific functions
Message-ID: <20250814214843.GA350844@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813042331.1258272-6-hans.zhang@cixtech.com>

On Wed, Aug 13, 2025 at 12:23:23PM +0800, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Split the Cadence PCIe controller RP functionality into common
> functions and functions for legacy PCIe RP controller.

I guess this is simply a move, with no actual code changes?

> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep-common.h
> @@ -1,10 +1,10 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  // Copyright (c) 2017 Cadence
> -// Cadence PCIe Endpoint controller driver.
> +// Cadence PCIe Endpoint controller driver
>  // Author: Manikandan K Pillai <mpillai@cadence.com>
>  
> -#ifndef _PCIE_CADENCE_EP_COMMON_H_
> -#define _PCIE_CADENCE_EP_COMMON_H_
> +#ifndef _PCIE_CADENCE_EP_COMMON_H
> +#define _PCIE_CADENCE_EP_COMMON_H
>  
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
> @@ -33,4 +33,4 @@ const struct pci_epc_features *cdns_pcie_ep_get_features(struct pci_epc *epc,
>  							 u8 func_no,
>  							 u8 vfunc_no);
>  
> -#endif /* _PCIE_CADENCE_EP_COMMON_H_ */
> +#endif /* _PCIE_CADENCE_EP_COMMON_H */

All these changes should be in the patch that creates
pcie-cadence-ep-common.h so we don't have to touch it twice.

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> new file mode 100644
> index 000000000000..5625c64c7974
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017 Cadence
> +// Cadence PCIe host controller driver.
> +// Author: Manikandan K Pillai <mpillai@cadence.com>

Not sure about the author here.  The authorship info is usually all
there in the git history, so there's less value in including it in the
file itself than there used to be.

