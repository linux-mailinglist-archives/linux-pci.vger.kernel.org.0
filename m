Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AB715FDE0
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2020 10:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgBOJgK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Feb 2020 04:36:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgBOJgK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Feb 2020 04:36:10 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 484002084E
        for <linux-pci@vger.kernel.org>; Sat, 15 Feb 2020 09:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581759369;
        bh=77s9AGSrmY2uC8X9ep4myTtJnVg00ZN9jRlXRrvaG24=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mi+fxFzOStybH7IZFKMtjZzjbSIBOjpfdq2tb6eMs8UuBtHBJwoIPxf8vdHZ1K6rr
         p1flvGcPJEWDD4IMJkCwhx7Sy29KcSXUmob68SxAQBRmCZ1EEbR+KeYPSdXZ9azGuV
         2/DN98d9DJB5yZaImb4DGEzimhXItaYUffAP4pCk=
Received: by mail-wr1-f41.google.com with SMTP id z3so13832537wru.3
        for <linux-pci@vger.kernel.org>; Sat, 15 Feb 2020 01:36:09 -0800 (PST)
X-Gm-Message-State: APjAAAWWRKNm9cbiVgkY3+vEOy04z2zOEgoqN9asyGJwiT6FtVtmGQDa
        /mQyIMIsiQi+Idvx8mc6RIwPC7JX8HVp5hA+91tuBg==
X-Google-Smtp-Source: APXvYqw5avri6PHrQnPJzEOMuwzoacfNoEZg+aBei77RX1trdP5kEvDNrXlc6432RC92Le6+sSr5u6yyI2X7WwTCSek=
X-Received: by 2002:adf:8564:: with SMTP id 91mr9603108wrh.252.1581759367635;
 Sat, 15 Feb 2020 01:36:07 -0800 (PST)
MIME-Version: 1.0
References: <20170821192907.8695-3-ard.biesheuvel@linaro.org> <1581728065-5862-1-git-send-email-alan.mikhak@sifive.com>
In-Reply-To: <1581728065-5862-1-git-send-email-alan.mikhak@sifive.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 15 Feb 2020 10:35:56 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9W0v9owp85hkAatwCvu-y9z4BZxvbKf92N-s_nnD910Q@mail.gmail.com>
Message-ID: <CAKv+Gu9W0v9owp85hkAatwCvu-y9z4BZxvbKf92N-s_nnD910Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] pci: designware: add separate driver for the MSI part
 of the RC
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

(updated some email addresses in cc, including my own)

On Sat, 15 Feb 2020 at 01:54, Alan Mikhak <alan.mikhak@sifive.com> wrote:
>
> Hi..
>
> What is the right approach for adding MSI support for the generic
> Linux PCI host driver?
>
> I came across this patch which seems to address a similar
> situation. It seems to have been dropped in v3 of the patchset
> with the explanation "drop MSI patch [for now], since it
> turns out we may not need it".
>
> [PATCH 2/3] pci: designware: add separate driver for the MSI part of the RC
> https://lore.kernel.org/linux-pci/20170821192907.8695-3-ard.biesheuvel@linaro.org/
>
> [PATCH v2 2/3] pci: designware: add separate driver for the MSI part of the RC
> https://lore.kernel.org/linux-pci/20170824184321.19432-3-ard.biesheuvel@linaro.org/
>
> [PATCH v3 0/2] pci: add support for firmware initialized designware RCs
> https://lore.kernel.org/linux-pci/20170828180437.2646-1-ard.biesheuvel@linaro.org/
>

For the platform in question, it turned out that we could use the MSI
block of the core's GIC interrupt controller directly, which is a much
better solution.

In general, turning MSIs into wired interrupts is not a great idea,
since the whole point of MSIs is that they are sufficiently similar to
other DMA transactions to ensure that the interrupt won't arrive
before the related memory transactions have completed.

If your interrupt controller does not have this capability, then yes,
you are stuck with this little widget that decodes an inbound write to
a magic address and turns it into a wired interrupt.

I'll leave it up to the Synopsys folks to comment on whether this
feature is generic enough to describe it like this, but if so, I think
it still makes sense to model it this way rather than fold it into the
RC driver and description.
