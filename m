Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED5B35FBD4
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 21:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345785AbhDNTrS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 15:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345326AbhDNTrS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Apr 2021 15:47:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAE4C61166;
        Wed, 14 Apr 2021 19:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618429616;
        bh=KuVnof+r6hRvfkV5hg/I5cwh0JERg3t7/JNTMJrdSTU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p2YWWgqeuaUlwXSjE+9RjYo6AkX/3oCNfYq3ioiwSV7R0sxpHPIt20Ga7XSFNMCSh
         XgegTcjDDAIzr5H7h/M1HtT+jjBFAwroDtoyKn4PGWjy8kV0tFVjRjPGgUYJp8tvM1
         YCJJsT5diCCVcVk5CUsFN/4OWtj76Vfe/a3arc1qn4zv/V++A95RozAlLIwpCC6Wlm
         pKqrc5jVG6kJex/vpwUH+MhYKBflGCTm3rHWBznlJ9Gqn5tOGYNh8CdhG4zIYgD27J
         tlNSvXrqXAXZ/x7klLcCJ346XrpXZS6RYCT8/KMy0RG22jqIYtR58mL6z2wKyGCTB/
         R/Pl+wkbw6v3w==
Date:   Wed, 14 Apr 2021 14:46:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH v10 3/3] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
Message-ID: <20210414194654.GA2526782@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617985338-19648-4-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 10, 2021 at 01:22:18AM +0900, Kunihiko Hayashi wrote:
> This patch adds misc interrupt handler to detect and invoke PME/AER event.
> 
> In UniPhier PCIe controller, PME/AER signals are assigned to the same
> signal as MSI by the internal logic. These signals should be detected by
> the internal register, however, DWC MSI handler can't handle these signals.
> 
> DWC MSI handler calls .msi_host_isr() callback function, that detects
> PME/AER signals using the internal register and invokes the interrupt
> with PME/AER vIRQ numbers.
> 
> These vIRQ numbers is obtained by uniphier_pcie_port_get_irq() function,
> that finds the device that matches PME/AER from the devices associated
> with Root Port, and returns its vIRQ number.

Why do you use the term "vIRQ"?  What exactly is a vIRQ?  It seems no
different than the simple "irq" as stored in pci_dev.irq or
pcie_device.irq and passed to generic_handle_irq().  "virq" is also
used in the patch, so if you change one, please change the other as
well.

Bjorn
