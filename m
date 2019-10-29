Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E531E8B49
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 15:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388899AbfJ2O4R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 10:56:17 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41548 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388713AbfJ2O4R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2019 10:56:17 -0400
Received: by mail-ot1-f66.google.com with SMTP id 94so9971731oty.8
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2019 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FdV3Var4HGrWGzVusBRK79viWL5WaK8Y1u6DFBz9i7o=;
        b=H8yLttDieWgzBqge1hgc+cyRcU+bGPRDCYOlHc3n6jLbdqzPF5vHosmJR9QPPZM/eo
         F+r4JgjePmQKeiO4t7C2OkRM092DuIrCbNN1Cd+qczZRfbpbC7pDVMTM62hXfUp9ea+U
         1oKIGGC5eN4XI/b3DeIBgndhqFn30BljiHXiyM52cFN0BUPbyve/o/JozyyVgl5G/rA7
         3JD8TWOKCoQMhO4sqUaRAu4Y/Lgji5mkk7DN04fy6YJfzUj0n3HeNV+Df8v45hKgT0N2
         Gtv5TWwjiPZChnviK2S901jH9Qs2JXfdRP8jbf0RzkdkO8tE55N5WN21SE3FifQZmULh
         mS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdV3Var4HGrWGzVusBRK79viWL5WaK8Y1u6DFBz9i7o=;
        b=QT97OLp0kxIwJyPz7183YAO6IgOSTI2Y1hqOWUB235rosE35enPYQ3dLgXaDlKbYwK
         YyDg8qYCj7CrnYukQiOyF4sJtwwuJfq7fSkUSqrRcRNLpjzjfuqlWbPEsAH5auS+9MDT
         +mf330bOPS8ypYY9h2lv/EZrf+lAEp0bkFVIeZ8MZATDWizffC1fUl94RgizGAsG/sGL
         cVZxRQQoTmAwZBm0wKadeDIJqUgF7cuDXfTsa+vZq49Kzf4ExZ+8wlhvRaRehScXJ4ki
         j5gY1ifYVkZ3U4t6nf44LC8J/rofxu3vlfsnjvsGNsjGjMYWFSNcfoLd1nK84cBcVrfK
         OORw==
X-Gm-Message-State: APjAAAW06cw9E3d/Qf9r8C0KfbfTugUWBBC/v1gn/IRNjRpqfVVZWM8F
        Tnq4Qaayed/tZrw/a4IgNDCzV/NXYYpX4qBHc+0=
X-Google-Smtp-Source: APXvYqzbIRuEziUcWOc3TS0Co0zGuzvQU/FrmRMe+o1sd6cpWlFW6fUdsfh92RzAfNXdPWut6CfC7DBtAhP/WkEOz44=
X-Received: by 2002:a9d:5d09:: with SMTP id b9mr951104oti.44.1572360976266;
 Tue, 29 Oct 2019 07:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <CA+V-a8sCjSCgj_WKeEtxRwjF+PM392zeTQ3F3ZwQR=nPavFyXQ@mail.gmail.com>
 <b91c3f6e-cef5-c06d-4282-84c24d616533@ti.com> <CA+V-a8tFB=giGvcLNhfTaaQ-R8svXijcoQ_QUdRMX3Hb4Ur95Q@mail.gmail.com>
 <CA+V-a8vR+xar-TsTOiBtNfbYuP8Wb_ktuf-i7tOkQ+==rs7Rug@mail.gmail.com>
 <1ccb98e7-837d-059a-1292-f001b4bb66c6@ti.com> <CA+V-a8tesARYDpZ8n6=DJ2DMCuykikWfXx2bKe9XPRSq1yfZgg@mail.gmail.com>
 <CA+V-a8ugFfLaapNcQdvzHEYfyT8UajY6psc0G1K7sdAgGzpSOQ@mail.gmail.com> <196e020d-e0aa-8a8d-21da-deff05d8aa81@ti.com>
In-Reply-To: <196e020d-e0aa-8a8d-21da-deff05d8aa81@ti.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 29 Oct 2019 14:55:50 +0000
Message-ID: <CA+V-a8soeaeHYyV3wQw0Qa5FvHJWo1dWHdf+19PYuYa31_3uHA@mail.gmail.com>
Subject: Re: [Query] : PCIe - Endpoint Function
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 29, 2019 at 10:54 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi,
>
> On 29/10/19 3:54 PM, Lad, Prabhakar wrote:
> > Hi Kishon,
> >
> > On Tue, Oct 22, 2019 at 7:06 AM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> >>
> >> Hi Kishon,
> >>
> >>
> >> On Tue, Oct 15, 2019 at 8:53 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>>
> >>> Hi Prabhakar,
> >>>
> >>> On 11/10/19 7:07 PM, Lad, Prabhakar wrote:
> >>>> Hi Kishon
> >>>>
> >>>> On Fri, Oct 11, 2019 at 8:35 AM Lad, Prabhakar
> >>>> <prabhakar.csengg@gmail.com> wrote:
> >>>>>
> >>>>> Hi Kishon,
> >>>>>
> >>>>> On Thu, Oct 10, 2019 at 12:32 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>>>>>
> >>>>>> Hi Prabhakar,
> >>>>>>
> >>>>>> On 10/10/19 4:57 PM, Lad, Prabhakar wrote:
> >>>>>>> Hello,
> >>>>>>>
> >>>>>>> I am currently working on adding pcie-endpoint support for a
> >>>>>>> controller, this controller doesn't support outbound- inbound address
> >>>>>>> translations, it has 1-1 mapping between the CPU and PCI addresses,
> >>>>>>> the current endpoint framework is based on  outbound-inbound
> >>>>>>> translations, what is the best approach to add this support, or is
> >>>>>>> there any WIP already for it ?
> >>>>>>
> >>>>>> How will the endpoint access host buffer without outbound ATU? I assume the PCI
> >>>>>> address reserved for endpoint is not the full 32-bit or 64-bit address space?
> >>>>>> In that case, the endpoint cannot directly access the host buffer (unless the
> >>>>>> host already knows the address space of the endpoint and gives the endpoint an
> >>>>>> address in its OB address space).
> >>>>>>
> >>>> I lied in my previous mail.
> >>>>
> >>>> a] The controller needs the cpu_address before starting the link, ie
> >>>> with the current implementation,the bars physical address in endpoint
> >>>> are assigned
> >>>> using dma_alloc_coherent(), but I what I actually want here is the
> >>>> phys_addr returned by pci_epc_mem_alloc_addr().
> >>>>
> >>>> b] In the pci_endpoint_test driver, the pci_address sent to the
> >>>> endpoint driver is again dma_alloc_coherent(), but the address which I
> >>>> actually want to
> >>>> send to endpoint is the BAR's assigned regions in the RC.
> >>>
> >>> The BAR assigned regions are usually used by RC to access EP memory.
> >>> dma_alloc_coherent() is used in pci_endpoint_test to allocate buffer in host
> >>> memory to be accessed by EP. Can you again check if statement 'b' is accurate?
> >>>
> >> yes you were correct, I misread the manual I have a rough driver
> >> working now, will post as
> >> soon as I tidy it up.
> >>
> > after several runs of pcitest I hit the following issue any pointers
> > on would this be the RC/endpoint ?
>
> It's difficult to tell without seeing your EP controller driver. It could be a
> ordering issue. Can you add mb() after memcpy_fromio() in pcitest (for the
> error below)?
>
adding a memory barrier to doesn't help either. Ill debug further.

Cheers,
--Prabhakar Lad
