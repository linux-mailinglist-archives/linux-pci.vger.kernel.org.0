Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481BC344E13
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 19:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhCVSEJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 14:04:09 -0400
Received: from foss.arm.com ([217.140.110.172]:36316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhCVSED (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 14:04:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DDE2113E;
        Mon, 22 Mar 2021 11:04:02 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.49.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A7B23F718;
        Mon, 22 Mar 2021 11:04:01 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        gustavo.pimentel@synopsys.com, robh@kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com
Subject: Re: [PATCH] PCI: dwc: Move forward the iATU detection process
Date:   Mon, 22 Mar 2021 18:03:57 +0000
Message-Id: <161643622212.21337.14859040633786233709.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210125044803.4310-1-Zhiqiang.Hou@nxp.com>
References: <20210125044803.4310-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 25 Jan 2021 12:48:03 +0800, Zhiqiang Hou wrote:
> In the dw_pcie_ep_init(), it depends on the detected iATU region
> numbers to allocate the in/outbound window management bit map.
> It fails after the commit 281f1f99cf3a ("PCI: dwc: Detect number
> of iATU windows").
> 
> So this patch move the iATU region detection into a new function,
> move forward the detection to the very beginning of functions
> dw_pcie_host_init() and dw_pcie_ep_init(). And also remove it
> from the dw_pcie_setup(), since it's more like a software
> perspective initialization step than hardware setup.

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: Move forward the iATU detection process
      https://git.kernel.org/lpieralisi/pci/c/5ff8ca16f8

Thanks,
Lorenzo
