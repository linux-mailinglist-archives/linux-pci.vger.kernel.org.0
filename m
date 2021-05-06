Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AC23751C6
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 11:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhEFJrn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 05:47:43 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35446 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhEFJrn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 May 2021 05:47:43 -0400
Received: by mail-ot1-f50.google.com with SMTP id b5-20020a9d5d050000b02902a5883b0f4bso4381101oti.2;
        Thu, 06 May 2021 02:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLw6wpF1SpPaYf9GjIKaoxywxvbZeYQGn/3BsI8vClk=;
        b=loBktZabexdFTcahOcl+/W9lK4YUyX5dUOxX0exuwMfm9WsdwjxoQaqHmVHd48iBZ2
         7UbbzpECNE3uBgrqVa05JObzdRnKFohBxwP8SV9ePNIyNOwutMivZCKPTYn8wiBj2MEz
         rEIy5F67c1tpExq0X/lXO5qiO0UggllooRKqB+PsXSroofHibEhFdE0CoZ4eOG9u5H9K
         OXWPbpA8uasOJaQMjgUiTwybteHJaAnkearX/3UILAR+G5zjM+VT48O/PoAFQYYwetBl
         UUzNlqr5tCF925f7Jy5cDrsgQRIYPcFGGqWU+SNgrBID4gkiGX3lbMNy8XMTWdOZsrVC
         GyDg==
X-Gm-Message-State: AOAM532V8m8J9FuVz+P2buJ6kw+tZMqRreTuhNS/H89HCqShOE95vsAz
        YMkZadHq3LnwzEL1UcelSIS2iup8Ek0sHc911Aw=
X-Google-Smtp-Source: ABdhPJyAsuVo6svOMDODs74V1AcY7zQZ8HNwrp/WdernvPw059EjB7XBOZVJ1YRHznkASCdNNtLe7vGRDXaOLBJfzZI=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr2800612otb.260.1620294404422;
 Thu, 06 May 2021 02:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <CABTNMG0Y5iAD4E8XFkOwrNTBHNDcNKRt=+BLPHs4tw5O2eVBDA@mail.gmail.com>
