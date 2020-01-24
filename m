Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFA4147922
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 09:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgAXICR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jan 2020 03:02:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46837 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbgAXICR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jan 2020 03:02:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so794985wrl.13
        for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2020 00:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OlLbxKAm24kk7BqwIB6TdUq5++JUPjcTVNPlce6GGcA=;
        b=yYskb3nRQojn0YR1a1/P0UHdl5YnI3pCUdr4PPlNU5LW0kRu1w3guS8Ad6Z3JSiCyx
         /gE+u5fYheiNhvXdQYXXJReZrGE36JOdZApYsKt6rlQ2V71bSakZ+hxzFdiu0pnPB9w4
         SPwrcVj7Pa6Ex7DwmVPDOpp1NEQElepcVu/GVtHzF6NdPeFeOI3VzAMXQ/34f4Bvu0aW
         feJh3i9mUJuyShUjnLBz2BKn0yjstr9M8ASaDXDMmPUPzIMgKfIRQ51VxNuiuJjGxP0x
         7zGobXhRWAmeJ6mKNpYcqy7g8XHLqSA7o6PrxAivqHVguWFNWbhVjqqiFtchypjYFL1s
         ci3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OlLbxKAm24kk7BqwIB6TdUq5++JUPjcTVNPlce6GGcA=;
        b=PjEgBbPIy33B1O71TNJ4hBnGrlBA6fJKZDn1Fz9Qs04T3ASPsYArH7j6bW0BCtyX+0
         w7fWg+LulIa7ypAKufQObAYX+WXj6NuWfdR3T4h26OLBNQ2SebOS/p6CJ0cNEq20qMeC
         0km4QfCnfNgJOQmbiGZ4NFyrF+VI8vcIUUa/h4OeUD8YnSL24jyJxfr9QVOuB66OqVcn
         ccc4Xi+dA/9xtCHTIrmNXirjRurYOXx/35WT4tHztEqNeEK1SsrxRQ2g+poPlTC2Ah80
         FPhw3NyzNQH48JtmEL5j0xhRPcLBBrgr0vURXxM9fgqG021b7fXcDQy8v+POJ5sG432h
         mZPQ==
X-Gm-Message-State: APjAAAWJflzCut9w3Umko5lGwYckD0i+2sdtB5mXGut2NkYFDMP6nR1k
        sUII2CDZ1QqwI5J9I9y5QTqkpb+u5ZGQVQ==
X-Google-Smtp-Source: APXvYqxwSfBAgmCTm7xqCMMitgplyqDCqW9WDbMLGahzpXS0qBQbOZ0sOoYUFZGwCGy9tpKozf5t7A==
X-Received: by 2002:adf:ec0d:: with SMTP id x13mr2722298wrn.400.1579852934189;
        Fri, 24 Jan 2020 00:02:14 -0800 (PST)
Received: from [10.1.2.12] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p5sm6201089wrt.79.2020.01.24.00.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 00:02:13 -0800 (PST)
Subject: Re: [PATCH v6 0/7] PCI: amlogic: Make PCIe working reliably on AXG
 platforms
To:     Remi Pommarel <repk@triplefau.lt>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
References: <20200123232943.10229-1-repk@triplefau.lt>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <64b5d857-569a-ab2e-a467-9cdb47cf20e4@baylibre.com>
Date:   Fri, 24 Jan 2020 09:02:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200123232943.10229-1-repk@triplefau.lt>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 24/01/2020 00:29, Remi Pommarel wrote:
> PCIe device probing failures have been seen on AXG platforms and were
> due to unreliable clock signal output. Setting HHI_MIPI_CNTL0[26] bit
> in MIPI's PHY registers solved the problem. This bit controls band gap
> reference.
> 
> As discussed here [1] one of these shared MIPI/PCIE analog PHY register
> bits was implemented in the clock driver as CLKID_MIPI_ENABLE. This adds
> a PHY driver to control this bit instead, as well as setting the band
> gap one in order to get reliable PCIE communication.
> 
> While at it add another PHY driver to control PCIE only PHY registers,
> making AXG code more similar to G12A platform thus allowing to remove
> some specific platform handling in pci-meson driver.
> 
> Please note that CLKID_MIPI_ENABLE removable will be done in a different
> serie.
> 
> Changes since v5:
>  - Add additionalProperties in device tree binding documentation
>  - Make analog PHY required
> 
> Changes since v4:
>  - Rename the shared MIPI/PCIe PHY to analog
>  - Chain the MIPI/PCIe PHY to the PCIe one
> 
> Changes since v3:
>  - Go back to the shared MIPI/PCIe phy driver solution from v2
>  - Remove syscon usage
>  - Add all dt-bindings documentation
> 
> Changes since v2:
>  - Remove shared MIPI/PCIE device driver and use syscon to access register
>    in PCIE only driver instead
>  - Include devicetree documentation
> 
> Changes sinve v1:
>  - Move HHI_MIPI_CNTL0 bit control in its own PHY driver
>  - Add a PHY driver for PCIE_PHY registers
>  - Modify pci-meson.c to make use of both PHYs and remove specific
>    handling for AXG and G12A
> 
> [1] https://lkml.org/lkml/2019/12/16/119
> 
> Remi Pommarel (7):
>   dt-bindings: Add AXG PCIE PHY bindings
>   dt-bindings: Add AXG shared MIPI/PCIE analog PHY bindings
>   dt-bindings: PCI: meson: Update PCIE bindings documentation
>   arm64: dts: meson-axg: Add PCIE PHY nodes
>   phy: amlogic: Add Amlogic AXG MIPI/PCIE analog PHY Driver
>   phy: amlogic: Add Amlogic AXG PCIE PHY Driver
>   PCI: amlogic: Use AXG PCIE
> 
>  .../bindings/pci/amlogic,meson-pcie.txt       |  22 +-
>  .../amlogic,meson-axg-mipi-pcie-analog.yaml   |  35 ++++
>  .../bindings/phy/amlogic,meson-axg-pcie.yaml  |  52 +++++
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  16 ++
>  drivers/pci/controller/dwc/pci-meson.c        | 116 ++---------
>  drivers/phy/amlogic/Kconfig                   |  22 ++
>  drivers/phy/amlogic/Makefile                  |  12 +-
>  .../amlogic/phy-meson-axg-mipi-pcie-analog.c  | 188 +++++++++++++++++
>  drivers/phy/amlogic/phy-meson-axg-pcie.c      | 192 ++++++++++++++++++
>  9 files changed, 543 insertions(+), 112 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
>  create mode 100644 drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
>  create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c
> 

You forgot to keep the Reviewed-by/Acked-by tags from the previous reviews.

Neil
