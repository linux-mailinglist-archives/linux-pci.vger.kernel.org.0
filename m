Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D0943CF37
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 18:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243142AbhJ0RBa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 13:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237929AbhJ0RBZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Oct 2021 13:01:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8962560EDF;
        Wed, 27 Oct 2021 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635353939;
        bh=kaTwXIJN40QCdVhjU8t/SSdOu1JqzIHQJoWDXuNybm0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PA786h6onPARN5DmpCKcVlgIhdSBBgu5ndzyI6U+HKZ1g/MA5ycb5ijyGIiMzzQKF
         u87j4x6sL3i9EluMCuzknSv1hL0GJ57rkRx60UV5/FQ9YmfB22CuCH2pcd5uceVNvA
         EUR1nZ0y7WK6lw7hTzQk2P9j5TbbT1zdnTR+7LfJNX/9dajtJOFIR9T6/S0PIbpI/t
         HRg3xpUPL40GcJRSGCMzK4quK/+Du3fAhmUYq8AqwMZ4dEqE4aqS6Clvm1lpvS9u8U
         vJc0lfGe7ApcWkhkHzaKlt7eQsOK2LhQ0t6ZUVUoKmnCGpU9JA+E2UMXdKsKsXANN5
         owBvlYRnkpNCw==
Date:   Wed, 27 Oct 2021 11:58:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <20211027165857.GA229979@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNyxYm4Sf6EsKjmedi8RF-CZKsXs9KXMjaTd_xqnyFL8ZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 26, 2021 at 05:27:32PM -0400, Jim Quinlan wrote:

> I don't think it matters but our PCIe controllers only have a single
> root port.

Just to kibitz, and I don't know anything about the DT binding under
discussion here, but I would prefer if DTs and drivers did not have
the "single root port" assumption baked deeply in them.

I expect some controllers to support multiple root ports, and it would
be really nice if the DTs and drivers all had similar structures with
the single-root-port controllers just being the N=1 case.

For example, some drivers put their per-root port stuff in
*_add_pcie_port() functions, which I think is a nice way to do it
because it leaves the door open for calling *_add_pcie_port() in a
loop.

Ironically, the only driver I see that looks like it currently
supports multiple root ports is pci-mvebu.c, and it doesn't have an
_add_pcie_port() function.

Having this sort of consistent structure and naming across drivers is
a huge help for ongoing maintenance.

Bjorn
