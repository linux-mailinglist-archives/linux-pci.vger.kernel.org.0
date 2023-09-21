Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF47C7AA04A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 22:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjIUUfz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 21 Sep 2023 16:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjIUUew (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 16:34:52 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AF473547;
        Thu, 21 Sep 2023 10:33:03 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59be81cf0d8so2356287b3.0;
        Thu, 21 Sep 2023 10:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317439; x=1695922239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4u4Ae4qmn0j8vaZq8VmeR6efjSH5qgFemSVQPrsJHw=;
        b=IeSZRoz0xYezONjfazpVXRNfgFOYVTLPNTLaRcSeMX/ChQiXY9rIR+q8jiG9UwewH3
         urqstrUwTjnJJKLN58Ek6jzfbnEDLzTqDv4K5/DjmGQCdr+tFQvzbkDm6Xj0oaKuQpVo
         P1gvp4jKK2Gtjx3F4COC6HMj/nHbxqWbQolYDkNQxrGrXqjNQ+uBa5GTjnWvFAnSGxgR
         o04VYvGFj29h8LKfVRIliHwxjRodCr75sOEn5GgXMqTBFuc5AfoEENLuCfCs5jfmCPxI
         vBAUhYEAu+WupKjrc8FRDAUnne6Gi4xO82pGXroFReESVshDgnnMvtgRpOKBuXQe3xTs
         YUKA==
X-Gm-Message-State: AOJu0YwOe6Zxht7KScDLO8EQKvne7TK9InHfxquIheCSxnN2zRQk5HaU
        1z/CsGW9+AVR7m8/R1UutP9BkAe01+w1z9HVNooEMNlL
X-Google-Smtp-Source: AGHT+IFqOKRaoSGisF4HxZ5+8mAFkH7uuxt1CiZ2fWObTP62x0ne77EscHn7VM8hUS0SM0xgt3WWxah+cm9vG27xjLg=
X-Received: by 2002:a4a:2a4e:0:b0:573:3a3b:594b with SMTP id
 x14-20020a4a2a4e000000b005733a3b594bmr4666981oox.1.1695288795434; Thu, 21 Sep
 2023 02:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230914041806.816741-1-kai.heng.feng@canonical.com>
 <7b45ac2ed091497b4e21a6a5c19956161175ba16.camel@linux.intel.com>
 <SN6PR11MB26245C44E84C37C1B551260EF4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
 <CAAd53p5ywMVKWzhn0nYzvBnW_Bc=sntgBttJdcVUuf_a4AnX5w@mail.gmail.com>
 <SN6PR11MB262473E2BF4057F4D285A613F4F6A@SN6PR11MB2624.namprd11.prod.outlook.com>
 <DM6PR11MB26184A8A3F955589F5FC6836F4FBA@DM6PR11MB2618.namprd11.prod.outlook.com>
 <CAAd53p4o1pB-yzpvUCYsvuYEvQQK0my=u-ogrByRCx_Lvns=hw@mail.gmail.com>
 <bbbf36724d63f7532696a960a9d56d7ccd5a5bee.camel@linux.intel.com>
 <CAAd53p6MA9YLbcXxpC8=YEtbO6frFJk1LQ1BNUgPk=r1_uR8iw@mail.gmail.com>
 <67c85f083201ed2cda2cab198b40141ad21912a2.camel@linux.intel.com>
 <CAJZ5v0iFLxpWHW=sDZ7=Wne3Yt=8_EwhW9SeCmRP6REpVqo8rA@mail.gmail.com> <CAAd53p67tiP0xXwhn=NviU_rvrSveSxbAhDieYG9AmUWF2e__Q@mail.gmail.com>
In-Reply-To: <CAAd53p67tiP0xXwhn=NviU_rvrSveSxbAhDieYG9AmUWF2e__Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Sep 2023 11:33:02 +0200
Message-ID: <CAJZ5v0hzLNeDyFE=NTAAf1Uwj_kLxP_424T3riO2GG0LUmzpNw@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Xu, Even" <even.xu@intel.com>,
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
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 21, 2023 at 8:08 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Wed, Sep 20, 2023 at 2:00 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Sep 19, 2023 at 6:54 PM srinivas pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > On Tue, 2023-09-19 at 15:36 +0800, Kai-Heng Feng wrote:
> > > > On Mon, Sep 18, 2023 at 11:57 PM srinivas pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > >
> > > > > Hi Kai-Heng,
> > > > > On Mon, 2023-09-18 at 09:17 +0800, Kai-Heng Feng wrote:
> > > > > > Hi Even,
> > > > > >
> > > > > > On Mon, Sep 18, 2023 at 8:33 AM Xu, Even <even.xu@intel.com>
> > > > > > wrote:
> > > > > > >
> > > > > > > Hi, Kai-Heng,
> > > > > > >
> > > > > > > I just got feedback, for testing EHL S5 wakeup feature, you
> > > > > > > need
> > > > > > > several steps to setup and access
> > > > > > > "https://portal.devicewise.com/things/browse" to trigger wake.
> > > > > > > But currently, our test account of this website are all out of
> > > > > > > data.
> > > > > > > So maybe you need double check with the team who required you
> > > > > > > preparing the patch for the verification.
> > > > > >
> > > > > > The patch is to solve the GPE refcount overflow, while
> > > > > > maintaining S5
> > > > > > wakeup. I don't have any mean to test S5 wake.
> > > > > >
> > > > > The issue is not calling acpi_disable_gpe(). To reduce the scope of
> > > > > change can we just add that instead of a adding new callbacks. This
> > > > > way
> > > > > scope is reduced.
> > > >
> > > > This patch does exactly the same thing by letting PCI and ACPI handle
> > > > the PME and GPE.
> > > > Though the change seems to be bigger, it actually reduces the duped
> > > > code, while keep the S5 wakeup ability intact.
> > > It may be doing the same. But with long chain of calls without
> > > verification, I am not comfortable.
> > > This can be another patch by itself to use the framework.
> >
> > I agree.
> >
> > Let's change one thing at a time.
> >
> > > But you are targeting a fix for overflow issue, which is separate from
> > > the use of PCI/ACPI framework.
> >
> > Yes, let's fix the bug first and make things look nicer separately.
>
> Right, please use the fix from Srinivas and I'll send a separate patch
> to make things looks better.

OK

Srinivas, please resend the patch with a changelog etc.
