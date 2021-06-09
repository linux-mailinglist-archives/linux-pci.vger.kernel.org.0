Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0A03A0EF1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 10:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhFIIwn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 04:52:43 -0400
Received: from foss.arm.com ([217.140.110.172]:53326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232870AbhFIIwn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jun 2021 04:52:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE5D91396;
        Wed,  9 Jun 2021 01:50:48 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.37.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F22D3F719;
        Wed,  9 Jun 2021 01:50:46 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Xogium <contact@xogium.me>, linux-pci@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] PCI: aardvark: Fix kernel panic during PIO transfer
Date:   Wed,  9 Jun 2021 09:50:39 +0100
Message-Id: <162322862108.3345.4160808336030929680.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210608203655.31228-1-pali@kernel.org>
References: <20210608203655.31228-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 8 Jun 2021 22:36:55 +0200, Pali Rohár wrote:
> Trying to start a new PIO transfer by writing value 0 in PIO_START register
> when previous transfer has not yet completed (which is indicated by value 1
> in PIO_START) causes an External Abort on CPU, which results in kernel
> panic:
> 
>     SError Interrupt on CPU0, code 0xbf000002 -- SError
>     Kernel panic - not syncing: Asynchronous SError Interrupt
> 
> [...]

Applied to pci/aardvark, thanks!

[1/1] PCI: aardvark: Fix kernel panic during PIO transfer
      https://git.kernel.org/lpieralisi/pci/c/f77378171b

Thanks,
Lorenzo
