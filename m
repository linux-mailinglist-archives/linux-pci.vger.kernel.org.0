Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B76827477C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 19:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgIVRam (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 13:30:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVRam (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 13:30:42 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429FF22206;
        Tue, 22 Sep 2020 17:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600795842;
        bh=h/Ld3B+y9ti44HaX9WBK4umuicsG2Hw4yBOtkCQsXm0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hA8Xdhw2USh4kEEPqjKDIT0mhCkpZpCochvP0DjCFvzxc+vAhm+YpgHLL9mZu5HeU
         GakRDxsjIPzPj53y2Za7Fwa3UN8BOj34bJ5v+X1TB8hzlE1YanZlO80Qyx0G018TVo
         vmRBRRVaboUuhyQvTKIIuBkvUDsfzT07l4CyQb6Y=
Received: by mail-oi1-f176.google.com with SMTP id v20so21914043oiv.3;
        Tue, 22 Sep 2020 10:30:42 -0700 (PDT)
X-Gm-Message-State: AOAM532VnlAaIX+rJmpqHBcv+D/A4hGgmVZj4YvK30PBIo+3WFDGnDoF
        X8mvKEtdsnrX308ALJ7Cdf9we5pNIjiGYIYTLA==
X-Google-Smtp-Source: ABdhPJyR6TOz5P3635ttyIAV8HOhgZ+lkgMa2lt2O2qCFj7x8E0qhcXa056jzEwtzQMukGxjEo9dw8CwafWjv0lsZfM=
X-Received: by 2002:aca:1711:: with SMTP id j17mr3427994oii.152.1600795841602;
 Tue, 22 Sep 2020 10:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200921074953.25289-1-narmstrong@baylibre.com>
In-Reply-To: <20200921074953.25289-1-narmstrong@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Sep 2020 11:30:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLZzxXcvoqd29NM45UjL-mbSiHphTO_zOwbCwPKd+jWEw@mail.gmail.com>
Message-ID: <CAL_JsqLZzxXcvoqd29NM45UjL-mbSiHphTO_zOwbCwPKd+jWEw@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc/meson: do not fail on wait linkup timeout
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yue Wang <yue.wang@amlogic.com>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 21, 2020 at 1:50 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> When establish link timeouts, probe fails but the error is unrelated since
> the PCIe controller has been probed succesfully.
>
> Align with most of the other dw-pcie drivers and ignore return of
> dw_pcie_wait_for_link() in the host_init callback.

I think all, not most DWC drivers should be aligned. Plus the code
here is pretty much the same, so I'm working on moving all this to the
common DWC code. Drivers that need to bring up the link will need to
implement .start_link() (currently only used for EP mode). Most of the
time that is just setting the LTSSM bit which Synopsys thought letting
every vendor do their own register for was a good idea. Sigh.

Rob
