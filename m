Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDED62F451E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 08:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbhAMHVu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 02:21:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbhAMHVu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Jan 2021 02:21:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B83E221E2;
        Wed, 13 Jan 2021 07:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610522470;
        bh=Mvi+9ZB26e7kwWopE/JrOTsi3ksANLPXPUSYb5Y1k/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ojeS2YxspW2+lSL/fOIiIm+2HHH/r8w2ap0+lm0uyFxvRa8oU4rQ6M5gjd6ZUNVXj
         VBm/72SloxB1SPKHgrsgjHe84eW/MDP+1kx/Z3IgK+ZXkpiW9k2QPSepQOH/VTxdEp
         nbgT38xWkjgP8X86Jt/bUUsxEfwmzdj/bVnI0c5x/z/Rw791Imywl8TkmM1dV0yvi3
         sDQwF99BXVxXschtabSpHWjwjarErv4wzf0Bc8N3uM4spmwKjP2brpqcnbydpwh8pf
         N2aLwnp92q9l0hhX8OGE7kRG/4kVBRU8s0JwN4TPPWrFeUovB66T0Gp5KdpzgSlzDx
         qtoZHNE3h/nnQ==
Date:   Wed, 13 Jan 2021 09:21:04 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        pankaj.dubey@samsung.com, sriram.dash@samsung.com,
        niyas.ahmed@samsung.com, p.rajanbabu@samsung.com,
        l.mehra@samsung.com, hari.tv@samsung.com
Subject: Re: [PATCH v4] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Message-ID: <20210113072104.GH4678@unreal>
References: <CGME20210112140234epcas5p4f97e9cf12e68df9fb55d1270bd14280c@epcas5p4.samsung.com>
 <1610460145-14645-1-git-send-email-shradha.t@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610460145-14645-1-git-send-email-shradha.t@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 12, 2021 at 07:32:25PM +0530, Shradha Todi wrote:
> get_features ops of pci_epc_ops may return NULL, causing NULL pointer
> dereference in pci_epf_test_bind function. Let us add a check for
> pci_epc_feature pointer in pci_epf_test_bind before we access it to avoid
> any such NULL pointer dereference and return -ENOTSUPP in case
> pci_epc_feature is not found.
>
> When the patch is not applied and EPC features is not implemented in the
> platform driver, we see the following dump due to kernel NULL pointer
> dereference.
>
> [  105.135936] Call trace:
> [  105.138363]  pci_epf_test_bind+0xf4/0x388
> [  105.142354]  pci_epf_bind+0x3c/0x80
> [  105.145817]  pci_epc_epf_link+0xa8/0xcc
> [  105.149632]  configfs_symlink+0x1a4/0x48c
> [  105.153616]  vfs_symlink+0x104/0x184
> [  105.157169]  do_symlinkat+0x80/0xd4
> [  105.160636]  __arm64_sys_symlinkat+0x1c/0x24
> [  105.164885]  el0_svc_common.constprop.3+0xb8/0x170
> [  105.169649]  el0_svc_handler+0x70/0x88
> [  105.173377]  el0_svc+0x8/0x640
> [  105.176411] Code: d2800581 b9403ab9 f9404ebb 8b394f60 (f9400400)
> [  105.182478] ---[ end trace a438e3c5a24f9df0 ]---


Description and call trace don't correlate with the proposed code change.

The code in pci_epf_test_bind() doesn't dereference epc_features, at
least in direct manner.

Thanks
