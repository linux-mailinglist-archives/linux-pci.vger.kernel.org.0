Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DFD425612
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 17:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242330AbhJGPIG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 11:08:06 -0400
Received: from foss.arm.com ([217.140.110.172]:59698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242331AbhJGPIF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 11:08:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3EDA1FB;
        Thu,  7 Oct 2021 08:06:11 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.53.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9A2F3F66F;
        Thu,  7 Oct 2021 08:06:10 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: visconti: Remove surplus dev_err() when using platform_get_irq_byname()
Date:   Thu,  7 Oct 2021 16:06:03 +0100
Message-Id: <163361908019.10230.16372923271080342072.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211007122848.3366-1-kw@linux.com>
References: <20211007122848.3366-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 7 Oct 2021 12:28:48 +0000, Krzysztof Wilczyński wrote:
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
> 
> This change is as per suggestions from Coccinelle, e.g.,
>   drivers/pci/controller/dwc/pcie-visconti.c:286:2-9: line 286 is redundant because platform_get_irq() already prints an error
> 
> [...]

Applied to pci/dwc, thanks!

[1/1] PCI: visconti: Remove surplus dev_err() when using platform_get_irq_byname()
      https://git.kernel.org/lpieralisi/pci/c/5b8402562e

Thanks,
Lorenzo
