Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFC54A8EFC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 21:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiBCUmC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 15:42:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40182 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354976AbiBCUii (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 15:38:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B4EBB83556;
        Thu,  3 Feb 2022 20:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A26C340E8;
        Thu,  3 Feb 2022 20:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643920716;
        bh=KqcRBHHZvoZzX9kbACzClvmZ6/tlvG8DciwPkL4BxwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KM4Xmum1FCnpD4sw+PrpUF+HZMlMh6m/nUxGUmj9x0BzQ48I4YhbWcKSGU99z03fR
         f41gwPWIbjCScpGJsluIHmNjI6PyOQJWSFejosCCiFbcw0cNhG4tqwtuqXXHenx1pJ
         v7+SmoqKOQNxY1LTeue3GnhG8ZJxRwiTv6zbjS1kEr2gyRPOks9MKSN8SGpTdiw+R7
         KSVllhlGGG1voFY02n26yg0tdsfToVFfMgffUlyCABOMIa0TXbKbCXZPYK6Co8gCni
         YFM7ulAMkTJXZXWYcTmX8kGlmfg99DmXaP+nC3jS5nFgNf+kYYFOyQxEXlmLPQNvxO
         0n5U3otQcouIw==
Date:   Thu, 3 Feb 2022 14:38:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Liguang Zhang <zhangliguang@linux.alibaba.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: clear cmd_busy bit when Command Completed
 in polling mode
Message-ID: <20220203203833.GA113163@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203190731.GA24120@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 03, 2022 at 08:07:31PM +0100, Lukas Wunner wrote:
> Hi Bjorn,
> 
> the below patch is marked "Changes Requested" in patchwork:
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20211111054258.7309-1-zhangliguang@linux.alibaba.com/
> 
> I think that might be erroneous because the patch is correct,
> I've provided a Reviewed-by and no change requests are recorded
> in patchwork or the mailing list archive.
> 
> If you've got a few minutes to spare, could you double-check the
> state in patchwork and provide Liguang Zhang with the changes you'd
> want (if any)?

Thanks for reminding me about this.  I don't remember why I marked it
"changes requested" but I often do that if there's been significant
discussion.  In this case you also provided additional information
(Fixes tag, bugzilla link, commit log elaboration) that should be
included.  Given that, I would typically wait for the author to repost
it and incorporate the additional information.

But I applied it to pci/hotplug with the commit log below.

commit 92912b175178 ("PCI: pciehp: Clear cmd_busy bit in polling mode")
Author: Liguang Zhang <zhangliguang@linux.alibaba.com>
Date:   Thu Nov 11 13:42:58 2021 +0800

    PCI: pciehp: Clear cmd_busy bit in polling mode
    
    Writes to a Downstream Port's Slot Control register are PCIe hotplug
    "commands."  If the Port supports Command Completed events, software must
    wait for a command to complete before writing to Slot Control again.
    
    pcie_do_write_cmd() sets ctrl->cmd_busy when it writes to Slot Control.  If
    software notification is enabled, i.e., PCI_EXP_SLTCTL_HPIE and
    PCI_EXP_SLTCTL_CCIE are set, ctrl->cmd_busy is cleared by pciehp_isr().
    
    But when software notification is disabled, as it is when pcie_init()
    powers off an empty slot, pcie_wait_cmd() uses pcie_poll_cmd() to poll for
    command completion, and it neglects to clear ctrl->cmd_busy, which leads to
    spurious timeouts:
    
      pcieport 0000:00:03.0: pciehp: Timeout on hotplug command 0x01c0 (issued 2264 msec ago)
      pcieport 0000:00:03.0: pciehp: Timeout on hotplug command 0x05c0 (issued 2288 msec ago)
    
    Clear ctrl->cmd_busy in pcie_poll_cmd() when it detects a Command Completed
    event (PCI_EXP_SLTSTA_CC).
    
    [bhelgaas: commit log]
    Fixes: a5dd4b4b0570 ("PCI: pciehp: Wait for hotplug command completion where necessary")
    Link: https://lore.kernel.org/r/20211111054258.7309-1-zhangliguang@linux.alibaba.com
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=215143
    Link: https://lore.kernel.org/r/20211126173309.GA12255@wunner.de
    Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Lukas Wunner <lukas@wunner.de>
    Cc: stable@vger.kernel.org	# v4.19+
