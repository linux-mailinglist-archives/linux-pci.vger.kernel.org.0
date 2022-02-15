Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDD44B73C8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 17:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiBOQjm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 11:39:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbiBOQjl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 11:39:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663D0F1EBF
        for <linux-pci@vger.kernel.org>; Tue, 15 Feb 2022 08:39:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AD5BB81B81
        for <linux-pci@vger.kernel.org>; Tue, 15 Feb 2022 16:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505C6C340EB;
        Tue, 15 Feb 2022 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644943168;
        bh=uDxtLw82/Lqy3SuvmfZY4xv40CLYpmGdO0lStxoyPNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K3qU48MqS5bfyFeqdD5rCNP4MGZ1k1fYdicbZONquBSHTEMq65cLA2QejjODAYwEv
         vOF0ttrsVvkdcKKq3GKhO0SEdURrkhDMdNQ9Y50oCMob8QMu5WVG9eQw5cqabrN+tv
         yt2rYyzDQqgtnW8kqtDkGDgtrI48gMe0wzK6gNlB6i8teZLyHOfy/8JGM1MtIRSGXb
         F6qLfsbR9jSJEywI3AQWw1Bm1wvUtdvXpBuWOg04wbuutMHuQhCnYfqoJQG3ZsTea5
         4aQg2tgSzTV326XDt+3M4YbzfdOFtu2hgwSmBgUFFyLv1HXr7rv9kdZ++qRe4tojL0
         SGQ4TbHuQr5lw==
Date:   Tue, 15 Feb 2022 10:39:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Rahul Kumar <rahul.kumar1@amd.com>, Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [Bug 215590] New: PCI link is down after suspend after we try to
 plug device
Message-ID: <20220215163925.GA116437@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-215590-41252@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 11, 2022 at 02:29:33PM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=215590
> 
>            Summary: PCI link is down after suspend after we try to plug
>                     device
>     Kernel Version: 5.4 and 5.11
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>           Severity: high
>           Priority: P1
>         Regression: No
> 
> Created attachment 300434
>   --> https://bugzilla.kernel.org/attachment.cgi?id=300434&action=edit
> dmesg log
> 
> PCI link is not coming up
> 
> we have been facing a race condition between AER and hoptplug stack which is
> happening after suspend when device is unplugged, to avoid that  we have used
> below three patches.
> 
> 1 - To Avoid lockdep
> 
> https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas@wunner.de/
> 
> 2 - AER sleep transition patch 
> https://lore.kernel.org/linux-pci/20220127025418.1989642-1-kai.heng.feng@canonical.com/
> 
> 3 - DPC sleep transition patch
> https://lore.kernel.org/linux-pci/20220127025418.1989642-2-kai.heng.feng@canonical.com/
> 
> 
> Additional info when we are using unplug using sysfs we dont see the issue
