Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E12519002
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 23:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbiECVXj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 17:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiECVXi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 17:23:38 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF4140918;
        Tue,  3 May 2022 14:20:03 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id k25-20020a056830169900b00605f215e55dso9123463otr.13;
        Tue, 03 May 2022 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dx5XsBT6PARbrle2xEtaM8IpH1XBV5e8ywqS1he24jU=;
        b=gtxC8WR/kasXgYsFv0Qkulgc/+UE91je4Y/EPRnVr/T+mKTIxEq1FGrfS58NhwWe4H
         FrGBOOoiUlkOoTvZ9P+YynWhMlcjbOAmF6ztgwnO2dUkLxc4qYckeL9f/tGAE7tcLx5k
         gAwcCQUf0czCX5wABCdWVnqZWr2XvFhffJnF7abxDngn5wa6xNgUgQJYXpB+SWKBriyt
         BjZHR1km7qx8J3cBvt7iTPqwnAMgRE0rdH1hdaXlsIeZf48rrth04v8HhtLyNnyrjE+L
         j7LtzXLjJQ186RW4g1y4Y2tX490Op3G5/2ykic6Gi1WxFd434MDvx/ftFqtZH4GDOdza
         nZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dx5XsBT6PARbrle2xEtaM8IpH1XBV5e8ywqS1he24jU=;
        b=xMvIe3pgDxqSNYC5E1Q3HAv6Zvmm/n27BZcev45mayy3mGUd3kvAyboupXdOhe9SnC
         s6hYOiDI7bRZlWO7nPzIQ2KIYQUb79HjMp2k23wB4E9/z92BF91MN/L3gCSdJIXH8l2d
         Tt+zWEjCXDwuwOYvcpxEpbzFdYgnRr65nNwHxaHwj9/5508sWPfX1mXCI3LS7yZ5lNsL
         CDbn5aw6+oIBhvcxIJoOHNvCVKbuxTvSi6IYjjH/ew5/kMssJH7hp1AJl4+XFxRlDHwg
         q6E6SHrbiqVuel4sbVnDcIc/aVzuGtOMrxQ4y5AQDdQwcW7TO+Iru40s+26WFE2rwKJ2
         C3Jg==
X-Gm-Message-State: AOAM533UlTrRmX0U56mKkGf/4uHHVspp3J26J600sWghC6qk3jnwyZwn
        d+AipVDxyFtngwBeksj+hXA=
X-Google-Smtp-Source: ABdhPJytVRRwWewEMG1iJJK/tffrl0KtmSMqfmxy1U94mS9ssLH0ceD9XJVxWiPd6r+4IHQF4wZjjA==
X-Received: by 2002:a05:6830:1613:b0:605:e75c:52d0 with SMTP id g19-20020a056830161300b00605e75c52d0mr6249096otr.378.1651612802222;
        Tue, 03 May 2022 14:20:02 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:253a:a0c9:3eee:7e0d])
        by smtp.gmail.com with ESMTPSA id t13-20020a05683014cd00b0060603221245sm4393769otq.21.2022.05.03.14.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 14:20:01 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com, Tim Harvey <tharvey@gateworks.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>, monstr@monstr.eu,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 1/1] of: overlay: rename overlay source files from .dts to .dtso
Date:   Tue,  3 May 2022 16:19:54 -0500
Message-Id: <20220503211954.1428919-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

In drivers/of/unittest-data/:
   - Rename .dts overlay source files to use .dtso suffix.
   - Add Makefile rule to build .dtbo.o assembly file from overlay
     .dtso source file.
   - Update Makefile to build .dtbo.o objects instead of .dtb.o from
     unittest overlay source files.

Modify driver/of/unitest.c to use .dtbo.o based symbols instead of
.dtb.o

Modify scripts/Makefile.lib %.dtbo rule to depend upon %.dtso instead
of %.dts

Rename .dts overlay source files to use .dtso suffix in:
   arch/arm64/boot/dts/freescale/
   arch/arm64/boot/dts/xilinx/

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Testing by arm64 people would be much appreciated.

Applies on branch dt/next, commit 4fb74186cee8 of Rob's kernel.org tree.
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux

version 1 patch:
   https://lore.kernel.org/r/20210324223713.1334666-1-frowand.list@gmail.com

