Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B883A279FD0
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 11:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgI0JFn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 05:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgI0JFn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 05:05:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64704C0613CE;
        Sun, 27 Sep 2020 02:05:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f1so1710649plo.13;
        Sun, 27 Sep 2020 02:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zYhhCBAXk2rgjYgHVWVmGeflX53x+Xsb0tmWI78pw/Q=;
        b=jDuKX8xHrjokE4xb2XWzVvpcUnUVAtRlW135FzPnXfA23KalThB7i+ZACmIr7HElin
         mEwYrMIb7/SV2bDA1EhDOwAhLuKJ5B5fmLIgbUX8TKv/q8gtLg5OVk9R9Kb4UljZJ/wF
         CIuTUzgUXu6w655uCPoPMQHVIEfd9gN3bYO7RcWXLaqG0+THfZP3+pci2OKyOxV66zsF
         VXQWRfpimImDQ5XwIRfKvBNRy2fzRqT6hfywAMwdQr/Y8xdmxPtFT9BtNfMUDFdh/mRh
         hozVqQUG2aEJ2+hecp3h/zGII2KSn9N66GO0QT+Gj2rDJc+y27f0GDesSEdwvr3tO7QG
         E9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zYhhCBAXk2rgjYgHVWVmGeflX53x+Xsb0tmWI78pw/Q=;
        b=MAsx3VOIR42gwPiOlNCoRn1Bfti50bzLuDzqlgWCUrPs3hD8qVv4EvLDFWHaAnUx+8
         jc6OO3TjePEDXvtqphzoBTyojsodeMbSKBmXoq9qEc8yKDQbYd6EQ5aSF2qSYL1fNtzZ
         RvcgldwCMMMxVPlTc6xIClvhpfcjvKWcSkaLsSIL30FTbMkTzJYKNiitBIU/uN0Xkewf
         iizIR6GDR4Dmpac/2kAlFD23gjeQ3fbI/0FemjVuTgp8bPVwzaRVpEST2998m+x2RAum
         OBBU8PAxvMc/3v3F5o2pb/R+eyIX+hk0olt2pB855Cq8rw7qKgTbcXftb8GyBk7TzwP5
         1JlA==
X-Gm-Message-State: AOAM532/QRcoIomU5dCsbVN6ukKn+dcALF+89E48/ClHT3mS5fNAVFJn
        /KNo2NM9ceY5dc1z87NtyxCwiYU9MG1BEbFCuOM=
X-Google-Smtp-Source: ABdhPJyRqZRrcGE8GQdtWS7HHdqx6vkpdPgp3lrXRota6LAkRHcNMaBEq1lpxgLtZYxgActQ/XWS606GIu23vHStex0=
X-Received: by 2002:a17:90b:fc4:: with SMTP id gd4mr4938883pjb.129.1601197542886;
 Sun, 27 Sep 2020 02:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200927082736.14633-1-haifeng.zhao@intel.com> <20200927082736.14633-2-haifeng.zhao@intel.com>
In-Reply-To: <20200927082736.14633-2-haifeng.zhao@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Sep 2020 12:05:26 +0300
Message-ID: <CAHp75Vc_7RRtYv0HzqXqZO=hbN+tSFirxakJGkA1qYXZt676ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/5 V4] PCI: define a function to check and wait till port
 finish DPC handling
To:     Ethan Zhao <haifeng.zhao@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 27, 2020 at 11:33 AM Ethan Zhao <haifeng.zhao@intel.com> wrote:
>
> Once root port DPC capability is enabled and triggered, at the beginning
> of DPC is triggered, the DPC status bits are set by hardware and then
> sends DPC/DLLSC/PDC interrupts to OS DPC and pciehp drivers, it will
> take the port and software DPC interrupt handler 10ms to 50ms (test data
> on ICS(Ice Lake SP platform, see
> https://en.wikichip.org/wiki/intel/microarchitectures/ice_lake_(server)
> & stable 5.9-rc6) to complete the DPC containment procedure
> till the DPC status is cleared at the end of the DPC interrupt handler.
>
> We use this function to check if the root port is in DPC handling status
> and wait till the hardware and software completed the procedure.
>
> Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
> Tested-by: Wen Jin <wen.jin@intel.com>
> Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I haven't given you this tag. Where did you get it from?
(Dave, that's the case where we need to push the [internal review] process)

> Reviewed-by: Christoph Hellwig <hch@infradead.org>
> ---
> changes:
>  V2=EF=BC=9Aalign ICS code name to public doc.
>  V3: no change.
>  V4: response to Christoph's (Christoph Hellwig <hch@infradead.org>)
>      tip, move pci_wait_port_outdpc() to DPC driver and its declaration
>      to pci.h.
>
>  drivers/pci/pci.h      |  2 ++
>  drivers/pci/pcie/dpc.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fa12f7cbc1a0..8fdb0d823d5a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -455,10 +455,12 @@ void pci_restore_dpc_state(struct pci_dev *dev);
>  void pci_dpc_init(struct pci_dev *pdev);
>  void dpc_process_error(struct pci_dev *pdev);
>  pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
> +bool pci_wait_port_outdpc(struct pci_dev *pdev);
>  #else
>  static inline void pci_save_dpc_state(struct pci_dev *dev) {}
>  static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
>  static inline void pci_dpc_init(struct pci_dev *pdev) {}
> +inline bool pci_wait_port_outdpc(struct pci_dev *pdev) { return false; }
>  #endif
>
>  #ifdef CONFIG_PCI_ATS
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index daa9a4153776..2e0e091ce923 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -71,6 +71,33 @@ void pci_restore_dpc_state(struct pci_dev *dev)
>         pci_write_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, *cap);
>  }
>
> +bool pci_wait_port_outdpc(struct pci_dev *pdev)
> +{
> +       u16 cap =3D pdev->dpc_cap, status;
> +       u16 loop =3D 0;
> +
> +       if (!cap) {
> +               pci_WARN_ONCE(pdev, !cap, "No DPC capability initiated\n"=
);
> +               return false;
> +       }
> +       pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> +       pci_dbg(pdev, "DPC status %x, cap %x\n", status, cap);
> +
> +       while (status & PCI_EXP_DPC_STATUS_TRIGGER && loop < 100) {
> +               msleep(10);
> +               loop++;
> +               pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &sta=
tus);
> +       }
> +
> +       if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
> +               pci_dbg(pdev, "Out of DPC %x, cost %d ms\n", status, loop=
*10);
> +               return true;
> +       }
> +
> +       pci_dbg(pdev, "Timeout to wait port out of DPC status\n");
> +       return false;
> +}
> +
>  static int dpc_wait_rp_inactive(struct pci_dev *pdev)
>  {
>         unsigned long timeout =3D jiffies + HZ;
> --
> 2.18.4
>


--=20
With Best Regards,
Andy Shevchenko
