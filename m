Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6863618776
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 19:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiKCSas (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 14:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiKCSaq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 14:30:46 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A492AE42;
        Thu,  3 Nov 2022 11:29:53 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id b185so2400986pfb.9;
        Thu, 03 Nov 2022 11:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZjEyPGh7N/ck24vh/VKMs5s50UIlOa2pgI4ml3dqpA=;
        b=wBIG6peM6DO5VkovFmK5TgeyvBa7jO8i95AVxC7AtHb7w6gbuyIVitJya39P0iaTJu
         0sT6wJ6o5hrKmNgXieS+gzsrfy5btgpKT6RZ2nSrQgaYhFueAGWUyUmm4pYpUFvbsiPn
         7oY6sqqszRlqiSokONWdNzFxaCSIc2FNrRUGQ7cCDsbMzfsGB791jzVb+LyoHWF36yoK
         2TrOYBVCI2uJxj7oZe3gEUTXw/Rl59c8yO59nawy3Xsh/YPXHqATxcpUZtOmF5C2qQIm
         d3+Ra3gi/m/RggvdOLbYJ/bpD4AHpoa2ao5th4mbUqIqD3J+HACVkCz5DRhVVTeNcERI
         z7qQ==
X-Gm-Message-State: ACrzQf3EhY2IWYhRFKNYyvinf1CSPHo9OLMWzdjT9rya749d8zsmYHdq
        YaY05A38KU+b5JFp2N8rNLs=
X-Google-Smtp-Source: AMsMyM4MMb94EAGz1kO2Q0DRDyjidkdmznJiyzQZ8JfQK1Y1FbZfy+aOFpE2yYDeDmYpBxRHuxCHKQ==
X-Received: by 2002:aa7:8c15:0:b0:56b:ead2:3950 with SMTP id c21-20020aa78c15000000b0056bead23950mr32086578pfd.77.1667500192405;
        Thu, 03 Nov 2022 11:29:52 -0700 (PDT)
Received: from rocinante (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id o14-20020a170902d4ce00b0018157b415dbsm1034089plg.63.2022.11.03.11.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:29:51 -0700 (PDT)
Date:   Fri, 4 Nov 2022 03:29:44 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH v2 4/4] pcmcia: Convert to use
 pci_bus_for_each_resource_p()
Message-ID: <Y2QImB0OLakzz1+F@rocinante>
References: <20221103164644.70554-1-andriy.shevchenko@linux.intel.com>
 <20221103164644.70554-5-andriy.shevchenko@linux.intel.com>
 <Y2P0XCNJvTVuziO7@owl.dominikbrodowski.net>
 <Y2P2ja26ikNecTsv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2P2ja26ikNecTsv@smile.fi.intel.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> > > -
> > > -	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
> > > -		res = s->cb_dev->bus->resource[i];
> > > -#else
> > > -	pci_bus_for_each_resource(s->cb_dev->bus, res, i) {
> > >  #endif
> > > +
> > > +	pci_bus_for_each_resource_p(s->cb_dev->bus, res) {
> > >  		if (!res)
> > >  			continue;
> > 
> > Doesn't this remove the proper iterator for X86? Even if that is the right
> > thing to do, it needs an explict explanation.
> 
> I dunno what was in 2010, but reading code now I have found no differences in
> the logic on how resources are being iterated in these two pieces of code.

This code is over a decade old (13 years old to be precise) and there was
something odd between Bjorn's and Jesse's patches, as per:

  89a74ecccd1f ("PCI: add pci_bus_for_each_resource(), remove direct bus->resource[] refs")
  cf26e8dc4194 ("pcmcia: do not autoadd root PCI bus resources")

> But fine, I will add a line to a commit message about this change.

I wouldn't, personally.  The change you are proposing is self-explanatory
and somewhat in-line with what is there already - unless I am also reading
the current implementation wrong.

That said, Dominik is the maintainer of PCMCIA driver, so his is the last
word, so to speak. :)

> Considering this is done, can you issue your conditional tag so I will
> incorporate it in v3?

No need, really.  Again, unless Dominik thinks otherwise.

	Krzysztof
