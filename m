Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32E47A6A5C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 20:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjISSAT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 19 Sep 2023 14:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjISSAS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 14:00:18 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2A999;
        Tue, 19 Sep 2023 11:00:11 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57acd4917f6so228676eaf.1;
        Tue, 19 Sep 2023 11:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695146411; x=1695751211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGnhbq+R2EZAb/x6yu0RGRdXqfvoA34iDXx6GRhUp24=;
        b=YdmJAnR6aAuzzF7ni0X2/2vxilkJrGscxdwyyCEVwo3iXrGsSH3YmP+5AWERSanicb
         IN50UvEQYetcZMN/ew24PHGDN5roEHgg7GJL2d4cstV5I61OCNCB82CGJCCzSf7WD8lR
         AJKmU0uTCkVm25ne5+DXZ0E0+bqhauHnjqqrxMLNJLq7K1sGDCdPAsUxL6Dflh5XsCvl
         BP8aRXUMuB0DsMjNBgMYhdlwgUDlWeqWexYd0PIZh7aF3kvx3RMA9zSX7kK89utmIxQk
         io1clZ6NQk3PJmJy2wXMjX73IvrDWK4UuedH1RLzncURa5xE306GcDSRN5gpDr54Tj17
         VT9g==
X-Gm-Message-State: AOJu0YxskWkvBL98bxY8Bo4nIvN3+IX+1HeTvVUX8MrQiLo9vfd23Lo/
        j9w6VaBFLrVjN9DhTmBzTiQRny94oNbkLQFqp0Y=
X-Google-Smtp-Source: AGHT+IFMu+Ev1F4fMXIPDMXQslgr0uGqZG7w8cxROaroYaD5SopHBj6Rj8C8Kxj3VjEthq3euI44tC5lnqRRzM4n0ew=
X-Received: by 2002:a4a:d103:0:b0:573:4a72:6ec with SMTP id
 k3-20020a4ad103000000b005734a7206ecmr284831oor.1.1695146410955; Tue, 19 Sep
 2023 11:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230914041806.816741-1-kai.heng.feng@canonical.com>
 <7b45ac2ed091497b4e21a6a5c19956161175ba16.camel@linux.intel.com>
 <SN6PR11MB26245C44E84C37C1B551260EF4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
 <CAAd53p5ywMVKWzhn0nYzvBnW_Bc=sntgBttJdcVUuf_a4AnX5w@mail.gmail.com>
 <SN6PR11MB262473E2BF4057F4D285A613F4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
 <DM6PR11MB26184A8A3F955589F5FC6836F4FBA@DM6PR11MB2618.namprd11.prod.outlook.com>
 <CAAd53p4o1pB-yzpvUCYsvuYEvQQK0my=u-ogrByRCx_Lvns=hw@mail.gmail.com>
 <bbbf36724d63f7532696a960a9d56d7ccd5a5bee.camel@linux.intel.com>
 <CAAd53p6MA9YLbcXxpC8=YEtbO6frFJk1LQ1BNUgPk=r1_uR8iw@mail.gmail.com> <67c85f083201ed2cda2cab198b40141ad21912a2.camel@linux.intel.com>
In-Reply-To: <67c85f083201ed2cda2cab198b40141ad21912a2.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Sep 2023 19:59:59 +0200
Message-ID: <CAJZ5v0iFLxpWHW=sDZ7=Wne3Yt=8_EwhW9SeCmRP6REpVqo8rA@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Xu, Even" <even.xu@intel.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Lee, Jian Hui" <jianhui.lee@canonical.com>,
        "Zhang, Lixu" <lixu.zhang@intel.com>,
        "Ba, Najumon" <najumon.ba@intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 19, 2023 at 6:54 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2023-09-19 at 15:36 +0800, Kai-Heng Feng wrote:
> > On Mon, Sep 18, 2023 at 11:57 PM srinivas pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > Hi Kai-Heng,
> > > On Mon, 2023-09-18 at 09:17 +0800, Kai-Heng Feng wrote:
> > > > Hi Even,
> > > >
> > > > On Mon, Sep 18, 2023 at 8:33 AM Xu, Even <even.xu@intel.com>
> > > > wrote:
> > > > >
> > > > > Hi, Kai-Heng,
> > > > >
> > > > > I just got feedback, for testing EHL S5 wakeup feature, you
> > > > > need
> > > > > several steps to setup and access
> > > > > "https://portal.devicewise.com/things/browse" to trigger wake.
> > > > > But currently, our test account of this website are all out of
> > > > > data.
> > > > > So maybe you need double check with the team who required you
> > > > > preparing the patch for the verification.
> > > >
> > > > The patch is to solve the GPE refcount overflow, while
> > > > maintaining S5
> > > > wakeup. I don't have any mean to test S5 wake.
> > > >
> > > The issue is not calling acpi_disable_gpe(). To reduce the scope of
> > > change can we just add that instead of a adding new callbacks. This
> > > way
> > > scope is reduced.
> >
> > This patch does exactly the same thing by letting PCI and ACPI handle
> > the PME and GPE.
> > Though the change seems to be bigger, it actually reduces the duped
> > code, while keep the S5 wakeup ability intact.
> It may be doing the same. But with long chain of calls without
> verification, I am not comfortable.
> This can be another patch by itself to use the framework.

I agree.

Let's change one thing at a time.

> But you are targeting a fix for overflow issue, which is separate from
> the use of PCI/ACPI framework.

Yes, let's fix the bug first and make things look nicer separately.
