Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631763B0167
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 12:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhFVKeV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 06:34:21 -0400
Received: from foss.arm.com ([217.140.110.172]:46380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhFVKeU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 06:34:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31FF111D4;
        Tue, 22 Jun 2021 03:32:05 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.45.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EF203F694;
        Tue, 22 Jun 2021 03:32:03 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with clocks gated
Date:   Tue, 22 Jun 2021 11:31:58 +0100
Message-Id: <162435790233.26282.6051078947920450608.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210608080409.1729276-1-javierm@redhat.com>
References: <20210608080409.1729276-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 8 Jun 2021 10:04:09 +0200, Javier Martinez Canillas wrote:
> IRQ handlers that are registered for shared interrupts can be called at
> any time after have been registered using the request_irq() function.
> 
> It's up to drivers to ensure that's always safe for these to be called.
> 
> Both the "pcie-sys" and "pcie-client" interrupts are shared, but since
> their handlers are registered very early in the probe function, an error
> later can lead to these handlers being executed before all the required
> resources have been properly setup.
> 
> [...]

Applied to pci/rockchip, thanks!

[1/1] PCI: rockchip: Avoid accessing PCIe registers with clocks gated
      https://git.kernel.org/lpieralisi/pci/c/c025f5b2e5

Thanks,
Lorenzo
