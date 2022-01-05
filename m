Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFA048569F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 17:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241911AbiAEQ0H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 11:26:07 -0500
Received: from foss.arm.com ([217.140.110.172]:45784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbiAEQ0G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jan 2022 11:26:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5835711D4;
        Wed,  5 Jan 2022 08:26:06 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.39.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 478753F774;
        Wed,  5 Jan 2022 08:26:04 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     helgaas@kernel.org, francisco.munoz.ruiz@linux.intel.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, dan.j.williams@intel.com,
        nirmal.patel@linux.intel.com,
        Karthik L Gopalakrishnan <karthik.l.gopalakrishnan@intel.com>,
        jonathan.derrick@linux.dev
Subject: Re: [PATCH V2] PCI: vmd: Add DID 8086:A77F for all Intel Raptor Lake SKU's
Date:   Wed,  5 Jan 2022 16:25:52 +0000
Message-Id: <164139992200.22541.3683009307717549521.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211217231211.46018-1-francisco.munoz.ruiz@linux.intel.com>
References: <20211129195302.GA2686292@bhelgaas> <20211217231211.46018-1-francisco.munoz.ruiz@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 17 Dec 2021 15:12:11 -0800, francisco.munoz.ruiz@linux.intel.com wrote:
> From: Karthik L Gopalakrishnan <karthik.l.gopalakrishnan@intel.com>
> 
> Add support for this VMD device which supports the bus restriction mode.
> The feature that turns off vector 0 for MSI-X remapping is also enabled.
> 
> 

Applied to pci/vmd, thanks!

[1/1] PCI: vmd: Add DID 8086:A77F for all Intel Raptor Lake SKU's
      https://git.kernel.org/lpieralisi/pci/c/922bfd001d

Thanks,
Lorenzo
