Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C1F39A552
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 18:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhFCQKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 12:10:02 -0400
Received: from foss.arm.com ([217.140.110.172]:44834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhFCQKB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 12:10:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8994D11B3;
        Thu,  3 Jun 2021 09:08:16 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.39.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EC963F73D;
        Thu,  3 Jun 2021 09:08:14 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com, robh@kernel.org,
        bhelgaas@google.com, Zou Wei <zou_wei@huawei.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: tegra: Add missing MODULE_DEVICE_TABLE
Date:   Thu,  3 Jun 2021 17:08:09 +0100
Message-Id: <162273647631.16916.18284032638415349701.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <1620792422-16535-1-git-send-email-zou_wei@huawei.com>
References: <1620792422-16535-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 12 May 2021 12:07:02 +0800, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.

Applied to pci/tegra, thanks!

[1/1] PCI: tegra: Add missing MODULE_DEVICE_TABLE
      https://git.kernel.org/lpieralisi/pci/c/7ebe6b79d7

Thanks,
Lorenzo
