Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE79C105EDA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 04:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfKVDAh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 22:00:37 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37911 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfKVDAh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 22:00:37 -0500
Received: by mail-qt1-f195.google.com with SMTP id 14so6216028qtf.5
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2019 19:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQXzMZojDdxTeVrFDC7oCHSUIlgKVBtiaKVu10Zcb/M=;
        b=j6OIwOyNVokNpMoYYRKV/i/g7qXb25aWC8/hPaKT6Fyn0ySkiz/DvN9nnm1eHhRXJv
         NB4dJ9QjiBgw31V9+ejfMxr5LH4cEbuQ1r10OdFXunZSS+h7YM5KHvGBLR8PAuIsg7b5
         RLakVpXGDy7gdlcsL8NMsaJdPxViJTdwg7s5Lc9qsKM1FSf8+LOoP4Dg5UieaC3JZP9w
         nHNeidIW3mejXB9pjC0q4eBbxrpZD5yRWVftc7G9+pdZj1TEI8ObSHpHVzaXSsF5aAe3
         NP3Ndjpb7ZQm1LlK3gbcHONUUSI7oe6HAFULHGAG+01SGKvvd6Vqx4osGB1obXD3j5py
         Mwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQXzMZojDdxTeVrFDC7oCHSUIlgKVBtiaKVu10Zcb/M=;
        b=ArZOD60abdGUEwMiXhxI0FHJDEx+HcWrNzE1VOvNLHNmx00fFTHohO8IWeCFHjAi14
         HRHu6oLKoJHo0ZzjNXMSatVFvPK4D9CCbcmORd6Ni8kZHH4a5mnsA4eKGxYfI4jX0R82
         0c7Xwo/j8L+ZRRvXmTfZ/HD9sr6KRYEvoLP8zLY4OhNNYeURPHdOhztphrcMJ4yMNNDD
         4SfvhOWnd8woXUdRP/sRoSGrrLnuzQP0x5lneloIhZ//qI1VLAaDQ2wB+dqzBJtUMg8w
         uFV4j3mzTe2Dcz5gvts82QcTXI0ho3jtBqtzXA/Il6SnmD4P2NbK5nlXKDmIvnXDqXeK
         WFpQ==
X-Gm-Message-State: APjAAAVNywcNA0BS7mHKodRWDYFo49dSKEfXb7BNxJA7ciWaPt2b97IY
        lePpRm2QV/ujo/lkcv2/9OX0l4I455EF/pP6GDZH1A==
X-Google-Smtp-Source: APXvYqxF++WJ4ysxQKliHFnNspapcsV/8c2phT5X5JEGqZj6yvwOy4roCA3ODgFlgFW8HPMqC7ELqBtX2Q4ycCqZrZU=
X-Received: by 2002:ac8:60d3:: with SMTP id i19mr12182666qtm.391.1574391635899;
 Thu, 21 Nov 2019 19:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20191120002836.GA247344@google.com> <20191121181500.GA55996@google.com>
In-Reply-To: <20191121181500.GA55996@google.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 22 Nov 2019 11:00:24 +0800
Message-ID: <CAD8Lp47o6PqKnQYBba0o_8LSGhd3_APhVuXAVsJRT7TedeqXDg@mail.gmail.com>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 22, 2019 at 2:15 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> I definitely was not understanding this correctly.  There is no path
> for a D3cold -> D3hot transition.  Per spec (PCIe r5.0, sec 5.8), the
> only legal exit from D3cold is to D0uninitialized.

I'm also learning these details as we go.

During runtime suspend, the ACPI _PS3 method (which does exist on this
device) is called, then _PR3 resources are turned off, which (I think)
means that the state should now be D3cold.

During runtime resume, the ACPI _PR0 resources are turned on, then
ACPI _PS0 method is called (and does exist on this device), and my
reading is that this should put the device in D0.

But then when pci_update_current_state() is called, it reads pmcsr as
3 (D3hot). That's not what I would expect. I guess this means that
this platform's _PR3/_PS3 do not actually allow us to put the device
into D3cold, and/or the _PR0/_PS0 transition does not actually
transition the device to D0.

While there is some ACPI strangeness here, the D3hot vs D3cold thing
is perhaps not the most relevant point. If I hack the code to avoid
D3cold altogether, just trying to do D0->D3hot->D0, it fails in the
same way.

> I know you tried a debug patch to call pci_dev_wait(), and it didn't
> work, but I'm not sure exactly where it was called.  I have these
> patches on my pci/pm branch for v5.5:
>
>   bae26849372b ("PCI/PM: Move pci_dev_wait() definition earlier")
>   395f121e6199 ("PCI/PM: Wait for device to become ready after power-on")
>
> The latter adds the wait just before we call
> pci_raw_set_power_state().  If the device is responding with CRS
> status, that should be the point where we'd see it.  If you have a
> chance to try it, I'd be interested in the results.

pci_dev_wait() doesn't have any effect no matter where you put it
because we have yet to observe this device presenting a CRS-like
condition. According to our earlier experiments, PCI_VENDOR_ID and
PCI_COMMAND never return the ~0 value that would be needed for
pci_dev_wait() to have any effect.

I tried the branch anyway and it doesn't solve the issue.

I haven't finished gathering all the logs you asked for, but I tried
to summarize my current understanding at
https://bugzilla.kernel.org/show_bug.cgi?id=205587 - hopefully that
helps.

Thanks
Daniel
