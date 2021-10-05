Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB7042218C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 10:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhJEJBs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 05:01:48 -0400
Received: from foss.arm.com ([217.140.110.172]:55442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232971AbhJEJBs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 05:01:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 975BE6D;
        Tue,  5 Oct 2021 01:59:57 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.51.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93E5F3F66F;
        Tue,  5 Oct 2021 01:59:56 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: visconti: Remove surplus dev_err() when using platform_get_irq_byname()
Date:   Tue,  5 Oct 2021 09:59:51 +0100
Message-Id: <163342437630.25790.1225284067114425606.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211001011626.132286-1-kw@linux.com>
References: <20211001011626.132286-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 1 Oct 2021 01:16:26 +0000, Krzysztof Wilczyński wrote:
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
      https://git.kernel.org/lpieralisi/pci/c/99e8fc7d35

Thanks,
Lorenzo
