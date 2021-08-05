Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A503B3E139A
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 13:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbhHELM0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 07:12:26 -0400
Received: from foss.arm.com ([217.140.110.172]:42940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240712AbhHELM0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 07:12:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C87551FB;
        Thu,  5 Aug 2021 04:12:11 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.41.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5066E3F719;
        Thu,  5 Aug 2021 04:12:10 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     bhelgaas@google.com, toan@os.amperecomputing.com, robh@kernel.org,
        ErKun Yang <yangerkun@huawei.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, yukuai3@huawei.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: xgene-msi: Remove redundant dev_err call in xgene_msi_probe()
Date:   Thu,  5 Aug 2021 12:12:04 +0100
Message-Id: <162816190524.30159.389276372936290977.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210408132751.1198171-1-yangerkun@huawei.com>
References: <20210408132751.1198171-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 8 Apr 2021 21:27:51 +0800, ErKun Yang wrote:
> devm_ioremap_resource() internally calls __devm_ioremap_resource() which
> is where error checking and handling is actually having place. So the
> dev_err in xgene_msi_probe() seems redundant and remove it.

Applied to pci/xgene, thanks!

[1/1] PCI: xgene-msi: Remove redundant dev_err() call in xgene_msi_probe()
      https://git.kernel.org/lpieralisi/pci/c/9e4ae52cab

Thanks,
Lorenzo
