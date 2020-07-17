Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40C52244EF
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 22:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgGQULd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 16:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgGQULd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2020 16:11:33 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207F8C0619D2;
        Fri, 17 Jul 2020 13:11:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so7195403pgb.6;
        Fri, 17 Jul 2020 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gj+SF1uP1XQufJCq7QqUYQaIKzzxk/s/GrmcfjtHR50=;
        b=ubDyEgHV9Y2tDnKO+NB95LzoOB4OlcjoCTsJa+SW+xzZUvgGNzqi43o34HmU/VnILQ
         OEYQofz+2m8X1sb8sKABioeV4PeVOZAI/DvGnIkW9EAOHglOGj6d1oPuP9wzIU6m/IY0
         rPqhkRqifTT1eNErmPOsKHbi2svxa56Uor9JcEBUHLwa8sPo9XT+MeDwbrQ8l2bfO1Ii
         InTtIfnSeF8E90O7ugxTdipNtUtejDpsMjztGGCUh3/MhO+7KVqqjpQ+NhHb8BVK7B9E
         chF2xH/Oi2w/N9WIiFbeDDEvio8MXqTzlL8fg8BwIJRa03xl9yyGdp+gCclzLkW35wlg
         A1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gj+SF1uP1XQufJCq7QqUYQaIKzzxk/s/GrmcfjtHR50=;
        b=L3Nb1uUTGdLSVVKkWWj7opbvTYPeiVV0v86y/ei6qVYK0j5Km9xbaWOAARB2/rgq0L
         fRAlAkiYg7Kv5VnW67gnpX3kNE+MOhLwgxtudAgrRJNA1flxZWoer1dNOP+2X7iWhhj8
         n5x2ChcmvOd1254hTR4mdVjBqLYOUtfl25D1M6MDkLXwBkDISPcDdKxfK9sie9yFBtqC
         moIhgUaYZqHtoEJ4oafJTqQ5/Mo838PcA2m2NHPTmOr04EHKB8eYsYU5RGy0z9ZxTGLf
         VtQK8PRzr6UmS6YZPHo7nOv5VeZgzvnd3vO7eb5KUA0JUiJ5e7c0w6eowDWxSM6LkeAW
         Rv0A==
X-Gm-Message-State: AOAM532yyOz1sWNB4gc1dHL3NydpzlTcHZosTYvAU6rhTi/gtKJomrpX
        eqm1M7wN3CAZhLFYM7k2WDcvTQR2c+CwcapApulB3hbE
X-Google-Smtp-Source: ABdhPJx2lC7BmaEzpn7uXGLICSdt0Ct9vd/TU65OMo/eECbb17lBMT9bNBH/5FKY6swD+AJ4Ue0pdNur7WBnmP3ivL8=
X-Received: by 2002:aa7:8bcb:: with SMTP id s11mr9175270pfd.170.1595016692513;
 Fri, 17 Jul 2020 13:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200714062323.19990-1-david.e.box@linux.intel.com> <20200717190620.29821-2-david.e.box@linux.intel.com>
In-Reply-To: <20200717190620.29821-2-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Jul 2020 23:11:16 +0300
Message-ID: <CAHp75Vd3-Mc0=K+pDzpeB9MeHLFCni_4PbmsFTaXXzFMSmVgbg@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] PCI: Add defines for Designated Vendor-Specific
 Extended Capability
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 17, 2020 at 10:05 PM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Add PCIe Designated Vendor-Specific Extended Capability (DVSEC) and defines
> for the header offsets. Defined in PCIe r5.0, sec 7.9.6.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  include/uapi/linux/pci_regs.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f9701410d3b5..beafeee39e44 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -720,6 +720,7 @@
>  #define PCI_EXT_CAP_ID_DPC     0x1D    /* Downstream Port Containment */
>  #define PCI_EXT_CAP_ID_L1SS    0x1E    /* L1 PM Substates */
>  #define PCI_EXT_CAP_ID_PTM     0x1F    /* Precision Time Measurement */
> +#define PCI_EXT_CAP_ID_DVSEC   0x23    /* Designated Vendor-Specific */
>  #define PCI_EXT_CAP_ID_DLF     0x25    /* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT 0x26    /* Physical Layer 16.0 GT/s */
>  #define PCI_EXT_CAP_ID_MAX     PCI_EXT_CAP_ID_PL_16GT
> @@ -1062,6 +1063,10 @@
>  #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE        0xe0000000  /* LTR_L1.2_THRESHOLD_Scale */
>  #define PCI_L1SS_CTL2          0x0c    /* Control 2 Register */
>
> +/* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
> +#define PCI_DVSEC_HEADER1              0x4 /* Designated Vendor-Specific Header1 */
> +#define PCI_DVSEC_HEADER2              0x8 /* Designated Vendor-Specific Header2 */
> +
>  /* Data Link Feature */
>  #define PCI_DLF_CAP            0x04    /* Capabilities Register */
>  #define  PCI_DLF_EXCHANGE_ENABLE       0x80000000  /* Data Link Feature Exchange Enable */
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
