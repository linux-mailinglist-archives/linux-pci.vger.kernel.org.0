Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97843B42AC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 13:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhFYLql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 07:46:41 -0400
Received: from foss.arm.com ([217.140.110.172]:54034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhFYLql (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 07:46:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8C291063;
        Fri, 25 Jun 2021 04:44:20 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.47.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D98E13F694;
        Fri, 25 Jun 2021 04:44:18 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH 0/3] PCI: aardvark: PIO fixes
Date:   Fri, 25 Jun 2021 12:44:10 +0100
Message-Id: <162462127436.16453.17392450814114184768.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210624213345.3617-1-pali@kernel.org>
References: <20210624213345.3617-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 24 Jun 2021 23:33:42 +0200, Pali Rohár wrote:
> Per Lorenzo's request [1] I'm resending PCI aardvark patches from big
> patch series [2] which fixes just one small thing - aardvark PIO code.
> 
> [1] - https://lore.kernel.org/linux-pci/20210603151605.GA18917@lpieralisi/
> [2] - https://lore.kernel.org/linux-pci/20210506153153.30454-1-pali@kernel.org/
> 
> Evan Wang (1):
>   PCI: aardvark: Fix checking for PIO status
> 
> [...]

Given that we are close to a release, I am trying to cherry-pick
some aardvark patches to cut the current delta.

Applied to pci/aardvark:

[1/1] PCI: aardvark: Fix checking for PIO Non-posted Request
      https://git.kernel.org/lpieralisi/pci/c/8ceeac307a

Thanks,
Lorenzo
