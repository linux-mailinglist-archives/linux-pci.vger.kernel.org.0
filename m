Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B93227E8E8
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 14:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgI3Mtn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 08:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbgI3Mtn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 08:49:43 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A66EF20936;
        Wed, 30 Sep 2020 12:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601470182;
        bh=07hSLMQoSpJSnvfViRt2er9D+38nJ1S81f1pw8lhyYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TgzEXMtQYCQ4hji7DOmdTnfI2lS3zxPnvm2KRDJwzG0XLgpzd0IJ97uLGmzQcoiQO
         Wd16HXQmPuh+vW9xDcMTBtL92NfjBHi97PdgUhKt+CrWruep/gPrasN/4kXkuDpSAl
         c/sO48ID8ZeZHagmOjeXESh3YeF+x5PprxgexAro=
Received: by mail-ot1-f53.google.com with SMTP id y5so1667507otg.5;
        Wed, 30 Sep 2020 05:49:42 -0700 (PDT)
X-Gm-Message-State: AOAM532Q4TwoigQSatjyiOws96T3YFJuPWUcH38NErt46dWA9eauyBYm
        gA/YshH8PXnu+14XpOOLfublX4nnfvH1WQsB6w==
X-Google-Smtp-Source: ABdhPJyR5QEMfsRPmsJEZQZKhpIiC7BJ0ZReMqLzMNDvpzBCR4FJ4JQzuiKDWDYNYA1PrgT9fFAZmU47iuzjUTHfy/s=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr1499160otp.129.1601470182041;
 Wed, 30 Sep 2020 05:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <1601444167-11316-1-git-send-email-hayashi.kunihiko@socionext.com> <1601444167-11316-4-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1601444167-11316-4-git-send-email-hayashi.kunihiko@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 30 Sep 2020 07:49:30 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+e+krj9xvOKdYNAGYFxPvRUsTQ=OzNvKg1D5_LherKvA@mail.gmail.com>
Message-ID: <CAL_Jsq+e+krj9xvOKdYNAGYFxPvRUsTQ=OzNvKg1D5_LherKvA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] PCI: dwc: Add common iATU register support
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

On Wed, Sep 30, 2020 at 12:36 AM Kunihiko Hayashi
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
