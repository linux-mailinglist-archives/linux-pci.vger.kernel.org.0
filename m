Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A811B0568
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 11:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgDTJRg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 05:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTJRg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2020 05:17:36 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A70FC061A0C;
        Mon, 20 Apr 2020 02:17:35 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id g14so1966572ooa.4;
        Mon, 20 Apr 2020 02:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AnWmmqyadUpYAg/OdUB3REEr7mswPcf6gajx39PJsls=;
        b=iMz5C7M8nwUrx4PejZt5Ek6DNYZFxgkLLWtP2mqKgO2eJVezj+9VzWUQUMHbt+OmbJ
         6zeKio16xHc6GdLed5Xy3i/+R9PDWQ91F9WupihOLmer9oz2zNYMIu2dQjHhwc0T1HjC
         B3m1VobXmuxbat9P+52AvY8zl/GGEjIVXYjYurr7gorAu8SJk1mHuDW0CxLswbHPk4w8
         lSnfXrCC3HR/nc3KiUqB4InexSyq6q/Og8e1aRe3fddjrIX1Whl0C4gAkft9JiU+iD99
         3s52XY3R79g2gBni4SVfzv8VeZ/y2PBZpq+ZLu2L8fKxnL1KiZ26JiZ+LDPi9YYkhw+k
         U+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AnWmmqyadUpYAg/OdUB3REEr7mswPcf6gajx39PJsls=;
        b=YUfAB3njKP9zFkW+7QZbEWYQI10aSmc45mSlbBfgYpc8xvme25D6bUFIkX9Gm7mQU0
         sYc0U0c56dDNPYhLJS4c0Wj5KJclDC74pzXmjxNbHs+hQS1STult90+1Kr3bS302jnt+
         CTPcYtm9dleiaK5H7eiOamR+6wWobFpjp2GYyTXTFUCSxrlZCfUPD0JzD9XRm33xhVyp
         SQvQIOb7KXdajSAqL3IMtafFcZi8+3hwPokoGtW1qTKgIU0bsGxFew5xyAav1xIG1eME
         iYygVSLj2h08AqdFHnkvc5S4Ls8xbtqZ/doWRg7fW0eyO9eztDDaPUaZ04HjkxH7A75u
         NS6w==
X-Gm-Message-State: AGi0Pub5QMuvAxP17OsCAIuQHoitZ+4newfr4uuLEI//aJUx5mPQXJrT
        EcVWt6sdeJH3vZgKqfb0vadQqT3IOYreJeFdc3C3UO9H
X-Google-Smtp-Source: APiQypI4Gr+ymKJWQD9+txTG6EVrczz7o4VweZ+9eE91Uh1wR935sBN7tHzoKMtrzlSaP1JA6RLmCgydoef3Y6ZHrSo=
X-Received: by 2002:a4a:e08b:: with SMTP id w11mr12080171oos.62.1587374254916;
 Mon, 20 Apr 2020 02:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <1587302823-4435-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587302823-4435-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com> <TYAPR01MB4544FDF2FEDBED104F6C6C45D8D40@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB4544FDF2FEDBED104F6C6C45D8D40@TYAPR01MB4544.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 20 Apr 2020 10:17:08 +0100
Message-ID: <CA+V-a8vkZwgOf8gkxWU62A3L1BTXw_y2H5MGo-7-+ad28q1tWQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] PCI: endpoint: Add support to handle multiple base
 for mapping outbound memory
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yoshihiro,

Thank you for the review.

On Mon, Apr 20, 2020 at 10:04 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> Hi Prabhakar-san,
>
> Thank you for the patch!
>
> > From: Lad Prabhakar, Sent: Sunday, April 19, 2020 10:27 PM
> <snip>
> > @@ -109,11 +137,22 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_init);
> >   */
> >  void pci_epc_mem_exit(struct pci_epc *epc)
> >  {
> > -     struct pci_epc_mem *mem = epc->mem;
> > +     struct pci_epc_mem *mem;
> > +     int i;
> >
> > +     if (!epc->num_windows)
> > +             return;
> > +
> > +     for (i = 0; i <= epc->num_windows; i++) {
>
> I'm sorry, I overlooked when I reviewed before.
> This condition should be "i < epc->num_windows".
>
Argh my bad, will fix it.

> > +             mem = epc->windows[i];
> > +             kfree(mem->bitmap);
> > +             kfree(mem);
> > +     }
> > +     kfree(epc->windows);
> > +
> > +     epc->windows = NULL;
> >       epc->mem = NULL;
> > -     kfree(mem->bitmap);
> > -     kfree(mem);
> > +     epc->num_windows = 0;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> >
> > @@ -129,31 +168,57 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> >  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
> >                                    phys_addr_t *phys_addr, size_t size)
> >  {
> > -     int pageno;
> >       void __iomem *virt_addr = NULL;
> > -     struct pci_epc_mem *mem = epc->mem;
> > -     unsigned int page_shift = ilog2(mem->page_size);
> > +     struct pci_epc_mem *mem;
> > +     unsigned int page_shift;
> > +     size_t align_size;
> > +     int pageno;
> >       int order;
> > +     int i;
> >
> > -     size = ALIGN(size, mem->page_size);
> > -     order = pci_epc_mem_get_order(mem, size);
> > -
> > -     mutex_lock(&mem->lock);
> > -     pageno = bitmap_find_free_region(mem->bitmap, mem->pages, order);
> > -     if (pageno < 0)
> > -             goto ret;
> > +     for (i = 0; i < epc->num_windows; i++) {
> > +             mem = epc->windows[i];
> > +             mutex_lock(&mem->lock);
> > +             align_size = ALIGN(size, mem->window.page_size);
> > +             order = pci_epc_mem_get_order(mem, align_size);
> >
> > -     *phys_addr = mem->phys_base + ((phys_addr_t)pageno << page_shift);
> > -     virt_addr = ioremap(*phys_addr, size);
> > -     if (!virt_addr)
> > -             bitmap_release_region(mem->bitmap, pageno, order);
> > +             pageno = bitmap_find_free_region(mem->bitmap, mem->pages,
> > +                                              order);
> > +             if (pageno >= 0) {
> > +                     page_shift = ilog2(mem->window.page_size);
> > +                     *phys_addr = mem->window.phys_base +
> > +                             ((phys_addr_t)pageno << page_shift);
> > +                     virt_addr = ioremap(*phys_addr, align_size);
> > +                     if (!virt_addr)
> > +                             bitmap_release_region(mem->bitmap,
> > +                                                   pageno, order);
>
> I'm sorry here again. But, I think we should call mutex_unlock() and "continue;"
> here if ioremap() failed for trying remaining windows. What do you think?
>
If ioremap() has failed something has really went wrong with the
system, but there is no harm in trying other windows. So Ill add the
code as suggested above.

Cheers,
--Prabhakar

> > +                     mutex_unlock(&mem->lock);
> > +                     return virt_addr;
> > +             }
> > +             mutex_unlock(&mem->lock);
> > +     }
> >
> > -ret:
> > -     mutex_unlock(&mem->lock);
> >       return virt_addr;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
>
> Best regards,
> Yoshihiro Shimoda
>
