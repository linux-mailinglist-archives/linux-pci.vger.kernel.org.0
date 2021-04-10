Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E71E35AD45
	for <lists+linux-pci@lfdr.de>; Sat, 10 Apr 2021 14:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhDJM3D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Apr 2021 08:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234392AbhDJM3D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Apr 2021 08:29:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AD89611AE
        for <linux-pci@vger.kernel.org>; Sat, 10 Apr 2021 12:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618057728;
        bh=jJM9L8VGUMULEWespnVrhB2m5QplbVSrK7u3PS8oAvM=;
        h=Date:From:To:Subject:From;
        b=sgmNvXnymx1GQUJC8OCtagvl5g0WXNB8K7Prby7ZJzV/MZ3ps0FnkrVmiYWni4XI8
         n8jpFVPWg35hFmESOnCzYu6/nONhjN6vERiSfv2CqoVyC6Bfgln+suM19OtlYFQA/G
         nhr3E+oxTNHy95kfijO/3T5SYwRsFAT8jlzLFAGymSKQbS9XDe/aRxYUC6M0HYOvH0
         dAUgGGTMcneOJxp05EGt2qPc/ny5/NV7TfgPUl5Y1TiQ93nG3yVRJxGY+arC7i5JIB
         +KHbucoLGUVQlg10ObyFNkWQv0DVafE3iayrL8pdYz6k+TFkVkDHKoQzcavmFuCKlS
         QdKd1OuhPQFUA==
Received: by pali.im (Postfix)
        id 35626BEF; Sat, 10 Apr 2021 14:28:45 +0200 (CEST)
Date:   Sat, 10 Apr 2021 14:28:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org
Subject: PCI service interrupt handlers & access to PCI config space
Message-ID: <20210410122845.nhenihbygmcjlegn@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

I see that more PCI service drivers in their interrupt handlers are
accessing PCI config space.

E.g. in PCIe Hot Plug interrupt handler pciehp_isr handler is called
pcie_capability_read_word() function.

It is correct? Because these capability functions are protected by
pci_lock_config() / pci_unlock_config() calls.

And what would happen when during execution of reading or writing to
PCIe config space (e.g. via pcie_capability_read_word()) is triggered
PCIe HP interrupt? Would not enter interrupt handler function in
deadlock (waiting for unlocking config space)?
