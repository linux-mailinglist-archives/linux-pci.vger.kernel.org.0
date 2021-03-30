Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F52334ED11
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhC3QCW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 12:02:22 -0400
Received: from foss.arm.com ([217.140.110.172]:40012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232032AbhC3QBw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Mar 2021 12:01:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5278DD6E;
        Tue, 30 Mar 2021 09:01:52 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.43.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CC3F3F719;
        Tue, 30 Mar 2021 09:01:51 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dongdong Liu <liudongdong3@huawei.com>, helgaas@kernel.org,
        wangzhou1@hisilicon.com, linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] dt-bindings: PCI: hisi: Delete the useless HiSilicon PCIe file
Date:   Tue, 30 Mar 2021 17:01:45 +0100
Message-Id: <161712006604.31373.14834820809321044616.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <1616842062-21823-1-git-send-email-liudongdong3@huawei.com>
References: <1616842062-21823-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 27 Mar 2021 18:47:42 +0800, Dongdong Liu wrote:
> The hisilicon-pcie.txt file is no longer useful since commit
> c2fa6cf76d20 (PCI: dwc: hisi: Remove non-ECAM HiSilicon
> hip05/hip06 driver), so delete it.

Applied to pci/misc, thanks!

[1/1] dt-bindings: PCI: hisi: Delete the obsolete HiSilicon PCIe file
      https://git.kernel.org/lpieralisi/pci/c/756d4c369c

Thanks,
Lorenzo
