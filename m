Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D446E44DC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 12:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjDQKLW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 06:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjDQKLU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 06:11:20 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD146A72;
        Mon, 17 Apr 2023 03:10:34 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id m21so13920519qtg.0;
        Mon, 17 Apr 2023 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681726114; x=1684318114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYIIRjxNda/ziUqkZhz2I8xvie0gsHo4ftMvTuqFRis=;
        b=NYIkajAArbsLM49c5Zzj36P+HXW/I+UYGch2JB2/+dWKLpa+omDZITXvq2zJDI+rFx
         QwInVjvGeD7a+UHoHAGb3CV8OruU7FcrkrPxgX0f8RW4vPY+R9KSNSCYNvOFaGEtig3P
         wwNi2xjv7qo9AUKJ/CE9fUM++ZbkYNf86vg+kG29TJHaXQuSyreEmQpJK/P8ZgK4tnQw
         +O9ol1qAi0zFipZB0TN4itsulLZv8lgQkMnxQjwA4jzTkH9YF/Ql7PEtFazJQB8GeuFW
         oOygwws8GrT7nYvy5qWqgHLJTHcMeZpkfqI5g07FLB4zq4HYrKRSvU/kfwFQpdKf5/4v
         CXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681726114; x=1684318114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYIIRjxNda/ziUqkZhz2I8xvie0gsHo4ftMvTuqFRis=;
        b=iRRi9Ch9GNnK0OAQzxPrpk6oboeWxUPKrVU/rLXaLIJzMphCLj5EPyhp0tobVvZlhY
         eAN1AJ0lI0Us9zH/FxFMPvZU2GhMJXkXt/GegDi3csx89PN09LKILK0udGgYoXDB/9a8
         6JXlXfR6eIuifh2uyhUs9laWncOAbZ1HdoGN6S82+966eMgD2FIAAxfK5LUK0Tc/Pi+/
         bZ6O+5VOkbRxfjQdD8hUFdd9eQxmRAhmkzyVH9isULPAfW1hE+xm3WvohBk8k2IV9Znu
         A+UE/werQ8v0J84BQj+19rXOy1pn5zxK36KY4xu1hs3MwFtqnX2g/NTT3YuETSnhS6Lk
         zokg==
X-Gm-Message-State: AAQBX9dfT0+9c56vk8MUDZHd8LKbdF/ok3mc0tQCkxdVztQQmyGv9kTK
        rIhHBM6r9ufv25TenjTLMY20iQTPSNYO+XPsyU4=
X-Google-Smtp-Source: AKy350aidr5mhwJmg0IddRiawwv35eduv7ffrQvf/kXLi/fnL1/dp4WvuTBRpSzBs+d5c4LHVDXqto/0bvBg2KzOWxE=
X-Received: by 2002:ac8:5902:0:b0:3de:d15a:847f with SMTP id
 2-20020ac85902000000b003ded15a847fmr4470777qty.0.1681726113789; Mon, 17 Apr
 2023 03:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230306151014.60913-1-schnelle@linux.ibm.com>
 <20230306151014.60913-2-schnelle@linux.ibm.com> <20230417074633.GA12881@wunner.de>
In-Reply-To: <20230417074633.GA12881@wunner.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 17 Apr 2023 13:07:57 +0300
Message-ID: <CAHp75VfuBTR6gO4SSZUZodWnBH7UfTS859PLCQy+qM+ABSkKdQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI: s390: Fix use-after-free of PCI resources
 with per-function hotplug
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 17, 2023 at 10:46=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wro=
te:
> On Mon, Mar 06, 2023 at 04:10:11PM +0100, Niklas Schnelle wrote:

...

> > +void pci_bus_remove_resource(struct pci_bus *bus, struct resource *res=
)
> > +{
> > +     struct pci_bus_resource *bus_res, *tmp;
> > +     int i;
> > +
> > +     for (i =3D 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
> > +             if (bus->resource[i] =3D=3D res) {
> > +                     bus->resource[i] =3D NULL;
> > +                     return;
> > +             }
> > +     }
> > +
> > +     list_for_each_entry_safe(bus_res, tmp, &bus->resources, list) {
> > +             if (bus_res->res =3D=3D res) {
> > +                     list_del(&bus_res->list);
> > +                     kfree(bus_res);
> > +                     return;
> > +             }
> > +     }
> > +}
>
> I realize this has already been applied so s390.git/master,
> but nevertheless would like to point out there's a handy
> pci_bus_for_each_resource() helper which could have been
> used here instead of the for-loop.

Actually in this case it's not possible. The above code nullifies the
matched resource or removes it from the list. We don't have any good
iterator inside pci_bus_for_each_resource() to do the latter.

There might be other places in the kernel code where something like
above is used and we can split a separate helper exactly for matching
cases, but with the above context I dunno we need to do anything right
now.

P.S. Thanks for Cc'ing me.

--=20
With Best Regards,
Andy Shevchenko
