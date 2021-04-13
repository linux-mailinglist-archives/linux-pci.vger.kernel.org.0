Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D049035E411
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 18:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345320AbhDMQfN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 12:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345749AbhDMQfK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 12:35:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E996560720;
        Tue, 13 Apr 2021 16:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618331690;
        bh=+Yx56PpD3SCxtUBo2DCtNb1srd795QCEePw1+OosqbQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sAP6p2suA6ho9DyLtmzzN9zduExPlSVWgJIW5f5b9bZENOVNXTBVN6vxL3Lf+GPZP
         XML/jm9Jj4nJePuUP1X8ZqMW4x2Ul1BdCX5MDPvpVsvUKvHNCGaTVHTIN5eUqpNc7u
         8p/NjGZqo8BVGfoTfyHF+DSx4gGWVsXmitLxSoW8K4P//ciXaXHhPF45upA6kD/hwM
         bqNR/vDSQzmIhj7w6DZwkKtB5MDKGUZ+eB6B6C0jOshTX4NhK5JJlO17F/KPzjx/RL
         L+EHtDLSvs9OHaw9WzTLnvKq/3dYfyr14yda4+2UOwR2Yw6xL1MbwhXyuKvpexpvLc
         WDckXWpeiAhGQ==
Date:   Tue, 13 Apr 2021 11:34:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        linux-acpi@vger.kernel.org, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, linuxarm@huawei.com,
        Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH v2 1/4] PCI: Add vendor define ID for the PCI SIG
Message-ID: <20210413163448.GA2240386@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413160159.935663-2-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 14, 2021 at 12:01:56AM +0800, Jonathan Cameron wrote:
> This ID is used in DOE headers to identify protocols that are
> defined within the PCI Express Base Specification.

Can you please include the specific spec citation here?

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> Since V1: New Patch
> 
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index a76ccb697bef..2c0459c23331 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -149,6 +149,7 @@
>  #define PCI_CLASS_OTHERS		0xff
>  
>  /* Vendors and devices.  Sort key: vendor first, device next. */
> +#define PCI_VENDOR_ID_PCI_SIG		0x0001
>  
>  #define PCI_VENDOR_ID_LOONGSON		0x0014
>  
> -- 
> 2.19.1
> 
