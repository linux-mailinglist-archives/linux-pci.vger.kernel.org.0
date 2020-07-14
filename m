Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BDB21EB90
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 10:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgGNIkg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 04:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgGNIkf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 04:40:35 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C543C061755;
        Tue, 14 Jul 2020 01:40:35 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md7so1196827pjb.1;
        Tue, 14 Jul 2020 01:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYA5e7ARxM6LIN4taGv+yFcdrKzm+MTO5NvTdpW41Ro=;
        b=T2lOnTLdKYH6OO1hKVWnOfUuo1+qOtx6+BTH4Z1JtU+qqoH+iYiR71ofLyjdn1Hq2d
         +mgYi4dVqEidffxZhXdFLx824uYHihWjHM7oqNoRfisNq3ZQt4zPA6ZUf9T4yN2dzeXN
         W4HZLj/2n/czW7sVpgBSyMWqlKX2zXbmgYF0GxYvoG2BPPtu5yf4FqbP0asJUSwnvahc
         0E0x+XLsSKsfvoj5PA8+NGNMIXtPmQvVZ9oBU+nym+MJ/5wz1ETBDXlVe6+2dCeFG9nW
         y/jnhzfD8//SByShVty8xDksD8PKBqj9WS5guPELcOy6ivddE7+lokHZUXcGvVFcbFyq
         Ycsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYA5e7ARxM6LIN4taGv+yFcdrKzm+MTO5NvTdpW41Ro=;
        b=f3vbucVaeO60cAcCZiHM7T/D/ME64Wzu5GenEyDUwaTMYyzGjfDLsySzXAptOTkdbv
         QP/5/XscI87T/b8b7LnIksXvBBm1o0/47v1RPSOZp9QR8XALrK5BJF6c2JfqGIt8Vuhc
         2P14WIX269MoTq/fmHtHleswgs6ejbNIjzQD9RrjtddyPG8Zksj+981xOuyDRw6G43j6
         EYknnVoiyIGAaFbQdBiJz4DlE3QdDiqB5t8RaTbCrqTLQ5q6ezB1vB6O9SobSqsRLV/K
         b+RZ1X90YfgUK6Qmtuz0ZRcfOz47Yq24c2x+EEbHkg2anf/l/DesF8653XnGllQrQ7wl
         f8Yw==
X-Gm-Message-State: AOAM5308aNHcJ6lLBT9R5BiuI1iU1pFY6G4PP+D8jAeUwJzms8DPw8OV
        7vJ7iztxCD5Zb+ku2rEEFr0xYrszWZpRI6smIeg=
X-Google-Smtp-Source: ABdhPJwyHSC2MglEc3MU1qW3Ba6mSuojPSrl7xxdg6zyyzvWhZHwZROYnhBDgZqucI3YJBIFjtYrDUxvZ8yZANTLbkE=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr3597107pjp.228.1594716035169;
 Tue, 14 Jul 2020 01:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200508021844.6911-1-david.e.box@linux.intel.com> <20200714062323.19990-2-david.e.box@linux.intel.com>
In-Reply-To: <20200714062323.19990-2-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jul 2020 11:40:18 +0300
Message-ID: <CAHp75VezDB5HqNn+rw72z2yt0buGh+szi4ytOMPejtQWMwr0+w@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] PCI: Add defines for Designated Vendor-Specific Capability
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

On Tue, Jul 14, 2020 at 9:22 AM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Add PCIe DVSEC extended capability ID and defines for the header offsets.
> Defined in PCIe r5.0, sec 7.9.6.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  include/uapi/linux/pci_regs.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f9701410d3b5..09daa9f07b6b 100644
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
> +#define PCI_DVSEC_HEADER1              0x4 /* Vendor-Specific Header1 */
> +#define PCI_DVSEC_HEADER2              0x8 /* Vendor-Specific Header2 */
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
