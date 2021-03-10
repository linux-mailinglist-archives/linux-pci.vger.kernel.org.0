Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B745334960
	for <lists+linux-pci@lfdr.de>; Wed, 10 Mar 2021 22:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhCJVDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 16:03:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230521AbhCJVDN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Mar 2021 16:03:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8137F64FC9;
        Wed, 10 Mar 2021 21:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615410192;
        bh=Jf27xRVYrSMID5wTQvmY/hiQVLNvvOHY8yJ1fyvs+0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gkHWX/k3e2zE2f3boEGX7GUR611wYLRuGOuOjdp+DTcaXuOlK0/5/SoEmO1hKh+i+
         2OYp5Y3F8Dgiusca7JwirA2QJpeRYW70ovAsNpPpvFjfmqKUz1Kr/JRTMekzkGm2MV
         lSh0Wc0/M3n5g8BX567pq4s0c/RrftUNxdkhhLQPiYmObp5lKZ039kMMTXJiOohaUM
         1zBmORIFVQ6hUDXRLPKXf2hec64ESYUr2x7kT2glWL3JUap07qYeDfM9Iy3nwrnRKw
         5dUC9UiMMgtINpkkFK6yhyLM+2z4bQWzkfCZoqzU2lUq3gzqe2UnVW1apTcU32H96b
         tG1SjWz6jbkqQ==
Received: by mail-oi1-f176.google.com with SMTP id x78so20717599oix.1;
        Wed, 10 Mar 2021 13:03:12 -0800 (PST)
X-Gm-Message-State: AOAM533JLASTx064DSuU3WHVeVH1XmNXW/s/6jLeUDrlHBj24K10NlI3
        bmVW6HL3JMM0RKufcoT0RIzd3Pz+KLN8LrMFF/o=
X-Google-Smtp-Source: ABdhPJxpCLy1jm0jLk8mhwUrnd66JTa55h/eyphlho8VJcUZlwk+T07aVZCbeZx7HMknpX1hePxVclScPgclVctmiK4=
X-Received: by 2002:aca:5e85:: with SMTP id s127mr3606549oib.67.1615410191745;
 Wed, 10 Mar 2021 13:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20210308152501.2135937-1-arnd@kernel.org> <20210310193246.GA2033984@bjorn-Precision-5520>
In-Reply-To: <20210310193246.GA2033984@bjorn-Precision-5520>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 10 Mar 2021 22:02:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2tNAqjSSP4g6dguT58C4DUGUT4Jgf-Osa1Da03cecLRQ@mail.gmail.com>
Message-ID: <CAK8P3a2tNAqjSSP4g6dguT58C4DUGUT4Jgf-Osa1Da03cecLRQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: controller: al: select CONFIG_PCI_ECAM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 10, 2021 at 8:32 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Mar 08, 2021 at 04:24:46PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Compile-testing this driver without ECAM support results in a link
> > failure:
> >
> > ld.lld: error: undefined symbol: pci_ecam_map_bus
> > >>> referenced by pcie-al.c
> > >>>               pci/controller/dwc/pcie-al.o:(al_pcie_map_bus) in archive drivers/built-in.a
> >
> > Select CONFIG_ECAM like the other drivers do.
>
> Did we add these compile issues in the v5.12-rc1?  I.e., are the fixes
> candidates for v5.12?

No, the bug exists but is hidden until you apply patch 3/3 because the
driver is never compile tested on anything other than arm64, which
turns on PCI_ECAM unconditionally.

Merging all three for 5.13 is sufficient.

       Arnd
