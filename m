Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57742578289
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 14:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiGRMmi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 08:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbiGRMmh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 08:42:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AF31A068;
        Mon, 18 Jul 2022 05:42:35 -0700 (PDT)
Received: from mail-yb1-f174.google.com ([209.85.219.174]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Ml3ym-1noIWk1QcO-00lVLF; Mon, 18 Jul 2022 14:42:34 +0200
Received: by mail-yb1-f174.google.com with SMTP id 75so20514047ybf.4;
        Mon, 18 Jul 2022 05:42:33 -0700 (PDT)
X-Gm-Message-State: AJIora+Bs2UwQXoBtV6ct8cbngKY6WqL6shi9w4xPPyYH6VwoZN/sbmw
        rltAH+g+YkRbd94JwtFaUI2fqm9fdmlrSd7mFlM=
X-Google-Smtp-Source: AGRyM1sS3ea7c3HilOgs/Nxe1l1twVZnqz2GtJLQRGd0cq1YnLTsC/jtrEpc3UYWeODWD8muMDisZeWXdNvOW2J4vUM=
X-Received: by 2002:a25:3b05:0:b0:66e:c216:4da3 with SMTP id
 i5-20020a253b05000000b0066ec2164da3mr28311420yba.550.1658148152980; Mon, 18
 Jul 2022 05:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <YtVKzW4vh1nRSqbx@debian>
In-Reply-To: <YtVKzW4vh1nRSqbx@debian>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jul 2022 14:42:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0MYMbRk1tVmWUBWfnD-1Z5P3fE+DvNycnXaffzqc3htw@mail.gmail.com>
Message-ID: <CAK8P3a0MYMbRk1tVmWUBWfnD-1Z5P3fE+DvNycnXaffzqc3htw@mail.gmail.com>
Subject: Re: build failure of next-20220718 due to 'imx6_pcie_host_exit'
 defined but not used
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
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
X-Provags-ID: V03:K1:tjloAKR9xLc6+p0Q6Y6zY/oCyyDrm/eBFl1AY0QLATa0AhvVQwH
 2GxoI93nUUQpIQjieuzUE+H49cVK7UFmQ0ezwYeBTNxBD0n1bMqRJe0wyZCCNOKbRTnIo6x
 9m+XTffI+xfuuujlv5/xlrznQ6GcAby6xMnpJNlmY9CPbzXmgoF3wg/BMeopiyAtBaBHt9/
 XBsu33urblo4ed2Z1YGTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JCK6NE6T8VE=:CjfW4h9i966oPuThifeZ3R
 EjxCVZyYaMfaVbPVkxnr1Nr4+p5ggyixcLw2XBM8JbqAKvGzacW4447/5twlQwXPnKLcXSEoz
 G4d4U3/VjWRAUvBUARE3YmeYQHc7Z5VteH0FsD3z4mdzQNqO61hqqOAoiWAaSuGMQgF2ciLX7
 E9Tbq5oq3IYYIsPtFo9YB2KnlOwDqpIDbzSNjDtlJ6WYSFPdWLsZkl+F/oMfLTe5I1i5/tWAa
 OrYWPalDATGjsaZcUPKr7TJy1bKSYR+gDDa8UACC6zl0b/6spgEGqmytVv+AdnDICyLwFA+qH
 kAL8soQMSJdknXKQyfi0DABCPBBMBHRCFeGoBswwKIZ5tVOLlJCD4m4UQ73s5iIrjJbQMK8GT
 ndXaVGKBmwUmke4eDlyVCfNwjm2ySAvXcm1PrMqP7jiWb9D5ikptB6Rdg/N588Z0L7Qxbttfq
 wDiIA0YwEYT0h9hHsbOkv0sAKpv+sRY6ouheP3a8HDuVTB1FXMWG76tsQalwGgADeOMK0WgzV
 S0WHHEl8qrhT1rSFwkxV07EeL/eW8F8tf8A9854AJLlAJy3Of6QETtpuUYxEYstqoxsGr3lbj
 f7fP2uDXs7HynyZwmnq6QksSENr8fDMeHM+tKwOH81TMBx7OTQH5M9vEMf5unNOuX/fH2E+c9
 pATxr0xHc0Y9djJ9SaPGVW+KwKMbB7c4/zfFYeHYsXKxm7HTD3pjErqiuRcbRL0PgoB0Oak1v
 mQUH94xiejcsY9ASLNyJR+Uy9APT/tbFN6jHCt6SnmxCiyBcnxgTc/pRKnnXdbEXO3ykww0qA
 cQdFrmIZlGMIRR7w4FOHIc3+VSY2YIYu5cBvHQlOb3AVjQFW/5fjLSvefNGgkJGcS+JQc6TsS
 kBS09Ec2meKFklxfCodQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 18, 2022 at 1:58 PM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> Not sure if it has been reported, builds of alpha, csky, xtensa, riscv, s390 allmodsconfig
> have failed to build next-20220718 with the error:
>
>
> drivers/pci/controller/dwc/pci-imx6.c:973:13: error: 'imx6_pcie_host_exit' defined but not used [-Werror=unused-function]
>   973 | static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
>       |             ^~~~~~~~~~~~~~~~~~~
> drivers/pci/controller/dwc/pci-imx6.c:904:13: error: 'imx6_pcie_stop_link' defined but not used [-Werror=unused-function]
>   904 | static void imx6_pcie_stop_link(struct dw_pcie *pci)
>       |             ^~~~~~~~~~~~~~~~~~~
>

These are called from inside an "#ifdef CONFIG_PM_SLEEP" section. The best
fix is to remove the #ifdef and replace SET_NOIRQ_SYSTEM_SLEEP_PM_OPS()
with the new simpler NOIRQ_SYSTEM_SLEEP_PM_OPS().

          Arnd
