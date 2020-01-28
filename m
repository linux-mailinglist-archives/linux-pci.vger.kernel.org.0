Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF114B6A3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2020 15:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgA1OGa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jan 2020 09:06:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:51918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgA1OEi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jan 2020 09:04:38 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3693624685;
        Tue, 28 Jan 2020 14:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220278;
        bh=HdJSVpKN5JwLk0pwKiSneDoMoxLzqMSUGMkaRqH6haw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HaTXBk4mDSCOL/fjI8NNX7pDSI/hDMf313v0noxUeKW2PrB3tkKVbjI2+xWe3GFAa
         I81UNYidQUJSK1qX25fUH8gRVuDgLEb7ulh+pXL842XiNqJlzE6XTVndHKLOnhxLfM
         UXq7Wc/5327RkVg5e4xUapqFeEdRrYRT8C/s2CoQ=
Date:   Tue, 28 Jan 2020 08:04:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rgummal@xilinx.com
Subject: Re: [PATCH v4 0/2] Adding support for Versal CPM as Root Port driver.
Message-ID: <20200128140437.GA149959@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580215483-8835-1-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 28, 2020 at 06:14:41PM +0530, Bharat Kumar Gogada wrote:
> - Add support for Versal CPM as Root port.
> - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
>   block for CPM along with the integrated bridge can function
>   as PCIe Root Port.
> - Versal CPM uses GICv3 ITS feature for assigning MSI/MSI-X
>   vectors and handling MSI/MSI-X interrupts.
> - Bridge error and legacy interrupts in Versal CPM are handled using
>   Versal CPM specific MISC interrupt line.
> 
> Bharat Kumar Gogada (2):
>   PCI: xilinx-cpm: Add device tree binding for Versal CPM host bridge.
>   PCI: xilinx-cpm: Add Versal CPM Root Port driver

Nit for next time: Omit the period at the end of the subject.  No need
to repost just for that.

>  .../devicetree/bindings/pci/xilinx-versal-cpm.txt  |  66 +++
>  drivers/pci/controller/Kconfig                     |   8 +
>  drivers/pci/controller/Makefile                    |   1 +
>  drivers/pci/controller/pcie-xilinx-cpm.c           | 506 +++++++++++++++++++++
>  4 files changed, 581 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
>  create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c
> 
> -- 
> 2.7.4
> 
