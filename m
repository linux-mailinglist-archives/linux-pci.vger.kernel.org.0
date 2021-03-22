Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F62344719
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 15:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhCVO1Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 10:27:24 -0400
Received: from foss.arm.com ([217.140.110.172]:32882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhCVO06 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 10:26:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A2611042;
        Mon, 22 Mar 2021 07:26:53 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.55.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF2FD3F719;
        Mon, 22 Mar 2021 07:26:51 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: microchip: Remove dev_err() when handing an error from platform_get_irq()
Date:   Mon, 22 Mar 2021 14:26:46 +0000
Message-Id: <161642318853.10431.11209153253917590509.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210310131913.2802385-1-kw@linux.com>
References: <20210310131913.2802385-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 10 Mar 2021 13:19:13 +0000, Krzysztof Wilczyński wrote:
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
> 
> This change is as per suggestions from Coccinelle, e.g.,
>   drivers/pci/controller/pcie-microchip-host.c:1027:2-9: line 1027 is
>   redundant because platform_get_irq() already prints an error
> 
> [...]

Applied to pci/microchip, thanks!

[1/1] PCI: microchip: Remove dev_err() when handing an error from platform_get_irq()
      https://git.kernel.org/lpieralisi/pci/c/6e7628c8c3

Thanks,
Lorenzo
