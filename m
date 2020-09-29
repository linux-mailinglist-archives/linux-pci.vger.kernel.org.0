Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F4927C19A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbgI2Jqy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 05:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgI2Jqy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 05:46:54 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018C7C0613D0;
        Tue, 29 Sep 2020 02:46:54 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id nw23so14093162ejb.4;
        Tue, 29 Sep 2020 02:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dlX9ML6fVb9S8x7kiYTJrMB76YSVBD8l2Xjnpe6uQN0=;
        b=CKAg6VcPf+vVQPucZwTCZ3JgBliP016s2y1iY9xWKcP56h/kg7Ep5mQYhNYkmfoPrH
         EcGm5KmOr7yhg7T3VGBBxzVGdawjwKsx76Y/OUfi3IAnGl4QC+AJnNGgksFBVPhaquR2
         joRwPCgeFxdQuMzm14Dev+WcY70zUaJDEEpzp4CfBGD+1e03NsQHLZ/DiMtiSvUaA+MK
         xZjX2RlfYFVECFcCJXEwKlShaCWYmsjngJg23dAH7flmpxyOALnBuqzY4a5wKV65QsKs
         NWLWnO9Afz8IJlBO49vz16cMYY+OrIqOQYcj9Zwa8D/GX5Q1yaZ11zhCpD5Pq8s0B4Sm
         17JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dlX9ML6fVb9S8x7kiYTJrMB76YSVBD8l2Xjnpe6uQN0=;
        b=LS50g7RufnVaDT4tr8n6iYQPf6VCE3tDkYoFa1kJkvqTMwrk9icORDDiPFVi9C+cbd
         z0WuKFgN/7g4jL/v0EcD8kmiG76lnnSsYuJmxHJsKyw9mfH4tAqpHFuT5eL5U0dqKAR3
         sm5hbu5KrQJYgT30MTXDa/ZMfsJoFVPq4Cm+G9kWoFbAoDG7+6ib9r+5PHWxwbXjNJiC
         6+s2IC3l4+wLTndCJB9TbSP87LyGKKfsouYzqt+nmzQ1Gsr1/RZSz1HlLnsE3ZsckSck
         1LYaj7S7fu1jw2y3QO9HcXSbrzovsTp4iOmfP8/lYHRhQx+ubue7o4I5yo1bYeMgDrAK
         yi2A==
X-Gm-Message-State: AOAM532je9wFsXuuzKGW9b3CSQY42/AptNwyFFW05umjAdVGyX2lFdLw
        E8tI30j0qUskMifJArk0w6qinbaAfmBPoZENe4ucvR+b
X-Google-Smtp-Source: ABdhPJymEC+kcus8E21qR8Q1us3zw/mM3XLRoWGuRhm6QQ67BLxbCX4otevrwAxE5sP3n2wrng+0qaQ4MMmqVyOTrMc=
X-Received: by 2002:a17:906:30c5:: with SMTP id b5mr3026594ejb.98.1601372812716;
 Tue, 29 Sep 2020 02:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200927032829.11321-1-haifeng.zhao@intel.com>
 <20200927032829.11321-3-haifeng.zhao@intel.com> <f2c9e3db-2027-f669-fcdd-fbc80888b934@kernel.org>
 <20200929081800.GA15858@wunner.de>
In-Reply-To: <20200929081800.GA15858@wunner.de>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Tue, 29 Sep 2020 17:46:41 +0800
Message-ID: <CAKF3qh3UxkVOwCOUB4rNdxLX0k9oZQRzXT_N0BNYKWL_BAHa5w@mail.gmail.com>
Subject: Re: [PATCH 2/5 V2] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Sinan Kaya <okaya@kernel.org>, Ethan Zhao <haifeng.zhao@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>, ashok.raj@linux.intel.com,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 4:29 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sun, Sep 27, 2020 at 11:27:46AM -0400, Sinan Kaya wrote:
> > On 9/26/2020 11:28 PM, Ethan Zhao wrote:
> > > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > > @@ -710,8 +710,10 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
> > >     down_read(&ctrl->reset_lock);
> > >     if (events & DISABLE_SLOT)
> > >             pciehp_handle_disable_request(ctrl);
> > > -   else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
> > > +   else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) {
> > > +           pci_wait_port_outdpc(pdev);
> > >             pciehp_handle_presence_or_link_change(ctrl, events);
> > > +   }
> > >     up_read(&ctrl->reset_lock);
> >
> > This looks like a hack TBH.
> >
> > Lukas, Keith;
> >
> > What is your take on this?
> > Why is device lock not protecting this situation?
> >
> > Is there a lock missing in hotplug driver?
>
> According to Ethan's commit message, there are two issues here:
> One, that pciehp may remove a device even though DPC recovered the error,
> and two, that a null pointer deref occurs.
>
> The latter is most certainly not a locking issue but failure of DPC
> to hold a reference on the pci_dev.

This is what patch 3/5 proposed to fix. while this one is to re-order
the mixed DPC
recovery procedure and DLLSC/PDC event handling, to make pciehp to know the
exact recovered result of DPC to malfunctional device ---- link
recovered, still there,
or is removed from the slot.

Thanks,
Ethan

>
> Thanks,
>
> Lukas
