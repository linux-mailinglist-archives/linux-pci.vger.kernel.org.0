Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D15579497
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 09:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiGSHwx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 03:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbiGSHww (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 03:52:52 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EF124F09;
        Tue, 19 Jul 2022 00:52:50 -0700 (PDT)
Received: from mail-yb1-f171.google.com ([209.85.219.171]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mqro7-1njJ6O0NxB-00mvkw; Tue, 19 Jul 2022 09:52:49 +0200
Received: by mail-yb1-f171.google.com with SMTP id f73so24955819yba.10;
        Tue, 19 Jul 2022 00:52:48 -0700 (PDT)
X-Gm-Message-State: AJIora9YwrRVjfUYtrlzUtsReG2idz5YbOVa5TkAUBNRn7ijCgNYhmWY
        KJ0STyWO9vcujO6gOFDFiurRBW2gqmStOaRntVA=
X-Google-Smtp-Source: AGRyM1sTlIiHTo89m0UXU/81kSNvZCwD8AnzAHR04IbPkzYG2NpiKx1JKX7ZwnY00TSJqPOcEi7rlTjfiXXFM/MSoSU=
X-Received: by 2002:a25:3b05:0:b0:66e:c216:4da3 with SMTP id
 i5-20020a253b05000000b0066ec2164da3mr32504793yba.550.1658217167726; Tue, 19
 Jul 2022 00:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0MYMbRk1tVmWUBWfnD-1Z5P3fE+DvNycnXaffzqc3htw@mail.gmail.com>
 <20220718161439.GA1419930@bhelgaas>
In-Reply-To: <20220718161439.GA1419930@bhelgaas>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jul 2022 09:52:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a31EeUBRs62=nR2Uj-d9dX2Mcc+fO=wE1nLYh+U1aNFfg@mail.gmail.com>
Message-ID: <CAK8P3a31EeUBRs62=nR2Uj-d9dX2Mcc+fO=wE1nLYh+U1aNFfg@mail.gmail.com>
Subject: Re: build failure of next-20220718 due to 'imx6_pcie_host_exit'
 defined but not used
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NfRZJ2hYJDzu1cOJsVTwCwJStSg+CsJuzGubLMd8N1+RTXgtTMn
 6rsGknIH6fjX06QcWuSkCaQilkuRvXcyC6TO0BPlqskrE6IxjwUgaeX7YqUWSgZrZLQurwj
 HUaCaoVI3P0PETx2HecsDdcj+dK+PH9vZNNk1ShtigW1YBy4paVKlb/hr5qctL/0N1iJC2w
 5Cv56DMd970rCyV0jf8bA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PlyapD2gSRw=:BdJsLc4N7WOIizo1UaNKMc
 GnbdZCSald1oWqSmsOxuWk84wyzZrgyx9S69NMDqM+TYxEcIdRC4DjXZRJrouSLQKHMUkG2Js
 7Bez9P32iMh/myCYSIoxRkVHtJegfNvS3RqXkqdYdFXE0+PeTtWJ4t7kEyn6YYEUimxbFD/0U
 q7ty9Gozf/XGW0J4h93bXPdsP0kBTogdhZNdWDoMt/7U2eWxvqSYs4idvWlA3LE9z+RYozgvK
 Y0b0efYe42ze/NVUMCR3iTV2YZnkx3pAUutzaHMVEsuV770nipVREV6vnOx6NvNB7kXVb9GkS
 5DG0C0rqVrOTLAA0zckVt0J3DFgjXwIy7rAmyODVUdcTAShVfEkJhf9ec986tB2ZdF7rRk/Y7
 By2pvxA2c15pz1Z2dWljdyEMQuZ2VP9C1XkX7G4XVwVrkJ1V5R1+WfFob3Ujo5oi7Vlk94KXC
 DXR71FDsV7aBzx/AVRMCBWwQrxroFWYcVsmrgR8wPNj40j4ghLgH+7Cmr0ckC4Zi5cVxg/kj7
 D1a/e2JL91OismykV+vfSRGrzqWw0AwKLTqSuGC+aeTHAvipNMZhsSIcic40BFfK1HBC9QoFz
 5225UhnbdG93JslZoL3b7pRwh5Jvc5ycnBeQKSCP2DW3SaWR+QI6AVU2SiCl3gaH/iQ5zpqC0
 IDSICjjP7ilfT4Jzmx7y/WNkFqa1jSPcUza6OA0Lc21YhhbhA7lvcytU/cb2nnJJBdhEDER1C
 5sEx3667XoEfwrkemJ7wJOtWJrmtPwh70v1LtrpqkqyVmoHBCnJMXxidwVbfQbIdiRNd98rwH
 toZPw5yhQamimYnIIxzwl+RRSDTRFeOhbUCMcxTzbGgGoxnjAHw5cfbqyAXNVzDIou3IlXzSK
 wDbA/u7OVSD28HtFaHrVAiyWJZ1ir9J9v5o2Fq13E=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 18, 2022 at 6:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Jul 18, 2022 at 02:42:16PM +0200, Arnd Bergmann wrote:
>
> Might be simpler, but wow, it's hard to keep up with all the
> permutations of sleep ops ;)
>
> Unfortunately 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros,
> deprecate old ones"), which added NOIRQ_SYSTEM_SLEEP_PM_OPS, didn't
> add any hints near SET_NOIRQ_SYSTEM_SLEEP_PM_OPS.
>
> We have several PCI controller drivers that use the "#ifdef
> CONFIG_PM_SLEEP" and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS pattern or the
> "__maybe_unused" + SET_NOIRQ_SYSTEM_SLEEP_PM_OPS pattern.  I guess we
> need to look at all of them and figure out the best practice.

Yes, this is a larger effort. It's been under discussion for many years until we
could agree on a nicer way to handle this and avoid both the #ifdef  and the
__maybe_unused annotations. There are hundreds of drivers using the older
patterns, and I think there is an effort to address them one subsystem
at a time,
whenever someone finds the time.

       Arnd
