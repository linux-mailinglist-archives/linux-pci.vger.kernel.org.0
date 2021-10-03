Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A89C420300
	for <lists+linux-pci@lfdr.de>; Sun,  3 Oct 2021 18:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhJCQ5e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Oct 2021 12:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhJCQ5e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Oct 2021 12:57:34 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C448C0613EC;
        Sun,  3 Oct 2021 09:55:46 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id 66so670601vsd.11;
        Sun, 03 Oct 2021 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hFtEl8S10zL/n9vo1k1ZM/Rpdozvd/xX5yiKs0GwGUU=;
        b=LorWYhqsx2crztXC7e03nWh/YejEJa5hD6+IpyuxY6lIlOmrqBySlqtIEYmblGpOTA
         OTKXi+EojGSBwhDWhPI5UDSLbtZZGkhULp4AsFxRHg5JItYl8GhsNkxcknz0Ev9U/PhI
         vQX1NXmBjdeUaJ14Q5UeuQobXWCsjG7O4e92MEFOLNKGk7PuRpzvojkv1xRjkY8qHsnY
         T+l/D1zv5PKPuLx4fhzRF9eRGwIkzbCamLPzjHGU1DDBUNsZnyVc5TCU50Iws/L5oIkT
         LpXibcTsIEM9zJ+kdQyAESFSE5tMcbRqFbW+iqoLQ/cfG2wWLNMHAkz+T675NRc2dXXZ
         RUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFtEl8S10zL/n9vo1k1ZM/Rpdozvd/xX5yiKs0GwGUU=;
        b=t3kYJUABgSjjVUxHElklvQJtg/RndkQf8uRL9mutgAu3v6rMslR/X0FPOJdMsz8nNJ
         ACpjLLvGjh64nO4GUJvIz2IlYUvj7QhX2Jlww0feupEsoMR+2T/fZ4+lzJY9OleF96fV
         YCDa3s4H4/J1CxvciT0R/PtP8u/7hw1Mhu1OwTTL2ol9id6omTFAXGqmNlNGZixKjBkU
         wNfIwu2ftfAxu2DEkrfqYaw3M2atVDCwBSvc3Hr1u2iKX06yv7an8H1TUEfLTPRFm4Uc
         zaBSWwY60z9J2RmSS+gOTgNqZSfe6vPbGzWVXuPidhYNYucunH45qOybeIqeE12aTMKa
         cYSg==
X-Gm-Message-State: AOAM533hTPVWiAKgYBwgm/xHD/sEM15uNEC+SCxDKqwASY/LTZxNbPq3
        39HkdFkyT/Q07dIr4vPcYrx9VB2Zt5tggC1wbk4=
X-Google-Smtp-Source: ABdhPJxSiyXNfs3bBalwZBhKxEV1wxQFc8AoojgOrPVCE/jtNgs2qdDlQvTnTAOC+nMXt5+HYx8/SAtEYYX3d7pwQ7Q=
X-Received: by 2002:a05:6102:20c1:: with SMTP id i1mr10273822vsr.28.1633280145424;
 Sun, 03 Oct 2021 09:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210922050035.18162-1-sergio.paracuellos@gmail.com>
 <20210922050035.18162-4-sergio.paracuellos@gmail.com> <06500d9d-4156-f9df-956c-7306a2984a3e@gmail.com>
In-Reply-To: <06500d9d-4156-f9df-956c-7306a2984a3e@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sun, 3 Oct 2021 18:55:34 +0200
Message-ID: <CAMhs-H-JWCX6cr+t4ca=o=C1rzL-NNMDjcrYy5eifbMyfpXJGw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] MAINTAINERS: add myself as maintainer of the
 MT7621 PCI controller driver
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        John Crispin <john@phrozen.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sergei,

On Wed, Sep 22, 2021 at 11:05 AM Sergei Shtylyov
<sergei.shtylyov@gmail.com> wrote:
>
> On 22.09.2021 8:00, Sergio Paracuellos wrote:
>
> > Add myself as maintainer of the PCie Controlller driver for
>
>      PCIe Controller. :-)

Ups, true :) I will send v4 with this fixed if more changes are needed.

Best regards,
    Sergio Paracuellos

>
> > MT7621 SoCs.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> [...]
>
> MBR, Sergei
>
