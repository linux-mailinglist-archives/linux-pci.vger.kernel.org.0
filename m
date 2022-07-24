Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE5657F5DC
	for <lists+linux-pci@lfdr.de>; Sun, 24 Jul 2022 17:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiGXPky convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sun, 24 Jul 2022 11:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiGXPkp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Jul 2022 11:40:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F3312632;
        Sun, 24 Jul 2022 08:40:38 -0700 (PDT)
Received: from mail-yb1-f170.google.com ([209.85.219.170]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MoOty-1nilnZ03B2-00oqRw; Sun, 24 Jul 2022 17:40:37 +0200
Received: by mail-yb1-f170.google.com with SMTP id r3so15910218ybr.6;
        Sun, 24 Jul 2022 08:40:36 -0700 (PDT)
X-Gm-Message-State: AJIora+i4hHfKQZIlHVXPgiRCt1meLOB7y3ILXIm3HES+OcwLXbi5Fis
        HgnzPrLyGXoI6mfafWOzpMC9mBxKu0lyNtLuIQQ=
X-Google-Smtp-Source: AGRyM1uotwQJ4MNCqVQmRM78qeoj4cT0vPQva71LvtJ3obbfvzi2nmqdnG3R8JatFR7uC4ssmpdyYfrUzqipHl/jWsQ=
X-Received: by 2002:a25:8b8b:0:b0:669:b37d:f9cd with SMTP id
 j11-20020a258b8b000000b00669b37df9cdmr6705303ybl.394.1658677235738; Sun, 24
 Jul 2022 08:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220724101353.127875-1-renzhijie2@huawei.com>
In-Reply-To: <20220724101353.127875-1-renzhijie2@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 24 Jul 2022 17:40:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a317gaAjwLhaxbR8bwZW60htG4pV+_DoS8VFkR39yCLMQ@mail.gmail.com>
Message-ID: <CAK8P3a317gaAjwLhaxbR8bwZW60htG4pV+_DoS8VFkR39yCLMQ@mail.gmail.com>
Subject: Re: [PATCH -next] PCI: imx6: Fix build error unused-function
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Uo8D0hHiZkyUSSn3v0+VRrDEdY4mR04SMii+IbI7JNgHHyjAmaT
 VROn2C/YXnoZVkHzKieV02Y3CVmt6eyiXlnhuwrDRs+94CpkcHk7YYQuV+z3NnsTsgGKwXL
 x55nKWQw2dqZVoyNAQXKDgpqPoXBAViulwXwyjYbH8h3vG9I3WHKHd1G7Dla7FAWSSoPTqg
 mBOZXyoYF0LM3GoyDRqHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jocxBtEsL18=:q9wm/86lcMnXWKiCxmhVxe
 8LixcBiwEcyM7VnGmKHrS8tYmOJPcEgbzzJU/5s74BGooG5UcdPZj9Ex8HoZAbi6M+7IVmYTf
 ad6C6kDQlgC4btxbH5eEehuYggAm3qNERVkvUkV38sC7WsbgH+mVvalhIQhPZ2tXVykVai9Zq
 stxvayD8FMlbWlV8YEs2+luX4OYDvEZ4prqTVY1ifwEblW4inszHMtGpx5NjKfekWz1XRcKLm
 K7gt68+2L7DY0BxoxsxBP93A7uGQ11sJ8hJRM8GagNHVQsgxJTYYH4t9fr+N4cZQv7XxnV9o9
 sSMgjc1hygyW+Fz3kWAWG4p9OqLscYRUK9Dpkog0vB9yDg9o3M3vKUyXWK+cRHGAxkOLP6TdO
 cUCiKNO7YWCpHWyFPo+EDk1eWQROWorXaTfZh3CZ8TEhpg/cuJqm9NP4x0XcN78xmh4NGQSfw
 5lUBonJZu04msWtGt/bq8irkhbLsCJNl11na/Db0VWAFe0mmaEroSAEaZMK064CLb26zR4HJn
 JR47TcQhDrBkgOCPl5JFxnMRBM1LCtPm5FNpcmxhHOwY8tL2P4SGzJE12DCV0FKAqGIOo0m47
 MOJ0g2wGE352r2OYfHSYqkjt1JxYwgw0osJroTd14IbIihnvcmvVlkunSomX3tYJfxQT+uI5r
 nUCtOSPYvHFu03xVnTCVV06mzrDzX3XN2WwbCDTk4jVdFHIdJ4pdiy6jY9ukrJRR+Oe8uhPJm
 hP3HOUiDzvYX/vSzSmCMzZ6AgCK7jXCtGH36tg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jul 24, 2022 at 12:13 PM Ren Zhijie <renzhijie2@huawei.com> wrote:
>
> If CONFIG_PM_SLEEP is not set,
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-, will be failed, like this:
>
> drivers/pci/controller/dwc/pci-imx6.c:973:13: error: ‘imx6_pcie_host_exit’ defined but not used [-Werror=unused-function]
>  static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
>              ^~~~~~~~~~~~~~~~~~~
> drivers/pci/controller/dwc/pci-imx6.c:904:13: error: ‘imx6_pcie_stop_link’ defined but not used [-Werror=unused-function]
>  static void imx6_pcie_stop_link(struct dw_pcie *pci)
>              ^~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[4]: *** [drivers/pci/controller/dwc/pci-imx6.o] Error 1
>
> These two functions imx6_pcie_host_exit() and imx6_pcie_stop_link() only be called by imx6_pcie_suspend_noirq(), which was warpped by CONFIG_PM_SLEEP.
> To fix build error unused-function, use __maybe_unused to attach them.
>
> Fixes: 25ae5434c3de ("PCI: imx6: Reformat suspend callback to keep symmetric with resume")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>

There is already a better fix for this, see
https://lore.kernel.org/all/20220719210427.GA1568454@bhelgaas/

If you come across other suspend/resume functions that trigger the
unused-function
warning, please use the same method there instead of adding __maybe_unused
or #ifdef annotations.

      Arnd
