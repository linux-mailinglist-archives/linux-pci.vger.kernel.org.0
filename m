Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24ECC3B0970
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhFVPrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 11:47:08 -0400
Received: from foss.arm.com ([217.140.110.172]:51572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231876AbhFVPrH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 11:47:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C68A031B;
        Tue, 22 Jun 2021 08:44:51 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.45.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5BDC3F718;
        Tue, 22 Jun 2021 08:44:49 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Sandor Bodo-Merle <sbodomerle@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: iproc: Fix multi-MSI base vector number allocation
Date:   Tue, 22 Jun 2021 16:44:45 +0100
Message-Id: <162437667135.7609.9525971996203421958.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210622152630.40842-1-sbodomerle@gmail.com>
References: <20210621144702.GD27516@lpieralisi> <20210622152630.40842-1-sbodomerle@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 22 Jun 2021 17:26:29 +0200, Sandor Bodo-Merle wrote:
> Commit fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> introduced multi-MSI support with a broken allocation mechanism (it failed
> to reserve the proper number of bits from the inner domain).  Natural
> alignment of the base vector number was also not guaranteed.

Applied to pci/iproc, thanks!

[1/2] PCI: iproc: Fix multi-MSI base vector number allocation
      https://git.kernel.org/lpieralisi/pci/c/e673d697b9
[2/2] PCI: iproc: Support multi-MSI only on uniprocessor kernel
      https://git.kernel.org/lpieralisi/pci/c/2dc0a201d0

Thanks,
Lorenzo
