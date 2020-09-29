Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9428E27B8BC
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 02:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgI2APR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 20:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgI2APR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 20:15:17 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2F5A21BE5;
        Tue, 29 Sep 2020 00:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601338516;
        bh=baIPeOgemeFr61uwQTlOv6Qsc/kogTd8QywnpnIgCzE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yegf2XtH8SJ8KJrkLu4ZM1WUOwqI3M5rpA+j/Fg8bXfmRMYGQrgp53N0wathTmqcx
         OYGWnA4nXinfJkcWt+e+jEn7K9pNyztNlIS5nyKgptNF/HiBw2tMLhTjitpyq8bnZz
         CtVKclxDiOVAfSto1MtiReVErWkv0ySpyhUCeVGw=
Received: by mail-oi1-f178.google.com with SMTP id z26so3432206oih.12;
        Mon, 28 Sep 2020 17:15:16 -0700 (PDT)
X-Gm-Message-State: AOAM531EFzAlV4p820/eZH57HuvffgbIRPuNcxNSMsCggwGnZ9kt2PT7
        24N3NxDweB0dTcd03ptX3c0SVHGTV59LVJasUQ==
X-Google-Smtp-Source: ABdhPJzH+t8p6+dN829taP8rHxo538zd3MXuzlsWyfOJJnlx9dtFVLSsire65FxiQ6bsLGtjD4RsKM5J5UrwPPLmd+c=
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr945214oie.152.1601338516089;
 Mon, 28 Sep 2020 17:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <1601255133-17715-1-git-send-email-hayashi.kunihiko@socionext.com> <1601255133-17715-4-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1601255133-17715-4-git-send-email-hayashi.kunihiko@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 28 Sep 2020 19:15:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLmbxS=ha75ZZprgnDSiSYZPrMRebdogq-4W4hgw3urKg@mail.gmail.com>
Message-ID: <CAL_JsqLmbxS=ha75ZZprgnDSiSYZPrMRebdogq-4W4hgw3urKg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PCI: dwc: Add common iATU register support
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 27, 2020 at 8:05 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> This gets iATU register area from reg property that has reg-names "atu".
> In Synopsys DWC version 4.80 or later, since iATU register area is
> separated from core register area, this area is necessary to get from
> DT independently.
>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
