Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B848F34B00B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 21:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCZUSH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 16:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhCZURw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Mar 2021 16:17:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2450561A18;
        Fri, 26 Mar 2021 20:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616789872;
        bh=HQiYbloBWeueZbq2L4oIhpCdSmR81v4HPpPi6S55n34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ANchPUbA7/niZ+2pM4ATJhblFIlE8ITlpAvMJLR+NSAxfJASezVQ9ueEhWhaJElvb
         5Fjusoq4cJ0G/sOxwXl0fz5HbIhwNBasdrdYjbUx3UmyCIR9b3qNbDa58OMuixoW2X
         tAqhmk5N+YeYehwzOTjnh11PdSoJieSF11ZManBgDB4SgRa29rCFAORH3ljc5PkIbB
         ZKTGa6IrzdubbAH9NINQB1/6Ykjvb9+oSblL3CEV1aTv9MoLtZ90DjyEpoe9aJtQp1
         GrFCofGtIWioYjjG8FMi4rBUtVqEWTLQVYfcrq2YwQgiawMoXxMqoMzs6DEKEsmYUh
         V+3mns8AoL8vQ==
Date:   Fri, 26 Mar 2021 15:17:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] PCI: brcmstb: Do not turn off regulators if EP
 can wake up
Message-ID: <20210326201750.GA905944@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326191906.43567-4-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 26, 2021 at 03:19:01PM -0400, Jim Quinlan wrote:
> If any downstream device may wake up during S2/S3 suspend, we do not want
> to turn off its power when suspending.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 58 +++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 7 deletions(-)

> +enum {
> +	TURN_OFF,		/* Turn egulators off, unless an EP is wakeup-capable */
> +	TURN_OFF_ALWAYS,	/* Turn Regulators off, no exceptions */
> +	TURN_ON,		/* Turn regulators on, unless pcie->ep_wakeup_capable */

s/egulators/regulators/
s/Regulators/regulators/
