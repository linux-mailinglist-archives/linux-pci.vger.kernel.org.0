Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3205A5A306A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 22:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbiHZUXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 16:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiHZUXD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 16:23:03 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441A8B5179
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 13:23:02 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t140so3306513oie.8
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 13:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc;
        bh=kS5gLref/yeXZPJM95FO6NB/TUzDNorimdYNoC2IhY0=;
        b=IfVDWnPh2pmitTa0mBVU5yMTg+GsLz0HAEtrsCYHNyYSyNi0PcHNVvrYQ5qRfDp2E/
         /fgifVueS3Cc6X8ANEDD8CYYVML5YLtbft40vaA3eDiT/xTAeYiZPjP/ieTmv9KqoJzg
         FwiQLsNubVZrD7CJdYxgclePk2dDaptC0GFsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc;
        bh=kS5gLref/yeXZPJM95FO6NB/TUzDNorimdYNoC2IhY0=;
        b=a4kJLzWYev6yQ2Tt2BcSjHxp+CQB5QSfAnORKuBI1asYiPU11Np5UdbMiBqVFiKz5u
         u5G3iOn5OYaibPeHUVD6rSdAfXfEoaC3jcLVgMtr9q5/JEULPNqebcDKk8yum/Lpd3nb
         aaCVC6e/0hJdVB6CX5WXob8Ip3qSyxibnMjKLZoieYcViSOh6HDYswMuDf5s4jrwvvci
         rUCQwz+8mIBX4WDgcTrAuGw1oMbSisNEigfS/8vT01aJLRywwjim4E16CSyh7c2Q8C1n
         fxgSnBoeiJyVJ0NuIJwpwAdgkD+uuoVz+hH/KpYF7tpe16X3yqXDlwLbWRMKVkYnLxhE
         sATw==
X-Gm-Message-State: ACgBeo2omZF/DLxw8yITsVEkz9G9K7QlScnW5OFRqtT0Eva2tsD2Ics7
        u+1FjaheuR6irvSgv3nE0C7VlJqrY9O4QVQiYItC0Q==
X-Google-Smtp-Source: AA6agR7yBBd6qqy3Gg/HIxNowO98A36LwiC1i0R4WBg6931/LkLIDTNxeKijqVcsS3bUCwt5oh5WK0bf4vUSE18eWcY=
X-Received: by 2002:a05:6808:bca:b0:344:ef42:930f with SMTP id
 o10-20020a0568080bca00b00344ef42930fmr2306646oik.0.1661545381545; Fri, 26 Aug
 2022 13:23:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Aug 2022 15:23:00 -0500
MIME-Version: 1.0
In-Reply-To: <81dcbf72-92bb-093a-da48-89a73ead820e@quicinc.com>
References: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
 <1659526134-22978-3-git-send-email-quic_krichai@quicinc.com>
 <CAE-0n500y-n+ZjasYQRAa3JgamQG1c+Aqn0YiX-i0L-w6C4dbQ@mail.gmail.com>
 <3d052733-3600-b6eb-baf3-d8806a150af3@quicinc.com> <CAE-0n53oMnnn7rOPEiibc=XM52z9THDc9jYhe3x3C_AsLtmARQ@mail.gmail.com>
 <81dcbf72-92bb-093a-da48-89a73ead820e@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 26 Aug 2022 15:23:00 -0500
