Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEC0466110
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 11:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhLBKEq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 05:04:46 -0500
Received: from foss.arm.com ([217.140.110.172]:60860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230089AbhLBKEj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Dec 2021 05:04:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0695142F;
        Thu,  2 Dec 2021 02:01:16 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.32.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19E2C3F7D7;
        Thu,  2 Dec 2021 02:01:15 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, pali@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 00/11] PCI: aardvark controller fixes BATCH 3
Date:   Thu,  2 Dec 2021 10:01:09 +0000
Message-Id: <163843918639.2166.8445948322592754351.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211130172913.9727-1-kabel@kernel.org>
References: <20211130172913.9727-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 30 Nov 2021 18:29:02 +0100, Marek Behún wrote:
> as you requested on IRC, I added more explanation to commit logs of the
> last 3 patches.
> 
> Changes since v3:
> - updated commit messages of patches 9, 10 and 11
> 
> Changes since v2:
> - updated the second patch, updated definitions of registers
>   PCI_EXP_DEVCAP2 and PCI_EXP_DEVCTL2
> 
> [...]

Applied to pci/aardvark, thanks!

[01/11] PCI: pci-bridge-emul: Add description for class_revision field
        https://git.kernel.org/lpieralisi/pci/c/9319230ac1
[02/11] PCI: pci-bridge-emul: Add definitions for missing capabilities registers
        https://git.kernel.org/lpieralisi/pci/c/8ea673a8b3
[03/11] PCI: aardvark: Add support for DEVCAP2, DEVCTL2, LNKCAP2 and LNKCTL2 registers on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/1d3e170344
[04/11] PCI: aardvark: Clear all MSIs at setup
        https://git.kernel.org/lpieralisi/pci/c/7d8dc1f7cd
[05/11] PCI: aardvark: Comment actions in driver remove method
        https://git.kernel.org/lpieralisi/pci/c/a4ca7948e1
[06/11] PCI: aardvark: Disable bus mastering when unbinding driver
        https://git.kernel.org/lpieralisi/pci/c/a46f2f6dd4
[07/11] PCI: aardvark: Mask all interrupts when unbinding driver
        https://git.kernel.org/lpieralisi/pci/c/13bcdf07cb
[08/11] PCI: aardvark: Fix memory leak in driver unbind
        https://git.kernel.org/lpieralisi/pci/c/2f040a17f5
[09/11] PCI: aardvark: Assert PERST# when unbinding driver
        https://git.kernel.org/lpieralisi/pci/c/1f54391be8
[10/11] PCI: aardvark: Disable link training when unbinding driver
        https://git.kernel.org/lpieralisi/pci/c/759dec2e3d
[11/11] PCI: aardvark: Disable common PHY when unbinding driver
        https://git.kernel.org/lpieralisi/pci/c/fdbbe242c1

Thanks,
Lorenzo
