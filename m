Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6C19F482
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 22:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfH0UvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 16:51:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36772 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfH0UvY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 16:51:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id k18so556251otr.3;
        Tue, 27 Aug 2019 13:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFtF8AMRjxGRycJChvuu+QOaS234Rbc2kfA92QoOhR8=;
        b=qYYxolS5fuSP3djvlBL/HOIW+sovTY0tqvgXcUM6zhqLnu/KdHnckre+AffxcaQPuw
         Pg7C2lm7ZvGoDDZiRwAbEcsRWGykPwuVl3iPGqeEXdGU6fJsFMEz0MmQNyMmL3NPyPoV
         0oR4WAdalK/clMCWNkqsrhe5KNzldZTg34rk9j+8oG2f1HSZjzGZFsrFzu7eIaZETyZg
         A5SwCpgSyexS45450GKEm0uddUj9B7kwdn5+yIA/LDWFzWP0Bag9VlUEpwpiRE4gmLHP
         wtJmYu+m+VUr+WNYJR7qxRnxZ7502Mh1Izq6nhKYCRYYqKe/b9kJggrpfF0WmBicFBCk
         oqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFtF8AMRjxGRycJChvuu+QOaS234Rbc2kfA92QoOhR8=;
        b=WJi1AJ3k1mP67mfqRie3Y1Mdax752nRxvfSd+ZjYUYg0NIOsiUeg5htTRRX9P+4KTr
         03DTQ/bNQy7/lf7IheVL4GQ/H85gx+lYgF3+srQVCMP8oIrtAC1X1ZkgjietHnkDnp/i
         UajlPaUBI1c9SWJiwjjB2qBzcFRenb1f6n8Qnb4otDLF1ytcwpTlqbAUG9ERkShmeU69
         k+C/y7KbjIRNfNudDBvfOO7BUroJm9WC2qr3iYPzl7mN3vYIbUueETHwZxyRG1z8oySy
         xJkFVa4HOhrdMxLkspsl0SjkUY3YNJqu4nDrGKCwhVZeh/WuNfydg6NOyndNEgYPG9PA
         1sZw==
X-Gm-Message-State: APjAAAWNrZvmVk+Sc1T4Ew3gS9kFnSqI9HJ1TZBbmpBYchGWW/hSpEkm
        T45BF0FYuLhmpNO8w1SdQB/RilX8EqtWIAZm6kqINkks
X-Google-Smtp-Source: APXvYqwFn2NE0qOdFMOqInpTjKCQduZPMBIHAU9paWcbft2GuR94j1ckD2V67ocVSCK8gs/Bh62sKrOwSg+711aT3sw=
X-Received: by 2002:a9d:7b44:: with SMTP id f4mr479637oto.42.1566939083798;
 Tue, 27 Aug 2019 13:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <9bd455a628d4699684c0f9d439b64af1535cccc6.1566208109.git.eswara.kota@linux.intel.com>
 <20190824210302.3187-1-martin.blumenstingl@googlemail.com>
 <2c71003f-06d1-9fe2-2176-94ac816b40e3@linux.intel.com> <CAFBinCDSJdq6axcYM7AkqvzUbc6X1zfOZ85Q-q1-FPwVxvgnpA@mail.gmail.com>
 <9ba19f08-e25a-4d15-8854-8dc4f9b6faca@linux.intel.com> <e4ddb571-e003-7bb8-a04c-795423ea0e2f@linux.intel.com>
In-Reply-To: <e4ddb571-e003-7bb8-a04c-795423ea0e2f@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 27 Aug 2019 22:51:12 +0200
Message-ID: <CAFBinCDgpNMfF-DnZSLAd7Ps66OKnUdpDmi7OE2O0bctOwwvCg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dwc: PCI: intel: Intel PCIe RC controller driver
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        hch@infradead.org, jingoohan1@gmail.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dilip,

On Tue, Aug 27, 2019 at 10:47 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
[...]
> >
> >
> >> now I am wondering:
> >> - if we don't have to disable the interrupt line (once it is enabled),
> >> why can't we enable all of these interrupts at initialization time
> >> (instead of doing it on-demand)?
> > Good point! we even can remote map_irq patch, directly call
> >
> > of_irq_parse_and_map_pci as other drivers do.
>
> Irrespective of disabling, imo interrupts(A/B/C/D) should be enabled
> when they are requested; which happens during map_irq() call.
with an integrated interrupt controller (which I decided to use in my
experiment because I could not find a .unmap_irq callback) this would
be the case:
- of_irq_parse_and_map_pci finds our APP interrupt
- this will enable the interrupt in the PCIe controller's APP register first
- then it will enable the interrupt in the parent interrupt controller
- when the PCIe card then frees the IRQ line again we will disable
both interrupts (the APP interrupt as well as the parent interrupt)

I don't see why of_irq_parse_and_map_pci + custom code to enable the
APP interrupt in .map_irq (without any .unmap_irq callback) is better
than always enabling it

[...]
> >>> This is needed. In the old driver, we fixed this by fixup. The original
> >>> comment as follows,
> >>>
> >>> /*
> >>>    * The root complex has a hardwired class of
> >>> PCI_CLASS_NETWORK_OTHER or
> >>>    * PCI_CLASS_BRIDGE_HOST, when it is operating as a root complex this
> >>>    * needs to be switched to * PCI_CLASS_BRIDGE_PCI
> >>>    */
> >> that would be a good comment to add if you really need it
> >> can you please look at dw_pcie_setup_rc (from
> >> pcie-designware-host.c), it does:
> >>    /* Enable write permission for the DBI read-only register */
> >>    dw_pcie_dbi_ro_wr_en(pci);
> >>    /* Program correct class for RC */
> >>    dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> >>    /* Better disable write permission right after the update */
> >>    dw_pcie_dbi_ro_wr_dis(pci);
> >>
> >> so my understanding is that there is a functional requirement to set
> >> the class to PCI_CLASS_BRIDGE_PCI
> >> however, that requirement is already covered by pcie-designware-host.c
> > I will task Dilip to check if we can use dwc one.
> dw_pcie_setup_rc () cannot be called here because, it is not doing
> PCI_CLASS_BRIDGE_PCI set alone, it is configuring many other things.
I am surprised to see that dw_pcie_setup_rc() is not used at all in your driver
it sets up BARs, bus numbers, interrupt pins, the command register, etc.
with my limited knowledge I assumed that these ("many other things")
are all mandatory so everything works correctly

what problems do you experience when you use dw_pcie_setup_rc()?

also it seems that virtually every PCIe driver based on the DWC
controller uses it:
$ grep -R dw_pcie_setup_rc drivers/pci/controller/dwc/ | wc -l
20


Martin
