Return-Path: <linux-pci+bounces-260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46F17FE427
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 00:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018E11C208DE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 23:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC4147A44;
	Wed, 29 Nov 2023 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUHjbiYj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCB64CB32
	for <linux-pci@vger.kernel.org>; Wed, 29 Nov 2023 23:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F35C433C7;
	Wed, 29 Nov 2023 23:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701300141;
	bh=0euqzIph0L67aoLFECRKJJGk+Cwo0OYK7duqaEhztvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kUHjbiYjoCXXjDtK4+6sAkFll8K8C0VugBxif088joxOVNumvw/414ipgLvmnDV5m
	 HBofxkICxZVmf/07EC8Exs6qtzZUHwjclvn34xr2hLPoT2wZedNplYgA4Tpd5hKnUl
	 cBtdbfgtZ4FD+6jwR5QnysRYqpLWL/w1ZITtcK3+SXGCnDPt1eRAir/ogA5g7V7Nly
	 m15DUBveoyvEmcy1HtYve6yGRYHtjDBXSzOfxa22ejElrt/qf/n7Pb5TnfRP2tmDgb
	 VwWH5CsGqjX2OqemGhzpohjCmMsvRZN3PTttJddrgYXkR/a+g0zKiFeWTzLChTF0Ce
	 A025HHEXFFspA==
Date: Wed, 29 Nov 2023 17:22:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kevin Xie <kevin.xie@starfivetech.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mason.huo@starfivetech.com,
	leyfoon.tan@starfivetech.com, minda.chen@starfivetech.com
Subject: Re: [PATCH v1] PCI: Add PCIE_CONFIG_REQUEST_WAIT_MS waiting time
 value
Message-ID: <20231129232219.GA444277@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124014508.43358-1-kevin.xie@starfivetech.com>

On Fri, Nov 24, 2023 at 09:45:08AM +0800, Kevin Xie wrote:
> Add the PCIE_CONFIG_REQUEST_WAIT_MS marco to define the minimum waiting
> time between sending the first configuration request to the device and
> exit from a conventional reset (or after link training completes).
> 
> As described in the conventional reset rules of PCI specifications,
> there are two different use cases of the value:
> 
>    - With a downstream port that supports link speeds <= 5.0 GT/s,
>      the waiting is following exit from a conventional reset.
> 
>    - With a downstream port that supports link speeds > 5.0 GT/s,
>      the waiting is after link training completes.
> 
> Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  drivers/pci/pci.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5ecbcf041179..4ca8766e546e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -22,6 +22,13 @@
>   */
>  #define PCIE_PME_TO_L2_TIMEOUT_US	10000
>  
> +/*
> + * PCIe r6.0, sec 6.6.1, <Conventional Reset>
> + * Requires a minimum waiting of 100ms before sending a configuration
> + * request to the device.
> + */
> +#define PCIE_CONFIG_REQUEST_WAIT_MS	100

Oh, and I think this name should include something about "reset"
because that's the common scenario and that's the spec section where
the value is mentioned.

