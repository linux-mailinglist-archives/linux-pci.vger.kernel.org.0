Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D557750AA7A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 23:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiDUVOA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 17:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiDUVN7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 17:13:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9A148E74;
        Thu, 21 Apr 2022 14:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01930B82939;
        Thu, 21 Apr 2022 21:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7194CC385A7;
        Thu, 21 Apr 2022 21:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650575465;
        bh=Z/8IJwNR5HI9ZzJwsHxg/Nx1x76tQDZbLuZtg/Z3b3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H/IByQTNQn69lKp+psedf4aIechOeR0j915REYKGr86wvc57eSLTAW3rWcnsKiN7l
         pM2INXuN4N4L8l78M+00xNpNRsuYpxbdfCTYLxf0REFBET1QBNcGuky6YcpUeABQtI
         3LoM5/4Bgqhc5bVK7BpsJQehCMuFsKDtrTLrrrmfTmMTov4Mx8hvTgZIVyweXqaVUR
         juwtmhYNGgFDQG63Mc1Y6CvCSyHh+fodKj56aAEdas9m3mlgqavBYnnkFxU6QrJtjS
         e9L1Xfl1Yr9KdsJS4TqcsX7xMLUMf62hM+uiHpncEtn+QfsM76lVd1vNm/vhXF3vDY
         Zq+58zDgQFVDw==
Date:   Thu, 21 Apr 2022 16:11:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
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
        Victor Ding <victording@google.com>
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Message-ID: <20220421211103.GA1426981@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f9a28-e67-ec2a-f6-9a8b58edd84d@panix.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 21, 2022 at 01:40:02PM -0700, Kenneth R. Crudup wrote:
> On Thu, 21 Apr 2022, Kai-Heng Feng wrote:
> 
> > I went through the whole discussion again, maybe Kenneth's case is
> > also the result of pcie_aspm_pm_state_change()?
> 
> > Since Kenneth is using TLP to switch ASPM between performance and
> > powersaving/powersupersaving, that means 'aspm_disabled' is false.
> > Hence the KOXIA NVMe stops working post suspend and Realtek card
> > reader toggles L1ss post hibernation.
> 
> > Kenneth, can you please see if removing pcie_aspm_pm_state_change()
> > from pci_raw_set_power_state() helps?
> > Anyway, this can be easier to spot if dmesg was attached.
> 
> Well, I haven't had an issue with resume/return from hibernate for quite some
> time, and the patch I'd reported a long time ago is now in the Linus' master
> I've been running. I believe a BIOS change from Dell fixed it up for me.

Which patch are you referring to?

Vidya's original patch [1] is not upstream, at least AFAIK.  Well, it
*was* merged as 4257f7e008ea [2] in v5.11-rc1, but then reverted by
40fb68c7725a [3] in v5.11-rc7.

[1] https://lore.kernel.org/r/20220201123536.12962-1-vidyas@nvidia.com
[2] https://git.kernel.org/linus/4257f7e008ea
[3] https://git.kernel.org/linus/40fb68c7725a
