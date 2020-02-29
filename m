Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8561747E1
	for <lists+linux-pci@lfdr.de>; Sat, 29 Feb 2020 17:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgB2QHt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Feb 2020 11:07:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39922 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgB2QHt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Feb 2020 11:07:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so7064216wrn.6
        for <linux-pci@vger.kernel.org>; Sat, 29 Feb 2020 08:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=48DSmx7US8n6WMlcgOvxvjVcQ+g4+Ibx6G+UETF629w=;
        b=xa25qD+ChpBdxQ6RLpkaOU3kV4mB4htgdPT4qxKmKIDt6/v7diTH14/6azdEsOmotU
         YlSzesmn0W2vrpAJYfNTOG5i4/9dEezxs6nbGrEqwxR00x2uQ9Rpa30xHj2PP1MvYPBq
         X2ZA6j/TuOPXQAPDoV2Cf5DvIkd7HO8a63Ug5TXJ3ThCOgBDxvXCfiDwFcuNnVYMCCII
         3/b4pubDwFnr+uFDWau33mwv6RfuAp8FHTLepmiGdysMll8c2EOzAndsn4OEIzS4R7eW
         MSMeqHgl1FFiSVwEclEMJybOcwSRrfsJRrQgz9xp06khN9IEyxbLSTCHqNt3a3IKQ9ZP
         2ThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=48DSmx7US8n6WMlcgOvxvjVcQ+g4+Ibx6G+UETF629w=;
        b=P++wgv58OxySiXgAICBiaUTNsUauUqeiUh4veompzdY47/GGjl0gBxJhNjRZJdVexH
         QvDPBvVLTwWLdc8rVf5Kqp9FVwQYVQJuHmRH0xmfstTqDoYeQovU8D4V3hJxaO+sfPs2
         Z/g0oM8jOvNkuJ13aO+VgpIXkOg8u6bZb/MBU6x3olsqbrInepnhG9erI2J3KBI2DQLr
         pdbEUssVkcP3QTl4caYuBMVgaNuxJInVhmMLCjjzMR+DNRlGeTepB/5lINl1SgJUNCUb
         05JUZRWcLn3bepZB57gNWPq39OTaAIjy8Q1vMKJhH3ilOkuOJUwdodJ1KXPWqZyVkoOV
         nWWQ==
X-Gm-Message-State: APjAAAWVzJN9ZcUWyg+IhY635OiLz+aRIcNySxqYb7BTX8SLZTvPEUj0
        BFc4MPQC8CFEc+aslgdjECtTzA==
X-Google-Smtp-Source: APXvYqxUgytqyvDZW+WcxWi1g8HE+C1vnsLjI/U/K70R4QGytxpW9GY+14iyGD3A2pOx2tsCrhjOmQ==
X-Received: by 2002:a5d:4610:: with SMTP id t16mr10996895wrq.408.1582992466554;
        Sat, 29 Feb 2020 08:07:46 -0800 (PST)
Received: from localhost (229.3.136.88.rev.sfr.net. [88.136.3.229])
        by smtp.gmail.com with ESMTPSA id q9sm10518220wrn.8.2020.02.29.08.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 08:07:45 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Remi Pommarel <repk@triplefau.lt>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/7] PCI: amlogic: Make PCIe working reliably on AXG platforms
In-Reply-To: <20200224141549.GB15614@e121166-lin.cambridge.arm.com>
References: <20200123232943.10229-1-repk@triplefau.lt> <20200224141549.GB15614@e121166-lin.cambridge.arm.com>
Date:   Sat, 29 Feb 2020 17:07:43 +0100
Message-ID: <7h8sklbcmo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> On Fri, Jan 24, 2020 at 12:29:36AM +0100, Remi Pommarel wrote:
>> PCIe device probing failures have been seen on AXG platforms and were
>> due to unreliable clock signal output. Setting HHI_MIPI_CNTL0[26] bit
>> in MIPI's PHY registers solved the problem. This bit controls band gap
>> reference.
>> 
>> As discussed here [1] one of these shared MIPI/PCIE analog PHY register
>> bits was implemented in the clock driver as CLKID_MIPI_ENABLE. This adds
>> a PHY driver to control this bit instead, as well as setting the band
>> gap one in order to get reliable PCIE communication.
>> 
>> While at it add another PHY driver to control PCIE only PHY registers,
>> making AXG code more similar to G12A platform thus allowing to remove
>> some specific platform handling in pci-meson driver.
>> 
>> Please note that CLKID_MIPI_ENABLE removable will be done in a different
>> serie.
>> 
>> Changes since v5:
>>  - Add additionalProperties in device tree binding documentation
>>  - Make analog PHY required
>> 
>> Changes since v4:
>>  - Rename the shared MIPI/PCIe PHY to analog
>>  - Chain the MIPI/PCIe PHY to the PCIe one
>> 
>> Changes since v3:
>>  - Go back to the shared MIPI/PCIe phy driver solution from v2
>>  - Remove syscon usage
>>  - Add all dt-bindings documentation
>> 
>> Changes since v2:
>>  - Remove shared MIPI/PCIE device driver and use syscon to access register
>>    in PCIE only driver instead
>>  - Include devicetree documentation
>> 
>> Changes sinve v1:
>>  - Move HHI_MIPI_CNTL0 bit control in its own PHY driver
>>  - Add a PHY driver for PCIE_PHY registers
>>  - Modify pci-meson.c to make use of both PHYs and remove specific
>>    handling for AXG and G12A
>> 
>> [1] https://lkml.org/lkml/2019/12/16/119
>> 
>> Remi Pommarel (7):
>>   dt-bindings: Add AXG PCIE PHY bindings
>>   dt-bindings: Add AXG shared MIPI/PCIE analog PHY bindings
>>   dt-bindings: PCI: meson: Update PCIE bindings documentation
>>   arm64: dts: meson-axg: Add PCIE PHY nodes
>>   phy: amlogic: Add Amlogic AXG MIPI/PCIE analog PHY Driver
>>   phy: amlogic: Add Amlogic AXG PCIE PHY Driver
>>   PCI: amlogic: Use AXG PCIE
>> 
>>  .../bindings/pci/amlogic,meson-pcie.txt       |  22 +-
>>  .../amlogic,meson-axg-mipi-pcie-analog.yaml   |  35 ++++
>>  .../bindings/phy/amlogic,meson-axg-pcie.yaml  |  52 +++++
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  16 ++
>>  drivers/pci/controller/dwc/pci-meson.c        | 116 ++---------
>>  drivers/phy/amlogic/Kconfig                   |  22 ++
>>  drivers/phy/amlogic/Makefile                  |  12 +-
>>  .../amlogic/phy-meson-axg-mipi-pcie-analog.c  | 188 +++++++++++++++++
>>  drivers/phy/amlogic/phy-meson-axg-pcie.c      | 192 ++++++++++++++++++
>>  9 files changed, 543 insertions(+), 112 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
>>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
>>  create mode 100644 drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
>>  create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c
>
> Hi Remi,
>
> I am ready to pull this series in, do you want me to ? Or you prefer
> it to go via a different tree upstream ?

To avoid conflicts, I'll take the DT patch (PATCH 4/7) through my
amlogic tree, but feel free to take the rest.

Kevin

