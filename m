Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD3462B202
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 05:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiKPEDL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 23:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiKPEDK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 23:03:10 -0500
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44391E3EC;
        Tue, 15 Nov 2022 20:03:09 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id g24so15310949plq.3;
        Tue, 15 Nov 2022 20:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1zIzDKHHVNaVurdU/es7VrrKvHMyE/kDIQtf0pEpjIw=;
        b=D+Dlj71vTioFw5aoFSqADw++/kUzanUTlYOQ7fNeSSjMyycrCR5pZhMeEJnkbqejcL
         LCCSFSnafpI5ssaa8POK0gcuW/Pw2DoQXy3ETf5PhEBkMpA7JxjClb0TQCXu2Wa34FNU
         paxEH9ZS+Smwlv0g1rjPoaXrow8a/svdMvaXfNRidTkqKBrFWYad/XgPkl6zJsV8VsDe
         ktLzqza/cEzYtGUx74382Cx01ZOtKLKnJQzlcTeXkB5TSprKJ3jLyCQH8Haaa+4SiKtE
         RmvJ+DvB7CJwQ75cNo6yH8rme3Eh9bGnpCXc6lr7VCy0DMpwD3MIByKOGAnmtW3WLsCq
         f3qA==
X-Gm-Message-State: ANoB5plbaNnxF6tUPO7irZmLJYu/BThk6sbTxnIKk+p0P70RfRudN0jn
        5Vs+jCTJiw6fbpcB5ggOi8U=
X-Google-Smtp-Source: AA0mqf6hyhoq112sIKQo2v/k51nNvfWIgxwNBEvlAx1Pthk/+MTebE7MSfBKsrWrQE5FLsqcaK8YIQ==
X-Received: by 2002:a17:90a:3f89:b0:217:90e0:3f8c with SMTP id m9-20020a17090a3f8900b0021790e03f8cmr1687555pjc.192.1668571388739;
        Tue, 15 Nov 2022 20:03:08 -0800 (PST)
Received: from rocinante (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id nl8-20020a17090b384800b0020d48bc6661sm390550pjb.31.2022.11.15.20.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 20:03:08 -0800 (PST)
Date:   Wed, 16 Nov 2022 13:03:01 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
        Miguel Ojeda <ojeda@kernel.org>,
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
Subject: Re: [PATCH v3 0/4] PCI: Add pci_dev_for_each_resource() helper and
Message-ID: <Y3Rg9dGmzZl4GJU5@rocinante>
References: <20221114185822.65038-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221114185822.65038-1-andriy.shevchenko@linux.intel.com>
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

> Provide two new helper macros to iterate over PCI device resources and
> convert users.
> 
> Looking at it, refactor existing pci_bus_for_each_resource() and convert
> users accordingly.
> 
> This applies on top of this patch Mika sent out earlier:
> https://lore.kernel.org/r/20221114115953.40236-1-mika.westerberg@linux.intel.com
> 
> Changelog v3:
> - rebased on top of v2 by Mika, see above
> - added tag to pcmcia patch (Dominik)
[...]

Thank you Andy for all the improvements and Mika for the idea!

For the whole series:
  Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Looks very nice!

	Krzysztof
