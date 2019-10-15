Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5448BD778F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 15:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbfJONi6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 09:38:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35217 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbfJONi6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 09:38:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id v8so23937495wrt.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2019 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Nu2z3Dgfr7/J7oYU8GOaoAiMptWMlXZ8SPSo2Cr62ZM=;
        b=F0nqJCOFOeroNljjk6F4DUNswWFyWQE/Zp2OgTK0vdHJJl3MTjGvvhbLb2GzZoYF0y
         DG84j4K4fsqKm8B9dmxN9++6+Kv2yDJZ0C3FFRJUzC7Te6LrAyiLpwCQbSRecB8kQ5Al
         ZyQaeUGlkC58Pp4vlpQqwMvLOwPvEXzMq6g2dfEpdmgpdwivRZY71YfB+A9PQK0HewY9
         lNbjyUbtIK4ED4xv3ttcNN4DQId/foyMHEOh3cvBStVu7KB/ZlY/7txH0yPm4YDDSrzf
         vr7B95+dyF+n0a2mEQwDks78KWvih6cuLMLd7nsqNr3TZyXLSXUpACb5V2WBQRts67C9
         ToOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Nu2z3Dgfr7/J7oYU8GOaoAiMptWMlXZ8SPSo2Cr62ZM=;
        b=cwEfX7hiZoo+xs/r9YmX2OH6PhVDu0zsVJrwCIlr77OGgnx+H+3k+1lVDGmm1bLpOd
         YzoAv/yncJ4RM4Fo0JlciXEYrohMaT+w94plcY/Mn0AzBSVnabJQ+h+CGbTewsQR2f0/
         bTIIAg27XqPckO/mVjePLpDmBMAXOSvBMcr4TzOb/oUnUTVLfPmFz+NK4cjU5i1UbIhK
         EIPXr8ztx71oFTy4o0AAlD9TW7uJEAM1cLOlhuzKVHljktCPoPJzxA0NfxUD2ycUXSlu
         TGX7ncksOZrElrWAtpOlV6YkPgHvTzrb2IvOTEY8ez801rXxIEWifY+gm7ivk9zypX36
         4BCQ==
X-Gm-Message-State: APjAAAVZnwuSE2eiV1viSprQTZBX2Ky6RRQxcBP32eo4VUqZqxMceV8R
        3sHem4YpBrIE2pksH2M7NtHyjw==
X-Google-Smtp-Source: APXvYqzlAAzvHjtdfpECSH1vFyKSqr33tk+sqhAor9Wt5UyDyOIMMS72yfETfvKX3wjYooh4R/XE9w==
X-Received: by 2002:adf:fe10:: with SMTP id n16mr21107992wrr.288.1571146734815;
        Tue, 15 Oct 2019 06:38:54 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e18sm30379633wrv.63.2019.10.15.06.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:38:54 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] arm64: dts: meson-g12: add support for PCIe
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     khilman@baylibre.com, kishon@ti.com, bhelgaas@google.com,
        andrew.murray@arm.com, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yue.wang@Amlogic.com, maz@kernel.org,
        repk@triplefau.lt, nick@khadas.com, gouwa@khadas.com
References: <20190916125022.10754-1-narmstrong@baylibre.com>
 <20191015131419.GA12343@e121166-lin.cambridge.arm.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <ca0d8068-fb44-7e91-fd52-d53f5759bcba@baylibre.com>
Date:   Tue, 15 Oct 2019 15:38:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015131419.GA12343@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 15/10/2019 15:14, Lorenzo Pieralisi wrote:
> On Mon, Sep 16, 2019 at 02:50:16PM +0200, Neil Armstrong wrote:
>> This patchset :
>> - updates the Amlogic PCI bindings for G12A
>> - reworks the Amlogic PCIe driver to make use of the
>> G12a USB3+PCIe Combo PHY instead of directly writing in
>> the PHY register
>> - adds the necessary operations to the G12a USB3+PCIe Combo PHY driver
>> - adds the PCIe Node for G12A, G12B and SM1 SoCs
>> - adds the commented support for the S922X, A311D and S905D3 based
>> VIM3 boards.
>>
>> The VIM3 schematic can be found at [1].
>>
>> This patchset is dependent on Remi's "Fix reset assertion via gpio descriptor"
>> patch at [2].
> 
> Merged in pci/meson; however, I am not sure what should be done on
> Remi's patch, I would like to queue it up too otherwise it looks
> to me that merging this series is not right.

This serie depends on the fixed polarity in Remi's patch to work.

As Martin noted, no need to update the bindings since the example
is still valid. The GPIO polarity is dependent on the board layout,
but the naming of the gpio needed an update in how we handle the polarity
in the driver like other driver does (we must consider ACTIVE_HIGH in the
driver, whatever is set in the DT since the gpio core will do the
conversion automatically).

Neil

> 
> Lorenzo
> 
>> This patchset has been tested in a A311D VIM3 and S905D3 VIM3L using a
>> 128Go TS128GMTE110S NVMe PCIe module.
>>
>> For indication, here is a bonnie++ run as ext4 formatted on the VIM3:
>>      ------Sequential Output------ --Sequential Input- --Random-
>>      -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
>> Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP /sec %CP
>>   4G 93865  99 312837  96 194487  23 102808  97 415501 21 +++++ +++
>>
>> and the S905D3 VIM3L version:
>>      ------Sequential Output------ --Sequential Input- --Random-
>>      -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
>> Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
>>   4G 52144  95 71766  21 47302  10 57078  98 415469  44 +++++ +++
>>
>> Changes since v1 at [3]:
>>  - Collected Andrew's and Rob's Reviewed-by tags
>>  - Added missing calls to phy_init/phy_exit
>>  - Fixes has_shared_phy handling for MIPI clock
>>  - Add comment in the DT concerning firmware setting the right properties
>>  - Added SM1 Power Domain to PCIe node
>>
>> [1] https://docs.khadas.com/vim3/HardwareDocs.html
>> [2] https://patchwork.kernel.org/patch/11125261/
>> [3] https://patchwork.kernel.org/cover/11136927/
>>
>> Neil Armstrong (6):
>>   dt-bindings: pci: amlogic,meson-pcie: Add G12A bindings
>>   PCI: amlogic: Fix probed clock names
>>   PCI: amlogic: meson: Add support for G12A
>>   phy: meson-g12a-usb3-pcie: Add support for PCIe mode
>>   arm64: dts: meson-g12a: Add PCIe node
>>   arm64: dts: khadas-vim3: add commented support for PCIe
>>
>>  .../bindings/pci/amlogic,meson-pcie.txt       |  12 +-
>>  .../boot/dts/amlogic/meson-g12-common.dtsi    |  33 +++++
>>  .../amlogic/meson-g12b-a311d-khadas-vim3.dts  |  25 ++++
>>  .../amlogic/meson-g12b-s922x-khadas-vim3.dts  |  25 ++++
>>  .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |   4 +
>>  .../dts/amlogic/meson-sm1-khadas-vim3l.dts    |  25 ++++
>>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |   4 +
>>  drivers/pci/controller/dwc/pci-meson.c        | 132 ++++++++++++++----
>>  .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    |  70 ++++++++--
>>  9 files changed, 292 insertions(+), 38 deletions(-)
>>
>> -- 
>> 2.22.0
>>

