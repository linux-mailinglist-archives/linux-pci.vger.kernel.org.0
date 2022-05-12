Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569B352454B
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 08:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350074AbiELGAZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 02:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350077AbiELGAX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 02:00:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2163921AAB0;
        Wed, 11 May 2022 23:00:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id m20so8001421ejj.10;
        Wed, 11 May 2022 23:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EsIEN4O+TN/lxuS5UZLuc5seboCoSmgg6DJggBHbT4Y=;
        b=HYG80oIF8cUpOGMyABw+qJ9keHg9v90TkcjPAjS4gUE6SH9FthhSZrjMmp9gP5sUo4
         hV06Kdx9GvoPPGRQvE6/uae7aygj2hBaoCrSJd7DrEj0OsAsWqsEicRW82Cqjt1MJlTM
         PJ92pppJXUIJgT0z1xue5WDKweXUim7LcrIUhgizV0EnSFkrpjZPOGacw7mPqp5A73jk
         VhdD13IGpaXTvpCYTip4lkZD4/jg9gAompIEs8WkP80Jw+qt+THOikPXexSTM1Jm3STJ
         t9YWEsESOyywtYtGFmxd2sJ1Zagr1odijVLS9UgsPBP3pwXZkj5NPSluVJ5e6IAdOiuO
         utwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EsIEN4O+TN/lxuS5UZLuc5seboCoSmgg6DJggBHbT4Y=;
        b=r9iclqUztdojPNbKo4z6i0/u5JuWF+vpSbsySS4aUclwiw2iRGMvqSIbBAPPpNFi+L
         CVt3YAxTyhTLT55+1lDmI6DK94RX5qCP2Rahh3Tb+vkqlfuK8iOAXFsxP43mnrLgAEzp
         PgA2taNzh8Is5MjpYqZvYBVKJDyNVvzuxcanxwbdMHqk2Mr3ijlg3EMQWa5pHfzSqZZk
         SbpLGqTKtHk1ZpPbgSTf8eV3+yABwe4xfCD2JiV+V3Bnb2bKU7GHxCBHi39bK6E5ua9K
         wGCT37YYuu0/V5Kh87axxNDPsV/js5FaCvIEV0f37SyfjMzLtw9kDHNzDF55hz1IS9uv
         9Y4g==
X-Gm-Message-State: AOAM530SWmor1klEQ8V62zAjOSY2+N9HbdmS/KANzQdV6uO0sq7f1xnv
        N25UqWycfFWDYo1VqwWbLQSlmY+XBFu5wNquxhk=
X-Google-Smtp-Source: ABdhPJxmaicvwEDsMJ+Hau8Pq8B99VQFj6+JSnEqaAQ9k+WI1DC7k2zhUbIuCEoR9nMMhuE4mVFUt5RC/LMKCDPE/aE=
X-Received: by 2002:a17:907:2064:b0:6f4:3f07:c76e with SMTP id
 qp4-20020a170907206400b006f43f07c76emr28442375ejb.462.1652335220507; Wed, 11
 May 2022 23:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220429105627.GA28438@lpieralisi> <20220429192825.GA82239@bhelgaas>
 <20220505144347.GA19346@JADEVM-DRA> <CAH9NwWcU71gZ2woZ7ePRvuwz=_T+F7V6VOYLyAqPhTy1j6xxPA@mail.gmail.com>
 <YnuuIQgwt45zUEcR@lpieralisi>
In-Reply-To: <YnuuIQgwt45zUEcR@lpieralisi>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Thu, 12 May 2022 08:00:09 +0200
Message-ID: <CAH9NwWdbknzwDqzjfKPx1FRa0JV8botWZH6_HOh+KbLpRof9hw@mail.gmail.com>
Subject: Re: [PATCH] PCI: cadence: respond to received PTM Requests
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Dominic Rath <dominic.rath@ibv-augsburg.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
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

Am Mi., 11. Mai 2022 um 14:37 Uhr schrieb Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com>:
>
> On Thu, May 05, 2022 at 04:48:17PM +0200, Christian Gmeiner wrote:
>
> [...]
>
> > > > I think the proposed subject of "Enable Controller to respond to
> > > > received PTM Requests" is somewhat misleading, though, because PTM
> > > > responses still aren't enabled until we set PTM Enable.  I suggest
> > > > something like:
> > > >
> > > >   PCI: cadence: Allow PTM Responder to be enabled
> > >
> > > I'll ask Christian for permission to resend his patch with the subject
> > > changed.
> > >
> >
> > I will send a new version tomorrow with an improved subject line.
>
> Hi Christian,

Hi Lorenzo

>
> just asking if you are about to post a new version to pick it up.
>

Sorry for the delay .. send out V3:
https://lore.kernel.org/lkml/20220512055539.1782437-1-christian.gmeiner@gmail.com/


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
