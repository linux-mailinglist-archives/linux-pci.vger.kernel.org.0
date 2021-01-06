Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFF52EBD49
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 12:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbhAFLkk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 06:40:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbhAFLkj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Jan 2021 06:40:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B2F923100;
        Wed,  6 Jan 2021 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609933199;
        bh=oVQy0WCzmrrM0N7SmWHba1flnwvWAZk0QOZxQDNRFeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9P2ZBPUp/btO/65Rs74MhMBR0vz9xgr5BeOKTOxIedNJpUE/jN8pGoUQr7xaWfRT
         FpgRPgYGnnUEh3nqB9N3xI6685F9kGvz9a0GEM30GMiDhAiEcccA0Wu9Ny3TVWoYe/
         f9xUD1H66EUj1/gRlh17WIT3uN1TeWDRN1Q4VZ0TtKMSMpQWZyLTcxk8oEfNKQ54V/
         BVGjLUWvnPpo1sV25vUhxEELP3yOrg72DxRyE+TutKs5elgpqdx6Mrb0BCXCyQosLP
         wmrTiPBmHesIARF6gRZ1wHpowjPh3+Cesfeh3FLEtGEtb4v9QWKB3LfnTbSpB41B2P
         SPWhLALexbjzg==
Date:   Wed, 6 Jan 2021 13:39:51 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        pankaj.dubey@samsung.com, sriram.dash@samsung.com,
        niyas.ahmed@samsung.com, p.rajanbabu@samsung.com,
        l.mehra@samsung.com, hari.tv@samsung.com
Subject: Re: [PATCH v3] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Message-ID: <20210106113951.GW31158@unreal>
References: <CGME20210106103829epcas5p20a5c8aa2ae8bd6d8d555dad1aa265a1c@epcas5p2.samsung.com>
 <1609929490-18921-1-git-send-email-shradha.t@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609929490-18921-1-git-send-email-shradha.t@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 06, 2021 at 04:08:10PM +0530, Shradha Todi wrote:
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
>
> Fixes: 2c04c5b8eef79 ("PCI: pci-epf-test: Use pci_epc_get_features() to get
> EPC features")
>
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Please no space between Fixes line and SOB.
Also please don't break Fixes lines.

Thanks
