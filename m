Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D47761D34
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 17:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGYPUu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 11:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGYPUt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 11:20:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C1199E
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690298404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bA9vphGlJ3SZEj4DDnNZJimUpMLjtG2Fng1WAhKeY0=;
        b=M4dVweE3z2BeFSZIxHTwUfwnUqqL8CG0dnflTb4YKHOU8Ld1NmvSBcyZLrYFiqFUstcyjm
        mQqCBuFee5cW3TjZ3nBBZh3fOKIWBjOPs7XKTtRsyQOLKmVjN6El9I7uQMdWBRiQikW+nN
        MbQNMFn79g87DjWwVz08ZCyU0snZfUg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-QXbVZSo5O3ml5bN2C06vMg-1; Tue, 25 Jul 2023 11:20:00 -0400
X-MC-Unique: QXbVZSo5O3ml5bN2C06vMg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-989249538a1so383718866b.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 08:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690298399; x=1690903199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bA9vphGlJ3SZEj4DDnNZJimUpMLjtG2Fng1WAhKeY0=;
        b=JOgty51sa0Opb6rDQ67AlWd+2yuyE63cjVWi1nXwkL7xCYsB1zMGqmBuNJ6n36J+64
         c49rwC9llJ4CCswk4t2bMKhflr83whs8V1QK57NsCt3JlMQVIz+6B4A/Jh9lb4mXIRQ1
         OftmyzwtFV7pHVVSv1g6/+c41MtxURVyyYGh7R03TtLkFrVv693kfngTK1/4ohUtFiY7
         od9Dj6ZlL1jhcW+W0QOlRc18RkhxYoFwBN6vRZMRQ64l4th6etyItQzMsLCvsz3NXtUA
         K+2sPeQZdRNZxDjyX1DW/ATGjxigy6JsuZuezW8awzCq8ee2XXMDBQKvPtZopfWOnYTB
         QkXg==
X-Gm-Message-State: ABy/qLb3UnVszKFv9bcnoZk5wWueFDsSzXVZSRa1dzTiOo73FphCIHad
        us3/2mRR2E5oHVLJTQ6bGO/8fsN+Fe5m9q6c33zQZmcGIy/25piQo7o+Yf6mHxfjeDmXQJAY5aP
        qiAdAp3Etx67xBRCONdnM
X-Received: by 2002:a17:907:77c6:b0:987:498a:87f6 with SMTP id kz6-20020a17090777c600b00987498a87f6mr12299463ejc.34.1690298399699;
        Tue, 25 Jul 2023 08:19:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGdjOtgSdV6CHAv6g0knEyXyiM4m969nzVV5AD938ec+dfyPnPPTmM0lk5/dJlhMoub3lIs0g==
X-Received: by 2002:a17:907:77c6:b0:987:498a:87f6 with SMTP id kz6-20020a17090777c600b00987498a87f6mr12299441ejc.34.1690298399345;
        Tue, 25 Jul 2023 08:19:59 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id cb14-20020a170906a44e00b00992eabc0ad8sm8279192ejb.42.2023.07.25.08.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:19:58 -0700 (PDT)
Date:   Tue, 25 Jul 2023 17:19:58 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Woody Suwalski <terraluna977@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, mst@redhat.com
Subject: Re: [RFC 0/3] acpipcihp: fix kernel crash on 2nd resume
Message-ID: <20230725171958.1eacd24e@imammedo.users.ipa.redhat.com>
In-Reply-To: <88a06e12-600a-a4bd-f216-44753965ce48@gmail.com>
References: <20230725113938.2277420-1-imammedo@redhat.com>
        <88a06e12-600a-a4bd-f216-44753965ce48@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Jul 2023 09:51:53 -0400
Woody Suwalski <terraluna977@gmail.com> wrote:

> Igor Mammedov wrote:
> > Changelog:
> >    * split out debug patch into a separate one with extra printk added
> >    * fixed inverte bus->self check (probably a reason why it didn't wor=
k before)
> >
> >
> > 1/3 debug patch
> > 2/3 offending patch
> > 3/3 potential fix
> >   =20
> > I added more files to trace, add following to kernel CLI
> >     dyndbg=3D"file drivers/pci/access.c +p; file drivers/pci/hotplug/ac=
piphp_glue.c +p; file drivers/pci/bus.c +p; file drivers/pci/pci.c +p; file=
 drivers/pci/setup-bus.c +p; file drivers/acpi/bus.c +p" ignore_loglevel
> >
> > should be applied on top of
> >     e8afd0d9fccc PCI: pciehp: Cancel bringup sequence if card is not pr=
esent
> >
> > apply a patch one by one and run testcase + capture dmesg after each pa=
tch
> > one shpould endup with 3 dmesg to ananlyse
> >   1st - old behaviour - no crash
> >   2nd - crash
> >   3rd - no crash hopefully
> >
> > Igor Mammedov (3):
> >    acpiphp: extra debug hack
> >    PCI: acpiphp: Reassign resources on bridge if necessary
> >    acpipcihp: use __pci_bus_assign_resources() if bus doesn't have brid=
ge
> >
> >   drivers/pci/hotplug/acpiphp_glue.c | 23 ++++++++++++++++++-----
> >   1 file changed, 18 insertions(+), 5 deletions(-)
> > =20
> Actually applying patch1 is already creating the crash (why???),
probably it's due to an extra debug line, I've added.
I dropped suspicions one, can you try again and see if it works.

> hence I=20
> have added also dmesg-6.5-0.txt which shows a working condition based on=
=20
> git e8afd0d9fccc level (acpiphp_glue in kernel 6.4)
>=20
> Patch3 did not fix the issue, it seems that the culprit is somewhere=20
> else triggered by=C2=A0 "benign" patch1 :-(
>=20
> Also note about the trigger description in patch3: the dmesg trace on=20
> Inspiron laptop is collected after the first wake from suspend to ram.=20
> The consecutive=C2=A0 attempt to sleep results in a frozen system.

Thanks for clarification, I'll correct commit message once culprit
is found.

>=20
> Thanks, Woody
>=20

