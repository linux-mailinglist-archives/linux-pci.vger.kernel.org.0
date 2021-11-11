Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD52444DDC9
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 23:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhKKWUG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 17:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhKKWUG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Nov 2021 17:20:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F5D06101C;
        Thu, 11 Nov 2021 22:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636669036;
        bh=a93R/TAKIik/1JJkF9BtbeeMgT0GaFv/oi3iUd1WivI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YS9Nld5GPwBbGgcQpz+CWYAj7G5NB3P7EtN7+OuDP1C8d2YLn/Fhw8InjV4cyS4Gj
         TqcoDNBC3V4b1ciNgy0KIrORuM87tA4BaLa1xqoU5OlUiAbKsvvYOHCmPFO7YlTk7Q
         OLqcr5yprEaFkFOyRAv42u7hIThnuk6gtoQbPqG/92uh0WKl7BMGBu275Qra7bnsec
         Hn2IL/61xjVsArXbgDkwchOVPzCbNkh/H2J/LntRptvJaf9XJSINOihlc5nxPQzDKN
         oGEBrMGwuO7VeFIoW7QjJdttuznno6ZczB6PQJd5m6DXo3trKz7Aq1mYX9H6a4Sf05
         zygR/0yS/ECpQ==
Date:   Thu, 11 Nov 2021 16:17:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 3/8] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <20211111221714.GA1354700@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110221456.11977-4-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 10, 2021 at 05:14:43PM -0500, Jim Quinlan wrote:
> Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
> allows optional regulators to be attached and controlled by the PCIe RC
> driver.  That being said, this driver searches in the DT subnode (the EP
> node, eg pci-ep@0,0) for the regulator property.
> 
> The use of a regulator property in the pcie EP subnode such as
> "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> file at
> 
> https://github.com/devicetree-org/dt-schema/pull/63

Can you use a lore URL here?  github.com is sort of outside the Linux
ecosystem and this link is more likely to remain useful if it's to
something in kernel.org.

The subject says what this patch does, but the commit log doesn't.
It's OK to repeat the subject in the commit log if that's what makes
the most sense.
