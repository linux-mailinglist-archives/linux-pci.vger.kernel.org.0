Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 754E211C00D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 23:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfLKWql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 17:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfLKWqk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Dec 2019 17:46:40 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 681C620836;
        Wed, 11 Dec 2019 22:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576104400;
        bh=DO7UyfzEBz8p1xfKYT9necVU3BMFfuI27Qs6t3xiY3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OnTKLlyWPmJTjY3iUjPJT0/C8AUPYg7+AIsI4GGDlsiPJBnvr4OMAGjBpVvXqflnb
         /oqNzVnkS5LSZu4nbtJS26Gi/oc7tXBWG+5TcMNpdM+M7+yCdXeW524IcSsjnr3Dvg
         IcCcZEpa5rYkE1c8W/kLCNqmx2nsvnKCUPuU8U9A=
Date:   Wed, 11 Dec 2019 16:46:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH 0/4] Redesign MSI-X support in PCIe Endpoint Core
Message-ID: <20191211224636.GA122332@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211124608.887-1-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 11, 2019 at 06:16:04PM +0530, Kishon Vijay Abraham I wrote:
> Existing MSI-X support in Endpoint core has limitations:
>  1) MSIX table (which is mapped to a BAR) is not allocated by
>     anyone. Ideally this should be allocated by endpoint
>     function driver.
>  2) Endpoint controller can choose any random BARs for MSIX
>     table (irrespective of whether the endpoint function driver
>     has allocated memory for it or not)
> 
> In order to avoid these limitations, pci_epc_set_msix() is
> modified to include BAR Indicator register (BIR) configuration
> and MSIX table offset as arguments. This series also fixed MSIX
> support in dwc driver and add MSI-X support in Cadence PCIe driver.
> 
> The previous version of Cadence EP MSI-X support is @ [1].
> This series is created on top of [2]
> 
> [1] -> https://patchwork.ozlabs.org/patch/971160/
> [2] -> http://lore.kernel.org/r/20191209092147.22901-1-kishon@ti.com
> 
> Alan Douglas (1):
>   PCI: cadence: Add MSI-X support to Endpoint driver
> 
> Kishon Vijay Abraham I (3):
>   PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments
>   PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSIX table
>     address
>   PCI: keystone: Add AM654 PCIe Endpoint to raise MSIX interrupt

Trivial nits:

  - There's a mix of "MSI-X" and "MSIX" in the subjects, commit logs,
    and comments.  I prefer "MSI-X" to match usage in the spec.

  - "Fixes:" tags need not include "commit".  It doesn't *hurt*
    anything, but it takes up space that could be used for the
    subject.

  - Commit references typically use a 12-char SHA1.  Again, doesn't
    hurt anything.