changes from version 1:
   - rebase to 5.18-rc1 plus many patches already accepted by Rob
     Applies on branch dt/next, commit 4fb74186cee8 of Rob's kernel.org tree.
   - Add new overlay source files in:
      arch/arm64/boot/dts/freescale/
      arch/arm64/boot/dts/xilinx/
   - Do not delete overlay documentation file

 ...qds-13bb.dts => fsl-ls1028a-qds-13bb.dtso} |  0
 ...qds-65bb.dts => fsl-ls1028a-qds-65bb.dtso} |  0
 ...qds-7777.dts => fsl-ls1028a-qds-7777.dtso} |  0
 ...qds-85bb.dts => fsl-ls1028a-qds-85bb.dtso} |  0
 ...qds-899b.dts => fsl-ls1028a-qds-899b.dtso} |  0
 ...qds-9999.dts => fsl-ls1028a-qds-9999.dtso} |  0
 ...ts => imx8mm-venice-gw72xx-0x-imx219.dtso} |  0
 ...=> imx8mm-venice-gw72xx-0x-rs232-rts.dtso} |  0
 ...dts => imx8mm-venice-gw72xx-0x-rs422.dtso} |  0
 ...dts => imx8mm-venice-gw72xx-0x-rs485.dtso} |  0
 ...ts => imx8mm-venice-gw73xx-0x-imx219.dtso} |  0
 ...=> imx8mm-venice-gw73xx-0x-rs232-rts.dtso} |  0
 ...dts => imx8mm-venice-gw73xx-0x-rs422.dtso} |  0
 ...dts => imx8mm-venice-gw73xx-0x-rs485.dtso} |  0
 ...v-g-revA.dts => zynqmp-sck-kv-g-revA.dtso} |  0
 ...v-g-revB.dts => zynqmp-sck-kv-g-revB.dtso} |  0
 drivers/of/unittest-data/Makefile             | 86 ++++++++++++-------
 .../{overlay.dts => overlay.dtso}             |  0
 .../{overlay_0.dts => overlay_0.dtso}         |  0
 .../{overlay_1.dts => overlay_1.dtso}         |  0
 .../{overlay_10.dts => overlay_10.dtso}       |  0
 .../{overlay_11.dts => overlay_11.dtso}       |  0
 .../{overlay_12.dts => overlay_12.dtso}       |  0
 .../{overlay_13.dts => overlay_13.dtso}       |  0
 .../{overlay_15.dts => overlay_15.dtso}       |  0
 .../{overlay_16.dts => overlay_16.dtso}       |  0
 .../{overlay_17.dts => overlay_17.dtso}       |  0
 .../{overlay_18.dts => overlay_18.dtso}       |  0
 .../{overlay_19.dts => overlay_19.dtso}       |  0
 .../{overlay_2.dts => overlay_2.dtso}         |  0
 .../{overlay_20.dts => overlay_20.dtso}       |  0
 .../{overlay_3.dts => overlay_3.dtso}         |  0
 .../{overlay_4.dts => overlay_4.dtso}         |  0
 .../{overlay_5.dts => overlay_5.dtso}         |  0
 .../{overlay_6.dts => overlay_6.dtso}         |  0
 .../{overlay_7.dts => overlay_7.dtso}         |  0
 .../{overlay_8.dts => overlay_8.dtso}         |  0
 .../{overlay_9.dts => overlay_9.dtso}         |  0
 ...node.dts => overlay_bad_add_dup_node.dtso} |  0
 ...prop.dts => overlay_bad_add_dup_prop.dtso} |  0
 ...d_phandle.dts => overlay_bad_phandle.dtso} |  0
 ...bad_symbol.dts => overlay_bad_symbol.dtso} |  0
 .../{overlay_base.dts => overlay_base.dtso}   |  0
 ...erlay_gpio_01.dts => overlay_gpio_01.dtso} |  0
 ...lay_gpio_02a.dts => overlay_gpio_02a.dtso} |  0
 ...lay_gpio_02b.dts => overlay_gpio_02b.dtso} |  0
 ...erlay_gpio_03.dts => overlay_gpio_03.dtso} |  0
 ...lay_gpio_04a.dts => overlay_gpio_04a.dtso} |  0
 ...lay_gpio_04b.dts => overlay_gpio_04b.dtso} |  0
 .../{static_base_1.dts => static_base_1.dtso} |  0
 .../{static_base_2.dts => static_base_2.dtso} |  0
 .../{testcases.dts => testcases.dtso}         |  0
 drivers/of/unittest.c                         | 48 +++++------
 scripts/Makefile.lib                          |  2 +-
 54 files changed, 78 insertions(+), 58 deletions(-)
 rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-13bb.dts => fsl-ls1028a-qds-13bb.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-65bb.dts => fsl-ls1028a-qds-65bb.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-7777.dts => fsl-ls1028a-qds-7777.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-85bb.dts => fsl-ls1028a-qds-85bb.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-899b.dts => fsl-ls1028a-qds-899b.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-9999.dts => fsl-ls1028a-qds-9999.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw72xx-0x-imx219.dts => imx8mm-venice-gw72xx-0x-imx219.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw72xx-0x-rs232-rts.dts => imx8mm-venice-gw72xx-0x-rs232-rts.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw72xx-0x-rs422.dts => imx8mm-venice-gw72xx-0x-rs422.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw72xx-0x-rs485.dts => imx8mm-venice-gw72xx-0x-rs485.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw73xx-0x-imx219.dts => imx8mm-venice-gw73xx-0x-imx219.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw73xx-0x-rs232-rts.dts => imx8mm-venice-gw73xx-0x-rs232-rts.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw73xx-0x-rs422.dts => imx8mm-venice-gw73xx-0x-rs422.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw73xx-0x-rs485.dts => imx8mm-venice-gw73xx-0x-rs485.dtso} (100%)
 rename arch/arm64/boot/dts/xilinx/{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso} (100%)
 rename arch/arm64/boot/dts/xilinx/{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso} (100%)
 rename drivers/of/unittest-data/{overlay.dts => overlay.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_0.dts => overlay_0.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_1.dts => overlay_1.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_10.dts => overlay_10.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_11.dts => overlay_11.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_12.dts => overlay_12.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_13.dts => overlay_13.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_15.dts => overlay_15.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_16.dts => overlay_16.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_17.dts => overlay_17.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_18.dts => overlay_18.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_19.dts => overlay_19.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_2.dts => overlay_2.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_20.dts => overlay_20.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_3.dts => overlay_3.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_4.dts => overlay_4.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_5.dts => overlay_5.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_6.dts => overlay_6.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_7.dts => overlay_7.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_8.dts => overlay_8.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_9.dts => overlay_9.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_bad_add_dup_node.dts => overlay_bad_add_dup_node.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_bad_add_dup_prop.dts => overlay_bad_add_dup_prop.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_bad_phandle.dts => overlay_bad_phandle.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_bad_symbol.dts => overlay_bad_symbol.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_base.dts => overlay_base.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_01.dts => overlay_gpio_01.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_02a.dts => overlay_gpio_02a.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_02b.dts => overlay_gpio_02b.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_03.dts => overlay_gpio_03.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_04a.dts => overlay_gpio_04a.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_04b.dts => overlay_gpio_04b.dtso} (100%)
 rename drivers/of/unittest-data/{static_base_1.dts => static_base_1.dtso} (100%)
 rename drivers/of/unittest-data/{static_base_2.dts => static_base_2.dtso} (100%)
 rename drivers/of/unittest-data/{testcases.dts => testcases.dtso} (100%)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dts
