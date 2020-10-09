Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CB42880A2
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 05:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbgJIDQh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 23:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbgJIDQh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2020 23:16:37 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6B4C0613D2;
        Thu,  8 Oct 2020 20:16:36 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i5so7895197edr.5;
        Thu, 08 Oct 2020 20:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S4gstCC/FekJI8QJ+2SOlsD1pKXfkis98By+iBN9Ti4=;
        b=jNjl33WDmlv7VtnPM5xttIFdg89OTGfAVQ5ZVUaMCPLxhEgXRjfbPCX8BD/hIR2RKs
         yWYwltFNyc/4s1vHMyfEvLO8IRllVCMyDp0ttjeoFqU3MuKSfiJ4zl7zf6/bm9EHcOqG
         KSw0wCvZ21TDXq/57ZLsjdtVXgaNE6N29X7tPsClpmTaCWUq5j37w6wOqkqDFkw0AwI9
         by0x9Y2Ps+UFAhwDoIHAKoZy5JrVqVUGyyDtfNXbNH6IcYcQcYDi5GJ7Y4IAPYJkrAfc
         EokiF+ejLKBYrxeq9MXoJiuO7RHgMAGe9K4VISFdYBGt9IKngGCh3zZdN/eoQ4kn+o/P
         t/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S4gstCC/FekJI8QJ+2SOlsD1pKXfkis98By+iBN9Ti4=;
        b=brs/bohK5/3Qcn9z7UUyWdXOIeo3wkimqof7urPuG9tShs1BcCwsusHHNDsreii2R2
         g93n2qtgK0hDYaJ7lXR/MwmZ0xGHEz8ZXbAARu1+dtV2Ht3oRA7kPuk5RCkmtwNFNhWa
         vcwG/vZukgQ11dHelSdkAc3PJVdERHAwVqVtvvbIz3uyfIEIAZ8LsXvUtow4Cx+pa64W
         ZAkLvwvlhNsi/5xHKWRFZgR9u1gB++Fy1fQeY3mTq5YpzFWrogM0p5W4bJLP9/vyF6oW
         Zx0CuaRMY9hd9UdXcPzLR6n3iMvyDQ8X+NmIvEZ9ihhdbAfrLjuOTUkwyPu/a2KxtIok
         QDvA==
X-Gm-Message-State: AOAM5331igb6UmXVRs3gfMx3rHaCjCHt4cRu0DcfhXisG9gkenMvU9kN
        B+OLI97MDz9eB1RfNe8dV61s/70N1CRl6/L/oXKpMwYoadDhNg==
X-Google-Smtp-Source: ABdhPJzyTKYR17OrIp2pbuAikyU62aKMT80JVOwYk4I58TqifFjCJAUTIKpgM+wlbBCpUUyKe2MKZdN9xcACzAsvUms=
X-Received: by 2002:a05:6402:1779:: with SMTP id da25mr12157144edb.60.1602213395450;
 Thu, 08 Oct 2020 20:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201007113158.48933-1-haifeng.zhao@intel.com>
 <20201007113158.48933-3-haifeng.zhao@intel.com> <4bedeb35-942e-5ad3-9721-62495af1f09a@intel.com>
In-Reply-To: <4bedeb35-942e-5ad3-9721-62495af1f09a@intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Fri, 9 Oct 2020 11:16:23 +0800
Message-ID: <CAKF3qh2BPt1Vgh+P_dJ=bHKMAhGjJmA2TY3WpBEmz=x0MOahNw@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] PCI/DPC: define a function to check and wait till
 port finish DPC handling
