Return-Path: <linux-pci+bounces-34077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4132BB270E6
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 23:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64FC1CC7E16
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 21:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA56278172;
	Thu, 14 Aug 2025 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blhHXW/t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F65273D66;
	Thu, 14 Aug 2025 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755207302; cv=none; b=B23xMxIyVJi4N6Miv3DfI5ZAvjhKzTxF5/k/sKUL2x7aWZVjOs2Wt0Cvs+781JQTIqr9m4Oi7Gox6Yv2H/A+vnF2SFSKgqsb6DEpoSuQ4lxWUBNHqt/Kl3uEHy+z7jWvtZwQct+PDbYhnO8bELIy3nD6UQlRG5cmtxO7AAS67jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755207302; c=relaxed/simple;
	bh=GvoyGKqpqnHQJSALXhthHHrNNHtaAxyrM6RIwsD7nxg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JpEvKf7ZAVdj7FDL+uaxZQXzPA8HHR/uS2rZ/OLReRuyX29p7j0/n91844B7pRCwQD7mbmiYrOWh/qhfdDpKTK33uslTtZQ518nOaHNCI6BDXNjTfOdfQTf8NvA/G2NrD7S+x/LbVLNKRQmIkBizHbD6bMz2zlNhF1hKDQKz4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blhHXW/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1042AC4CEED;
	Thu, 14 Aug 2025 21:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755207302;
	bh=GvoyGKqpqnHQJSALXhthHHrNNHtaAxyrM6RIwsD7nxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=blhHXW/tcU8US0K9ykVQNg6im++CWMJR1dMKKDcy0JOCG+vTNxnwVThv6Z6zAGOLO
	 VxgkarhYEhel4wJ75IdNKvxCCdQaubroTRJ+UwFdNibe0MK8/PrutvlvjfHpSMNOvj
	 37bBbWz9JhQSOIXmj9pD/GiZb+hwcqQGMDiC7Dt0mWTU8BoHwrJT7oU5VTd5XWM80A
	 tykcWTq1Ake8DE/Mwwi49INT6USI80Rs3o/c8TyLF6/0WL0x9TedXTlgcmS4GrGNTi
	 MYnOuUhD1TEVSWfHGVteilmlYCaPHT0F00puIBsYNUuroRmpUTzH+piXFRgx7vhWIO
	 iRxr4LWF6CDxw==
Date: Thu, 14 Aug 2025 16:35:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
	fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/13] PCI: cadence: Add register definitions for
 HPA(High Perf Architecture)
Message-ID: <20250814213500.GA350257@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813042331.1258272-4-hans.zhang@cixtech.com>

On Wed, Aug 13, 2025 at 12:23:21PM +0800, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Add the register offsets and register definitions for HPA(High
> Performance architecture) PCIe controllers from Cadence.

Add space in "HPA(High Performance architecture)"; also in subject.

> +++ b/drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h

> +/*
> + * HPA (High Performance Architecture) PCIe controller register
> + */

Typical style would be:

  /* HPA (High Performance Architecture) PCIe controller register */

> +#define CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON	0x01020000
> +/*
> + * Address Translation Registers(HPA)
> + */

Use a one-line comment and add a blank line before it.  Apply below
too.

> + * Root port register base address

s/Root port/Root Port/ to match spec and usage below.

> + * Endpoint Function BARs(HPA) Configuration Registers

Add space.

> + * Root Port Registers PCI config space(HPA) for root port function

Add space.

> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -22,10 +22,6 @@ struct cdns_plat_pcie {
>  	struct cdns_pcie        *pcie;
>  };
>  
> -struct cdns_plat_pcie_of_data {
> -	bool is_rc;
> -};

Everything from here down is (as Krzysztof pointed out) much different
than the above and should be in a separate patch so the commit log can
be more specific.

Bjorn

