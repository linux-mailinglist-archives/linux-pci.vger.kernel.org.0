Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF12B819B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 17:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKRQS5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 11:18:57 -0500
Received: from foss.arm.com ([217.140.110.172]:58600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgKRQS5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 11:18:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C29DD1396;
        Wed, 18 Nov 2020 08:18:56 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.62.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 187CF3F719;
        Wed, 18 Nov 2020 08:18:53 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     jingoohan1@gmail.com, bhelgaas@google.com,
        amurray@thegoodpenguin.co.uk, jonathanh@nvidia.com,
        gustavo.pimentel@synopsys.com, robh@kernel.org,
        Vidya Sagar <vidyas@nvidia.com>, treding@nvidia.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        linux-kernel@vger.kernel.org, mmaddireddy@nvidia.com,
        sagar.tv@gmail.com
Subject: Re: [PATCH V2 0/2] Add support to handle prefetchable memory
Date:   Wed, 18 Nov 2020 16:18:47 +0000
Message-Id: <160571623360.10954.9426111019711925652.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201118144626.32189-1-vidyas@nvidia.com>
References: <20201118144626.32189-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 18 Nov 2020 20:16:24 +0530, Vidya Sagar wrote:
> This patch series adds support for configuring the DesignWare IP's ATU
> region for prefetchable memory translations.
> It first starts by flagging a warning if the size of non-prefetchable
> aperture goes beyond 32-bit as PCIe spec doesn't allow it.
> And then adds required support for programming the ATU to handle higher
> (i.e. >4GB) sizes.
> 
> [...]

Applied to pci/dwc, thanks!

[1/2] PCI: of: Warn if non-prefetchable memory aperture size is > 32-bit
      https://git.kernel.org/lpieralisi/pci/c/fede8526cc
[2/2] PCI: dwc: Add support to program ATU for >4GB memory
      https://git.kernel.org/lpieralisi/pci/c/74081de4a1

Thanks,
Lorenzo
