Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B649ADE39
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2019 19:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfIIRur (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Sep 2019 13:50:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37332 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfIIRur (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Sep 2019 13:50:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id i1so14357382wro.4
        for <linux-pci@vger.kernel.org>; Mon, 09 Sep 2019 10:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DdPMRC7fgZpsKbVZ/B0zUuc2EzOH4bRfHzaKWExErGE=;
        b=Zrm/RwecGRKIQ+VTy+JsDQ+fpIMX6Z3bVGkjeNioi7u1ctxGFchxRKk0w2X3J8paCs
         nO+kpGwsngaIKWSBd+bLwD+msH1zmU5RfuH76T8G1k2JotXIfmE7t3pGKByUuMaJViOf
         nySZ8j4oh9BLIR7zo+e+YkssIldksT3h1/8MAOFfVqwz7sUlisuBuSxM76bcV1Oi9Jma
         adJP31ArUY/g32u+exgdl+SIWt/z38aT36wAx2uNt9ztXs0gJj9CHsL94b0pplSQsL8r
         SsgQWhfcTm14jeBAtJNeJfJD3iO/kgZphoRk7PgkfxvCosxnTyIX7EEulsPuNjZp0X3/
         F7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=DdPMRC7fgZpsKbVZ/B0zUuc2EzOH4bRfHzaKWExErGE=;
        b=iBXfO3ABGgiEndtEZrJVTb9ZV7rUGrtlRSfZTGaMX72177jz5reWFX2e0++uHnhnmO
         PCsurle6UZIvo/vO/07QHewco/fU8XcgWhbVPimDcurEK56aoSZ8sOLDl6R1oG7me1+a
         XCfQHIhJ3qL0G2IaG54HVGtVjMCCmzHLCV73Gtim2LA21GsihwmeIsHbdFkHepgsHAAY
         3KKMpoPOl8ynWHH3glWv66LF9sKp8MjkfZtdpVGlFR1gSgjJWW1x1CaVnkCp58FiKvqg
         w1T6GFfPJtYONF1zo2RjrKDtW/cb2LA3Xf41655Ov1CM7ElNYPf3a+BfA+TsAf0Zfs+2
         kZJQ==
X-Gm-Message-State: APjAAAXCdox4x2LeZQ1a/Jz9FLp3g9Op/KViYeBre8nXCtCVWWdiZInJ
        AOAFR4ex0azwwfFsnhGc2PfSPQ==
X-Google-Smtp-Source: APXvYqz5gCV5Ze/WC6zuHxMY6FG6sSTIDCIY33H80sMA4yZE+z6o/LNwDUTnh/CS7ryfujgHwlTHag==
X-Received: by 2002:a5d:48c2:: with SMTP id p2mr7815743wrs.348.1568051444421;
        Mon, 09 Sep 2019 10:50:44 -0700 (PDT)
Received: from [192.168.1.77] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id p8sm12079863wrq.22.2019.09.09.10.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 10:50:43 -0700 (PDT)
Subject: Re: [PATCH 6/6] arm64: dts: khadas-vim3: add commented support for
 PCIe
To:     Marc Zyngier <maz@kernel.org>
References: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
 <1567950178-4466-7-git-send-email-narmstrong@baylibre.com>
 <864l1ls9wy.wl-maz@kernel.org>
Cc:     khilman@baylibre.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, kishon@ti.com,
        repk@triplefau.lt, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <2c25e8b5-191f-96c9-8989-23959a7b1c4e@baylibre.com>
Date:   Mon, 9 Sep 2019 19:50:42 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <864l1ls9wy.wl-maz@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

Le 09/09/2019 à 18:37, Marc Zyngier a écrit :
> On Sun, 08 Sep 2019 14:42:58 +0100,
> Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
>> lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
>> an USB3.0 Type A connector and a M.2 Key M slot.
>> The PHY driving these differential lines is shared between
>> the USB3.0 controller and the PCIe Controller, thus only
>> a single controller can use it.
>>
>> The needed DT configuration when the MCU is configured to mux
>> the PCIe/USB3.0 differential lines to the M.2 Key M slot is
>> added commented and may uncommented to disable USB3.0 from the
>> USB Complex and enable the PCIe controller.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  .../amlogic/meson-g12b-a311d-khadas-vim3.dts  | 22 +++++++++++++++++++
>>  .../amlogic/meson-g12b-s922x-khadas-vim3.dts  | 22 +++++++++++++++++++
>>  .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  4 ++++
>>  .../dts/amlogic/meson-sm1-khadas-vim3l.dts    | 22 +++++++++++++++++++
>>  4 files changed, 70 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
>> index 3a6a1e0c1e32..0577b1435cbb 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
>> @@ -14,3 +14,25 @@
>>  / {
>>  	compatible = "khadas,vim3", "amlogic,a311d", "amlogic,g12b";
>>  };
>> +
>> +/*
>> + * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
>> + * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
>> + * an USB3.0 Type A connector and a M.2 Key M slot.
>> + * The PHY driving these differential lines is shared between
>> + * the USB3.0 controller and the PCIe Controller, thus only
>> + * a single controller can use it.
>> + * If the MCU is configured to mux the PCIe/USB3.0 differential lines
>> + * to the M.2 Key M slot, uncomment the following block to disable
>> + * USB3.0 from the USB Complex and enable the PCIe controller.
>> + */
>> +/*
>> +&pcie {
>> +	status = "okay";
>> +};
>> +
>> +&usb {
>> +	phys = <&usb2_phy0>, <&usb2_phy1>;
>> +	phy-names = "usb2-phy0", "usb2-phy1";
>> +};
>> + */
> 
> Although you can't do much more than this here, I'd expect firmware on
> the machine to provide the DT that matches its configuration. Is it
> the way it actually works? Or is the user actually expected to edit
> this file?

It's the plan when initial VIM3 support will be merged in u-boot mainline,
and the MCU driver will be added aswell :
https://patchwork.ozlabs.org/cover/1156618/
A custom board support altering the DT will be added when this patchset
is merged upstream.

But since these are separate projects, leaving this as commented is ugly,
but necessary.

Thanks,
Neil

> 
> Thanks,
> 
> 	M.
> 
