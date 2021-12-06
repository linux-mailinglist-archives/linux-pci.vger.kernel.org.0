Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3034469349
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 11:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbhLFKWc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 05:22:32 -0500
Received: from foss.arm.com ([217.140.110.172]:53080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhLFKWb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Dec 2021 05:22:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1EE411FB;
        Mon,  6 Dec 2021 02:19:02 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.33.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A50FD3F73D;
        Mon,  6 Dec 2021 02:19:01 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: (subset) [PATCH pci-fixes 0/2] PCI Aardvark controller fixes
Date:   Mon,  6 Dec 2021 10:18:53 +0000
Message-Id: <163878591893.8738.99958773296643620.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211125160148.26029-1-kabel@kernel.org>
References: <20211125160148.26029-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 25 Nov 2021 17:01:46 +0100, Marek Behún wrote:
> here are two fixes for pci-aardvark controller.
> 
> Marek
> 
> Marek Behún (1):
>   Revert "PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated
>     bridge"
> 
> [...]

Applied to pci/aardvark, thanks!

[1/2] PCI: aardvark: Fix checking for MEM resource type
      https://git.kernel.org/lpieralisi/pci/c/2070b2ddea

Thanks,
Lorenzo
