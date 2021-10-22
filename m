Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF1B4374D6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 11:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhJVJiX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 05:38:23 -0400
Received: from foss.arm.com ([217.140.110.172]:52032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhJVJiW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 05:38:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E4B21063;
        Fri, 22 Oct 2021 02:36:05 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.54.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37B303F70D;
        Fri, 22 Oct 2021 02:36:03 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     bhelgaas@google.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        robh@kernel.org, kishon@ti.com, kw@linux.com, tjoseph@cadence.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] PCI: j721e: Fix an error handling path in 'j721e_pcie_probe()'
Date:   Fri, 22 Oct 2021 10:35:58 +0100
Message-Id: <163489533869.17392.2233519953795577688.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <db477b0cb444891a17c4bb424467667dc30d0bab.1624794264.git.christophe.jaillet@wanadoo.fr>
References: <db477b0cb444891a17c4bb424467667dc30d0bab.1624794264.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 27 Jun 2021 13:46:24 +0200, Christophe JAILLET wrote:
> If an error occurs after a successful 'cdns_pcie_init_phy()' call, it must
> be undone by a 'cdns_pcie_disable_phy()' call, as already done above and
> below.
> 
> Update the 'goto' to branch at the correct place of the error handling
> path.
> 
> [...]

Applied to pci/cadence, thanks!

[1/1] PCI: j721e: Fix an error handling path in 'j721e_pcie_probe()'
      https://git.kernel.org/lpieralisi/pci/c/1faff614aa

Thanks,
Lorenzo
