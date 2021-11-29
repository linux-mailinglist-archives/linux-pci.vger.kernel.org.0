Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897C7461CE4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 18:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349398AbhK2Rp5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 12:45:57 -0500
Received: from foss.arm.com ([217.140.110.172]:43958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348208AbhK2Rn5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 12:43:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36DFF1063;
        Mon, 29 Nov 2021 09:40:39 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.34.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D05703F5A1;
        Mon, 29 Nov 2021 09:40:36 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     toan@os.amperecomputing.com, robh@kernel.org, bhelgaas@google.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kw@linux.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: xgene-msi: Use bitmap_zalloc() when applicable
Date:   Mon, 29 Nov 2021 17:40:29 +0000
Message-Id: <163820760990.16735.3697424205036931357.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <32f3bc1fbfbd6ee0815e565012904758ca9eff7e.1635019243.git.christophe.jaillet@wanadoo.fr>
References: <32f3bc1fbfbd6ee0815e565012904758ca9eff7e.1635019243.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 23 Oct 2021 22:02:05 +0200, Christophe JAILLET wrote:
> 'xgene_msi->bitmap' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
> improve the semantic and avoid some open-coded arithmetic in allocator
> arguments.
> 
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.
> 
> [...]

Applied to pci/xgene, thanks!

[1/1] PCI: xgene-msi: Use bitmap_zalloc() when applicable
      https://git.kernel.org/lpieralisi/pci/c/1ed9b961be

Thanks,
Lorenzo
