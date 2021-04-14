Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877A835F934
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352808AbhDNQri (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 12:47:38 -0400
Received: from foss.arm.com ([217.140.110.172]:59046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352815AbhDNQre (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Apr 2021 12:47:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E24211D4;
        Wed, 14 Apr 2021 09:46:57 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.44.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFC603F73B;
        Wed, 14 Apr 2021 09:46:55 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     bhelgaas@google.com, Chen Hui <clare.chenhui@huawei.com>,
        robh@kernel.org, ley.foon.tan@intel.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        rfi@lists.rocketboards.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: altera-msi: Remove redundant dev_err call in altera_msi_probe()
Date:   Wed, 14 Apr 2021 17:46:49 +0100
Message-Id: <161841879005.31658.12073491397078991276.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210409075748.226141-1-clare.chenhui@huawei.com>
References: <20210409075748.226141-1-clare.chenhui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 9 Apr 2021 15:57:48 +0800, Chen Hui wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.

Applied to pci/altera-msi, thanks!

[1/1] PCI: altera-msi: Remove redundant dev_err call in altera_msi_probe()
      https://git.kernel.org/lpieralisi/pci/c/b1160a06e0

Thanks,
Lorenzo
