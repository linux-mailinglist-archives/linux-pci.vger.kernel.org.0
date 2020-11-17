Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5EF2B5ED1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 13:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgKQMEs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 07:04:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45455 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgKQMEr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 07:04:47 -0500
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1kezj2-0003C9-KO
        for linux-pci@vger.kernel.org; Tue, 17 Nov 2020 12:04:44 +0000
Received: by mail-ed1-f69.google.com with SMTP id d1so9617753edz.14
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2020 04:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVhaLNmBtuqnmi4tGMJBvp0RPN7vCBWkGFN0wZbfqIU=;
        b=pYBrUekGVej1HgCOgP4h+naPM9c1wCRYI0hE/P7dw99RtKoPs+T/i5SFanSdxxjr5d
         26QQDRh6+yl5VKkjWW3QP46/NqMIIBnqJiGxQWZur2sCnVclk8kUZKOMH5r5RqakrqE3
         FxFckel2u2fBgxRaNnvY0rFXxd6fUbDvRVztWdWjBx4MQiaiv2rRmoLjHs/LJrErZPGh
         rPgP44gtkPzzMmm85272b9kMX2AHeIBKa1ppQyyjmMfyJEzvHW5gvOKGXOJMCHABe/e1
         nM2bXFDX0ILRJNCcMUwjdi16QOs94cVJeng56eK5gA3e+G+QQp3CRHyj52DqyeH6Npsk
         gdTw==
X-Gm-Message-State: AOAM532ZUBpchquCvyWWPlGwhekzLgiEn1YVCuUJ3kCocgG2U55TDTVq
        Vel3fMZb454jcBFDeWwr68HGTWrzhv1/+f8yfiMeYL85UEu/pVP6Yi6huQrUByHsINjnLbW9sgr
        k8IaplZab1sTvdBpp10QGLSZEyiCGRzhdN40FDXweGCG/S5bpxcTLZA==
X-Received: by 2002:a17:906:fcdb:: with SMTP id qx27mr19442460ejb.470.1605614684122;
        Tue, 17 Nov 2020 04:04:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNjl3vH5wIqmDtDTI5xUTL95hPqz+4DoXqLbqHyC7et+hNdTOMMEjmG2P9V+/rCvbOS8n8iZnmmiiRjQEp+Us=
X-Received: by 2002:a17:906:fcdb:: with SMTP id qx27mr19442435ejb.470.1605614683864;
 Tue, 17 Nov 2020 04:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20201117001907.GA1342260@bjorn-Precision-5520> <87h7poeqqn.fsf@x220.int.ebiederm.org>
In-Reply-To: <87h7poeqqn.fsf@x220.int.ebiederm.org>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Tue, 17 Nov 2020 09:04:07 -0300
Message-ID: <CAHD1Q_zS9Hs8mUsm=q0Ei0kQ+y+wQhkroD+M2eCPKo2xLO6hBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     lukas@wunner.de, linux-pci@vger.kernel.org,
        Pingfan Liu <kernelfans@gmail.com>, andi@firstfloor.org,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, Sinan Kaya <okaya@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Dave Young <dyoung@redhat.com>,
        Gavin Guo <gavin.guo@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Streetman <ddstreet@canonical.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 16, 2020 at 10:07 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
> [...]
> > I think we need to disable MSIs in the crashing kernel before the
> > kexec.  It adds a little more code in the crash_kexec() path, but it
> > seems like a worthwhile tradeoff.
>
> Disabling MSIs in the b0rken kernel is not possible.
>
> Walking the device tree or even a significant subset of it hugely
> decreases the chances that we will run into something that is incorrect
> in the known broken kernel.  I expect the code to do that would double
> or triple the amount of code that must be executed in the known broken
> kernel.  The last time something like that happened (switching from xchg
> to ordinary locks) we had cases that stopped working.  Walking all of
> the pci devices in the system is much more invasive.
>

I think we could try to decouple this problem in 2, if that makes
sense. Bjorn/others can jump in and correct me if I'm wrong. So, the
problem is to walk a PCI topology tree, identify every device and
disable MSI(/INTx maybe) in them, and the big deal with doing that in
the broken kernel before the kexec is that this task is complex due to
the tree walk, mainly. But what if we keep a table (a simple 2-D
array) with the address and data to be written to disable the MSIs,
and before the kexec we could have a parameter enabling a function
that just goes through this array and performs the writes?

The table itself would be constructed by the PCI core (and updated in
the hotplug path), when device discovery is happening. This table
would live in a protected area in memory, with no write/execute
access, this way if the kernel itself tries to corrupt that, we get a
fault (yeah, I know DMAs can corrupt anywhere, but IOMMU could protect
against that). If the parameter "kdump_clear_msi" is passed in the
cmdline of the regular kernel, for example, then the function walks
this simple table and performs the devices' writes before the kexec...

If that's not possible or a bad idea for any reason, I still think the
early_quirks() idea hereby proposed is not something we should
discard, because it'll help a lot of users even with its limitations
(in our case it worked very well).
Also, taking here the opportunity to clarify my understanding about
the limitations of that approach: Bjorn, in our reproducer machine we
had 3 parents in the PCI tree (as per lspci -t), 0000:00, 0000:ff and
0000:80 - are those all under "segment 0" as per your verbiage? In our
case the troublemaker was under 0000:80, and the early_quirks() shut
the device up successfully.

Thanks,


Guilherme
