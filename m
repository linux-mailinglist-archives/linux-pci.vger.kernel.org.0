Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86C022F4ED
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 18:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgG0QVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 12:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgG0QVy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 12:21:54 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5404420719;
        Mon, 27 Jul 2020 16:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595866914;
        bh=cLO0NxeCr6aiJsdIu7HcpNfBSCyRCi1cPeVbs8rOxGA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=akdPbJusg2G6SjMkHYw6Vs9om51Xwmjwo/KYRM+Mb/jZw7HTj9xYctrrK/Ydk0Baz
         2Z8FeL9U9fhwQPO9RxDdmC2/De6OOQOlZKhWcdEmba0JI0QJC0EHsGsVTTyiUV2TKp
         gDOPyRaLMTa+3WI/byJLoykWc5cxt2ZcA/IEjtM8=
Received: by mail-ot1-f44.google.com with SMTP id l27so5584677oti.3;
        Mon, 27 Jul 2020 09:21:54 -0700 (PDT)
X-Gm-Message-State: AOAM5315NHuNl0fYSwP22pVXojEg9pxTYVvuSpYNfL7PfaJSCtajhf5P
        TgEJVSDPwUQVvRlN6z9hYmB1KWUNQKgUA/rMIQ==
X-Google-Smtp-Source: ABdhPJxwQByrWhlNRNZf18NkjdycwcYghBUx6PVHU6APJ5seMssR7iKW5KXBj36RgrCcJB1MPOS+GYHvcbGF7AHoKV4=
X-Received: by 2002:a9d:4002:: with SMTP id m2mr21173627ote.129.1595866913712;
 Mon, 27 Jul 2020 09:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200623145528.1658337-1-thierry.reding@gmail.com> <20200623145528.1658337-2-thierry.reding@gmail.com>
In-Reply-To: <20200623145528.1658337-2-thierry.reding@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 27 Jul 2020 10:21:42 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+u=oFUAuURy-f8wCzagA-xKJES8RRf=kUSXJHoxOipBQ@mail.gmail.com>
Message-ID: <CAL_Jsq+u=oFUAuURy-f8wCzagA-xKJES8RRf=kUSXJHoxOipBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: tegra: Remove PLL power supplies
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 23, 2020 at 8:55 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> The Tegra PCI controller driver doesn't need to control the PLL power
> supplies directly, but rather uses the pads provided by the XUSB pad
> controller, which in turn is responsible for supplying power to the
> PLLs.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

What's going to happen here with a new dtb and an old kernel? Is it
going to error out due to missing supplies?

Rob
