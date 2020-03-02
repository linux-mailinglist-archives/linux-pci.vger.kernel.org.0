Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02E176865
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 00:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgCBXqH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 18:46:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgCBXqH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Mar 2020 18:46:07 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D80621556;
        Mon,  2 Mar 2020 23:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583192767;
        bh=hkF8rupYVWgItlqlmo6kmL4tHwE8HoFTsal6UnXbjKo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fZ801ys4m8VL4YQ8/te5CMPdpuY6g2+SphxKxFpWpwMSLv/z22M7diL/HfP0YAYxX
         I9aPpi5oQOL2CmuHBfQ0UeyxvmuxNzHPAEETL0AIyaX3WPRZagC+/OeBBR4sHmCayf
         ksPl85ivCvsYNRpvZK+8hkOFDbbLMkgMQPFxge6I=
Date:   Mon, 2 Mar 2020 17:46:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Jay Fang <f.fangjian@huawei.com>, huangdaode@huawei.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Improve link speed presentation process
Message-ID: <20200302234604.GA186686@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229030706.17835-1-helgaas@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 28, 2020 at 09:07:02PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Here's my proposal for merging this series.
> 
> The main difference from v4 is that this adds a pci_speed_string()
> interface instead of making the table public and uses that everywhere
> instead of PCI_SPEED2STR().
> 
> 
> v4: https://lore.kernel.org/r/1581937984-40353-1-git-send-email-yangyicong@hisilicon.com
> 
> Bjorn Helgaas (2):
>   PCI: Add pci_speed_string()
>   PCI: Use pci_speed_string() for all PCI/PCI-X/PCIe strings
> 
> Yicong Yang (2):
>   PCI: Add 32 GT/s decoding in some macros
>   PCI: Add PCIE_LNKCAP2_SLS2SPEED() macro
> 
>  drivers/pci/controller/pcie-brcmstb.c |  3 +--
>  drivers/pci/pci-sysfs.c               | 27 ++++---------------
>  drivers/pci/pci.c                     | 23 +++++-----------
>  drivers/pci/pci.h                     | 19 ++++++++------
>  drivers/pci/probe.c                   | 38 +++++++++++++++++++++++++++
>  drivers/pci/slot.c                    | 38 +--------------------------
>  include/linux/pci.h                   |  2 +-
>  7 files changed, 64 insertions(+), 86 deletions(-)

Applied to pci/enumeration for v5.7.
