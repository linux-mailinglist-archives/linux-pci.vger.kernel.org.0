Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ADC63357C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 07:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiKVGu2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 01:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiKVGu1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 01:50:27 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB28621266
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 22:50:25 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-14279410bf4so14504037fac.8
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 22:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lzFJLpTLcz/ApZwJA6HZYYwWg5c8s6kbjnuAYkfIuQ0=;
        b=Bp9iz5iWBO3rOgNazChfrLbalZWXa01HFbpzJayoUJFPQkEJOLB+p02PZPkrRQncsw
         f6xfr6Ave8C6rATZQe0YqQxG79MXg/TCciBgKxW/x9Hbd4XR5Ay1ARvRmtTWFaUOQBKd
         lhBX6jZUi/5WuxhhPyafPHvk34DPA0J38qj17TT47z1d1VWGOsxF0WP+YpU+zKYruEB1
         O3RwSmnuJCIyOtohhm553fjPmr10vukwRsiuuRwt3/yd3G2u748EWWurzG/eoI1UCA11
         vQmm/PNA1F6ClLB8uE31/uDDISLJyEv2nVEr6AYW2Z+G7G0QVtmSV80N2HERZaToPlPL
         +lSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzFJLpTLcz/ApZwJA6HZYYwWg5c8s6kbjnuAYkfIuQ0=;
        b=T5pQUgu6O7taCrT/jt7nI/zFe+AkPCCZoMLIlrLkhYidFHiwvL7aHSlDB0EbswKwM2
         fP+sbQ6glpalmS6CJ7cdELEWxWWb4Dhd30MD714XxL9yoqlbHR92URM2y7NR//WCdh4c
         vomZ2/wwCAI4aXoDzE3ZI7JGbZACJBvVpeetASmdobEaKjh4iMll860+/5Lhm/P6iDNH
         8XTEf3TuAZ/mf5VYS40WZ2zge3lZdTFJu7LdNgqO/XF6nWfgrBekWC1hY+hiGnHF9lMh
         LA0vEV/UGov6qkrt4C24f0zjwwoIXBO6sb2zg8Tx1CD0Rr6ZOrp47N/D5yeKvq0Z0YGT
         X1EA==
X-Gm-Message-State: ANoB5plUCzPKRmKaOyl5aVq9HAZqbbtsgBoHTWPj3zAyCj14LDwZuacC
        pzxR4seFQtpWx8wvkvi9VfXcf7mdq3KCl2OALL4=
X-Google-Smtp-Source: AA0mqf6dxxk/zXQvI8sJ6M21664ZNPRUZrEfzwoGEa2AogJXqZAWjlMjFWUSH2rD8j5DAqGJnL0ZPVik+3GVoGzFq78=
X-Received: by 2002:a05:6870:9591:b0:13a:eee0:b499 with SMTP id
 k17-20020a056870959100b0013aeee0b499mr1592368oao.83.1669099825206; Mon, 21
 Nov 2022 22:50:25 -0800 (PST)
MIME-Version: 1.0
References: <CAMhs-H-i1arxS4daudfG8AGuFyxmJuNe6CY4A+Pi+u8RNUM65A@mail.gmail.com>
 <20221121225052.GA140064@bhelgaas>
In-Reply-To: <20221121225052.GA140064@bhelgaas>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 22 Nov 2022 07:50:13 +0100
Message-ID: <CAMhs-H-cX2obR3XggAc-3hqHEW2S4UErYKVLWk=TKcJpYSd+gg@mail.gmail.com>
Subject: Re: [PATCH] PCI: mt7621: increase PERST_DELAY_MS
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
        bhelgaas@google.com, kw@linux.com, robh@kernel.org,
        lpieralisi@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 21, 2022 at 11:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sun, Nov 20, 2022 at 08:37:50AM +0100, Sergio Paracuellos wrote:
> > On Sat, Nov 19, 2022 at 7:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Sat, Nov 19, 2022 at 12:08:37PM +0100, Sergio Paracuellos wrote:
> > > > Some devices using this SoC and PCI's like ZBT WE1326 and Netgear R6220 need
> > > > more time to get the PCI ports properly working after reset. Hence, increase
> > > > PERST_DELAY_MS definition used for this purpose from 100 ms to 500 ms to get
> > > > into confiable boots and working PCI for these devices.
> > >
> > > confiable?
> >
> > It seems my spanish confused my mind here :). I meant trustable.
>
> Your English is WAY, WAY better than my Spanish :)
>
> I assume this is more about just making boots more "reliable" than
> something like the "Trusted Boot" or "Secure Boot" technologies [1,2]?

You are right. Reliable is definitely the accurate word for this :)

Thanks,
     Sergio Paracuellos
>
> Bjorn
>
> [1] https://trustedcomputinggroup.org/resource/trusted-boot/
> [2] https://learn.microsoft.com/en-us/windows/security/trusted-boot
