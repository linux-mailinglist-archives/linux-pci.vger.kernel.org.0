Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB5C11A357
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 05:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfLKEKY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 23:10:24 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35666 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLKEKY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2019 23:10:24 -0500
Received: by mail-io1-f68.google.com with SMTP id v18so21269319iol.2;
        Tue, 10 Dec 2019 20:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=X/8Op0hbC9FcMl5P88Fh+jNn8kY8fhf7703ZK88DExI=;
        b=kBfPqw5ioDQvcQCWSwiAqQwXjkcBx5JDwz3yvDNnIO5WEryzR9vNZdOo2Rfgccn+LO
         hA8rU8w+PpjDLB9MiNXD7jU+qb4fhhGHvO7ie9Zp+OnN2+5C1QeiTmuQLftrZOilffBR
         wbe8H2WmJWk4yTaycpoRctP4RDWWKM5yEIDF5G3DQ3tBItFg6Ocgjhg+FNzia6S6XMos
         lLjRSBQefodKfLM62vfMekrIiM9MGcmL2yAvyNTKrOxzu5idDo8CXI0R+EHxFIBz3JAH
         pMnPhDt8YWNj56mo+6H2AUObCRtt2nbrkRsh53ujLnAFrv62WlsGDS8OJwu/Hirlo1LX
         2RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=X/8Op0hbC9FcMl5P88Fh+jNn8kY8fhf7703ZK88DExI=;
        b=RYwpUqx6qszw7nAR8G5ILoM003uJJsvAYDcaUeUOtTBUtgfb/FxCAvdxXNMIOx0FTR
         e14SadmAoD26kQu8H0DCNq4vl69Vf1h45dyWihz6t2RH2bX4gy6Oxo03Wc8x7K/Hoxu+
         e/xs8ACbR7rfbp1sV4NA5v35nKZnHXCmTvfU2RTJvAto857uymkidbBfe+Ph5H2TVFuB
         kT/z5VxfxmdWknVRBNrhupfxp2B/5mwNgfKCdMn/j27FnLGfx27qNgsv4vywB/p23xgE
         aLgu+SzkENUTHWnkhCpbXnKl0CU+ZL7UPQKR9lEQM4J0Je61GukhUVx261Hkd3ZKu/FP
         vmGw==
X-Gm-Message-State: APjAAAX4Lm4plHn/UTb2dgVigDzxgudnAuI6bj98RhU5FfYOWFWzNRI0
        DbSCifF+JDuzd0ngp2pgTHWrrw51jAoEq+UO6tlQkAG7
X-Google-Smtp-Source: APXvYqx5WAqik/eCozmhH4/CIxvAum7u3esCCyxXvao5eIuBHooq1DrtQqQ1a/ndHqNmFE5FGaNIecqPO/DkL6/wSTE=
X-Received: by 2002:a6b:7201:: with SMTP id n1mr1043223ioc.37.1576037423377;
 Tue, 10 Dec 2019 20:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20191206181051.GA121021@google.com> <6ebfcfc7-f9f0-bee0-172c-89c93530d94b@huawei.com>
In-Reply-To: <6ebfcfc7-f9f0-bee0-172c-89c93530d94b@huawei.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Tue, 10 Dec 2019 22:10:12 -0600
Message-ID: <CABhMZUX8spN93es+qtZWtMSUi3M+c99649ect4ZAkcrPLqfO=g@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Add quirk for HiSilicon NP 5896 devices
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, andrew.murray@arm.com,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        wangkefeng.wang@huawei.com, huawei.libin@huawei.com,
        guohanjun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 10, 2019 at 9:28 PM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
>
>
> On 2019/12/7 2:10, Bjorn Helgaas wrote:
> > On Fri, Dec 06, 2019 at 03:01:45PM +0800, Xiongfeng Wang wrote:
> >> HiSilicon PCI Network Processor 5896 devices misreport the class type as
> >> 'NOT_DEFINED', but it is actually a network device. Also the size of
> >> BAR3 is reported as 265T, but this BAR is actually unused.
> >> This patch modify the class type to 'CLASS_NETWORK' and disable the
> >> unused BAR3.
> >
> > "NOT_DEFINED" is not the value in the Class Code register.  The commit
> > message should include the actual value.
>
> The actual value is 0, I will update the commit message.
>
> >
> >> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> >> ---
> >>  drivers/pci/quirks.c    | 29 +++++++++++++++++++++++++++++
> >>  include/linux/pci_ids.h |  1 +
> >>  2 files changed, 30 insertions(+)
> >>
> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >> index 4937a08..b9adebb 100644
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -5431,3 +5431,32 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
> >>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
> >>                            PCI_CLASS_DISPLAY_VGA, 8,
> >>                            quirk_reset_lenovo_thinkpad_p50_nvgpu);
> >> +
> >> +static void quirk_hisi_fixup_np_class(struct pci_dev *pdev)
> >> +{
> >> +    u32 class = pdev->class;
> >> +
> >> +    pdev->class = PCI_BASE_CLASS_NETWORK << 8;
> >> +    pci_info(pdev, "PCI class overriden (%#08x -> %#08x)\n",
> >> +             class, pdev->class);
> >> +}
> >> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HISI_5896,
> >> +                    quirk_hisi_fixup_np_class);
> >> +
> >> +/*
> >> + * HiSilicon NP 5896 devices BAR3 size is reported as 256T and causes problem
> >> + * when assigning the resources. But this BAR is actually unused by the driver,
> >> + * so let's disable it.
> >
> > The question is not whether the BAR is used by the driver; the
> > question is whether the device responds to accesses to the region
> > described by the BAR when PCI_COMMAND_MEMORY is turned on.
>
> I asked the hardware engineer. He said I can not write an address into that BAR.

If the BAR is not writable, I think sizing should fail, so I suspect
some of the bits are actually writable.

What do you see in dmesg when this device is enumerated?  Can you
instrument the code in __pci_read_base() and see what we read/write to
that BAR?

Per spec, if the BAR is not implemented, it should be read-only zero.
But obviously the whole reason for the quirk is that the device
doesn't comply with the spec.

Bjorn
