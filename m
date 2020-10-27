Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EF329BB87
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 17:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756113AbgJ0QQq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 12:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754778AbgJ0QQj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 12:16:39 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D06522263;
        Tue, 27 Oct 2020 16:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603815398;
        bh=NEoFtR+3zKcGMsPLbPNWhjiqjlHXguIOoKtXrV+qFy8=;
        h=Date:From:To:Cc:Subject:From;
        b=XgaVVIpQKhGdcYR75NvZbrc26f1DGmKmzVTWG651INNfhsd/gHgvcgUku+kr5w/Ut
         pI5FVslt4Xn9QX6ZNKOHLSDO3EB7d4IxpawaZ4izNkTRynERcWZJbjV4Jzhb9TPYuK
         5ItbFM4QjXbra2dr2hIEL0EI5zj5W0EmuyyVggLg=
Date:   Tue, 27 Oct 2020 11:16:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-pci@vger.kernel.org
Subject: pcie-rockchip-ep.c coverity issue #1437163
Message-ID: <20201027161636.GA182618@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shawn,

Please take a look at this issue reported by Coverity:

332 static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
333 {
334        struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
335        struct rockchip_pcie *rockchip = &ep->rockchip;
336        u16 flags;
337
338        flags = rockchip_pcie_read(rockchip,
339                                   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
340                                   ROCKCHIP_PCIE_EP_MSI_CTRL_REG);

CID 1437163 (#2 of 2): Operands don't affect result
(CONSTANT_EXPRESSION_RESULT) result_independent_of_operands: flags &
(65536UL /* 1UL << 16 */) is always 0 regardless of the values of its
operands. This occurs as the logical operand of !.

341        if (!(flags & ROCKCHIP_PCIE_EP_MSI_CTRL_ME))
342                return -EINVAL;
