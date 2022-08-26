Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6DA5A1F58
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 05:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244651AbiHZDNT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 23:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236722AbiHZDNS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 23:13:18 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D381D76746
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 20:13:16 -0700 (PDT)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7F40E3FF28
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 03:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661483595;
        bh=UWuPzi9cHt1QseAbEBNkjSeBAtIghoArUEkJhacB2Es=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=KimWWNjfiAAYNFDd8+efRg2uCQDtP2YnUyqq8d3UbkLR5g9uWl81tpduzqGk4hbPO
         4lqfaP+vQhzmWUcytj2GxbHOq8019gMwh2SDMN22BDLB8hJB605qxJ8V1RHi11Um7M
         k72VzshZsAkbtiw0OtwM2CnT9Xhiz1UI0bGHekskR+5Yq1YlK1KNJ7BnuC+GYP/Fs5
         x9BLq9WOLEGrk4PiqJeAxNHtFo/mCduwUrSUbif5gmx2rn7meQbEtvJKNU4WJR+tx5
         MOwE5dmZ9yokQ4G5l4Vpv/qbRbi6hstQxQEoq+BWBLaNDIeaw5c4qteNwt8g97CHVs
         IhGgakf2Z4cYg==
Received: by mail-ot1-f71.google.com with SMTP id h4-20020a056830034400b00638c37d1349so179501ote.10
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 20:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UWuPzi9cHt1QseAbEBNkjSeBAtIghoArUEkJhacB2Es=;
        b=7E9eG8zSe8YisMx3/S5CaG75mCFa9UYIXct1QgDoU+U3PKL0cNl8ngxgsBt+vKksra
         GLRm8g7GW79lJe4HHZj44wb/mTpwK3TOUdy5FPw6oAVi7XdZT4KOkRdrCRCkKHrZt/MJ
         l3OE6c3Eb2InruEplM1SuBbea2yvWCG79Cz4QEqXzqaGDQXuM5S9lqeF0QuxOSOgUAbn
         Ow9xulXzNIx56DjkJtkxmFz2tqSmVm2oslQVh5dwZywKOkjKL9iAvvIt7RARzBOwbC8H
         Z9/QDxokDiXhaETt5bFJa3ZgJ5SVaFu7CNahSphBmDe20GFHQ8uzcLen+mAueo1urCRu
         M3EQ==
X-Gm-Message-State: ACgBeo1kA1lKV6murlfZIa3UC8KdDWT8vvZFUhjxaqImml8xp/LN1aYN
        +uwnKQxU+IfwmVf23HLrluQyuOzWyKkbbGH9XjX9N2TZrx0LubcViwXLldkDPCjVnviS3uGsRLi
        STP3fZIzJZJZH3tUCeCbtdgw4RyT+kg0hJOWJk7eMB2sLQucBRDQkJQ==
X-Received: by 2002:a05:6808:209f:b0:344:8f50:1f29 with SMTP id s31-20020a056808209f00b003448f501f29mr764037oiw.42.1661483593539;
        Thu, 25 Aug 2022 20:13:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5c9YbTcAE+7VvnW8j5l8YwrY2ns+YbapGDGJIEUdlPYSpKB7QY7uzjfrpKKnzcU6j3ujba8CE9jvrYEBmvM7w=
X-Received: by 2002:a05:6808:209f:b0:344:8f50:1f29 with SMTP id
 s31-20020a056808209f00b003448f501f29mr764015oiw.42.1661483593249; Thu, 25 Aug
 2022 20:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p7WWxyvvB54ADkFSZE1oJweaoNK25g6YNcNxCqkeWiVKg@mail.gmail.com>
 <20220825230121.GA2879965@bhelgaas>
In-Reply-To: <20220825230121.GA2879965@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 26 Aug 2022 11:13:01 +0800
Message-ID: <CAAd53p5+WCKjSeWEV6ZCZixwow39Ot5GwpE6PUaumDH68t_4RA@mail.gmail.com>
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, Lukasz Majczak <lma@semihalf.com>,
        Rajat Jain <rajatja@google.com>,
        Ben Chuang <benchuanggli@gmail.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, refactormyself@gmail.com, kw@linux.com,
        kenny@panix.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 26, 2022 at 7:01 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Aug 23, 2022 at 10:55:01PM +0800, Kai-Heng Feng wrote:
> > On Tue, Aug 9, 2022 at 12:17 AM Vidya Sagar <vidyas@nvidia.com> wrote:
> > >
> > > Thanks Lukasz for the update.
> > > I think confirms that there is no issue with the patch as such.
> > > Bjorn, could you please define the next step for this patch?
> >
> > I think the L1SS cap went away _after_ L1SS registers are restored,
> > since your patch already check the cap before doing any write:
> > +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> > +       if (!aspm_l1ss)
> > +               return;
> >
> > That means it's more likely to be caused by the following change:
> > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
> >
> > So is it possible to clear PCI_L1SS_CTL1 before setting PCI_L1SS_CTL2,
> > like what aspm_calc_l1ss_info() does?
>
> Sorry, I've totally lost track of where we are with this.  I guess the
> object is to save/restore L1SS state.
>
> And there are two problems that aren't understood yet?
>
>   1) Lukasz's 01:00.0 wifi device didn't work immediately after
>   resume, but seemed to be hot-added later? [1]
>
>   2) The 00:14.0 Root Port L1SS capability was present before
>   suspend/resume but not after? [2,3]
>
> I thought Lukasz's latest emails [4,5] indicated that problem 1) still
> happened and presumably only happens with Vidya's patch, and 2) also
> still happens, but happens even *without* Vidya's patch.  Do I have
> that right?

Thanks, so root port already losing its L1SS cap before applying the patch.

>
> If adding the patch causes 1), obviously we would need to fix that.
> It would certainly be good to understand 2) as well, but I guess if
> that's a pre-existing problem, ...

I wonder if checking parent device's L1SS cap in
pci_restore_aspm_l1ss_state() a good workaround?

If this is indeed a firmware side issue, it explains why Kenneth's XPS
doesn't have this issue anymore after some BIOS updates.

Kai-Heng

>
> Bjorn
>
> [1] https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3#file-dmesg-L1762
> [2] https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3#file-lspci-before-suspend-log-L136
> [3] https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3#file-lspci-after-suspend-log-L136
> [4] https://lore.kernel.org/r/CAFJ_xbr5NjoV1jC3P93N4UgooUuNdCRnrX7HuK=xLtPM5y7EjA@mail.gmail.com
> [5] https://lore.kernel.org/r/CAFJ_xboyQyEaDeQ+pZH_YqN52-ALGNqzmmzeyNt6X_Cz-c1w9Q@mail.gmail.com
