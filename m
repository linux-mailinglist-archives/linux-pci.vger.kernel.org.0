Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F77465224
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 16:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351181AbhLAP4w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 10:56:52 -0500
Received: from foss.arm.com ([217.140.110.172]:40488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351180AbhLAP4w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 10:56:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 239AD143B;
        Wed,  1 Dec 2021 07:53:31 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.32.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FC8A3F766;
        Wed,  1 Dec 2021 07:53:28 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for internal use only
Date:   Wed,  1 Dec 2021 15:53:21 +0000
Message-Id: <163837398126.3058.11030158077196581603.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
References: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 15 Nov 2021 13:20:00 +0200, Andy Shevchenko wrote:
> Use BIT() as __GENMASK() is for internal use only. The rationale
> of switching to BIT() is to provide better generated code. The
> GENMASK() against non-constant numbers may produce an ugly assembler
> code. On contrary the BIT() is simply converted to corresponding shift
> operation.
> 
> Note, it's the only user of __GENMASK() in the kernel outside of its own realm.
> 
> [...]

Applied to pci/brcmstb, thanks!

[1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for internal use only
      https://git.kernel.org/lpieralisi/pci/c/6ec6eb949d

Thanks,
Lorenzo
