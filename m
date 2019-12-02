Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A6110ED53
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2019 17:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfLBQja (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Dec 2019 11:39:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbfLBQja (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Dec 2019 11:39:30 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D0C20748;
        Mon,  2 Dec 2019 16:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575304770;
        bh=BOYd7FIUwuN3tAA+k+QFiEnMWMetmq+s99CxPTiHIaU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zm2zuNr9W2dNwDK5mUKR3imz9kS2EL/vujtjBzVLAd9K9LlJiT7e2rpwNtCW+qQkh
         7trKeuBmMtlBlO4PiFNIxyT6iZMy7KaV77aqzH6YF/ucVdUQSngDxem1qQ4AHkO50P
         bp/hQfTMYHp4DFxIQyhe45ziL3hs+7hpOOif3jmE=
Received: by mail-qt1-f177.google.com with SMTP id n4so356189qte.2;
        Mon, 02 Dec 2019 08:39:29 -0800 (PST)
X-Gm-Message-State: APjAAAWeTF1XUN15ZRJNnK24As7gg2g7wcx/cEiEzyhl6Y+onK6vU223
        Zeq7hSD0QRchqgLzEC2qsyiEaSMN48w3abiQ0A==
X-Google-Smtp-Source: APXvYqwEfzQjYccT2wMEqMX5wDQatL2N4tHp4A7ns8FSpZxZv0Ca+4EE0DOAgrU16BLEIRXVuEDqcV+whmWoa1VfvRI=
X-Received: by 2002:ac8:341d:: with SMTP id u29mr179567qtb.300.1575304769066;
 Mon, 02 Dec 2019 08:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20191126091946.7970-1-nsaenzjulienne@suse.de> <20191126091946.7970-3-nsaenzjulienne@suse.de>
In-Reply-To: <20191126091946.7970-3-nsaenzjulienne@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 2 Dec 2019 10:39:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ=xXWVmnEJc7=Hg_NXhbHnCgkCOUMKRfmq7CKiGzg3Hg@mail.gmail.com>
Message-ID: <CAL_JsqJ=xXWVmnEJc7=Hg_NXhbHnCgkCOUMKRfmq7CKiGzg3Hg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: PCI: Add bindings for brcmstb's PCIe device
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        james.quinlan@broadcom.com, Matthias Brugger <mbrugger@suse.com>,
        Phil Elwell <phil@raspberrypi.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 26, 2019 at 3:20 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> From: Jim Quinlan <james.quinlan@broadcom.com>
>
> The DT bindings description of the brcmstb PCIe device is described.
> This node can only be used for now on the Raspberry Pi 4.
>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>
> ---
>
> Changes since v2:
>   - Add pci reference schema
>   - Drop all default properties
>   - Assume msi-controller and msi-parent are properly defined
>   - Add num entries on multiple properties
>   - use unevaluatedProperties
>   - Update required properties
>   - Fix license
>
> Changes since v1:
>   - Fix commit Subject
>   - Remove linux,pci-domain
>
> This was based on Jim's original submission[1], converted to yaml and
> adapted to the RPi4 case.
>
> [1] https://patchwork.kernel.org/patch/10605937/
>
>  .../bindings/pci/brcm,stb-pcie.yaml           | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
