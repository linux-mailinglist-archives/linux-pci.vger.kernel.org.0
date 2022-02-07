Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDDB4AC8BB
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 19:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiBGSje (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 13:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiBGSig (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 13:38:36 -0500
X-Greylist: delayed 1078 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 10:38:35 PST
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370A6C0401D9;
        Mon,  7 Feb 2022 10:38:35 -0800 (PST)
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4JsvZt0n2zzDSP;
        Mon,  7 Feb 2022 13:20:38 -0500 (EST)
Received: from [192.168.8.112] (unknown [172.58.175.115])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4JsvZn4ZQmzxgQ;
        Mon,  7 Feb 2022 13:20:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1644258036; bh=AweUI9+98BU3L9qNDLySuxNanB+460xiJXBRJN+1gT0=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=e6E4jOsvpnkSO2iEjQFuauRoWTIKpvbyBeKqdpK3sCWwxMLrGzBr5I+DznPgHcSH/
         F8jUQhGybLW99RtGkXvyqc1wL3QBUVVvL6l1hIP09An9oYIsYtxkGcigx01wUSreWf
         +SFa4ucDUb7Atts9SbQkLM0MbE833Wv7iaS3bDlM=
Date:   Mon, 7 Feb 2022 10:20:32 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        kai.heng.feng@canonical.com, chris.packham@alliedtelesis.co.nz,
        yangyicong@hisilicon.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
In-Reply-To: <20220207163332.GA397884@bhelgaas>
Message-ID: <79a41832-12e2-2ed-f3af-da3bac90d941@panix.com>
References: <20220207163332.GA397884@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Mon, 7 Feb 2022, Bjorn Helgaas wrote:

> I think it's more likely that something changed in BIOS settings or
> other configuration, which means other people may trip over it even if
> you don't see it.  Do you remember any BIOS updates, BIOS setup
> tweaks, hardware changes, kernel parameter changes, etc?

I thought about that Saturday morning, and yeah, it's been over a year, and
Dell has released at least two BIOS updates since then.

> If the problem really was fixed by some change elsewhere, it *should*
> still happen on v5.11-rc1.  I think we should verify that and try to
> figure out what the other change was.

Yeah, not a bad idea. I'm a little busy now, but I'll cut a kernel at
4257f7e0, remake, and see what happens. Gimme a day or so.

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
