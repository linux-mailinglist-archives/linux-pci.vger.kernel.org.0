Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CDA464D6A
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 13:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349127AbhLAMFK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 07:05:10 -0500
Received: from foss.arm.com ([217.140.110.172]:35132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349131AbhLAMFI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 07:05:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 212211477;
        Wed,  1 Dec 2021 04:01:47 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.32.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AD393F694;
        Wed,  1 Dec 2021 04:01:45 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org, jonathan.derrick@linux.dev
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5] PCI: vmd: Clean up domain before enumeration
Date:   Wed,  1 Dec 2021 12:01:37 +0000
Message-Id: <163836006898.17393.2740182735742705964.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211116221136.85134-1-nirmal.patel@linux.intel.com>
References: <20211116221136.85134-1-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 16 Nov 2021 15:11:36 -0700, Nirmal Patel wrote:
> During VT-d pass-through, the VMD driver occasionally fails to
> enumerate underlying NVMe devices when repetitive reboots are
> performed in the guest OS. The issue can be resolved by resetting
> VMD root ports for proper enumeration and triggering secondary bus
> reset which will also propagate reset through downstream bridges.
> 
> 
> [...]

Applied to pci/vmd, thanks!

[1/1] PCI: vmd: Clean up domain before enumeration
      https://git.kernel.org/lpieralisi/pci/c/6aab562229

Thanks,
Lorenzo
