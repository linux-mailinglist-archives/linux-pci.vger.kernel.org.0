Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14D14616D9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 14:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbhK2Nqa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 08:46:30 -0500
Received: from foss.arm.com ([217.140.110.172]:39724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237756AbhK2Noa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 08:44:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DC2C1042;
        Mon, 29 Nov 2021 05:41:12 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.34.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 073773F766;
        Mon, 29 Nov 2021 05:41:10 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        robh@kernel.org, bhelgaas@google.com, kw@linux.com,
        michal.simek@xilinx.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: xilinx-nwl: Simplify code and fix a memory leak
Date:   Mon, 29 Nov 2021 13:41:05 +0000
Message-Id: <163819324863.26090.8890227197735152343.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <5483f10a44b06aad55728576d489adfa16c3be91.1636279388.git.christophe.jaillet@wanadoo.fr>
References: <5483f10a44b06aad55728576d489adfa16c3be91.1636279388.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 7 Nov 2021 11:04:43 +0100, Christophe JAILLET wrote:
> Allocate space for 'bitmap' in 'struct nwl_msi' at build time instead of
> dynamically allocating the memory at runtime.
> 
> This simplifies code (especially error handling paths) and avoid some
> open-coded arithmetic in allocator arguments
> 
> This also fixes a potential memory leak. The bitmap was never freed. It is
> now part of a managed resource.
> 
> [...]

Applied to pci/xilinx-nwl, thanks!

[1/1] PCI: xilinx-nwl: Simplify code and fix a memory leak
      https://git.kernel.org/lpieralisi/pci/c/e2b86f9777

Thanks,
Lorenzo
