Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDCB50AA15
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 22:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392430AbiDUUj0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 16:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392435AbiDUUjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 16:39:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407F84DF6B;
        Thu, 21 Apr 2022 13:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52019B82915;
        Thu, 21 Apr 2022 20:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07B9C385AA;
        Thu, 21 Apr 2022 20:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650573391;
        bh=TotSHD6NiH+c/cQs+3AC5P1AE81U2W4GDZDFViL3gQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nGmyJ77Cqt/Q+5c39e+8bqydS7/XQ7dXYwE9S/28uX/Nk0rZ5inItdEFGnYn0CuAQ
         11ii8h7BKfOQAOABimpOfT80cwFpowkOPgqRsP//AliF6KOOJ8wjvb9q90M9Yz0CMg
         CLLRZEEJwQWXEuoMHPMufQvygvhYDehNu3wjN6JA1C9yzdUnV1IdCn9AGqqFQe7iwa
         H5/sL0LyK3wqYp38H0CANRIC7hPL1FyUT8/ysqGNbB+99ONJVfrIbNALzBz2UUA1RQ
         LX30I1CtpJ8UXr3uk1XhxIB34iv1V9vCS6TmDYSoY4NcRTWfa3kNWJekyYCTMuc/Nc
         /m3/c6WOA5d9g==
Date:   Thu, 21 Apr 2022 15:36:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        "Kenneth R. Crudup" <kenny@panix.com>, bhelgaas@google.com,
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
Message-ID: <20220421203629.GA1424868@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p6jh7Jx3pzg9TzrSrW8+3pzLN6EBAFjFv+7T4tMODmX+g@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 21, 2022 at 02:16:29PM +0800, Kai-Heng Feng wrote:
> On Sat, Apr 16, 2022 at 5:25 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Apr 15, 2022 at 10:26:19PM +0800, Kai-Heng Feng wrote:
> > ...

> > > So I forced the pcie_aspm_pm_state_change() calling path to eventually
> > > call aspm_calc_l1ss_info() which solved the problem for me.
> >
> > This would update T_PwrOn and LTR1.2_Threshold, so I guess it makes
> > sense that this would help.  But I think we need to figure out the
> > reason why pcie_aspm_pm_state_change() exists and get rid of it or at
> > least better integrate it with pci_restore_state().
> >
> > If we call pcie_aspm_pm_state_change() after D3cold or reset, things
> > still aren't going to work because the LTR cap isn't restored or
> > programmed.
> 
> More than that, the ASPM sysfs won't be restored correctly after
> resume [1] because of it.
> So I'd like to post a patch to drop pcie_aspm_pm_state_change() if
> there's no objection.

Please do :)  Obviously somebody thought we needed
pcie_aspm_pm_state_change() for some reason or it wouldn't have been
added.  But I didn't figure out since it was included in the very
first ASPM support: 6c723d5bd89f ("PCI: PCIE ASPM support").

Maybe the comment that "devices changed PM state, we should recheck if
latency meets all functions' requirement" is a clue but I haven't
followed up.

> [1] https://lore.kernel.org/linux-pci/20211021035159.1117456-2-kai.heng.feng@canonical.com/
> 
> Kai-Heng
