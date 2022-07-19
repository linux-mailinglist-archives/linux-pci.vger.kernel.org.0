Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD9457A8D0
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 23:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiGSVRC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 17:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGSVRB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 17:17:01 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A390F11468;
        Tue, 19 Jul 2022 14:17:00 -0700 (PDT)
Received: from mail-yb1-f179.google.com ([209.85.219.179]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MmUYD-1nnPTP3b4j-00iXAB; Tue, 19 Jul 2022 23:16:59 +0200
Received: by mail-yb1-f179.google.com with SMTP id r3so28865125ybr.6;
        Tue, 19 Jul 2022 14:16:58 -0700 (PDT)
X-Gm-Message-State: AJIora9N2WV6+1xae8EWvZjKx4IJ6w4qV7Xm9GoTG1qPhDduRxxO2FAm
        XURRs95fLfMP+Fbwa5ILzGWSD6Fb8PQQqq7A8cc=
X-Google-Smtp-Source: AGRyM1sI/ANvRuQzgIGjHCGC9d2EMffjmy1dco5InUp+sZM3+VYXylWgzFcwHl4oDMY2+qh3/s1XYfz1qu0gaJVqYb0=
X-Received: by 2002:a25:808c:0:b0:670:7d94:f2a with SMTP id
 n12-20020a25808c000000b006707d940f2amr6630554ybk.452.1658265417471; Tue, 19
 Jul 2022 14:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <YtVKzW4vh1nRSqbx@debian> <20220719210427.GA1568454@bhelgaas>
In-Reply-To: <20220719210427.GA1568454@bhelgaas>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jul 2022 23:16:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0qcd6pZ=9fGapGexBMifp68jVezQou0QuK9As9vCyfyg@mail.gmail.com>
Message-ID: <CAK8P3a0qcd6pZ=9fGapGexBMifp68jVezQou0QuK9As9vCyfyg@mail.gmail.com>
Subject: Re: build failure of next-20220718 due to 'imx6_pcie_host_exit'
 defined but not used
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
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
X-Provags-ID: V03:K1:VbLSWcUOv35+nG5np387bzI0zv7EGp/wyL+h4pP/h+ic+U1dP6D
 FHVT+e8wtvk0O30fOLIEycVhOrffESmYHnp9SOS2jnECUaFLvBnVVSWl2A3LLms/6b7irwI
 522y918VQlifgZysGo2OmzG3Fb6/3lAVZ26tOoFxp89pAVPB5zA1pjQF1QnW/cJf8GTv35n
 ItHTpYN9CAD/LCODp9hAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IlKh02Tckes=:WTBhEUydwFqbl6LMK/J1TI
 TSpWuERdNXT9KAKQIzwRAP0U4HxFtfV1+ihJ5Gd+DNuj0pQ2N64gO+lLTwCxDB6mGNPEUEN4B
 KGeBpKCz5me1gF1i2bT1iAYGGs2d6HlpVLlJCS42oNezMPdGf4xUIvNWXJOJPuvLOgTSX7Abe
 H5rkzMELh/a5OWjBxVkOwHZhz10eOrEpgeyGitcmxepXKZfr4/dZXjHezCwkqRdy+ux+3SuKQ
 2roni7qfJ2Qe8TbFR+VzaOXQIhlGjMxleScj6Tttha8X1wTQssCrCoB3au6cuqfxQ61L+RVso
 wObbgNtF/tMu0bA6NcEp8JvNXRpA3vlg+W220F+AFAxKZ43VsX55SMuzTjjF1ezw9FIgJAr+h
 CYZpkwfe3u18DvAwcyPIiMKyvYHOSjLilYfeoMMhH2I0vgBj/VSajAeUwl9k66AYyIwa5GiMp
 Y5cb1LlojErkuhAENEf74HhyvNsgbtDtJGWFBjjjI9ZgAu0Nv1eU9MsinvORmalui2uXNqWim
 mR4Dd4ZAi0RYFUHc3hYS5+TOhRRBuliQlubYSihPCmyVVgMVcWEI7JATck9yBLcLGjVHwOqje
 abpeLgtGheSjgs7y3A9m1TXhoP1zgS6yNhcNmxVEfw3TP3jN2SSUhCl5MzVybziwFsOGG/x+V
 8bfUHIlwcGIRwBKzGYv1e8ZjqfGid+3qLrGfuxdFoqVlDT+wQt+JbfITfOHw7XdGW0fH5mPoo
 +GpsJZdme8sIx6uFef0GlSc9kciqZRLIqGC8Q6t43OB3c2TcWMNPx1994bzFjbc/B0AZnqeCs
 WfEwnBsR6KJs38yYQ7zjqsTcuE1YMSI3UHa9pZ8s5cIjKuF5pKQPHO4zDH/dF1URQqD23A+/+
 e2fHCyLWcRnuwhRozPYTjEo9bdyrxHpWNU8s+8oug=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 19, 2022 at 11:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> commit 0e4daeaa52ca ("PCI: imx6: Convert to NOIRQ_SYSTEM_SLEEP_PM_OPS()")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Jul 19 15:50:18 2022 -0500
>
>     PCI: imx6: Convert to NOIRQ_SYSTEM_SLEEP_PM_OPS()
>
>     Replace SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() with NOIRQ_SYSTEM_SLEEP_PM_OPS(),
>     which has the advantage that the compiler always sees the PM callbacks as
>     referenced, so they don't need to be wrapped with "#ifdef CONFIG_PM_SLEEP"
>     or tagged with "__maybe_unused" to avoid "defined but not used" warnings.
>
>     See 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old ones").
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
