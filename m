Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7185302812
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 17:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbhAYQka (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 11:40:30 -0500
Received: from foss.arm.com ([217.140.110.172]:51228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730797AbhAYQj4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jan 2021 11:39:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1C7C1042;
        Mon, 25 Jan 2021 08:39:10 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.45.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EC923F68F;
        Mon, 25 Jan 2021 08:39:09 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] PCI: dwc: Drop support for config space in 'ranges'
Date:   Mon, 25 Jan 2021 16:39:03 +0000
Message-Id: <161159271692.16704.13308317128436782830.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201215194149.86831-1-robh@kernel.org>
References: <20201215194149.86831-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 15 Dec 2020 13:41:49 -0600, Rob Herring wrote:
> Since commit a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and
> "addr_space" resource setup into common code"), the code
> setting dbi_base when the config space is defined in 'ranges' property
> instead of 'reg' is dead code as dbi_base is never NULL.
> 
> Rather than fix this, let's just drop the code. Using ranges has been
> deprecated since 2014. The only platforms using this were exynos5440,
> i.MX6 and Spear13xx. Exynos5440 is dead and has been removed. i.MX6 and
> Spear13xx had PCIe support added just before this was deprecated and
> were fixed within a kernel release or 2.

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: Drop support for config space in 'ranges'
      https://git.kernel.org/lpieralisi/pci/c/42aa2bd9a0

Thanks,
Lorenzo
