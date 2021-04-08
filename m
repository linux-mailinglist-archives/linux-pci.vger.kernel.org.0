Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38098358E9B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 22:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhDHUkY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 16:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhDHUkV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 16:40:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDAAC061760;
        Thu,  8 Apr 2021 13:40:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x4so4008310edd.2;
        Thu, 08 Apr 2021 13:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cdnz5MS52djhpwbbkLCsPHwd/MEWr4tBT7iNzH5Z8TU=;
        b=UQ1Szyiw0zN99Cb0U3iJfFF1fmoF05UMQdTU631crr73g/tROQxrTQEcC0RhTB6uRa
         8alpIEX1ZJEL14WlVVnH93048ryQPOYL21KlXpUV9tDNuLdN1TpIGIjrEuTCOmsTR5G6
         9iyx2rg+RwVxabamLFt3PTTY34DJubbAVWNquJW6OR9Mj9OlJrTc+1dv9rgpfiSQA094
         zeT3U2/qIWyVKgeMQt95eEa2ByoC/fgSpu1+WxVt0onI0TmE9TMdorH5AXm9iwwZdi5f
         6BWSlq7sH/ZvNqMph496kFPAopuCzD4hRBX/Nq0dHl+Mz9yVsbWFCZElpJnZ8h0zxxgE
         NcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cdnz5MS52djhpwbbkLCsPHwd/MEWr4tBT7iNzH5Z8TU=;
        b=TEOWMvuxr4fAl1SScF9HqPOM2SeYEptq+sIXZpS6dCGSxQPGiAGQdnPgR2Ikfp9bmm
         LH9Z+LDF2sdJUzkqCkXkgh/eSe3xUFyiwzIDeizfsZ4FqvqWVoISkbb7QDUTr/jP4R99
         3+nTx5UETUNsnOVMqupI0PPhI4O1SUhfJ4AIYhJNk2ehK4x/NrWDPSyDXCqDJH79P19Q
         WobYFLlqE0VR7Bn1gpxmSlFzcVR11vAMJrXCFqhqcb5aIHMeA5uF4E3+fdaA0JGM6C1K
         BIRo6rM/DeEqpEj5EpHG0Bduv3ZzAsHFDHwiqYUBbc4x8xaU9CAn4M/5T9/VxWmuI5Ig
         eaaw==
X-Gm-Message-State: AOAM532WiX1TuXk2epImNnhfCfwHMSd5HxDkUR9cb4bjbMNNtxjffQuc
        LHWhMIUg94rdJBVVPEPTdUJX6Zyvoi2XH+l9Mow=
X-Google-Smtp-Source: ABdhPJzVf196FdKT3Xhp5a/Pki2NE6SMHEglXfT94rbLCW/KYq8U4vKXaSmXj4/enbczwHdEjvvGLcaCiBMypQx44Yo=
X-Received: by 2002:a05:6402:13ce:: with SMTP id a14mr14124148edx.365.1617914408152;
 Thu, 08 Apr 2021 13:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210106135540.48420-1-martin.blumenstingl@googlemail.com> <20210323113559.GE29286@e121166-lin.cambridge.arm.com>
In-Reply-To: <20210323113559.GE29286@e121166-lin.cambridge.arm.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 8 Apr 2021 22:39:57 +0200
Message-ID: <CAFBinCBaa_uGBg8x=nPTs6sYNqv_OCU2PgCaUKLQGNSN+Up99A@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc/intel-gw: Fix enabling the legacy PCI interrupt lines
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        rtanwar@maxlinear.com
Cc:     Dilip Kota <eswara.kota@linux.intel.com>, robh@kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Tue, Mar 23, 2021 at 12:36 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Jan 06, 2021 at 02:55:40PM +0100, Martin Blumenstingl wrote:
> > The legacy PCI interrupt lines need to be enabled using PCIE_APP_IRNEN
> > bits 13 (INTA), 14 (INTB), 15 (INTC) and 16 (INTD). The old code however
> > was taking (for example) "13" as raw value instead of taking BIT(13).
> > Define the legacy PCI interrupt bits using the BIT() macro and then use
> > these in PCIE_APP_IRN_INT.
> >
> > Fixes: ed22aaaede44 ("PCI: dwc: intel: PCIe RC controller driver")
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-intel-gw.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > index 0cedd1f95f37..ae96bfbb6c83 100644
> > --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> > +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > @@ -39,6 +39,10 @@
> >  #define PCIE_APP_IRN_PM_TO_ACK               BIT(9)
> >  #define PCIE_APP_IRN_LINK_AUTO_BW_STAT       BIT(11)
> >  #define PCIE_APP_IRN_BW_MGT          BIT(12)
> > +#define PCIE_APP_IRN_INTA            BIT(13)
> > +#define PCIE_APP_IRN_INTB            BIT(14)
> > +#define PCIE_APP_IRN_INTC            BIT(15)
> > +#define PCIE_APP_IRN_INTD            BIT(16)
> >  #define PCIE_APP_IRN_MSG_LTR         BIT(18)
> >  #define PCIE_APP_IRN_SYS_ERR_RC              BIT(29)
> >  #define PCIE_APP_INTX_OFST           12
> > @@ -48,10 +52,8 @@
> >       PCIE_APP_IRN_RX_VDM_MSG | PCIE_APP_IRN_SYS_ERR_RC | \
> >       PCIE_APP_IRN_PM_TO_ACK | PCIE_APP_IRN_MSG_LTR | \
> >       PCIE_APP_IRN_BW_MGT | PCIE_APP_IRN_LINK_AUTO_BW_STAT | \
> > -     (PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTA) | \
> > -     (PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTB) | \
> > -     (PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTC) | \
> > -     (PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTD))
> > +     PCIE_APP_IRN_INTA | PCIE_APP_IRN_INTB | \
> > +     PCIE_APP_IRN_INTC | PCIE_APP_IRN_INTD)
> >
> >  #define BUS_IATU_OFFSET                      SZ_256M
> >  #define RESET_INTERVAL_MS            100
>
> This looks like a significant bug - which in turn raises the question
> on how well this driver has been tested.
to give them the benefit of doubt: maybe only MSIs were tested

> Dilip, can you review and ACK asap please ?
From "Re: MaxLinear, please maintain your drivers was Re: [PATCH]
leds: lgm: fix gpiolib dependency" [0]:
> Please send any Lightning Mountain SoC related issues email to Rahul
> Tanwar (rtanwar@maxlinear.com) and I will ensure that I address the
> issues in a timely manner.
so I added rtanwar@maxlinear.com to this email


Best regards,
Martin


[0] https://lkml.org/lkml/2021/3/16/282
