Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E27461600
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 14:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbhK2NRN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 08:17:13 -0500
Received: from foss.arm.com ([217.140.110.172]:39010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232071AbhK2NPN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 08:15:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 724A0150C;
        Mon, 29 Nov 2021 05:11:55 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.34.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 738B53F766;
        Mon, 29 Nov 2021 05:11:52 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        f.fainelli@gmail.com, robh@kernel.org, jim2101024@gmail.com,
        kw@linux.com, Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        bhelgaas@google.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: brcmstb: Declare a bitmap as a bitmap, not as a plain 'unsigned long'
Date:   Mon, 29 Nov 2021 13:11:45 +0000
Message-Id: <163819142462.10670.2516167038486090067.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <e6d9da2112aab2939d1507b90962d07bfd735b4c.1636273671.git.christophe.jaillet@wanadoo.fr>
References: <e6d9da2112aab2939d1507b90962d07bfd735b4c.1636273671.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 7 Nov 2021 09:32:58 +0100, Christophe JAILLET wrote:
> The 'used' field of 'struct brcm_msi' is used as a bitmap. So it should
> be declared as so (i.e. unsigned long *).
> 
> This fixes an harmless Coverity warning about array vs singleton usage.
> 
> This bitmap can be BRCM_INT_PCI_MSI_LEGACY_NR or BRCM_INT_PCI_MSI_NR long.
> So, while at it, document it, should it help someone in the future.

Applied to pci/brcmstb, thanks!

[1/1] PCI: brcmstb: Declare a bitmap as a bitmap, not as a plain 'unsigned long'
      https://git.kernel.org/lpieralisi/pci/c/3e46790d16

Thanks,
Lorenzo
