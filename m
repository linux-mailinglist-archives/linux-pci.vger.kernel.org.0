Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267187A9CF5
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 21:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjIUT1Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 15:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjIUT1W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 15:27:22 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD7898A6C
        for <linux-pci@vger.kernel.org>; Thu, 21 Sep 2023 10:56:52 -0700 (PDT)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9EFF73F688
        for <linux-pci@vger.kernel.org>; Thu, 21 Sep 2023 06:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695276528;
        bh=LGLvEUCLByX56ZHTlqmLlwmZ6pTbCna8gvztcJYDoU8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=rauudwVUP8l7s8SwO4VSe69N7gnmCVEH1jsNY1fFoKehhXjOrLiPmAoeqI7widzy7
         ZUxhg4oe+oHsZfKmL/AMw6mjza/a7C4z12xb4eiJ+dfy2KR5I2nipRDHlvAGbxCnWh
         canQ+lz3VdI78sZMi0Yr86AqHTZJxAVIREWSg5gLp6dut/4Ne+d7F4W7G8Xtw5M+jq
         IC6PBAWXzjBkgllANmR9e7E1ru5kZ0cJkRwgmeuSWpu/kP7PIlyLwPRCCZdh7Pb3Bs
         Y3VCQo9nYSaSkQcZC2VDeulP1/JUSxlpXKP4s509rTW/mPkfmwJ0hUIp87GeLa6yEs
         sEkFWaQd34ztQ==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-27472e97c0bso384303a91.3
        for <linux-pci@vger.kernel.org>; Wed, 20 Sep 2023 23:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695276527; x=1695881327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGLvEUCLByX56ZHTlqmLlwmZ6pTbCna8gvztcJYDoU8=;
        b=Sw5/smui6JqIPu7VZX1WK2FG99SYC024INCzqDo9OzV8bsxW9k7aLCVBOfTYMg8ori
         EbhDQJ/cf7frP3hQ/NoGrsuQDwk1l+CDCLe7eje7VcY0RaIk4+sDscVzIqPj1q0lwpQ6
         m+iFzWkq9qmiPFoMjNLUhlehDGvVPE0/s4wR2oytRrP5xGrsYdlOZhZZ89y7xPKFETxk
         IwD7Jj3Bs1+6KPN9O4oRlVAWQ+xnLOsDO6NzF5IA483unRx1oAQ56GHGxgv6Y/EuXBK8
         XFPJTOQ19L4xEe8BdwX06Zxq6sKmmAoh3Lkft9evQyq4wGfQ4cmS3mqUlo896CeZ8hoZ
         MCHw==
X-Gm-Message-State: AOJu0YzdPzNyxGDQDqR9gAHsKzUNwYui1F7DwTegJqgx0RB7F0I2OHaW
        wJtBKTBwvFUGfQGuByHVwrEih9KHxCMor/mIXWes7YWQObPgyyJrFEypwS2cNQEodypKRhBjJoP
        XCRP1I710DT/GjF7LHF3qKgeS7rEOamNge3xB2AHrE5evDjmVah4O8w==
X-Received: by 2002:a17:90b:60f:b0:271:9237:a07f with SMTP id gb15-20020a17090b060f00b002719237a07fmr4869854pjb.32.1695276527090;
        Wed, 20 Sep 2023 23:08:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3mcQsaQ+FE/ji4v4nyF6aUsilUttOw7YcXgkdZG82nw6jvzjNPhHOMNN3PnauJxNw7lKirmfAfZZ+zIWZCFI=
X-Received: by 2002:a17:90b:60f:b0:271:9237:a07f with SMTP id
 gb15-20020a17090b060f00b002719237a07fmr4869844pjb.32.1695276526779; Wed, 20
 Sep 2023 23:08:46 -0700 (PDT)
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
 <67c85f083201ed2cda2cab198b40141ad21912a2.camel@linux.intel.com> <CAJZ5v0iFLxpWHW=sDZ7=Wne3Yt=8_EwhW9SeCmRP6REpVqo8rA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iFLxpWHW=sDZ7=Wne3Yt=8_EwhW9SeCmRP6REpVqo8rA@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 21 Sep 2023 14:08:33 +0800
Message-ID: <CAAd53p67tiP0xXwhn=NviU_rvrSveSxbAhDieYG9AmUWF2e__Q@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 20, 2023 at 2:00=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Sep 19, 2023 at 6:54=E2=80=AFPM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > On Tue, 2023-09-19 at 15:36 +0800, Kai-Heng Feng wrote:
> > > On Mon, Sep 18, 2023 at 11:57=E2=80=AFPM srinivas pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > >
> > > > Hi Kai-Heng,
> > > > On Mon, 2023-09-18 at 09:17 +0800, Kai-Heng Feng wrote:
> > > > > Hi Even,
> > > > >
> > > > > On Mon, Sep 18, 2023 at 8:33=E2=80=AFAM Xu, Even <even.xu@intel.c=
om>
> > > > > wrote:
> > > > > >
> > > > > > Hi, Kai-Heng,
> > > > > >
> > > > > > I just got feedback, for testing EHL S5 wakeup feature, you
> > > > > > need
> > > > > > several steps to setup and access
> > > > > > "https://portal.devicewise.com/things/browse" to trigger wake.
> > > > > > But currently, our test account of this website are all out of
> > > > > > data.
> > > > > > So maybe you need double check with the team who required you
> > > > > > preparing the patch for the verification.
> > > > >
> > > > > The patch is to solve the GPE refcount overflow, while
> > > > > maintaining S5
> > > > > wakeup. I don't have any mean to test S5 wake.
> > > > >
> > > > The issue is not calling acpi_disable_gpe(). To reduce the scope of
> > > > change can we just add that instead of a adding new callbacks. This
> > > > way
> > > > scope is reduced.
> > >
> > > This patch does exactly the same thing by letting PCI and ACPI handle
> > > the PME and GPE.
> > > Though the change seems to be bigger, it actually reduces the duped
> > > code, while keep the S5 wakeup ability intact.
> > It may be doing the same. But with long chain of calls without
> > verification, I am not comfortable.
> > This can be another patch by itself to use the framework.
>
> I agree.
>
> Let's change one thing at a time.
>
> > But you are targeting a fix for overflow issue, which is separate from
> > the use of PCI/ACPI framework.
>
> Yes, let's fix the bug first and make things look nicer separately.

Right, please use the fix from Srinivas and I'll send a separate patch
to make things looks better.

Kai-Heng
