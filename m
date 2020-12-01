Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EAE2CA009
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 11:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgLAKhz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 05:37:55 -0500
Received: from foss.arm.com ([217.140.110.172]:40272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730096AbgLAKhy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Dec 2020 05:37:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FCC21042;
        Tue,  1 Dec 2020 02:37:09 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.32.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 917E83F66B;
        Tue,  1 Dec 2020 02:37:05 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        gregkh@linuxfoundation.org, robh@kernel.org, bhelgaas@google.com,
        kw@linux.com, jingoohan1@gmail.com, Vidya Sagar <vidyas@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, sagar.tv@gmail.com,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com
Subject: Re: [PATCH] PCI: tegra: Move "dbi" accesses to post common DWC initialization
Date:   Tue,  1 Dec 2020 10:36:57 +0000
Message-Id: <160681898561.2864.9528605586162039459.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201125192234.2270-1-vidyas@nvidia.com>
References: <20201125192234.2270-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 26 Nov 2020 00:52:34 +0530, Vidya Sagar wrote:
> commit a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space"
> resource setup into common code") moved the code that sets up dbi_base
> to DWC common code thereby creating a requirement to not access the "dbi"
> region before calling common DWC initialization code. But, Tegra194
> already had some code that programs some of the "dbi" registers resulting
> in system crash. This patch addresses that issue by refactoring the code
> to have accesses to the "dbi" region only after common DWC initialization.

Applied to pci/dwc, thanks!

[1/1] PCI: tegra: Move "dbi" accesses to post common DWC initialization
      https://git.kernel.org/lpieralisi/pci/c/369b868f4a

Thanks,
Lorenzo
