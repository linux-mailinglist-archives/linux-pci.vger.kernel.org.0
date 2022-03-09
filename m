Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F42A4D3CAD
	for <lists+linux-pci@lfdr.de>; Wed,  9 Mar 2022 23:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbiCIWL4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 17:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiCIWLz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 17:11:55 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B4B120F44;
        Wed,  9 Mar 2022 14:10:54 -0800 (PST)
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mhl4Q-1o5p7c43JA-00dn4Q; Wed, 09 Mar 2022 23:10:53 +0100
Received: by mail-wr1-f47.google.com with SMTP id q14so5166270wrc.4;
        Wed, 09 Mar 2022 14:10:52 -0800 (PST)
X-Gm-Message-State: AOAM532kejNrbECFCg1pGeByIFYDZ+e6JfGmWP/pDZzWU0A/Iw4Mexkr
        jrt8ZBSVCsfQ7NJeYmHefQEIQEJkzWogY3XIyyI=
X-Google-Smtp-Source: ABdhPJxsBGIQNKZzHxQk8oqPdmlG3af8A3l8ciIsInAxxCnaweP10DRaknHvPgyXAEXDv60+d1/JCW6F4HQCVabMjxE=
X-Received: by 2002:adf:e181:0:b0:1f7:7d5e:c3bb with SMTP id
 az1-20020adfe181000000b001f77d5ec3bbmr1273025wrb.12.1646863852593; Wed, 09
 Mar 2022 14:10:52 -0800 (PST)
MIME-Version: 1.0
References: <25d93797bd5a5bae5c7613ec42c01ecd7c69cd17.1646855282.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <25d93797bd5a5bae5c7613ec42c01ecd7c69cd17.1646855282.git.christophe.jaillet@wanadoo.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 9 Mar 2022 23:10:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0bwM3fQDGOzRZm09eJ1vgB4ptQxMdo=6XOEfi6B3KTjw@mail.gmail.com>
Message-ID: <CAK8P3a0bwM3fQDGOzRZm09eJ1vgB4ptQxMdo=6XOEfi6B3KTjw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Remove the deprecated "pci-dma-compat.h" API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3Mo/QZCO4GmcfQLv+pAYUPIQ5X+XcR3FmhkrlcYVicXuNVYmoyS
 O7PygsMPHbjRhwkRLoGWCbMAXvIZ28ruxdGL7jxF2SIH/ADy79kHgmltU6SpF11UUHksPrx
 TsGSgaZAFPIiyAaWgLEtSCTLc5CxLI5MFS1XMdfGLSWokDF8bdTtbg6nn4fRgopLZs4NkRM
 GBpFR9CdeYYOcXKE9WNMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bODM39m/7Lg=:PMXFlBnLIeLh4TR1+Hu3wP
 //5GYQ4iZ1h+ORqg3tHlSw9j3GY4psYZYhdiaeUUAHqmEdfxFdqhCFjWys8T40nmDvbtYl8Cl
 lKAg4Ca/sJU1l57iyIrC+l/jWhI4RkG59iC0bkY6STojD8ZEI2lpd9GZs4cYPu/rzQuk9akt0
 h2nsJTZXkLr5RGOqMV+zURG+uI5XebRosXBWoY2gs+XEgXGfepAY4e95U81Ah5wbJ8ueR9dcC
 F8AhabhT551kw9GTAqH8YdioCnhmqg68XqW+tWMOmO9C8iPieXXY1Kx2s25nAHuzxXjGtsgA7
 qwfneqpZn8eFyk8EkwP7rwOPgfFt4MGzBQhaRdM2wBtTUYXh/SgOpXEcS31P208dIzW4ruRhs
 Vm2ZuBFoV34yX7YWSrdiGWWndGUQbDfaBjcjxTd2HGfJ07dyfzskbScA75hDF1NTsujpPSJl6
 5xCkRlRlyKG5cwGzWKaIn3eRqs7uwNXq97QEO0AjTCGzpyoQMAlQR/6cnc9Lc8DA0nJYFquFc
 RtwjtrnD7rpl46QQ4e0oG28866MNtW7ylG2Md9uygTNSigMIGIRcpFxNBsezwd6Yp38vAquGG
 +lzVBhfgmFFqzYaDlxjL3AcYQHkYuL8IANlbQZ8kneLju7OGh+6TFmv0jxdXUd5Dad3hECCUB
 J+Cy54eV7RT6LrKmtCWzl5A1S0EvR58/DC50sgOhDMpMb+bu0jqRA9XmLgzMPMn8Hjuo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 9, 2022 at 8:50 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Now that all usages of the functions defined in "pci-dma-compat.h" have
> been removed, it is time to remove this file as well.
>
> In order not to break builds, move the "#include <linux/dma-mapping.h>"
> that was in "pci-dma-compat.h" into "include/linux/pci.h"
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks a lot for following through with this!

Acked-by: Arnd Bergmann <arnd@arndb.de>
