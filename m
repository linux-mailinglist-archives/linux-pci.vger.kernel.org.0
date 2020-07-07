Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962692162D9
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 02:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGGAH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 20:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgGGAH2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 20:07:28 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34F422065D;
        Tue,  7 Jul 2020 00:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594080447;
        bh=u3AzzMQQytp0tgLKZB99Ebdd0nnL+25GERfNHmfazzo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sy5/jHlqXE37Np9TckDkzm+8iq7ga24JRaRcA/JUB+Wr9ub1cu2cb7k0otBJ+kffa
         Yra8QaxorDcLMiHfyGkfOtTlAtQEjs9YuHgTqjRd/7oS9iJQhp5nHfmZYNrxLFuQni
         +SYxRxV/mXTZCLTNMEqdyn3npFkWmVMfnzIoWrRc=
Date:   Mon, 6 Jul 2020 19:07:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daire.McNamara@microchip.com
Cc:     amurray@thegoodpenguin.co.uk, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        david.abdurachmanov@gmail.com
Subject: Re: [PATCH v12 0/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20200707000551.GA174271@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97e528fd7582186d7db4073c78d72601b2ce553f.camel@microchip.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 02, 2020 at 03:37:12PM +0000, Daire.McNamara@microchip.com wrote:
> This v12 patch adds support for the Microchip PCIe PolarFire PCIe
> controller when configured in host (Root Complex) mode.

> Daire McNamara (2):
>   PCI: microchip: Add host driver for Microchip PCIe controller
>   PCI: microchip: Add host driver for Microchip PCIe controller

Hi Daire,

I see this in the lore archive:
https://lore.kernel.org/linux-pci/97e528fd7582186d7db4073c78d72601b2ce553f.camel@microchip.com/

but

  - It's not threaded correctly.  The 1/2 and 2/2 patches should be
    responses to the 0/2 cover letter.  The fact that they're not
    means one cannot navigate through the series on
    https://lore.kernel.org.

  - For some reason none of these made it to me directly even though
    I'm in the To: list as well as subscribed to the linux-pci list.
    They *do* appear in both patchwork and lore, and I think they both
    get things via the linux-pci list, so I don't know what's wrong.

    I did correct Rob's email address; maybe that was part of it?

  - The patches should have different subjects.  The DT binding should
    have a subject that matches the history in
    Documentation/devicetree/bindings/pci/, e.g., something like:

    dt-bindings: PCI: microchip: Add Microchip PolarFire host binding

  - The commit logs should be good English; for example, they should
    start with a capital letter.

>  .../bindings/pci/microchip,pcie-host.yaml     |  93 +++
>  drivers/pci/controller/Kconfig                |   9 +
>  drivers/pci/controller/Makefile               |   1 +
>  drivers/pci/controller/pcie-microchip-host.c  | 683 ++++++++++++++++++
>  4 files changed, 786 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
>  create mode 100644 drivers/pci/controller/pcie-microchip-host.c
> 
> 
> base-commit: cd77006e01b3198c75fb7819b3d0ff89709539bb
> -- 
> 2.17.1
> 
