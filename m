Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E061472F5
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 22:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgAWVFz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 16:05:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbgAWVFz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jan 2020 16:05:55 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 361C424655;
        Thu, 23 Jan 2020 21:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579813554;
        bh=dunM65I74eKTRUPfWJAtQ6Dy7fFVl4yChRTjzTEzWYc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EjAUbistvTOqR0a5V1Od77P12vsgWc6aS0MPkPR9KgqTY4/9LrVlQEcnfdV/2RVlK
         7Y+pHYblFGAJeuYMYRblD10S9IxQP/V7ZUW2xKdmiQDoVvNrFmssm6EF4G63TkE8CW
         M4+vhMUn/Drd354Ny/hoSew2iDKLjE1e0f15hx1A=
Received: by mail-qt1-f180.google.com with SMTP id h12so3677385qtu.1;
        Thu, 23 Jan 2020 13:05:54 -0800 (PST)
X-Gm-Message-State: APjAAAVr85EcEyeYWSXxvrgFC9mvs9vXXW0tlAIRpU6aWQzwVGCxlaKU
        fZiocoCbQcS+KSknW/P9/B5Gxed2cYNs39R4EQ==
X-Google-Smtp-Source: APXvYqySxHcOs6216VOirl3ClgOuv8JuMSzq6M7VnhGNDXB5MtonzXZs7sYmSERQxMar54LRvc3eotxuuqWc1g2lvu4=
X-Received: by 2002:ac8:59:: with SMTP id i25mr128556qtg.110.1579813553390;
 Thu, 23 Jan 2020 13:05:53 -0800 (PST)
MIME-Version: 1.0
References: <20191231193903.15929-1-robh@kernel.org> <20191231193903.15929-3-robh@kernel.org>
In-Reply-To: <20191231193903.15929-3-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 23 Jan 2020 15:05:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ+5B45FRfwc+OK2q+on8sNSyKuZ=w2C1Ar+38LKVrDOQ@mail.gmail.com>
Message-ID: <CAL_JsqJ+5B45FRfwc+OK2q+on8sNSyKuZ=w2C1Ar+38LKVrDOQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: PCI: Convert generic host binding to
 DT schema
To:     devicetree@vger.kernel.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 31, 2019 at 1:39 PM Rob Herring <robh@kernel.org> wrote:
>
> Convert the generic PCI host binding to DT schema. The derivative Juno,
> PLDA XpressRICH3-AXI, and Designware ECAM bindings all just vary in
> their compatible strings. The simplest way to convert those to
> schema is just add them into the common generic PCI host schema.
>
> The HiSilicon ECAM and Cavium ThunderX PEM bindings have an additional
> 'reg' entry, but are otherwise the same binding as well.
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: David Daney <david.daney@cavium.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - Add in Cavium PEM and HiSilicon ECAM bindings
> - Drop dma-coherent description
> - Drop leftover interrupt mapping text
> - Add description for generic compatibles and drop 'contains'
>
>  .../bindings/pci/arm,juno-r1-pcie.txt         |  10 -
>  .../bindings/pci/designware-pcie-ecam.txt     |  42 -----
>  .../bindings/pci/hisilicon-pcie.txt           |  42 -----
>  .../bindings/pci/host-generic-pci.txt         | 101 ----------
>  .../bindings/pci/host-generic-pci.yaml        | 172 ++++++++++++++++++
>  .../bindings/pci/pci-thunder-ecam.txt         |  30 ---
>  .../bindings/pci/pci-thunder-pem.txt          |  43 -----
>  .../bindings/pci/plda,xpressrich3-axi.txt     |  12 --
>  MAINTAINERS                                   |   2 +-
>  9 files changed, 173 insertions(+), 281 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt
>  delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
>  delete mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
>  delete mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt

Applied to DT tree.

Rob
