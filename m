Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7E5372008
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 20:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhECS6w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 14:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhECS6v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 May 2021 14:58:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D812461153;
        Mon,  3 May 2021 18:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620068278;
        bh=cQ75rdudKQ/QAGQKDKaMh2yRb48TX9KsOBfAfYu9N7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sJZy4fWaeT/ZWrSgcd57XTlmRT2guB3g7nFyaLh3Kpz/Ky20f9h7KZbGwMNf46S7u
         GKObapn7TwMpwbqXKm+dtXFzVY2ECL0edaxcq2qo3/3Gd7vkje81KU2TxcvDx+jI5H
         IsCxTuGcrTHt3zwHGDDFLKxwPjthmth0bcNVQj1NmudaJ2UbCfepGpU80AK4dEfoig
         vo8U6LS18a7PQIOHk/rngm8juav6OHXhibxHheW64HAo4uQJT++O4S5Nr1JECdsiay
         meD5lbXc+UkqeGFP85RrsRetmZ2UkUbbc6fPWIgNn3cvIHe94PUq5tVHAKECle03i1
         r5E8EQS2+F3oA==
Date:   Mon, 3 May 2021 13:57:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Jim Quinlan <jquinlan@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 0/3] ata: ahci_brcm: Fix use of BCM7216 reset
 controller
Message-ID: <20210503185756.GA993240@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430152156.21162-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 30, 2021 at 11:21:53AM -0400, Jim Quinlan wrote:
> v6 -- Added new commit which adds a missing function to the reset API.
>       This fixes 557acb3d2cd9 and should be destined for linux stable.
> 
> v5 -- Improved (I hope) commit description (Bjorn).
>    -- Rnamed error labels (Krzyszt).
>    -- Fixed typos.
> 
> v4 -- does not rely on a pending commit, unlike v3.
> 
> v3 -- discard commit from v2; instead rely on the new function
>       reset_control_rearm provided in a recent commit [1] applied
>       to reset/next.
>    -- New commit to correct pcie-brcmstb.c usage of a reset controller
>       to use reset/rearm verses deassert/assert.
> 
> v2 -- refactor rescal-reset driver to implement assert/deassert rather than
>       reset because the reset call only fires once per lifetime and we need
>       to reset after every resume from S2 or S3.
>    -- Split the use of "ahci" and "rescal" controllers in separate fields
>       to keep things simple.
> 
> v1 -- original
> 
> Jim Quinlan (3):
>   reset: add missing empty function reset_control_rearm()
>   ata: ahci_brcm: Fix use of BCM7216 reset controller
>   PCI: brcmstb: Use reset/rearm instead of deassert/assert
> 
>  drivers/ata/ahci_brcm.c               | 46 +++++++++++++--------------
>  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++----
>  include/linux/reset.h                 |  5 +++
>  3 files changed, 41 insertions(+), 29 deletions(-)

I provisionally applied these to my pci/brcmstb branch for v5.13.

I carried forward Jens' ack on "ata: ahci_brcm: Fix use of BCM7216
reset controller" since the patch is identical to the v5 version that
he acked.

I'm hoping to get an ack from Philipp for the reset.h change.

Bjorn
