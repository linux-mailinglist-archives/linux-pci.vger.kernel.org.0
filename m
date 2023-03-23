Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282516C6D7F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 17:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjCWQ3a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 23 Mar 2023 12:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjCWQ3R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 12:29:17 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551FC28D3D;
        Thu, 23 Mar 2023 09:29:10 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id s12so27185997qtq.11;
        Thu, 23 Mar 2023 09:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679588949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UL3/4GqvmmUqfCC6k4K5nIi6sLrnnlUEco09johNyxg=;
        b=mPE+X7sf5GgBnYeWLJT5ij4OD/Qrcn0L8bl7nuAMN8UzvgLTkLpuVjDeOykQV1TkRm
         hPg2iG0gmbl59AA5wduA7eQXiacfKbvQXuwnSUUEc/TIs6+VsLplD32T6bgVpy+s/DJD
         2felFsO7BIu7BE+xnC4W2Yx3kideFeEGxvUc9v2qctdkp2Ixgc5W4adXg9fELtqv62sp
         zxX2Ygo5/AUzsh6QTOKt/FgrUaHxaNvN20zn8zD8Rzvn9KUoUJmBOIwtTgXJWW2jl9UM
         ObGZj3zlG/AYmInMe0Pp4LI6WOK/PmFV4yLk4sR1PgVL/ELxvbqXrQD4mTtBsT1RTGtO
         OP9A==
X-Gm-Message-State: AO0yUKUgl+f5W2MwM3cI2A7eApnMNLra0B30IhUsk56uY1KPnwfjbXMF
        BElXuFyIkevT79b8AGMWCOaHgsqE6GNa1zgW
X-Google-Smtp-Source: AK7set9RfytlRTXKzAv+fZH9ZgrVhu3Wp0W+Ws4B1kgrWy260ylYOtE3lquBI4C5T7SOzjaDMTf1Yg==
X-Received: by 2002:ac8:5c0c:0:b0:3bf:c407:10ca with SMTP id i12-20020ac85c0c000000b003bfc40710camr10679877qti.10.1679588949012;
        Thu, 23 Mar 2023 09:29:09 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 66-20020a370b45000000b0071eddd3bebbsm5146565qkl.81.2023.03.23.09.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 09:29:08 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id e71so25578812ybc.0;
        Thu, 23 Mar 2023 09:29:07 -0700 (PDT)
X-Received: by 2002:a05:6902:728:b0:a09:314f:a3ef with SMTP id
 l8-20020a056902072800b00a09314fa3efmr2603297ybt.12.1679588947338; Thu, 23 Mar
 2023 09:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <ZBxiaflGTeK8Jlgx@smile.fi.intel.com> <20230323150238.GA2550157@bhelgaas>
 <ZBxrfy83MRjnReAs@smile.fi.intel.com>
In-Reply-To: <ZBxrfy83MRjnReAs@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Mar 2023 17:28:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWkavUwZrfuJ5YSsb2kkHVZ0TCzcme5o6CkYGcSDVt+jw@mail.gmail.com>
Message-ID: <CAMuHMdWkavUwZrfuJ5YSsb2kkHVZ0TCzcme5o6CkYGcSDVt+jw@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] PCI: Introduce pci_dev_for_each_resource()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anatolij Gustschin <agust@denx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

On Thu, Mar 23, 2023 at 4:15 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Mar 23, 2023 at 10:02:38AM -0500, Bjorn Helgaas wrote:
> > I poked around looking for similar patterns elsewhere with:
> >   git grep "#define.*for_each_.*_p("
> >   git grep "#define.*for_each_.*_idx("
> >
> > I didn't find any other "_p" iterators and just a few "_idx" ones, so
> > my hope is to follow what little precedent there is, as well as
> > converge on the basic "*_for_each_resource()" iterators and remove the
> > "_idx()" versions over time by doing things like the
> > pci_claim_resource() change.
>
> The p is heavily used in the byte order conversion helpers.

I can't seem to find them. Example?

Or do you mean cpu_to_be32p()? There "p" means pointer,
which is something completely different.

> > What do you think?  If it seems like excessive churn, we can do it
> > as-is and still try to reduce the use of the index variable over time.
>
> I think _p has a precedent as well. But I can think about it a bit, maybe
> we can come up with something smarter.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
