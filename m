Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC861DEC88
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 17:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgEVPyk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 11:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:32794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730137AbgEVPyj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 11:54:39 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83134207F9;
        Fri, 22 May 2020 15:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590162879;
        bh=wGRZvt3Z+867keqt3QAT0Chc0raT1nG9Wgs/nGQRLbY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n/tqVDm2zEEQ4mU7pMZXNvqNl/+Y8L81dHXFkDfcoI4SgD9+fXk86fQkSXltNzcNk
         B+hEJas5BrQkR05xveBENPvtkW8Vgasbvs5S7fZw37eVL4MaZRqM3KXMXDZ7hqr4Vy
         n9WATdimBm1rfvbvcAe1tYeVUt6edphAX4TkYLsg=
Received: by mail-oi1-f175.google.com with SMTP id 23so8471991oiq.8;
        Fri, 22 May 2020 08:54:39 -0700 (PDT)
X-Gm-Message-State: AOAM530V0mN0of4VjGyclDDNiSKcoWpJwB86rcP4HSu5l0DLDU3HZW23
        MR1zGIyFessWFUf4DNf0OdV01SytntOtd52WqA==
X-Google-Smtp-Source: ABdhPJzQ8I+vECFyhVYyk2x4i27BUXmDXS2vlHoGkAessFkDVhzp1YCya/jmMWgspVusAE/rNHggVAYEsM+awFHIX9U=
X-Received: by 2002:a05:6808:7cb:: with SMTP id f11mr3196684oij.152.1590162878837;
 Fri, 22 May 2020 08:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200522033631.32574-1-kishon@ti.com> <20200522033631.32574-4-kishon@ti.com>
In-Reply-To: <20200522033631.32574-4-kishon@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 May 2020 09:54:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJjXUUgTbSAi83w4Eie-sVTrkLLMGh_PRQsd8k2vuua4Q@mail.gmail.com>
Message-ID: <CAL_JsqJjXUUgTbSAi83w4Eie-sVTrkLLMGh_PRQsd8k2vuua4Q@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] PCI: cadence: Convert all r/w accessors to
 perform only 32-bit accesses
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        linux-omap <linux-omap@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 9:37 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Certain platforms like TI's J721E using Cadence PCIe IP can perform only
> 32-bit accesses for reading or writing to Cadence registers. Convert all
> read and write accesses to 32-bit in Cadence PCIe driver in preparation
> for adding PCIe support in TI's J721E SoC.

Looking more closely I don't think cdns_pcie_ep_assert_intx is okay
with this and never can be given the PCI_COMMAND and PCI_STATUS
registers are in the same word (IIRC, that's the main reason 32-bit
config space accesses are broken). So this isn't going to work at
least for EP accesses. And maybe you need a custom .raise_irq() hook
to minimize any problems (such as making the RMW atomic at least from
the endpoint's perspective).

Rob
