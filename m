Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A37463C1B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 17:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhK3Qrx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 11:47:53 -0500
Received: from foss.arm.com ([217.140.110.172]:43190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhK3Qrw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Nov 2021 11:47:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42C7C6D;
        Tue, 30 Nov 2021 08:44:33 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.34.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 653963F694;
        Tue, 30 Nov 2021 08:44:31 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] PCI: apple: Enable clock gating
Date:   Tue, 30 Nov 2021 16:44:20 +0000
Message-Id: <163829063706.20838.16525085467992307850.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211117141916.197192-1-marcan@marcan.st>
References: <20211117141916.197192-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 17 Nov 2021 23:19:16 +0900, Hector Martin wrote:
> These pokes are not required to make the PCIe port work, but it sounds
> like this should save some power at least.
> 
> 

Applied to pci/apple, thanks!

[1/1] PCI: apple: Enable clock gating
      https://git.kernel.org/lpieralisi/pci/c/754bb7ad29

Thanks,
Lorenzo
