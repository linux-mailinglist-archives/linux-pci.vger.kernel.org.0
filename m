Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7E94FF794
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 15:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiDMN3M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 09:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiDMN3M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 09:29:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628105D649;
        Wed, 13 Apr 2022 06:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AADF6196E;
        Wed, 13 Apr 2022 13:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84157C385A6;
        Wed, 13 Apr 2022 13:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649856406;
        bh=huzeaPBM4joEiWG34xFTjGMlaFsI6Qi5QXhXd+tYt4E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eUO8ZZFD4VMw0xm2d7KhfkyWSTpIogel1xK2LFNPpTcqQWUBWSZkU7E0qTMEeRa6+
         FDDeQtz5+8zg/a/uw37loUdLe8t2IP2upCrtDlGWC4DTwju3Gb0iifml08wHvPAslW
         1mIPepdi+GgU+I1VfbkIkAZmLbqDhyoBgziZuySU/Cjm3vcFylh/0MOOVgqzT1jB/3
         ae+jdYAOk4f/UqwmrapIM9rPHk/ibtO+ExhhJl9aSIwvqLbpLxSBB74y4KZH/fyw/0
         lxhDlyiaXZV55Ya2xuF2X0fyimMZB2OurpDqbqgoLJOkk4Wnn7YAsgz6l9XFTEFDxW
         2XIT8wqG2Q8pw==
Date:   Wed, 13 Apr 2022 08:26:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     "Kenneth R. Crudup" <kenny@panix.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        kai.heng.feng@canonical.com, chris.packham@alliedtelesis.co.nz,
        yangyicong@hisilicon.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Ricky Wu <ricky_wu@realtek.com>,
        Rajat Jain <rajatja@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Victor Ding <victording@google.com>
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Message-ID: <20220413132644.GA673431@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412225047.GA627910@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 12, 2022 at 05:50:47PM -0500, Bjorn Helgaas wrote:
> ...
> I think we should try this patch again with some changes and maybe
> some debug logging:
> 
>   - I wonder if we should integrate the LTR, L1 SS, and Link Control
>     ASPM restore instead of having them spread around through
>     pci_restore_ltr_state(), pci_restore_aspm_l1ss_state(), and
>     pci_restore_pcie_state().  Maybe a new pci_restore_aspm() that
>     would be called from pci_restore_pcie_state()?

Sorry, this was a dumb idea, please ignore it.  Maybe it would be
useful in the future sometime, but right now when we're trying to
understand the issue, the code churn would just confuse things.  I
think we need minimal changes right now (like 4257f7e008ea).

>   - For L1 PM Substates configuration, sec 5.5.4 says that both ports
>     must be configured while ASPM L1 is disabled, but I don't think we
>     currently guarantee this: we restore all the upstream component
>     state first, and we don't know the ASPM state of the downstream
>     one.  Maybe we need to:
> 
>       * When restoring upstream component,
>           + disable its ASPM
> 
>       * When restoring downstream component,
>           + disable its ASPM
> 	  + restore upstream component's LTR, L1SS
> 	  + restore downstream component's LTR, L1SS
> 	  + restore upstream component's ASPM
> 	  + restore downstream component's ASPM
> 
>       This seems pretty messy, but seems like what the spec requires.

Actually, I think it's unlikely that a downstream device would have
ASPM enabled while we're restoring state of the upstream device, since 
we're probably restoring state after a reset or coming back from
D3cold.  But we may still need to wait to enable the upstream device
ASPM until after configuring it in the downstream device.

Logging of the previous & new state of these registers might help
untangle things.

>     - Add some pci_dbg() logging of all these save/restore values to
>       help debug any issues.
