Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF8D501975
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 19:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbiDNREV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 13:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbiDNREN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 13:04:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23B9B7C54;
        Thu, 14 Apr 2022 09:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D6146206E;
        Thu, 14 Apr 2022 16:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62838C385A5;
        Thu, 14 Apr 2022 16:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649954496;
        bh=49nKOguN6hmCIr/dOmsf3k+fvl1CA8AutZRRIS585d4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Czsmm49U9rxGSLWubSu56gUZaJRqNUtxT0Ug5fBcjxAEZGMFImZakI+nJkNReePgE
         Ppsjni6QGjOOe4lCjfvdhh49+vC7qIwmgOJh4VKuWncMuXm4xeLvXlmnqYUn80Zk+s
         Qc1PwQhDkPNg1mNuIYs1tCRJrtqgLmxXLEOoVyedjY28EAy/Dx6HrQ+lpLbvnGV86K
         yj9aazcnHEiVvaDOfydO7dj7O5KAMbmjQL7HsI5rLyOxj7gBjrf3PLV6/qCm19BwbP
         U8SccJMN6xIS3mCx3zBjhroJW249unzy8LAyJU98DfixhBGCRijac25ndzI3FNde/6
         q+cpGf2JLA3fA==
Date:   Thu, 14 Apr 2022 11:41:34 -0500
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
Message-ID: <20220414164134.GA751756@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p4r1v_sN=8kv_fOx_VEb3k=4rU9iw52LfmEHO1crnms=g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 13, 2022 at 08:19:26AM +0800, Kai-Heng Feng wrote:
> On Wed, Apr 13, 2022 at 6:50 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > ...

> >   - For L1 PM Substates configuration, sec 5.5.4 says that both ports
> >     must be configured while ASPM L1 is disabled, but I don't think we
> >     currently guarantee this: we restore all the upstream component
> >     state first, and we don't know the ASPM state of the downstream
> >     one.  Maybe we need to:
> >
> >       * When restoring upstream component,
> >           + disable its ASPM
> >
> >       * When restoring downstream component,
> >           + disable its ASPM
> >           + restore upstream component's LTR, L1SS
> >           + restore downstream component's LTR, L1SS
> >           + restore upstream component's ASPM
> >           + restore downstream component's ASPM
> 
> Right now L1SS isn't reprogrammed after S3, and that causes WD NVMe
> starts to spew lots of AER errors.

Right now we don't fully restore L1SS-related state after S3, so maybe
there's some inconsistency that leads to the AER errors.

Could you collect the "lspci -vv" state before and after S3 so we can
compare them?

> So yes please restore L1SS upon resume. Meanwhile I am asking vendor
> _why_ restoring L1SS is crucial for it to work.
> 
> I also wonder what's the purpose of pcie_aspm_pm_state_change()? Can't
> we just restore ASPM bits like other configs?

Good question.  What's the context?  This is in the
pci_raw_set_power_state() path, not the pci_restore_state() path, so
seems like a separate discussion.

Bjorn
