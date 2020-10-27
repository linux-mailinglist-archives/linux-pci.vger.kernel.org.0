Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ADE29BD7E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 17:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1802411AbgJ0QhF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 12:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1811064AbgJ0QhE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 12:37:04 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58E9521655;
        Tue, 27 Oct 2020 16:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603816623;
        bh=WbQsLPN/35tnOGTJ2hyYA+zyMpk851Ej93huhfMvwOs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LXD43APtdh6YdNG/PiLbW2caVqBTEEI4+oT+NhDcaee4wM+Fynv683b8FHYEci/H5
         1D8NYGw7gzr0DgyipRfrjuKXw83YHbPoB9K/H6SMV8axgvVC8yHZnNiRRPC7IrDwrq
         KkMtBtc0+LeHcxeIF7N/I70vxq1Kg7XM4mjeZZuM=
Date:   Tue, 27 Oct 2020 11:37:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: pcie-rockchip-ep.c coverity issue #1437163
Message-ID: <20201027163701.GA184393@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027161636.GA182618@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 27, 2020 at 11:16:38AM -0500, Bjorn Helgaas wrote:
> Hi Shawn,
> 
> Please take a look at this issue reported by Coverity:
> 
> 332 static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
> 333 {
> 334        struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
> 335        struct rockchip_pcie *rockchip = &ep->rockchip;
> 336        u16 flags;
> 337
> 338        flags = rockchip_pcie_read(rockchip,
> 339                                   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> 340                                   ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
> 
> CID 1437163 (#2 of 2): Operands don't affect result
> (CONSTANT_EXPRESSION_RESULT) result_independent_of_operands: flags &
> (65536UL /* 1UL << 16 */) is always 0 regardless of the values of its
> operands. This occurs as the logical operand of !.
> 
> 341        if (!(flags & ROCKCHIP_PCIE_EP_MSI_CTRL_ME))
> 342                return -EINVAL;

The same issue also occurs in rockchip_pcie_ep_send_msi_irq()
(Coverity issue #143765 for that one).
