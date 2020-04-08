Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F6C1A2C88
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 01:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDHXqZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 19:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbgDHXqZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Apr 2020 19:46:25 -0400
Received: from localhost (mobile-166-175-188-68.mycingular.net [166.175.188.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8821C20787;
        Wed,  8 Apr 2020 23:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586389585;
        bh=jdERzFagcZJpT6zeQ9ptPHc+W/HgbAkXikMkMpGMIc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UBEF4PPNtgYeAzJH79lLGGULnX41ZtOGL+nLtZMe5rqcdjOevaJL0F7SJcJqnQ/gL
         cbk/jdvfvN7/J57YJCjLt9hgnh47iQLIXE+WlxuVESZ/NcOWOUykYPQC8tj5yfO0K9
         NtF4OXMIed85faV2LxGjwdhmPKjCAsn4lB7mBgEc=
Date:   Wed, 8 Apr 2020 18:46:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-rockchip@lists.infradead.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH v7 4/8] PCI: endpoint: Add support to handle multiple
 base for mapping outbound memory
Message-ID: <20200408234622.GA150772@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586360280-10956-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 08, 2020 at 04:37:56PM +0100, Lad Prabhakar wrote:
> R-Car PCIe controller has support to map multiple memory regions for
> mapping the outbound memory in local system also the controller limits
> single allocation for each region (that is, once a chunk is used from the
> region it cannot be used to allocate a new one). This features inspires to
> add support for handling multiple memory bases in endpoint framework.
> 
> With this patch pci_epc_mem_init() initializes address space for endpoint
> controller which support single window and whereas __pci_epc_mem_init()
> now accepts pointer to multiple windows supported by endpoint controller.

Adding a double underscore prefix usually indicates an internal
function that skips some checking.

It doesn't seem like quite the right thing for this external interface
that adds functionality.  Maybe the name could include something like
"multi"?

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This needs an ack from Kishon, of course.

This patch seems like it does several things that could possibly be
split into separate patches?

  - Change pci_epc_mem_init() interface to add page_size argument (the
    only one that touches cadence & rockchip; it would be nice if this
    were a tiny patch)

  - Add struct pci_epc_mem_window

  - Add a pci_epc_multi_mem_init() or similar, implement
    pci_epc_mem_init() in terms of it (as you already do)

Bjorn
