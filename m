Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191BD34ED1C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 18:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhC3QFc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 12:05:32 -0400
Received: from foss.arm.com ([217.140.110.172]:40290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231627AbhC3QFK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Mar 2021 12:05:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D6E1D6E;
        Tue, 30 Mar 2021 09:05:10 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.43.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 195103F719;
        Tue, 30 Mar 2021 09:05:08 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        wangzhou1@hisilicon.com, kw@linux.com,
        Dongdong Liu <liudongdong3@huawei.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V2] dt-bindings: PCI: hisi: Delete the obsolete HiSilicon PCIe file
Date:   Tue, 30 Mar 2021 17:05:03 +0100
Message-Id: <161712023580.32399.5879086805905167506.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <1617111799-109749-1-git-send-email-liudongdong3@huawei.com>
References: <1617111799-109749-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 30 Mar 2021 21:43:19 +0800, Dongdong Liu wrote:
> The hisilicon-pcie.txt file is no longer useful since commit
> c2fa6cf76d20 (PCI: dwc: hisi: Remove non-ECAM HiSilicon
> hip05/hip06 driver), so delete it and remove related code in
> MAINTAINERS file.

I applied v2 to pci/misc, discarded v1, thanks:

[1/1] dt-bindings: PCI: hisi: Delete the obsolete HiSilicon PCIe file
      https://git.kernel.org/lpieralisi/pci/c/52ab55dfe3

Thanks,
Lorenzo
