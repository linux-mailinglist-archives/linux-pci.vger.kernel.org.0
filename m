Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910DF3DE2A5
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 00:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhHBWoc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 18:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhHBWob (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 18:44:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AE136056B;
        Mon,  2 Aug 2021 22:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627944261;
        bh=ixlUMBCIAggutsyEK8Ic/YdBz61qA8VdIJ4Ym14prFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qOi5FqbQiCOTI6GyZ1iGkhMPk7fsh9NFS5X95az/2ekjoL5Vz83fdD3NRFyV/gBld
         GXavDKf5qRfXRS+j4Uod+6E4r+65BZe7fuJgg4/tpAhoiQ9466Fg3wImBLT7nA+FTz
         ify0WAkIwK1tCQmXD8+IA2hL8CgrKwuTy+swfs1yvPbptsFuWh0iyCc4cJHnGyfTre
         dofqydTZmkemOm4Hr42q8EDd7BcgvjX5xmHDHgLjvVtTwSzOu3flVCO/ekvrRBQWKJ
         K/IqHSasoFdtDgWULn5Fe7VjEFAVTsxwQ9ngNqJejJTyAbQe9QfK//G8AvXLDhf3bU
         gAuyHSt4ge8Kg==
Date:   Mon, 2 Aug 2021 17:44:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v13 2/9] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210802224420.GA1472058@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801142518.1224-3-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 01, 2021 at 07:55:11PM +0530, Amey Narkhede wrote:
> Currently there is separate function pcie_has_flr() to probe if PCIe FLR
> is supported by the device which does not match the calling convention
> followed by reset methods which use second function argument to decide
> whether to probe or not. Add new function pcie_reset_flr() that follows
> the calling convention of reset methods.
> 
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +--
>  drivers/pci/pci.c                          | 40 +++++++++++++++-------
>  drivers/pci/pcie/aer.c                     | 12 +++----
>  drivers/pci/quirks.c                       |  9 ++---
>  include/linux/pci.h                        |  2 +-
>  5 files changed, 38 insertions(+), 29 deletions(-)

>  int pcie_flr(struct pci_dev *dev)
>  {
> @@ -4655,7 +4653,26 @@ int pcie_flr(struct pci_dev *dev)
>  
>  	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
>  }
> -EXPORT_SYMBOL_GPL(pcie_flr);
> +EXPORT_SYMBOL(pcie_flr);

Why this change?  If it's unintentional and there's no other reason to
repost, I can fix it up locally.
