Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF4B2FB884
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 15:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392207AbhASM5r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 07:57:47 -0500
Received: from foss.arm.com ([217.140.110.172]:53428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732408AbhASMAH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 07:00:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C49F2113E;
        Tue, 19 Jan 2021 03:59:21 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.35.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0545C3F719;
        Tue, 19 Jan 2021 03:59:18 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH v3 0/2] brcmstb: initial work on BCM4908
Date:   Tue, 19 Jan 2021 11:59:09 +0000
Message-Id: <161105750898.12456.5384775550030324470.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201210180421.7230-1-zajec5@gmail.com>
References: <20201210180421.7230-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 10 Dec 2020 19:04:19 +0100, Rafał Miłecki wrote:
> BCM4908 uses very similar hardware to the STB one. It still requires
> some tweaks but this initial work allows accessing hardware without:
> 
> Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
> 
> Rafał Miłecki (2):
>   dt-bindings: PCI: brcmstb: add BCM4908 binding
>   PCI: brcmstb: support BCM4908 with external PERST# signal controller
> 
> [...]

Applied to pci/brcmstb, thanks!

[1/2] dt-bindings: PCI: brcmstb: add BCM4908 binding
      https://git.kernel.org/lpieralisi/pci/c/f435ce7ebf
[2/2] PCI: brcmstb: support BCM4908 with external PERST# signal controller
      https://git.kernel.org/lpieralisi/pci/c/0cdfaceb98

Thanks,
Lorenzo
