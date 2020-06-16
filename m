Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7921FC15C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 00:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgFPWEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 18:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgFPWEz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 18:04:55 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1217D2098B;
        Tue, 16 Jun 2020 22:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592345094;
        bh=zZ4bUdq2K5ojEsFNwkT75BRnNvTH2SiQYaGdmtmA+LY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dd7DDppHgktg8e8KtkNmGEBjAzou4NJtHhshd5D5iXcW+leO25FXNxXDZWnY2I0Bk
         YrxOpMwfKTfQ2ieFXVvDjA9DHKagBo5wTtub2FYwA+pxC4gHs4II2F9118TPhU0NwW
         CEOrkYO+kNqRG1mP0l0R1uk+nRVtuDAWkJ2JD1zA=
Date:   Tue, 16 Jun 2020 17:04:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/12] ata: ahci_brcm: Fix use of BCM7216 reset
 controller
Message-ID: <20200616220451.GA1983693@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616205533.3513-3-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 04:55:09PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> A reset controller "rescal" is shared between the AHCI driver and the PCIe
> driver for the BrcmSTB 7216 chip.  The code is modified to allow this
> sharing and to deassert() properly.

Use imperative mood, e.g.,

  A reset controller "rescal" is shared between the AHCI driver and
  the PCIe driver for the BrcmSTB 7216 chip.  Use
  devm_reset_control_get_optional_shared control() to handle this
  sharing.

> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> 
> Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
> Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller
> name")

Don't wrap "Fixes:" lines so it's easier to search for them.
