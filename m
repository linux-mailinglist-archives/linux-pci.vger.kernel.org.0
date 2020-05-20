Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D3E1DC025
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 22:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgETUaZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 16:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgETUaZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 16:30:25 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8450820708;
        Wed, 20 May 2020 20:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590006624;
        bh=qcg/Qu49E2DS3eXuokkXkP+SYKXKPE1qQn/Eyz24upc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ENC5AZWJKAfOFyxzIFQ8srOw9AlF709uZF77fuNEvRAOI5Qi9F8qagECc5RrvOShd
         Wh/Vu6J6ZtH9qw1bKcPUV4VuB1N8v2N+HMPl+n3YqGFZyONYIlBH2e0WA6545jn9UU
         S5LoSz4szwgDz0bzPCLe8o+qgG6XlMXEOFUlbfJE=
Date:   Wed, 20 May 2020 15:30:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Chuhong Yuan <hslester96@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: Reference bridge window resources explicitly
Message-ID: <20200520203022.GA1117009@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520183411.1534621-1-kw@linux.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 20, 2020 at 06:34:09PM +0000, Krzysztof Wilczynski wrote:
> Add definitions to allow for more explicit mapping of Peer-to-Peer (P2P)
> and CardBus bridge window resources.
> 
> Added for P2P:
> 
>   PCI_BRIDGE_RESOURCES + 0 -> PCI_BRIDGE_IO_WINDOW
>   PCI_BRIDGE_RESOURCES + 1 -> PCI_BRIDGE_MEM_WINDOW
>   PCI_BRIDGE_RESOURCES + 2 -> PCI_BRIDGE_PREF_MEM_WINDOW
> 
> Added for CardBus:
> 
>   PCI_BRIDGE_RESOURCES + 0 -> PCI_CB_BRIDGE_IO_0_WINDOW
>   PCI_BRIDGE_RESOURCES + 1 -> PCI_CB_BRIDGE_IO_1_WINDOW
>   PCI_BRIDGE_RESOURCES + 2 -> PCI_CB_BRIDGE_MEM_0_WINDOW
>   PCI_BRIDGE_RESOURCES + 3 -> PCI_CB_BRIDGE_MEM_1_WINDOW
> 
> The old way of addressing resources using an index:
> 
>   bridge->resource[PCI_BRIDGE_RESOURCES+0]
> 
> Would now be replaced with:
> 
>   bridge->resource[PCI_BRIDGE_IO_WINDOW]
> 
> This series of patches builds on top of the changes proposed before:
> 
>   https://lore.kernel.org/r/20100203233931.10803.39854.stgit@bob.kio
>   https://lore.kernel.org/r/20100212170022.19522.81135.stgit@bob.kio
> 
> Krzysztof Wilczynski (2):
>   PCI: Move from using PCI_BRIDGE_RESOURCES to bridge resource
>     definitions
>   pcmcia: Use resources definitions when freeing CardBus resources
> 
> ---
> Changes in v2:
>   Split patches based on the feedback from Bjorn allowing for the
>   patch that correct the PCI quirk for the ALI chipset to be applied
>   independently, if someone needs to cherry-pick it, before updating
>   the said quirk to use definitions for bridge window resources.
> 
> Changes in v3:
>   Remove the PCI quirk patch for ALI M7101 chipset as it's not needed.
>   Remove surplus new variables added in pci_bus_size_cardbus().
> 
>  drivers/pci/quirks.c          |  37 +++++------
>  drivers/pci/setup-bus.c       | 114 ++++++++++++++++++----------------
>  drivers/pcmcia/yenta_socket.c |  46 +++++++++-----
>  include/linux/pci.h           |  14 ++++-
>  4 files changed, 122 insertions(+), 89 deletions(-)

Applied to pci/enumeration for v5.8, thanks!
