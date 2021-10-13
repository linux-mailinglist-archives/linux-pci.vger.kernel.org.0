Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2CF42C14E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 15:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhJMNYJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 09:24:09 -0400
Received: from foss.arm.com ([217.140.110.172]:39182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233962AbhJMNYI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 09:24:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DAF41FB;
        Wed, 13 Oct 2021 06:22:05 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.53.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20FA93F66F;
        Wed, 13 Oct 2021 06:22:03 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: uniphier: Serialize INTx masking/unmasking and fix the bit operation
Date:   Wed, 13 Oct 2021 14:21:57 +0100
Message-Id: <163413129990.22138.15702601418817174711.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1631924579-24567-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1631924579-24567-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 18 Sep 2021 09:22:59 +0900, Kunihiko Hayashi wrote:
> The condition register PCI_RCV_INTX is used in irq_mask() and irq_unmask()
> callbacks. Accesses to register can occur at the same time without a lock.
> Add a lock into each callback to prevent the issue.
> 
> And INTX mask and unmask fields in PCL_RCV_INTX register should only be
> set/reset for each bit. Clearing by PCL_RCV_INTX_ALL_MASK should be
> removed.
> 
> [...]

Applied to pci/qcom, thanks!

[1/1] PCI: uniphier: Serialize INTx masking/unmasking and fix the bit operation
      https://git.kernel.org/lpieralisi/pci/c/bab406fc11

Thanks,
Lorenzo