rename to arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dts
rename to arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dtso
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dts
rename to arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dtso
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dts
rename to arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dtso
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dts
rename to arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dtso
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts
rename to arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
similarity index 100%
rename from arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
rename to arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
similarity index 100%
rename from arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
rename to arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index d072f3ba3971..df2ca1820273 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -1,38 +1,58 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y += testcases.dtb.o
 
-obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
-			    overlay_0.dtb.o \
-			    overlay_1.dtb.o \
-			    overlay_2.dtb.o \
-			    overlay_3.dtb.o \
-			    overlay_4.dtb.o \
-			    overlay_5.dtb.o \
-			    overlay_6.dtb.o \
-			    overlay_7.dtb.o \
-			    overlay_8.dtb.o \
-			    overlay_9.dtb.o \
-			    overlay_10.dtb.o \
-			    overlay_11.dtb.o \
-			    overlay_12.dtb.o \
-			    overlay_13.dtb.o \
-			    overlay_15.dtb.o \
-			    overlay_16.dtb.o \
-			    overlay_17.dtb.o \
-			    overlay_18.dtb.o \
-			    overlay_19.dtb.o \
-			    overlay_20.dtb.o \
-			    overlay_bad_add_dup_node.dtb.o \
-			    overlay_bad_add_dup_prop.dtb.o \
-			    overlay_bad_phandle.dtb.o \
-			    overlay_bad_symbol.dtb.o \
-			    overlay_base.dtb.o \
-			    overlay_gpio_01.dtb.o \
-			    overlay_gpio_02a.dtb.o \
-			    overlay_gpio_02b.dtb.o \
-			    overlay_gpio_03.dtb.o \
-			    overlay_gpio_04a.dtb.o \
-			    overlay_gpio_04b.dtb.o
+# Generate an assembly file to wrap the output of the device tree compiler
+quiet_cmd_dt_S_dtbo= DTB     $@
+cmd_dt_S_dtbo=\
+{							\
+	echo '\#include <asm-generic/vmlinux.lds.h>';	\
+	echo '.section .dtb.init.rodata,"a"';		\
+	echo '.balign STRUCT_ALIGNMENT';		\
+	echo '.global __dtbo_$(subst -,_,$(*F))_begin';	\
+	echo '__dtbo_$(subst -,_,$(*F))_begin:';	\
+	echo '.incbin "$<" ';				\
+	echo '__dtbo_$(subst -,_,$(*F))_end:';		\
+	echo '.global __dtbo_$(subst -,_,$(*F))_end';	\
+	echo '.balign STRUCT_ALIGNMENT';		\
+} > $@
+
+
+$(obj)/%.dtbo.S: $(obj)/%.dtbo FORCE
+	$(call if_changed,dt_S_dtbo)
+
+obj-y += testcases.dtbo.o
+
+obj-$(CONFIG_OF_OVERLAY) += overlay.dtbo.o \
+			    overlay_0.dtbo.o \
+			    overlay_1.dtbo.o \
+			    overlay_2.dtbo.o \
+			    overlay_3.dtbo.o \
+			    overlay_4.dtbo.o \
+			    overlay_5.dtbo.o \
+			    overlay_6.dtbo.o \
+			    overlay_7.dtbo.o \
+			    overlay_8.dtbo.o \
+			    overlay_9.dtbo.o \
+			    overlay_10.dtbo.o \
+			    overlay_11.dtbo.o \
+			    overlay_12.dtbo.o \
+			    overlay_13.dtbo.o \
+			    overlay_15.dtbo.o \
+			    overlay_16.dtbo.o \
+			    overlay_17.dtbo.o \
+			    overlay_18.dtbo.o \
+			    overlay_19.dtbo.o \
+			    overlay_20.dtbo.o \
+			    overlay_bad_add_dup_node.dtbo.o \
+			    overlay_bad_add_dup_prop.dtbo.o \
+			    overlay_bad_phandle.dtbo.o \
+			    overlay_bad_symbol.dtbo.o \
+			    overlay_base.dtbo.o \
+			    overlay_gpio_01.dtbo.o \
+			    overlay_gpio_02a.dtbo.o \
+			    overlay_gpio_02b.dtbo.o \
+			    overlay_gpio_03.dtbo.o \
+			    overlay_gpio_04a.dtbo.o \
+			    overlay_gpio_04b.dtbo.o
 
 # enable creation of __symbols__ node
 DTC_FLAGS_overlay += -@
