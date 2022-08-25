Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00F15A1CEA
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 01:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbiHYXB1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 19:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237680AbiHYXB0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 19:01:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34D02F38D;
        Thu, 25 Aug 2022 16:01:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75222B82ED6;
        Thu, 25 Aug 2022 23:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CF3C433D7;
        Thu, 25 Aug 2022 23:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661468483;
        bh=N9/OkBdSri03Qzc+4rkRzs+yO6Yj2dmrnrsBxRJtJkA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ah2YD2HhZ1OrzztkUliUk/p7ynvLyqyqpmGJkdpkIZ6PmjppuJJLmDEqVokgvdrQn
         PKBGzBB/H7cLvFxLwO194fgJzJnOo7/6+Tt1Bh0KlTOw/426psUnV7QEa+0EKOlx9g
         dQT4q8GFyssoZGz2rcgSN0oiMADrQw97RNllV02FEq4EcLseQbpBeUL6D7O2i/FClZ
         E0ULcJoHPd1p9XDzrDSD+vgKpNphoOvHgpOUUSdiN6OBKGtxSmcGutjjFR17iJ+MKR
         q7EerHOBxF2IqY1ArbP2R1/2oscYC1kB7H9llbo/c5wnlCOGuY5blKUqQ/+nPD1LQB
         9CEhCMT80SinA==
Date:   Thu, 25 Aug 2022 18:01:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, Lukasz Majczak <lma@semihalf.com>,
        Rajat Jain <rajatja@google.com>,
        Ben Chuang <benchuanggli@gmail.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, refactormyself@gmail.com, kw@linux.com,
        kenny@panix.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Message-ID: <20220825230121.GA2879965@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p7WWxyvvB54ADkFSZE1oJweaoNK25g6YNcNxCqkeWiVKg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 23, 2022 at 10:55:01PM +0800, Kai-Heng Feng wrote:
> On Tue, Aug 9, 2022 at 12:17 AM Vidya Sagar <vidyas@nvidia.com> wrote:
> >
> > Thanks Lukasz for the update.
> > I think confirms that there is no issue with the patch as such.
> > Bjorn, could you please define the next step for this patch?
> 
> I think the L1SS cap went away _after_ L1SS registers are restored,
> since your patch already check the cap before doing any write:
> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +       if (!aspm_l1ss)
> +               return;
> 
> That means it's more likely to be caused by the following change:
> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
> 
> So is it possible to clear PCI_L1SS_CTL1 before setting PCI_L1SS_CTL2,
> like what aspm_calc_l1ss_info() does?

Sorry, I've totally lost track of where we are with this.  I guess the
object is to save/restore L1SS state.

And there are two problems that aren't understood yet?

  1) Lukasz's 01:00.0 wifi device didn't work immediately after
  resume, but seemed to be hot-added later? [1]

  2) The 00:14.0 Root Port L1SS capability was present before
  suspend/resume but not after? [2,3]

I thought Lukasz's latest emails [4,5] indicated that problem 1) still
happened and presumably only happens with Vidya's patch, and 2) also
still happens, but happens even *without* Vidya's patch.  Do I have
that right?

If adding the patch causes 1), obviously we would need to fix that.
It would certainly be good to understand 2) as well, but I guess if
that's a pre-existing problem, ...

Bjorn

[1] https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3#file-dmesg-L1762
[2] https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3#file-lspci-before-suspend-log-L136
[3] https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3#file-lspci-after-suspend-log-L136
[4] https://lore.kernel.org/r/CAFJ_xbr5NjoV1jC3P93N4UgooUuNdCRnrX7HuK=xLtPM5y7EjA@mail.gmail.com
[5] https://lore.kernel.org/r/CAFJ_xboyQyEaDeQ+pZH_YqN52-ALGNqzmmzeyNt6X_Cz-c1w9Q@mail.gmail.com
