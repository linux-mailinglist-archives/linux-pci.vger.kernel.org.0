Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C672B817D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 17:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgKRQGa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 11:06:30 -0500
Received: from foss.arm.com ([217.140.110.172]:58334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgKRQGa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 11:06:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A54181396;
        Wed, 18 Nov 2020 08:06:29 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.62.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 037513F719;
        Wed, 18 Nov 2020 08:06:27 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI: dwc: Support multiple ATU memory regions
Date:   Wed, 18 Nov 2020 16:06:18 +0000
Message-Id: <160571541071.4535.5411939926220228556.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201026181652.418729-1-robh@kernel.org>
References: <20201026181652.418729-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 26 Oct 2020 13:16:52 -0500, Rob Herring wrote:
> The current ATU setup only supports a single memory resource which
> isn't sufficient if there are also prefetchable memory regions. In order
> to support multiple memory regions, we need to move away from fixed ATU
> slots and rework the assignment. As there's always an ATU entry for
> config space, let's assign index 0 to config space. Then we assign
> memory resources to index 1 and up. Finally, if we have an I/O region
> and slots remaining, we assign the I/O region last. If there aren't
> remaining slots, we keep the same config and I/O space sharing.

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: Support multiple ATU memory regions
      https://git.kernel.org/lpieralisi/pci/c/9f9e59a480

Thanks,
Lorenzo