diff --git a/drivers/of/unittest-data/overlay.dts b/drivers/of/unittest-data/overlay.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay.dts
rename to drivers/of/unittest-data/overlay.dtso
diff --git a/drivers/of/unittest-data/overlay_0.dts b/drivers/of/unittest-data/overlay_0.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_0.dts
rename to drivers/of/unittest-data/overlay_0.dtso
diff --git a/drivers/of/unittest-data/overlay_1.dts b/drivers/of/unittest-data/overlay_1.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_1.dts
rename to drivers/of/unittest-data/overlay_1.dtso
diff --git a/drivers/of/unittest-data/overlay_10.dts b/drivers/of/unittest-data/overlay_10.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_10.dts
rename to drivers/of/unittest-data/overlay_10.dtso
diff --git a/drivers/of/unittest-data/overlay_11.dts b/drivers/of/unittest-data/overlay_11.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_11.dts
rename to drivers/of/unittest-data/overlay_11.dtso
diff --git a/drivers/of/unittest-data/overlay_12.dts b/drivers/of/unittest-data/overlay_12.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_12.dts
rename to drivers/of/unittest-data/overlay_12.dtso
diff --git a/drivers/of/unittest-data/overlay_13.dts b/drivers/of/unittest-data/overlay_13.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_13.dts
rename to drivers/of/unittest-data/overlay_13.dtso
diff --git a/drivers/of/unittest-data/overlay_15.dts b/drivers/of/unittest-data/overlay_15.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_15.dts
rename to drivers/of/unittest-data/overlay_15.dtso
diff --git a/drivers/of/unittest-data/overlay_16.dts b/drivers/of/unittest-data/overlay_16.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_16.dts
rename to drivers/of/unittest-data/overlay_16.dtso
diff --git a/drivers/of/unittest-data/overlay_17.dts b/drivers/of/unittest-data/overlay_17.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_17.dts
rename to drivers/of/unittest-data/overlay_17.dtso
diff --git a/drivers/of/unittest-data/overlay_18.dts b/drivers/of/unittest-data/overlay_18.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_18.dts
rename to drivers/of/unittest-data/overlay_18.dtso
diff --git a/drivers/of/unittest-data/overlay_19.dts b/drivers/of/unittest-data/overlay_19.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_19.dts
rename to drivers/of/unittest-data/overlay_19.dtso
diff --git a/drivers/of/unittest-data/overlay_2.dts b/drivers/of/unittest-data/overlay_2.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_2.dts
rename to drivers/of/unittest-data/overlay_2.dtso
diff --git a/drivers/of/unittest-data/overlay_20.dts b/drivers/of/unittest-data/overlay_20.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_20.dts
rename to drivers/of/unittest-data/overlay_20.dtso
diff --git a/drivers/of/unittest-data/overlay_3.dts b/drivers/of/unittest-data/overlay_3.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_3.dts
rename to drivers/of/unittest-data/overlay_3.dtso
diff --git a/drivers/of/unittest-data/overlay_4.dts b/drivers/of/unittest-data/overlay_4.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_4.dts
rename to drivers/of/unittest-data/overlay_4.dtso
diff --git a/drivers/of/unittest-data/overlay_5.dts b/drivers/of/unittest-data/overlay_5.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_5.dts
rename to drivers/of/unittest-data/overlay_5.dtso
diff --git a/drivers/of/unittest-data/overlay_6.dts b/drivers/of/unittest-data/overlay_6.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_6.dts
rename to drivers/of/unittest-data/overlay_6.dtso
diff --git a/drivers/of/unittest-data/overlay_7.dts b/drivers/of/unittest-data/overlay_7.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_7.dts
rename to drivers/of/unittest-data/overlay_7.dtso
diff --git a/drivers/of/unittest-data/overlay_8.dts b/drivers/of/unittest-data/overlay_8.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_8.dts
rename to drivers/of/unittest-data/overlay_8.dtso
diff --git a/drivers/of/unittest-data/overlay_9.dts b/drivers/of/unittest-data/overlay_9.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_9.dts
rename to drivers/of/unittest-data/overlay_9.dtso
diff --git a/drivers/of/unittest-data/overlay_bad_add_dup_node.dts b/drivers/of/unittest-data/overlay_bad_add_dup_node.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_bad_add_dup_node.dts
rename to drivers/of/unittest-data/overlay_bad_add_dup_node.dtso
diff --git a/drivers/of/unittest-data/overlay_bad_add_dup_prop.dts b/drivers/of/unittest-data/overlay_bad_add_dup_prop.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
rename to drivers/of/unittest-data/overlay_bad_add_dup_prop.dtso
diff --git a/drivers/of/unittest-data/overlay_bad_phandle.dts b/drivers/of/unittest-data/overlay_bad_phandle.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_bad_phandle.dts
rename to drivers/of/unittest-data/overlay_bad_phandle.dtso
diff --git a/drivers/of/unittest-data/overlay_bad_symbol.dts b/drivers/of/unittest-data/overlay_bad_symbol.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_bad_symbol.dts
rename to drivers/of/unittest-data/overlay_bad_symbol.dtso
diff --git a/drivers/of/unittest-data/overlay_base.dts b/drivers/of/unittest-data/overlay_base.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_base.dts
rename to drivers/of/unittest-data/overlay_base.dtso
diff --git a/drivers/of/unittest-data/overlay_gpio_01.dts b/drivers/of/unittest-data/overlay_gpio_01.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_gpio_01.dts
rename to drivers/of/unittest-data/overlay_gpio_01.dtso
diff --git a/drivers/of/unittest-data/overlay_gpio_02a.dts b/drivers/of/unittest-data/overlay_gpio_02a.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_gpio_02a.dts
rename to drivers/of/unittest-data/overlay_gpio_02a.dtso
diff --git a/drivers/of/unittest-data/overlay_gpio_02b.dts b/drivers/of/unittest-data/overlay_gpio_02b.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_gpio_02b.dts
rename to drivers/of/unittest-data/overlay_gpio_02b.dtso
diff --git a/drivers/of/unittest-data/overlay_gpio_03.dts b/drivers/of/unittest-data/overlay_gpio_03.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_gpio_03.dts
rename to drivers/of/unittest-data/overlay_gpio_03.dtso
diff --git a/drivers/of/unittest-data/overlay_gpio_04a.dts b/drivers/of/unittest-data/overlay_gpio_04a.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_gpio_04a.dts
rename to drivers/of/unittest-data/overlay_gpio_04a.dtso
diff --git a/drivers/of/unittest-data/overlay_gpio_04b.dts b/drivers/of/unittest-data/overlay_gpio_04b.dtso
similarity index 100%
rename from drivers/of/unittest-data/overlay_gpio_04b.dts
rename to drivers/of/unittest-data/overlay_gpio_04b.dtso
diff --git a/drivers/of/unittest-data/static_base_1.dts b/drivers/of/unittest-data/static_base_1.dtso
similarity index 100%
rename from drivers/of/unittest-data/static_base_1.dts
rename to drivers/of/unittest-data/static_base_1.dtso
diff --git a/drivers/of/unittest-data/static_base_2.dts b/drivers/of/unittest-data/static_base_2.dtso
similarity index 100%
rename from drivers/of/unittest-data/static_base_2.dts
rename to drivers/of/unittest-data/static_base_2.dtso
diff --git a/drivers/of/unittest-data/testcases.dts b/drivers/of/unittest-data/testcases.dtso
similarity index 100%
rename from drivers/of/unittest-data/testcases.dts
rename to drivers/of/unittest-data/testcases.dtso
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index dff55ae09d97..1d3c170d95db 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1423,12 +1423,12 @@ static int __init unittest_data_add(void)
 	void *unittest_data_align;
 	struct device_node *unittest_data_node = NULL, *np;
 	/*
-	 * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
-	 * created by cmd_dt_S_dtb in scripts/Makefile.lib
+	 * __dtbo_testcases_begin[] and __dtbo_testcases_end[] are
+	 * created by cmd_dt_S_dtbo in Makefile
 	 */
