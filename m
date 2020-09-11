Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E1F265708
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 04:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgIKCf4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 22:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKCfz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 22:35:55 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48C7C061573;
        Thu, 10 Sep 2020 19:35:53 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r9so9501445ioa.2;
        Thu, 10 Sep 2020 19:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLDGTHB0Vy6RWLw3amMhOLqk1tJytCqyFKQIvhrZNns=;
        b=VPw5s7kkd9VXg+7GkI431vyBAGb+qG1x8R1FpoEuiUd7pM5xJnIMSMU/4O3Gp/afKH
         NP/Yfe2XwgyT/TouC5k0PSfho7jcayFu4gtGlNvwULftvHZ6SivjVef5Vm37B+zPAG8o
         lsqHVXJxWLYUOwhDBao2X8yXkXFi1eSJn+c536SvNB0+Izekk+/QUebji9qBRFSFc2cQ
         yc9yzIeS8yPMakpfsiH9WJ3r6fDRphSP5/elqAYTrlPq0npnTRk4E8IFRltnrzHyO/pi
         ++NOOTAWU68KuZXippX1HoauDT3C8opz03CbRjQ0gu3iToGXUu+HZoNiX9N74hlMpdGc
         Ru8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLDGTHB0Vy6RWLw3amMhOLqk1tJytCqyFKQIvhrZNns=;
        b=tSdFf4iNqWzIZFbSdq5CM+rcNsfBLq3rfGY37G47MqcjUTPu14UnDKNVmvdRN+NpIv
         mh/sQdwkw/oV2LDZpF5hizVTXEYTjiVCI2ndaDv8JLfhKtFgbnLLIPkdD4FILwVMh3ek
         1UR0e7ZPuDetY7EF+AdooLHGtZlenglY7t0LmZZjVLA9GHFrdnXIr5QTKT59MgO53IG3
         hD16+lkq40tMUMpb6ftxozhAziwQT+PLMe/KbzStxVIcavy6Y2QcObdRyqNe/6yUipl8
         fgkH4oljSKaPaEyBxCJcetW56vzzdpHJEr20cob2eAbG0VRwTGVBg5B9xC7X05HB7jxe
         GO6A==
X-Gm-Message-State: AOAM533CRdkUXVOC8y0moTKW4ZOZvfK6qbbhs6pWnZWP4dydJI+HT+kn
        rZFs/cUx4DjtRGgbOoLbkfkzF16SpVrwpFEP52I=
X-Google-Smtp-Source: ABdhPJxCArdw93rlVIk7k/3JCu4ZsL4A/XRNFH2fkgVjBjdjlQF//xYp2rj7Ce1enzL53jDVyqx6XmsOEJLEFsjrqLc=
X-Received: by 2002:a5e:890c:: with SMTP id k12mr61362ioj.75.1599791753153;
 Thu, 10 Sep 2020 19:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200910202106.GA811000@bjorn-Precision-5520> <b8f0d64d-8a29-aa4f-c764-397e87527600@loongson.cn>
In-Reply-To: <b8f0d64d-8a29-aa4f-c764-397e87527600@loongson.cn>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 11 Sep 2020 12:35:41 +1000
Message-ID: <CAOSf1CGM0SV2ux-TYv_N2frgZtqin8yfvh1wUDj+oMVmjr3GHQ@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI/portdrv: No need to call pci_disable_device()
 during shutdown
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 11:55 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> On 09/11/2020 04:21 AM, Bjorn Helgaas wrote:
> > [+cc Huacai]
> >
> > On Thu, Sep 10, 2020 at 02:41:39PM -0500, Bjorn Helgaas wrote:
> >> On Sat, Sep 05, 2020 at 04:33:26PM +0800, Tiezhu Yang wrote:
> >>> After commit 745be2e700cd ("PCIe: portdrv: call pci_disable_device
> >>> during remove") and commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe
> >>> services during shutdown"), it also calls pci_disable_device() during
> >>> shutdown, this seems unnecessary, so just remove it.
> >> I would like to get rid of the portdrv completely by folding its
> >> functionality into the PCI core itself, so there would be no portdrv
> >> probe or remove.
> >>
> >> Does this solve a problem?
>
> Yes, sometimes it can not shutdown or reboot normally with
> pci_disable_device().

Do you have any more details about what goes wrong here? Leaving
devices enabled when actually shutting down probably doesn't matter.
However, .shutdown() is also used when kexec()ing into a new kernel
and we probably should be disabling devices before handing over to the
new kernel.

Is the real issue that we're closing the bridge windows before the
endpoint drivers have had a chance to clean up?

Oliver