Message-ID: <CAE-0n50NRiBNDjK2UrA_wOoRz3+3cKb4uiUiCw4t1F19Kw9EhA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] PCI: qcom: Restrict pci transactions after pci suspend
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        dmitry.baryshkov@linaro.org, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Krishna Chaitanya Chundru (2022-08-25 06:52:43)
>
> On 8/24/2022 10:50 PM, Stephen Boyd wrote:
> > Quoting Krishna Chaitanya Chundru (2022-08-23 20:37:59)
> >> On 8/9/2022 12:42 AM, Stephen Boyd wrote:
> >>> Quoting Krishna chaitanya chundru (2022-08-03 04:28:53)
> >>>> If the endpoint device state is D0 and irq's are not freed, then
> >>>> kernel try to mask interrupts in system suspend path by writing
> >>>> in to the vector table (for MSIX interrupts) and config space (for M=
SI's).
> >>>>
> >>>> These transactions are initiated in the pm suspend after pcie clocks=
 got
> >>>> disabled as part of platform driver pm  suspend call. Due to it, the=
se
> >>>> transactions are resulting in un-clocked access and eventually to cr=
ashes.
> >>> Why are the platform driver pm suspend calls disabling clks that earl=
y?
> >>> Can they disable clks in noirq phase, or even later, so that we don't
> >>> have to check if the device is clocking in the irq poking functions?
> >>> It's best to keep irq operations fast, so that irq control is fast gi=
ven
> >>> that these functions are called from irq flow handlers.
> >> We are registering the pcie pm suspend ops as noirq ops only. And this
> >> msix and config
> >>
> >> access is coming at the later point of time that is reason we added th=
at
> >> check.
> >>
> > What is accessing msix and config? Can you dump_stack() after noirq ops
> > are called and figure out what is trying to access the bus when it is
> > powered down?
>
> The msix and config space is being accessed to mask interrupts. The
> access is coming at the end of the suspend
>
> and near CPU disable. We tried to dump the stack there but the call
> stack is not coming as it is near cpu disable.

That is odd that you can't get a stacktrace.

>
> But we got dump at resume please have look at it
>
> [=C2=A0=C2=A0 54.946268] Enabling non-boot CPUs ...
> [=C2=A0=C2=A0 54.951182] CPU: 1 PID: 21 Comm: cpuhp/1 Not tainted 5.15.41=
 #105
> 43491e4414b1db8a6f59d56b617b520d92a9498e
> [=C2=A0=C2=A0 54.961122] Hardware name: Qualcomm Technologies, Inc. sc728=
0 IDP
> SKU2 platform (DT)
> [=C2=A0=C2=A0 54.969088] Call trace:
> [=C2=A0=C2=A0 54.971612]=C2=A0 dump_backtrace+0x0/0x200
> [=C2=A0=C2=A0 54.975399]=C2=A0 show_stack+0x20/0x2c
> [=C2=A0=C2=A0 54.978826]=C2=A0 dump_stack_lvl+0x6c/0x90
> [=C2=A0=C2=A0 54.982614]=C2=A0 dump_stack+0x18/0x38
> [=C2=A0=C2=A0 54.986043]=C2=A0 dw_msi_unmask_irq+0x2c/0x58
> [=C2=A0=C2=A0 54.990096]=C2=A0 irq_enable+0x58/0x90
> [=C2=A0=C2=A0 54.993522]=C2=A0 __irq_startup+0x68/0x94
> [=C2=A0=C2=A0 54.997216]=C2=A0 irq_startup+0xf4/0x140
> [=C2=A0=C2=A0 55.000820]=C2=A0 irq_affinity_online_cpu+0xc8/0x154
> [=C2=A0=C2=A0 55.005491]=C2=A0 cpuhp_invoke_callback+0x19c/0x6e4
> [=C2=A0=C2=A0 55.010077]=C2=A0 cpuhp_thread_fun+0x11c/0x188
> [=C2=A0=C2=A0 55.014216]=C2=A0 smpboot_thread_fn+0x1ac/0x30c
> [=C2=A0=C2=A0 55.018445]=C2=A0 kthread+0x140/0x30c
> [=C2=A0=C2=A0 55.021788]=C2=A0 ret_from_fork+0x10/0x20
> [=C2=A0=C2=A0 55.028243] CPU1 is up
>
> So the same stack should be called at the suspend path while disabling CP=
U.

Sounds like you're getting hit by affinity changes while offlining CPUs
during suspend (see irq_migrate_all_off_this_cpu()). That will happen
after devices are suspended (all phases of suspend ops).

>
> If there is any other way to remove these calls can you please help us
> point that way.

I'm not sure. I believe genirq assumes the irqchips are always
accessible. There is some support to suspend irqchips. See how the
struct irq_chip::irq_suspend() function is called by syscore ops in the
generic irqchip 'irq_gc_syscore_ops' hooks. Maybe you could add a
syscore suspend/resume hook to disable/enable the clks and power to the
PCI controller. syscore ops run after secondary CPUs are hotplugged out
during suspend.

Or maybe setting the IRQCHIP_MASK_ON_SUSPEND flag can be used so that on
irq migration nothing writes the irq hardware because it is already
masked in the hardware earlier. I think the problem is that on resume
we'll restart the irq from the first CPU online event, when you don't
want to do that because it is too early.

I have another question though, which is do MSIs support wakeup? I don't
see how it works if the whole bus is effectively off during suspend. If
wakeup needs to be supported then I suspect the bus can't be powered
down during suspend.