In-Reply-To: <CABTNMG0Y5iAD4E8XFkOwrNTBHNDcNKRt=+BLPHs4tw5O2eVBDA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 May 2021 11:46:33 +0200
Message-ID: <CAJZ5v0hqU4xc8oCWXPBYhdGdG__=15+M67QWVSfFeUR3DN4Evw@mail.gmail.com>
Subject: Re: NVIDIA GPU fallen off the bus after exiting s2idle
To:     Chris Chiu <chris.chiu@canonical.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 4, 2021 at 10:08 AM Chris Chiu <chris.chiu@canonical.com> wrote:
>
> Hi,
>     We have some Intel laptops (11th generation CPU) with NVIDIA GPU
> suffering the same GPU falling off the bus problem while exiting
> s2idle with external display connected. These laptops connect the
> external display via the HDMI/DisplayPort on a USB Type-C interfaced
> dock. If we enter and exit s2idle with the dock connected, the NVIDIA
> GPU (confirmed on 10de:24b6 and 10de:25b8) and the PCIe port can come
> back to D0 w/o problem. If we enter the s2idle, disconnect the dock,
> then exit the s2idle, both external display and the panel will remain
> with no output. The dmesg as follows shows the "nvidia 0000:01:00.0:
> can't change power state from D3cold to D0 (config space
> inaccessible)" due to the following ACPI error
> [ 154.446781]
> [ 154.446783]
> [ 154.446783] Initialized Local Variables for Method [IPCS]:
> [ 154.446784] Local0: 000000009863e365 <Obj> Integer 00000000000009C5
> [ 154.446790]
> [ 154.446791] Initialized Arguments for Method [IPCS]: (7 arguments
> defined for method invocation)
> [ 154.446792] Arg0: 0000000025568fbd <Obj> Integer 00000000000000AC
> [ 154.446795] Arg1: 000000009ef30e76 <Obj> Integer 0000000000000000
> [ 154.446798] Arg2: 00000000fdf820f0 <Obj> Integer 0000000000000010
> [ 154.446801] Arg3: 000000009fc2a088 <Obj> Integer 0000000000000001
> [ 154.446804] Arg4: 000000003a3418f7 <Obj> Integer 0000000000000001
> [ 154.446807] Arg5: 0000000020c4b87c <Obj> Integer 0000000000000000
> [ 154.446810] Arg6: 000000008b965a8a <Obj> Integer 0000000000000000
> [ 154.446813]
> [ 154.446815] ACPI Error: Aborting method \IPCS due to previous error
> (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
> [ 154.446824] ACPI Error: Aborting method \MCUI due to previous error
> (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
> [ 154.446829] ACPI Error: Aborting method \SPCX due to previous error
> (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
> [ 154.446835] ACPI Error: Aborting method \_SB.PC00.PGSC due to
> previous error (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
> [ 154.446841] ACPI Error: Aborting method \_SB.PC00.PGON due to
> previous error (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
> [ 154.446846] ACPI Error: Aborting method \_SB.PC00.PEG1.NPON due to
> previous error (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
> [ 154.446852] ACPI Error: Aborting method \_SB.PC00.PEG1.PG01._ON due
> to previous error (AE_AML_LOOP_TIMEOUT) (20200925/psparse-529)
> [ 154.446860] acpi device:02: Failed to change power state to D0
> [ 154.690760] video LNXVIDEO:00: Cannot transition to power state D0
> for parent in (unknown)

If I were to guess, I would say that AML tries to access memory that
is not accessible while suspended, probably PCI config space.

> The IPCS is the last function called from \_SB.PC00.PEG1.PG01._ON
> which we expect it to prepare everything before bringing back the
> NVIDIA GPU but it's stuck in the infinite loop as described below.
> Please refer to
> https://gist.github.com/mschiu77/fa4f5a97297749d0d66fe60c1d421c44 for
> the full DSDT.dsl.

The DSDT alone may not be sufficient.

Can you please create a bug entry at bugzilla.kernel.org for this
issue and attach the full output of acpidump from one of the affected
machines to it?  And please let me know the number of the bug.

Also please attach the output of dmesg including a suspend-resume
cycle including dock disconnection while suspended and the ACPI
messages quoted below.

>            While (One)
>             {
>                 If ((!IBSY || (IERR == One)))
>                 {
>                     Break
>                 }
>
>                 If ((Local0 > TMOV))
>                 {
>                     RPKG [Zero] = 0x03
>                     Return (RPKG) /* \IPCS.RPKG */
>                 }
>
>                 Sleep (One)
>                 Local0++
>             }
>
> And the upstream PCIe port of NVIDIA seems to become inaccessible due
> to the messages as follows.
> [ 292.746508] pcieport 0000:00:01.0: waiting 100 ms for downstream
> link, after activation
> [ 292.882296] pci 0000:01:00.0: waiting additional 100 ms to become accessible
> [ 316.876997] pci 0000:01:00.0: can't change power state from D3cold
> to D0 (config space inaccessible)
>
> Since the IPCS is the Intel Reference Code and we don't really know
> why the never-end loop happens just because we unplug the dock while
> the system still stays in s2idle. Can anyone from Intel suggest what
> happens here?

This list is not the right channel for inquiries related to Intel
support, we can only help you as Linux kernel developers in this
venue.

> And one thing also worth mentioning, if we unplug the display cable
> from the dock before entering the s2idle, NVIDIA GPU can come back w/o
> problem even if we disconnect the dock before exiting s2idle. Here's
> the lspci information
> https://gist.github.com/mschiu77/0bfc439d15d52d20de0129b1b2a86dc4 and
> the dmesg log with ACPI trace_state enabled and dynamic debug on for
> drivers/pci/pci.c, drivers/acpi/device_pm.c for the whole s2idle
> enter/exit with IPCS timeout.
>
> Any suggestion would be appreciated. Thanks.

First, please use proper Intel support channels for BIOS-related inquiries.

Second, please open a bug as suggested above and let's use it for
further communication regarding this issue as far as Linux is
concerned.

Thanks!
