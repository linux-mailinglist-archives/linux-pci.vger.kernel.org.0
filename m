Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716AC5311F5
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbiEWP7l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 11:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbiEWP7j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 11:59:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874FD13F8C;
        Mon, 23 May 2022 08:59:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z25so1398780pfr.1;
        Mon, 23 May 2022 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rWxANZwiWxjY7oEsXTVwMbfOrUKsgscWMIFvRo3MrvA=;
        b=E1xNhK6Upsw0ZUh99teWH8au6Io9PBLwuE/c4tpF8a+zsv3UQl0KETRa1lqqnvbgWL
         Pd8tObJLx1JRUwNdN5boLTBmTPncS+y50Iu8H+9vXxXFplb8MqP55/sloeSqW057UNvo
         xnmUTMefwOGabbcJ9HvIaGkiy3kw8DyevTW/wyiT6z7i2pkOtJcFLZ8gEkTkD5dXA2W+
         PYmv78BCvbbRY27BAv7oTEUo9axMgDwtt/wgIykOwA6nzNWFfJ36mwvUTYS+roGvd2SL
         x81lNhlVTgn2hg+I9HeGatRU8Ck7xhXlS1//vzL+XjTVWJVb6BxI8eHvCIfTShMESZ5A
         DczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWxANZwiWxjY7oEsXTVwMbfOrUKsgscWMIFvRo3MrvA=;
        b=UYHipf2mdGPAsrKM1Uis26KQ6Jk0gwZTLMTzJJYXoBenIypHF/HQKlsQ0mG07RYz5i
         F+MP+6jCQ5NbEBUX1/8J7tcP3MmTboUh7rvSD6t71Qtfob3fUIdBdzzmRXmQiD/JrGVS
         XqI8MEHDsPTLdG5iVknluBZv0/aDYJ0eknR3f9QDggOvqSNkAua4oonx0OvQyMxT4Pmb
         ebbftTEtg73QPYjG3BJqMXbleiVxCYMBvtadL/rm9nP+xUwGjaU+l4fAC8XzZuxyZCrG
         8mT6f+X4gVvnkSrWeU1K5Qcr2XA+YIHo8dklvp65nYyHp45/HBIgT6zYFFBCePXQBpmh
         bNWQ==
X-Gm-Message-State: AOAM532l5N7mxXDBCCSn42N8hVQ4V8ZTmM+j1LZcYUu4DXa/ij4/TbnO
        UDakiyeN/pJ+XbMdvwV3MI9AtIw6YOMhZ4wWAbk=
X-Google-Smtp-Source: ABdhPJy0XNmt9jGyIiTXD/bSqHP+LfQiWrd20vM4ZnFCT++jqLNdDrSCT37JvnwMRMVRUlulBuY+OztPCu3Lwr8+Lhs=
X-Received: by 2002:a05:6a00:1501:b0:510:7ab8:71c8 with SMTP id
 q1-20020a056a00150100b005107ab871c8mr24123220pfu.63.1653321578047; Mon, 23
 May 2022 08:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220516165740.6256af51.alex.williamson@redhat.com>
 <20220518115432.76183-1-windy.bi.enflame@gmail.com> <20220520064148.GA20418@wunner.de>
 <CAGdb+H2_pX4TzG=sJ8XE6KiyWW9niJQawCbcDN2byxDfybukiA@mail.gmail.com>
 <20220521124910.GA13556@wunner.de> <CAGdb+H19bfbXM1cPJvhh6gixJbF7Sk=v53d9VpvWY8HEs0mSKg@mail.gmail.com>
 <20220523142042.GA19286@wunner.de>
In-Reply-To: <20220523142042.GA19286@wunner.de>
From:   Sheng Bi <windy.bi.enflame@gmail.com>
Date:   Mon, 23 May 2022 23:59:23 +0800
Message-ID: <CAGdb+H0qnC4noBa_=N3oQW88+dgXYtA7gqJ5qiD2g7Ywd+2K=Q@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Fix no-op wait after secondary bus reset
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 23, 2022 at 10:20 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sun, May 22, 2022 at 01:37:50AM +0800, Sheng Bi wrote:
> > On Sat, May 21, 2022 at 8:49 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Sat, May 21, 2022 at 04:36:10PM +0800, Sheng Bi wrote:
> > > > If so, I also want to align the polling things mentioned in the
> > > > question from Alex, since pci_dev_wait() is also used for reset
> > > > functions other than SBR. To Bjorn, Alex, Lucas, how do you think if
> > > > we need to change the polling in pci_dev_wait() to 20ms intervals, or
> > > > keep binary exponential back-off with probable unexpected extra
> > > > timeout delay.
> > >
> > > The exponential backoff should probably be capped at some point
> > > to avoid excessive wait delays.  I guess the rationale for
> > > exponential backoff is to not poll too frequently.
> > > Capping at 20 msec or 100 msec may be reasonable, i.e.:
> > >
> > > -               delay *= 2;
> > > +               delay = min(delay * 2, 100);
> >
> > Capping at 20 or 100 msec seems reasonable to me. Btw, since 20 msec
> > is not a long time in these scenarios, how about changing to a fixed
> > 20 msec interval?
>
> The callers of pci_dev_wait() seem to wait for the spec-defined
> delay and only call pci_dev_wait() to allow for an additional period
> that non-compliant devices may need.  That extra delay can be expected
> to be low, which is why it makes sense to start with a short poll interval
> and gradually extend it.  So the algorithm seems to be reasonable and
> I wouldn't recommend changing it to a constant interval unless that
> fixes something which is currently broken.
>
> Thanks,
>
> Lukas

Thanks Lukas!

From my perspective, there is nothing broken so far, but a theoretical
unexpected extra delay while the timeout has passed. So I will keep
pci_dev_wait() as previously with exponential backoff in this patch,
and change the pci_bridge_secondary_bus_wait() with "jiffies" and
pci_dev_wait().

Thanks,

windy
