Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC0A3B439E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 14:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFYMy5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 08:54:57 -0400
Received: from foss.arm.com ([217.140.110.172]:55144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhFYMy4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 08:54:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B72A31B;
        Fri, 25 Jun 2021 05:52:35 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.47.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 094593F694;
        Fri, 25 Jun 2021 05:52:31 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nadav Haklai <nadavh@marvell.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, Xogium <contact@xogium.me>,
        linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Kostya Porotchkin <kostap@marvell.com>
Subject: Re: [RESEND PATCH 0/5] PCI: aardvark: Initialization fixes
Date:   Fri, 25 Jun 2021 13:52:25 +0100
Message-Id: <162462543780.14822.10606953515342691039.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210624222621.4776-1-pali@kernel.org>
References: <20210624222621.4776-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 25 Jun 2021 00:26:16 +0200, Pali Rohár wrote:
> Per Lorenzo's request [1] I'm resending [2] some other aardvark patches
> which fixes initialization.
> 
> The last patch 5/5 is the new and was not in previous patch series [2].
> Please see detailed description and additional comment after --- section.
> 
> [1] - https://lore.kernel.org/linux-pci/20210603151605.GA18917@lpieralisi/
> [2] - https://lore.kernel.org/linux-pci/20210506153153.30454-1-pali@kernel.org/
> 
> [...]

Cherry picked this patch for the next merge window.

Applied to pci/aardvark:

[1/1] PCI: aardvark: Implement workaround for the readback value of VEND_ID
      https://git.kernel.org/lpieralisi/pci/c/7f71a409fe

Thanks,
Lorenzo
