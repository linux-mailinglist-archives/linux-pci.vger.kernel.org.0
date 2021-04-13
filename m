Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9286B35DCAF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 12:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343760AbhDMKqY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 06:46:24 -0400
Received: from foss.arm.com ([217.140.110.172]:40156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236926AbhDMKqW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 06:46:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5662106F;
        Tue, 13 Apr 2021 03:46:02 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.59.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C47503F73B;
        Tue, 13 Apr 2021 03:46:01 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, bhelgaas@google.com,
        kishon@ti.com
Subject: Re: [PATCH -next] PCI: endpoint: fix missing destroy_workqueue()
Date:   Tue, 13 Apr 2021 11:45:56 +0100
Message-Id: <161831070900.4077.16892670108343328959.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210331084012.2091010-1-yangyingliang@huawei.com>
References: <20210331084012.2091010-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 31 Mar 2021 16:40:12 +0800, Yang Yingliang wrote:
> Add the missing destroy_workqueue() before return from
> pci_epf_test_init() in the error handling case and add
> destroy_workqueue() in pci_epf_test_exit().

Applied to pci/endpoint, thanks!

[1/1] PCI: endpoint: Fix missing destroy_workqueue()
      https://git.kernel.org/lpieralisi/pci/c/acaef7981a

Thanks,
Lorenzo
