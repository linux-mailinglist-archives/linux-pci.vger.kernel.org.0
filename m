Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DE73028E7
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 18:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbhAYRab (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 12:30:31 -0500
Received: from foss.arm.com ([217.140.110.172]:53042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730872AbhAYRa1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jan 2021 12:30:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88FCB1063;
        Mon, 25 Jan 2021 09:29:41 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.45.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FED03F68F;
        Mon, 25 Jan 2021 09:29:39 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pan Bian <bianpan2016@163.com>, Rob Herring <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: xilinx-cpm: Fix reference count leak on error path
Date:   Mon, 25 Jan 2021 17:29:33 +0000
Message-Id: <161159572326.6620.10179220906412292762.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210120143745.699-1-bianpan2016@163.com>
References: <20210120143745.699-1-bianpan2016@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 20 Jan 2021 06:37:45 -0800, Pan Bian wrote:
> Also drop the reference count of the node on error path.

Applied to pci/xilinx, thanks!

[1/1] PCI: xilinx-cpm: Fix reference count leak on error path
      https://git.kernel.org/lpieralisi/pci/c/ae191d2e51

Thanks,
Lorenzo
