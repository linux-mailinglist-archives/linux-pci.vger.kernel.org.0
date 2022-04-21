Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05CD50AA6E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 23:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356103AbiDUVCz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 17:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244830AbiDUVCz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 17:02:55 -0400
X-Greylist: delayed 1184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Apr 2022 14:00:03 PDT
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782E76178;
        Thu, 21 Apr 2022 14:00:01 -0700 (PDT)
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4KkqDL0Jm5zDQD;
        Thu, 21 Apr 2022 16:40:18 -0400 (EDT)
Received: from [192.168.125.3] (ip98-164-213-246.oc.oc.cox.net [98.164.213.246])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4KkqD52yctz18CR;
        Thu, 21 Apr 2022 16:40:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1650573616; bh=3DLk127xG6VmBI2lKNf3p0IKGAxhZ0S9OZakATsgpqs=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=j7RQKhZN/XZTnUPLR9x7uHijW3ePTAXL2PVcl0tnQxrNO+5FexNvT+UJa3k3nTW5V
         nU00sTmYdbkH720jliREH/mq6ycYwHiXmS7o4+fyGZtnInVPkpjUIYDfPrP6iDHKdJ
         SqqP4nAgxKSCuqqbmTO1r6kNbGoGlkCu3QXoMgfs=
Date:   Thu, 21 Apr 2022 13:40:02 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        chris.packham@alliedtelesis.co.nz, yangyicong@hisilicon.com,
        treding@nvidia.com, jonathanh@nvidia.com, abhsahu@nvidia.com,
        sagupta@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Ricky Wu <ricky_wu@realtek.com>,
        Rajat Jain <rajatja@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Victor Ding <victording@google.com>,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
In-Reply-To: <CAAd53p6jh7Jx3pzg9TzrSrW8+3pzLN6EBAFjFv+7T4tMODmX+g@mail.gmail.com>
Message-ID: <42f9a28-e67-ec2a-f6-9a8b58edd84d@panix.com>
References: <CAAd53p6DX2C7KVRV=uu_mmPTTjE7=RsXfNPxjbOBLRbf-pXi5A@mail.gmail.com> <20220415212533.GA844147@bhelgaas> <CAAd53p6jh7Jx3pzg9TzrSrW8+3pzLN6EBAFjFv+7T4tMODmX+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Thu, 21 Apr 2022, Kai-Heng Feng wrote:

> I went through the whole discussion again, maybe Kenneth's case is
> also the result of pcie_aspm_pm_state_change()?

> Since Kenneth is using TLP to switch ASPM between performance and
> powersaving/powersupersaving, that means 'aspm_disabled' is false.
> Hence the KOXIA NVMe stops working post suspend and Realtek card
> reader toggles L1ss post hibernation.

> Kenneth, can you please see if removing pcie_aspm_pm_state_change()
> from pci_raw_set_power_state() helps?
> Anyway, this can be easier to spot if dmesg was attached.

Well, I haven't had an issue with resume/return from hibernate for quite some
time, and the patch I'd reported a long time ago is now in the Linus' master
I've been running. I believe a BIOS change from Dell fixed it up for me.

But if you're looking for information in any case, I could still do this and
get back to the topic re: the results.

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