To:     "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
Cc:     Ethan Zhao <haifeng.zhao@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 8, 2020 at 2:16 AM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@intel.com> wrote:
>
>
> On 10/7/20 4:31 AM, Ethan Zhao wrote:
> > Once root port DPC capability is enabled and triggered, at the beginnin=
g
> > of DPC is triggered, the DPC status bits are set by hardware and then
> > sends DPC/DLLSC/PDC interrupts to OS DPC and pciehp drivers, it will
> > take the port and software DPC interrupt handler 10ms to 50ms (test dat=
a
> > on ICS(Ice Lake SP platform, see
> > https://en.wikichip.org/wiki/intel/microarchitectures/ice_lake_(server)
> > & stable 5.9-rc6) to complete the DPC containment procedure
> This data is based on one particular architecture. So using this
> to create a timed loop in pci_wait_port_outdpc() looks incorrect.

To clarify there, it is not random to wait for specific 1000ms for
specific architecture.
Though there is no specification to say how many ms totally cost by
hardware DPC containment,
plus its interrupt handling.  but you could read the whole PCIe
specification to know how
many ms cost at most by power state transition, link training etc, you
may know the max single delay
in hardware state transition is 200ms. Other small delay in hardware
state transition is 100ms,
48ms, 32ms etc.

If the DPC containment hardware procedure is pure resetting (or cold
power on) without
software access configuration as the worst case. we wait its handling
process from 10ms
(actually 20ms is the minimum delay we could do with msleep() )  till
1000ms timeout is a
reasonable value.

Thanks,
Ethan




>
> I still recommend looking for some locking model to fix this
> issue (may be atomic state flag or lock).
> > till the DPC status is cleared at the end of the DPC interrupt handler.
> >
> > We use this function to check if the root port is in DPC handling statu=
s
> > and wait till the hardware and software completed the procedure.
> >
> > Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
> > Tested-by: Wen Jin <wen.jin@intel.com>
> > Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
> > ---
> > changes:
> >   v2=EF=BC=9Aalign ICS code name to public doc.
> >   v3: no change.
> >   v4: response to Christoph's (Christoph Hellwig <hch@infradead.org>)
> >       tip, move pci_wait_port_outdpc() to DPC driver and its declaratio=
n
> >       to pci.h.
> >   v5: fix building issue reported by lkp@intel.com with some config.
> >   v6: move from [1/5] to [2/5].
> >   v7: no change.
> >   v8: no change.
> >
> >   drivers/pci/pci.h      |  2 ++
> >   drivers/pci/pcie/dpc.c | 27 +++++++++++++++++++++++++++
> >   2 files changed, 29 insertions(+)
> >
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index fa12f7cbc1a0..455b32187abd 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -455,10 +455,12 @@ void pci_restore_dpc_state(struct pci_dev *dev);
> >   void pci_dpc_init(struct pci_dev *pdev);
> >   void dpc_process_error(struct pci_dev *pdev);
> >   pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
> > +bool pci_wait_port_outdpc(struct pci_dev *pdev);
> >   #else
> >   static inline void pci_save_dpc_state(struct pci_dev *dev) {}
> >   static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
> >   static inline void pci_dpc_init(struct pci_dev *pdev) {}
> > +static inline bool pci_wait_port_outdpc(struct pci_dev *pdev) { return=
 false; }
> >   #endif
> >
> >   #ifdef CONFIG_PCI_ATS
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index daa9a4153776..2e0e091ce923 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -71,6 +71,33 @@ void pci_restore_dpc_state(struct pci_dev *dev)
> >       pci_write_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, *cap);
> >   }
> >
> > +bool pci_wait_port_outdpc(struct pci_dev *pdev)
> > +{
> > +     u16 cap =3D pdev->dpc_cap, status;
> > +     u16 loop =3D 0;
> > +
> > +     if (!cap) {
> > +             pci_WARN_ONCE(pdev, !cap, "No DPC capability initiated\n"=
);
> > +             return false;
> > +     }
> > +     pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> > +     pci_dbg(pdev, "DPC status %x, cap %x\n", status, cap);
> > +
> > +     while (status & PCI_EXP_DPC_STATUS_TRIGGER && loop < 100) {
> > +             msleep(10);
> > +             loop++;
> > +             pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &sta=
tus);
> > +     }
> > +
> > +     if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
> > +             pci_dbg(pdev, "Out of DPC %x, cost %d ms\n", status, loop=
*10);
> > +             return true;
> > +     }
> > +
> > +     pci_dbg(pdev, "Timeout to wait port out of DPC status\n");
> > +     return false;
> > +}
> > +
> >   static int dpc_wait_rp_inactive(struct pci_dev *pdev)
> >   {
> >       unsigned long timeout =3D jiffies + HZ;
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>
