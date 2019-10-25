Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D558E53D1
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 20:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfJYSes (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 14:34:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40523 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfJYSer (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2019 14:34:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id d8so2712316otc.7;
        Fri, 25 Oct 2019 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hm0Ccb1XcBEqHioOFaaTuXW5eigKyCxSRPKBPo0oEsg=;
        b=GUO0P0MbwPYsH7pOQeoo76LGvuOW+bdYbTpUysx8kCjr+s8sXWH7PMWDrPg99dkcUP
         SqUqbxxU2iUnJLr+c4tUPmUUOXTBVWg9Y08E3Bacf2F3i6M9CB3mpe1OphNgnznUCVJ2
         V1gs8n+kCd1Ogl6pMRNbz7F/iXSj9hngfu0IvXFvM2zLfoEpjNpndQqoZvhPwfIRSR/g
         35FvpkMTcnsNveY4tYAwfgqxIBJmjqeZu2yRDKM+qPwhxSIfAMFaBXz1JcULTnYQ+AuX
         e5oMtcEP9P8k9/54PqBajFvYnMzCp83aq34tbdzI2qjGySVBxlRpPpFc4cI9r8wz7mBw
         UFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hm0Ccb1XcBEqHioOFaaTuXW5eigKyCxSRPKBPo0oEsg=;
        b=T4Ys8CI41WfgOHXgF/UgIqGCzSGnbEsGaR+AyHfB8bmE8TdwGRjnCNlX/66wX5/92q
         hzgAL0vZqt+5nlJj+5u1SeulipAoP1uUmCA15O894ckvX2N651oio9WHfUMTzOATkz1y
         ku29vcn68tLpWZn/awpYak7Fp5PLJujw8n7sCoGosNUXh/w+G+lBeGco2UbuEoA1xego
         GnhKs3QEKAfGPM9JS5KKCDxgF135xL4BYosBQqaXAdlrUM8u4p+OLBqO2Hcl+37tqj2f
         /58Q9AoWGlwJQwmNSFmCCjcsNGhRwPQSv5OePjlp/6sue6C07/jdpKq1eqvW48eLvjVY
         yqMQ==
X-Gm-Message-State: APjAAAWKFWKK7C1RObVLcSSepiv1jeyUgVRwDiYIoCvK/pwHm1NJhAQA
        qdmArXBYUjCFTo+0cVzl1LuSqJ8hybJrxN1vQOE=
X-Google-Smtp-Source: APXvYqwSdEI5b98EZSpcZbM2XjLim2W5AMxG02Aa++qPslKTu5llRoR7fXpW/ObA4+9MveRby0LGGWWJ+fP525og8Rg=
X-Received: by 2002:a9d:6c56:: with SMTP id g22mr3746628otq.89.1572028484057;
 Fri, 25 Oct 2019 11:34:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:648:0:0:0:0:0 with HTTP; Fri, 25 Oct 2019 11:34:42 -0700 (PDT)
In-Reply-To: <20191025075536.GA14531@owl.dominikbrodowski.net>
References: <20191020090800.GA2778@light.dominikbrodowski.net>
 <20191021160952.GA229204@google.com> <CAFjuqNg2BjbxsOeOpoo8FQRwatQHeHKhj01hbwNrSHjz9p3vYw@mail.gmail.com>
 <20191021184701.GA1823@light.dominikbrodowski.net> <CAFjuqNiyS4cd=YEFvn3tLkp5zSPbO2vj8JfHsymUuDyEmLydUA@mail.gmail.com>
 <CAFjuqNg8_G-B5Owz1NBxa-nw620hXwcn9WkE4sfETVR81MWatA@mail.gmail.com>
 <CAFjuqNiToDC9BSJVdahdkPz8Ejb-rM3VRkyoBNUTJr8go=7zrg@mail.gmail.com> <20191025075536.GA14531@owl.dominikbrodowski.net>
From:   "Michael ." <keltoiboy@gmail.com>
Date:   Sat, 26 Oct 2019 05:34:42 +1100
Message-ID: <CAFjuqNit=Uf-q4hqgD88O5cxXaBNpXBkUP6nRnOUcSV+JwMB5Q@mail.gmail.com>
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not working
 on Panasonic Toughbook CF-29]
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>,
        Morgan Klym <moklym@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dominik
Thanks for your continued help. I used the file you attached and tried
a compile on 4.19.80 here is the outout of the failure
  CC [M]  drivers/net/wireless/marvell/mwifiex/uap_txrx.o
  CC [M]  drivers/net/wireless/marvell/mwifiex/cfg80211.o
  CC [M]  drivers/net/wireless/marvell/mwifiex/ethtool.o
  CC [M]  drivers/net/wireless/marvell/mwifiex/11h.o
  CC [M]  drivers/net/wireless/marvell/mwifiex/tdls.o
  CC [M]  drivers/net/wireless/marvell/mwifiex/debugfs.o
  LD [M]  drivers/net/wireless/marvell/mwifiex/mwifiex.o
  CC [M]  drivers/net/wireless/marvell/mwifiex/sdio.o
  LD [M]  drivers/net/wireless/marvell/mwifiex/mwifiex_sdio.o
  CC [M]  drivers/net/wireless/marvell/mwifiex/pcie.o
  LD [M]  drivers/net/wireless/marvell/mwifiex/mwifiex_pcie.o
  CC [M]  drivers/net/wireless/marvell/mwifiex/usb.o
  LD [M]  drivers/net/wireless/marvell/mwifiex/mwifiex_usb.o
  AR      drivers/net/wireless/marvell/built-in.a
  CC [M]  drivers/net/wireless/marvell/mwl8k.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/usb.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/init.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/main.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/mcu.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/trace.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/dma.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/phy.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/mac.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/util.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/debugfs.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/tx.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x0/core.o
  LD [M]  drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mmio.o
  CC [M]  drivers/net/wireless/mediatek/mt76/util.o
  CC [M]  drivers/net/wireless/mediatek/mt76/trace.o
  CC [M]  drivers/net/wireless/mediatek/mt76/dma.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mac80211.o
  CC [M]  drivers/net/wireless/mediatek/mt76/debugfs.o
  CC [M]  drivers/net/wireless/mediatek/mt76/eeprom.o
  CC [M]  drivers/net/wireless/mediatek/mt76/tx.o
  CC [M]  drivers/net/wireless/mediatek/mt76/agg-rx.o
  LD [M]  drivers/net/wireless/mediatek/mt76/mt76.o
  CC [M]  drivers/net/wireless/mediatek/mt76/usb.o
  CC [M]  drivers/net/wireless/mediatek/mt76/usb_trace.o
  CC [M]  drivers/net/wireless/mediatek/mt76/usb_mcu.o
  LD [M]  drivers/net/wireless/mediatek/mt76/mt76-usb.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_eeprom.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_mac_common.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_init_common.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_common.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_phy_common.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_debugfs.o
  LD [M]  drivers/net/wireless/mediatek/mt76/mt76x2-common.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_pci.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_dma.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_main.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_init.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_tx.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_core.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_mac.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_mcu.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_phy.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_dfs.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_trace.o
  LD [M]  drivers/net/wireless/mediatek/mt76/mt76x2e.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2_usb.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2u_init.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2u_main.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2u_mac.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2u_mcu.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2u_phy.o
  CC [M]  drivers/net/wireless/mediatek/mt76/mt76x2u_core.o
  LD [M]  drivers/net/wireless/mediatek/mt76/mt76x2u.o
  CC [M]  drivers/net/wireless/mediatek/mt7601u/usb.o
  CC [M]  drivers/net/wireless/mediatek/mt7601u/init.o
  CC [M]  drivers/net/wireless/mediatek/mt7601u/main.o
  CC [M]  drivers/net/wireless/mediatek/mt7601u/mcu.o
  CC [M]  drivers/net/wireless/mediatek/mt7601u/trace.o
  CC [M]  drivers/net/wireless/mediatek/mt7601u/dma.o
  CC [M]  drivers/net/wireless/mediatek/mt7601u/core.o
  CC [M]  drivers/net/wireless/mediatek/mt7601u/eeprom.o
  CC [M]  drivers/net/wireless/mediatek/mt7601u/phy.o
  CC [M]  drivers/net/wireless/mediatek/mt7601u/mac.o
  CC [M]  drivers/net/wireless/mediatek/mt7601u/util.o
  CC [M]  drivers/net/wireless/mediatek/mt7601u/debugfs.o
  CC [M]  drivers/net/wireless/mediatek/mt7601u/tx.o
  LD [M]  drivers/net/wireless/mediatek/mt7601u/mt7601u.o
  AR      drivers/net/wireless/mediatek/built-in.a
  AR      drivers/net/wireless/quantenna/built-in.a
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2x00dev.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2x00mac.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2x00config.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2x00queue.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2x00link.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2x00crypto.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2x00firmware.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2x00leds.o
  LD [M]  drivers/net/wireless/ralink/rt2x00/rt2x00lib.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2x00mmio.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2x00pci.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2x00usb.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2800lib.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2800mmio.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2400pci.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2500pci.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt61pci.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2800pci.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2500usb.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt73usb.o
  CC [M]  drivers/net/wireless/ralink/rt2x00/rt2800usb.o
  AR      drivers/net/wireless/ralink/built-in.a
  CC [M]  drivers/net/wireless/realtek/rtl818x/rtl8180/dev.o
  CC [M]  drivers/net/wireless/realtek/rtl818x/rtl8180/rtl8225.o
  CC [M]  drivers/net/wireless/realtek/rtl818x/rtl8180/sa2400.o
  CC [M]  drivers/net/wireless/realtek/rtl818x/rtl8180/max2820.o
  CC [M]  drivers/net/wireless/realtek/rtl818x/rtl8180/grf5101.o
  CC [M]  drivers/net/wireless/realtek/rtl818x/rtl8180/rtl8225se.o
  LD [M]  drivers/net/wireless/realtek/rtl818x/rtl8180/rtl818x_pci.o
  CC [M]  drivers/net/wireless/realtek/rtl818x/rtl8187/dev.o
  CC [M]  drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.o
  CC [M]  drivers/net/wireless/realtek/rtl818x/rtl8187/leds.o
  CC [M]  drivers/net/wireless/realtek/rtl818x/rtl8187/rfkill.o
  LD [M]  drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8187.o
  CC [M]  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.o
  CC [M]  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.o
  CC [M]  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.o
  CC [M]  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.o
  CC [M]  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.o
  LD [M]  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8192e2ant.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/btcoexist/btcoexist.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8188ee/pwrseq.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8188ee/rf.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8188ee/table.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl8188ee/rtl8188ee.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192c/main.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192c/rtl8192c-common.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ce/dm.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ce/led.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ce/rf.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ce/table.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ce/rtl8192ce.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/dm.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/led.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/phy.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/table.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rtl8192cu.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192de/table.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192de/rtl8192de.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ee/led.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ee/pwrseq.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ee/rf.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ee/table.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192ee/rtl8192ee.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192se/dm.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192se/table.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl8192se/rtl8192se.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_bt_coexist.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/pwrseq.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rf.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/table.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rtl8723ae.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723be/fw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723be/led.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723be/pwrseq.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723be/rf.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723be/table.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723be/rtl8723be.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723com/main.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723com/dm_common.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl8723com/rtl8723-common.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/led.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/pwrseq.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/rf.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/table.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl8821ae/rtl8821ae.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/base.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/cam.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/core.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/debug.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/efuse.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/ps.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/rc.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/regd.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/stats.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtlwifi.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/pci.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl_pci.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/usb.o
  LD [M]  drivers/net/wireless/realtek/rtlwifi/rtl_usb.o
  AR      drivers/net/wireless/realtek/built-in.a
  AR      drivers/net/wireless/rsi/built-in.a
  CC [M]  drivers/net/wireless/rsi/rsi_91x_main.o
  CC [M]  drivers/net/wireless/rsi/rsi_91x_core.o
  CC [M]  drivers/net/wireless/rsi/rsi_91x_mac80211.o
  CC [M]  drivers/net/wireless/rsi/rsi_91x_mgmt.o
  CC [M]  drivers/net/wireless/rsi/rsi_91x_hal.o
  CC [M]  drivers/net/wireless/rsi/rsi_91x_ps.o
  CC [M]  drivers/net/wireless/rsi/rsi_91x_coex.o
  CC [M]  drivers/net/wireless/rsi/rsi_91x_debugfs.o
  LD [M]  drivers/net/wireless/rsi/rsi_91x.o
  CC [M]  drivers/net/wireless/rsi/rsi_91x_usb.o
  CC [M]  drivers/net/wireless/rsi/rsi_91x_usb_ops.o
  LD [M]  drivers/net/wireless/rsi/rsi_usb.o
  AR      drivers/net/wireless/st/built-in.a
  CC [M]  drivers/net/wireless/zydas/zd1211rw/zd_chip.o
  CC [M]  drivers/net/wireless/zydas/zd1211rw/zd_mac.o
  CC [M]  drivers/net/wireless/zydas/zd1211rw/zd_rf_al2230.o
  CC [M]  drivers/net/wireless/zydas/zd1211rw/zd_rf_rf2959.o
  CC [M]  drivers/net/wireless/zydas/zd1211rw/zd_rf_al7230b.o
  CC [M]  drivers/net/wireless/zydas/zd1211rw/zd_rf_uw2453.o
  CC [M]  drivers/net/wireless/zydas/zd1211rw/zd_rf.o
  CC [M]  drivers/net/wireless/zydas/zd1211rw/zd_usb.o
  LD [M]  drivers/net/wireless/zydas/zd1211rw/zd1211rw.o
  AR      drivers/net/wireless/zydas/built-in.a
  CC [M]  drivers/net/wireless/zydas/zd1201.o
  AR      drivers/net/wireless/built-in.a
  CC [M]  drivers/net/wireless/ray_cs.o
  CC [M]  drivers/net/wireless/wl3501_cs.o
  CC [M]  drivers/net/wireless/rndis_wlan.o
  CC [M]  drivers/net/wireless/mac80211_hwsim.o
  CC [M]  drivers/net/xen-netback/netback.o
  CC [M]  drivers/net/xen-netback/xenbus.o
  CC [M]  drivers/net/xen-netback/interface.o
  CC [M]  drivers/net/xen-netback/hash.o
  CC [M]  drivers/net/xen-netback/rx.o
  LD [M]  drivers/net/xen-netback/xen-netback.o
  CC      drivers/net/Space.o
  CC      drivers/net/loopback.o
  AR      drivers/net/built-in.a
  CC [M]  drivers/net/dummy.o
  CC [M]  drivers/net/eql.o
  CC [M]  drivers/net/ifb.o
  CC [M]  drivers/net/macsec.o
  CC [M]  drivers/net/macvlan.o
  CC [M]  drivers/net/macvtap.o
  CC [M]  drivers/net/mii.o
  CC [M]  drivers/net/mdio.o
  CC [M]  drivers/net/netconsole.o
  CC [M]  drivers/net/tun.o
  CC [M]  drivers/net/tap.o
  CC [M]  drivers/net/veth.o
  CC [M]  drivers/net/virtio_net.o
  CC [M]  drivers/net/vxlan.o
  CC [M]  drivers/net/geneve.o
  CC [M]  drivers/net/gtp.o
  CC [M]  drivers/net/nlmon.o
  CC [M]  drivers/net/vrf.o
  CC [M]  drivers/net/vsockmon.o
  CC [M]  drivers/net/sb1000.o
  CC [M]  drivers/net/sungem_phy.o
  CC [M]  drivers/net/xen-netfront.o
  CC [M]  drivers/net/thunderbolt.o
  LD [M]  drivers/net/thunderbolt-net.o
  CC [M]  drivers/net/net_failover.o
  CC [M]  drivers/nfc/pn533/pn533.o
  CC [M]  drivers/nfc/pn533/usb.o
  LD [M]  drivers/nfc/pn533/pn533_usb.o
  CC [M]  drivers/nfc/pn544/pn544.o
  CC [M]  drivers/nfc/pn544/mei.o
  LD [M]  drivers/nfc/pn544/pn544_mei.o
  AR      drivers/nfc/built-in.a
  CC [M]  drivers/nfc/mei_phy.o
  CC [M]  drivers/nfc/nfcsim.o
  CC [M]  drivers/nfc/port100.o
  CC [M]  drivers/nvdimm/core.o
  CC [M]  drivers/nvdimm/bus.o
  CC [M]  drivers/nvdimm/dimm_devs.o
  CC [M]  drivers/nvdimm/dimm.o
  CC [M]  drivers/nvdimm/region_devs.o
  CC [M]  drivers/nvdimm/region.o
  CC [M]  drivers/nvdimm/namespace_devs.o
  CC [M]  drivers/nvdimm/label.o
  CC [M]  drivers/nvdimm/badrange.o
  CC [M]  drivers/nvdimm/claim.o
  CC [M]  drivers/nvdimm/btt_devs.o
  LD [M]  drivers/nvdimm/libnvdimm.o
  CC [M]  drivers/nvdimm/pmem.o
  LD [M]  drivers/nvdimm/nd_pmem.o
  CC [M]  drivers/nvdimm/btt.o
  LD [M]  drivers/nvdimm/nd_btt.o
  CC [M]  drivers/nvdimm/blk.o
  LD [M]  drivers/nvdimm/nd_blk.o
  CC [M]  drivers/nvdimm/e820.o
  LD [M]  drivers/nvdimm/nd_e820.o
  AR      drivers/nvme/host/built-in.a
  CC [M]  drivers/nvme/host/core.o
  CC [M]  drivers/nvme/host/trace.o
  CC [M]  drivers/nvme/host/multipath.o
  LD [M]  drivers/nvme/host/nvme-core.o
  CC [M]  drivers/nvme/host/pci.o
  LD [M]  drivers/nvme/host/nvme.o
  CC [M]  drivers/nvme/host/fabrics.o
  LD [M]  drivers/nvme/host/nvme-fabrics.o
  CC [M]  drivers/nvme/host/rdma.o
  LD [M]  drivers/nvme/host/nvme-rdma.o
  CC [M]  drivers/nvme/host/fc.o
  LD [M]  drivers/nvme/host/nvme-fc.o
  AR      drivers/nvme/target/built-in.a
  CC [M]  drivers/nvme/target/core.o
  CC [M]  drivers/nvme/target/configfs.o
  CC [M]  drivers/nvme/target/admin-cmd.o
  CC [M]  drivers/nvme/target/fabrics-cmd.o
  CC [M]  drivers/nvme/target/discovery.o
  CC [M]  drivers/nvme/target/io-cmd-file.o
  CC [M]  drivers/nvme/target/io-cmd-bdev.o
  LD [M]  drivers/nvme/target/nvmet.o
  CC [M]  drivers/nvme/target/rdma.o
  LD [M]  drivers/nvme/target/nvmet-rdma.o
  CC [M]  drivers/nvme/target/fc.o
  LD [M]  drivers/nvme/target/nvmet-fc.o
  AR      drivers/nvme/built-in.a
  CC      drivers/nvmem/core.o
  AR      drivers/nvmem/built-in.a
  CC      drivers/opp/core.o
  CC      drivers/opp/cpu.o
  CC      drivers/opp/debugfs.o
  AR      drivers/opp/built-in.a
  CC [M]  drivers/parport/share.o
  CC [M]  drivers/parport/ieee1284.o
  CC [M]  drivers/parport/ieee1284_ops.o
  CC [M]  drivers/parport/procfs.o
  CC [M]  drivers/parport/daisy.o
  CC [M]  drivers/parport/probe.o
  LD [M]  drivers/parport/parport.o
  CC [M]  drivers/parport/parport_pc.o
  CC [M]  drivers/parport/parport_serial.o
  CC [M]  drivers/parport/parport_cs.o
  AR      drivers/pci/controller/dwc/built-in.a
  AR      drivers/pci/controller/built-in.a
  CC      drivers/pci/hotplug/pci_hotplug_core.o
  CC      drivers/pci/hotplug/cpci_hotplug_core.o
  CC      drivers/pci/hotplug/cpci_hotplug_pci.o
  CC      drivers/pci/hotplug/acpi_pcihp.o
  CC      drivers/pci/hotplug/pciehp_core.o
  CC      drivers/pci/hotplug/pciehp_ctrl.o
  CC      drivers/pci/hotplug/pciehp_pci.o
  CC      drivers/pci/hotplug/pciehp_hpc.o
  CC      drivers/pci/hotplug/shpchp_core.o
  CC      drivers/pci/hotplug/shpchp_ctrl.o
  CC      drivers/pci/hotplug/shpchp_pci.o
  CC      drivers/pci/hotplug/shpchp_sysfs.o
  CC      drivers/pci/hotplug/shpchp_hpc.o
  CC      drivers/pci/hotplug/acpiphp_core.o
  CC      drivers/pci/hotplug/acpiphp_glue.o
  AR      drivers/pci/hotplug/built-in.a
  CC [M]  drivers/pci/hotplug/cpqphp_core.o
  CC [M]  drivers/pci/hotplug/cpqphp_ctrl.o
  CC [M]  drivers/pci/hotplug/cpqphp_sysfs.o
  CC [M]  drivers/pci/hotplug/cpqphp_pci.o
  LD [M]  drivers/pci/hotplug/cpqphp.o
  CC [M]  drivers/pci/hotplug/ibmphp_core.o
  CC [M]  drivers/pci/hotplug/ibmphp_ebda.o
  CC [M]  drivers/pci/hotplug/ibmphp_pci.o
  CC [M]  drivers/pci/hotplug/ibmphp_res.o
  CC [M]  drivers/pci/hotplug/ibmphp_hpc.o
  LD [M]  drivers/pci/hotplug/ibmphp.o
  CC [M]  drivers/pci/hotplug/cpcihp_zt5550.o
  CC [M]  drivers/pci/hotplug/cpcihp_generic.o
  CC [M]  drivers/pci/hotplug/acpiphp_ibm.o
  CC      drivers/pci/pcie/portdrv_core.o
  CC      drivers/pci/pcie/portdrv_pci.o
  CC      drivers/pci/pcie/err.o
  CC      drivers/pci/pcie/aspm.o
  CC      drivers/pci/pcie/aer.o
  CC      drivers/pci/pcie/pme.o
  CC      drivers/pci/pcie/dpc.o
  CC      drivers/pci/pcie/ptm.o
  AR      drivers/pci/pcie/built-in.a
  CC [M]  drivers/pci/pcie/aer_inject.o
  AR      drivers/pci/switch/built-in.a
  CC      drivers/pci/access.o
  CC      drivers/pci/bus.o
  CC      drivers/pci/probe.o
  CC      drivers/pci/host-bridge.o
  CC      drivers/pci/remove.o
  CC      drivers/pci/pci.o
  CC      drivers/pci/pci-driver.o
  CC      drivers/pci/search.o
  CC      drivers/pci/pci-sysfs.o
  CC      drivers/pci/rom.o
  CC      drivers/pci/setup-res.o
  CC      drivers/pci/irq.o
  CC      drivers/pci/vpd.o
  CC      drivers/pci/setup-bus.o
  CC      drivers/pci/vc.o
  CC      drivers/pci/mmap.o
  CC      drivers/pci/setup-irq.o
  CC      drivers/pci/proc.o
  CC      drivers/pci/slot.o
  CC      drivers/pci/quirks.o
drivers/pci/quirks.c: In function =E2=80=98quirk_synopsys_haps=E2=80=99:
drivers/pci/quirks.c:631:7: error: =E2=80=98PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3=
=E2=80=99
undeclared (first use in this function); did you mean
=E2=80=98PCI_DEVICE_ID_ESS_MAESTRO3=E2=80=99?
  case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3:
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       PCI_DEVICE_ID_ESS_MAESTRO3
drivers/pci/quirks.c:631:7: note: each undeclared identifier is
reported only once for each function it appears in
drivers/pci/quirks.c:632:7: error:
=E2=80=98PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI=E2=80=99 undeclared (first use=
 in this
function); did you mean =E2=80=98PCI_DEVICE_ID_SUN_CASSINI=E2=80=99?
  case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI:
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       PCI_DEVICE_ID_SUN_CASSINI
drivers/pci/quirks.c:633:7: error: =E2=80=98PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3=
1=E2=80=99
undeclared (first use in this function); did you mean
=E2=80=98PCI_DEVICE_ID_SUN_CASSINI=E2=80=99?
  case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31:
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       PCI_DEVICE_ID_SUN_CASSINI
drivers/pci/quirks.c: In function =E2=80=98quirk_disable_aspm_l0s=E2=80=99:
drivers/pci/quirks.c:2229:2: error: implicit declaration of function
=E2=80=98pci_disable_link_state=E2=80=99; did you mean =E2=80=98pci_restore=
_iov_state=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
  pci_disable_link_state(dev, PCIE_LINK_STATE_L0S);
  ^~~~~~~~~~~~~~~~~~~~~~
  pci_restore_iov_state
drivers/pci/quirks.c:2229:30: error: =E2=80=98PCIE_LINK_STATE_L0S=E2=80=99 =
undeclared
(first use in this function); did you mean =E2=80=98PCIE_LNK_WIDTH_RESRV=E2=
=80=99?
  pci_disable_link_state(dev, PCIE_LINK_STATE_L0S);
                              ^~~~~~~~~~~~~~~~~~~
                              PCIE_LNK_WIDTH_RESRV
drivers/pci/quirks.c: At top level:
drivers/pci/quirks.c:4612:4: error: =E2=80=98PCI_VENDOR_ID_HXT=E2=80=99 und=
eclared
here (not in a function); did you mean =E2=80=98PCI_VENDOR_ID_ATT=E2=80=99?
  { PCI_VENDOR_ID_HXT, 0x0401, pci_quirk_qcom_rp_acs },
    ^~~~~~~~~~~~~~~~~
    PCI_VENDOR_ID_ATT
drivers/pci/quirks.c:4633:4: error:
=E2=80=98PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS=E2=80=99 undeclared here (not =
in a
function); did you mean =E2=80=98PCI_VENDOR_ID_AMAZON=E2=80=99?
  { PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    PCI_VENDOR_ID_AMAZON
drivers/pci/quirks.c: In function =E2=80=98quirk_nvidia_hda=E2=80=99:
drivers/pci/quirks.c:5096:20: error:
=E2=80=98PCI_DEVICE_ID_NVIDIA_GEFORCE_320M=E2=80=99 undeclared (first use i=
n this
function); did you mean =E2=80=98PCI_DEVICE_ID_NVIDIA_GEFORCE_6200=E2=80=99=
?
  if (gpu->device < PCI_DEVICE_ID_NVIDIA_GEFORCE_320M)
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    PCI_DEVICE_ID_NVIDIA_GEFORCE_6200
drivers/pci/quirks.c:5096:18: warning: comparison between pointer and integ=
er
  if (gpu->device < PCI_DEVICE_ID_NVIDIA_GEFORCE_320M)
                  ^
cc1: some warnings being treated as errors
make[5]: *** [scripts/Makefile.build:304: drivers/pci/quirks.o] Error 1
make[4]: *** [scripts/Makefile.build:544: drivers/pci] Error 2
make[3]: *** [Makefile:1046: drivers] Error 2
make[2]: *** [debian/rules:4: build] Error 2
dpkg-buildpackage: error: debian/rules build subprocess returned exit statu=
s 2
make[1]: *** [scripts/package/Makefile:75: deb-pkg] Error 2
make: *** [Makefile:1359: deb-pkg] Error 2
root@CF-29:/home/michael/kernel/linux-4.19.80#

I will now try a compile of 5.4-rc1
Cheers.
Michael.


On 25/10/2019, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> The patch doesn't seem to have been applied correctly (using the patch(1)
> utility). Attached is the file how it should look like.
>
> 	Dominik
>
> On Fri, Oct 25, 2019 at 01:38:46PM +1100, Michael . wrote:
>> Here's the resulting output of the failed compilation of 5.4rc1 with
>> the patch applied to quirks.c:
>>  CC      drivers/pci/quirks.o
>> drivers/pci/quirks.c:3039:1: error: expected identifier or =E2=80=98(=E2=
=80=99 before =E2=80=98-=E2=80=99
>> token
>>  3039 | -static void ricoh_mmc_fixup_rl5c476(struct pci_dev *dev)
>>       | ^
>> drivers/pci/quirks.c:3068:1: error: expected identifier or =E2=80=98(=E2=
=80=99 before =E2=80=98-=E2=80=99
>> token
>
>