-	extern uint8_t __dtb_testcases_begin[];
-	extern uint8_t __dtb_testcases_end[];
-	const int size = __dtb_testcases_end - __dtb_testcases_begin;
+	extern uint8_t __dtbo_testcases_begin[];
+	extern uint8_t __dtbo_testcases_end[];
+	const int size = __dtbo_testcases_end - __dtbo_testcases_begin;
 	int rc;
 	void *ret;
 
@@ -1443,7 +1443,7 @@ static int __init unittest_data_add(void)
 		return -ENOMEM;
 
 	unittest_data_align = PTR_ALIGN(unittest_data, FDT_ALIGN_SIZE);
-	memcpy(unittest_data_align, __dtb_testcases_begin, size);
+	memcpy(unittest_data_align, __dtbo_testcases_begin, size);
 
 	ret = of_fdt_unflatten_tree(unittest_data_align, NULL, &unittest_data_node);
 	if (!ret) {
@@ -3009,24 +3009,24 @@ static inline void __init of_unittest_overlay(void) { }
 #ifdef CONFIG_OF_OVERLAY
 
 /*
- * __dtb_ot_begin[] and __dtb_ot_end[] are created by cmd_dt_S_dtb
- * in scripts/Makefile.lib
+ * __dtbo_##overlay_name##_begin[] and __dtbo_##overlay_name##_end[] are
+ * created by cmd_dt_S_dtbo in Makefile
  */
 
-#define OVERLAY_INFO_EXTERN(name) \
-	extern uint8_t __dtb_##name##_begin[]; \
-	extern uint8_t __dtb_##name##_end[]
+#define OVERLAY_INFO_EXTERN(overlay_name) \
+	extern uint8_t __dtbo_##overlay_name##_begin[]; \
+	extern uint8_t __dtbo_##overlay_name##_end[]
 
-#define OVERLAY_INFO(overlay_name, expected)             \
-{	.dtb_begin       = __dtb_##overlay_name##_begin, \
-	.dtb_end         = __dtb_##overlay_name##_end,   \
-	.expected_result = expected,                     \
-	.name            = #overlay_name,                \
+#define OVERLAY_INFO(overlay_name, expected)               \
+{	.dtbo_begin       = __dtbo_##overlay_name##_begin, \
+	.dtbo_end         = __dtbo_##overlay_name##_end,   \
+	.expected_result = expected,                       \
+	.name            = #overlay_name,                  \
 }
 
 struct overlay_info {
-	uint8_t		*dtb_begin;
-	uint8_t		*dtb_end;
+	uint8_t		*dtbo_begin;
+	uint8_t		*dtbo_end;
 	int		expected_result;
 	int		ovcs_id;
 	char		*name;
@@ -3100,7 +3100,7 @@ static struct overlay_info overlays[] = {
 	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
 	OVERLAY_INFO(overlay_bad_symbol, -EINVAL),
 	/* end marker */
-	{.dtb_begin = NULL, .dtb_end = NULL, .expected_result = 0, .name = NULL}
+	{.dtbo_begin = NULL, .dtbo_end = NULL, .expected_result = 0, .name = NULL}
 };
 
 static struct device_node *overlay_base_root;
@@ -3157,13 +3157,13 @@ void __init unittest_unflatten_overlay_base(void)
 		return;
 	}
 
-	data_size = info->dtb_end - info->dtb_begin;
+	data_size = info->dtbo_end - info->dtbo_begin;
 	if (!data_size) {
 		pr_err("No dtb 'overlay_base' to attach\n");
 		return;
 	}
 
-	size = fdt_totalsize(info->dtb_begin);
+	size = fdt_totalsize(info->dtbo_begin);
 	if (size != data_size) {
 		pr_err("dtb 'overlay_base' header totalsize != actual size");
 		return;
@@ -3175,7 +3175,7 @@ void __init unittest_unflatten_overlay_base(void)
 		return;
 	}
 
-	memcpy(new_fdt, info->dtb_begin, size);
+	memcpy(new_fdt, info->dtbo_begin, size);
 
 	__unflatten_device_tree(new_fdt, NULL, &overlay_base_root,
 				dt_alloc_memory, true);
@@ -3210,11 +3210,11 @@ static int __init overlay_data_apply(const char *overlay_name, int *ovcs_id)
 		return 0;
 	}
 
-	size = info->dtb_end - info->dtb_begin;
+	size = info->dtbo_end - info->dtbo_begin;
 	if (!size)
 		pr_err("no overlay data for %s\n", overlay_name);
 
-	ret = of_overlay_fdt_apply(info->dtb_begin, size, &info->ovcs_id);
+	ret = of_overlay_fdt_apply(info->dtbo_begin, size, &info->ovcs_id);
 	if (ovcs_id)
 		*ovcs_id = info->ovcs_id;
 	if (ret < 0)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 9f69ecdd7977..b409bec5fa45 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -363,7 +363,7 @@ endef
 $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
 	$(call if_changed_rule,dtc)
 
-$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
+$(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
 	$(call if_changed_dep,dtc)
 
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
-- 
Frank Rowand <frank.rowand@sony.com>

