Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9E35A6286
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 13:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiH3Lz3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 07:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiH3Lz2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 07:55:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803614E85C
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 04:55:24 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l3so10862248plb.10
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 04:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=fyFT8QYNTXAXuWa2luhizjn+sDYqI/fEqOEfOhP43Go=;
        b=lOLC5rNnSUFiPL4SOwr2ytXsEZFRVUUpHGbgCOKoPj2miFeoURlvUj1yknB6xl1h/j
         ah72aaCgp8ugpvrwn1EXouIO1NwWyKBY1J/vpNW2OcXuaCJdf8jexulLw7BBC6cpSids
         bgnZcCWsYvU1jtXTF6vzt6Uz73cpR91PPGlNqB6iMtg/9rSKwkoy13K8xj6fX8XB+bXO
         4pD7owWwkwoAJVvadJCdjF7gKHHys2w0iDhtt/cjKLRaBA9HlvyGF99qnDgSdFNUtMMR
         JTLT10bsq69P3DZf9L91zWge4xEAi6gBkssDabwm1J9Of5LFwIjlVW2Ot49WsYSIB9Hx
         2OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=fyFT8QYNTXAXuWa2luhizjn+sDYqI/fEqOEfOhP43Go=;
        b=LGjsfp58zyOxAEZjkub69ABE0FSVQCC+dhGkjU7MfVP71jBjb+G2RzsPNNfyHhBEz8
         SUh+SMCMISmmXEPvU6z2mvZTM8rI7TnOgvJ4n8ZQnXV2PbNtyqrmPk9urLQ3nFdeyYn8
         40hZEpczOYhfjXL+/pvLnTO6z9WeS7sohC6zTaqo3B1YY3Gy9ZZLP8/8sKOJgUuq9N7I
         ULydfnnsi7ZrcJaaWR1ObModqmkFTO2twidYtUBk0cj31S11ZgeVwu5TuBsji6kob67n
         0EuckR6qHgNFH2bFTP4AeFwWgpdHLQB57ZffGQlz+a+sV9svG19KpGUW/0nW/M7BhQbH
         ZNUg==
X-Gm-Message-State: ACgBeo1zVYBYYO32dUmTJLPAzFlIlS+1vTanVjzzc9BMNlidncthT5sU
        dTzAgxACfqR6Cb8/HrO41uw+
X-Google-Smtp-Source: AA6agR4nKp8fxJW7OsYF7nGW1wKJPM3RJj8PdqSwrgqEzo6hws6adwA09zAj/DOEBcmbHaoPNv8/QQ==
X-Received: by 2002:a17:90a:d343:b0:1fd:b437:7ae9 with SMTP id i3-20020a17090ad34300b001fdb4377ae9mr12947467pjx.73.1661860523933;
        Tue, 30 Aug 2022 04:55:23 -0700 (PDT)
Received: from thinkpad ([117.217.182.234])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b0016ed5266a5csm9615538plh.170.2022.08.30.04.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 04:55:23 -0700 (PDT)
Date:   Tue, 30 Aug 2022 17:25:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, dmitry.baryshkov@linaro.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 2/3] PCI: qcom: Restrict pci transactions after pci
 suspend
Message-ID: <20220830115514.GD135982@thinkpad>
References: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
 <1659526134-22978-3-git-send-email-quic_krichai@quicinc.com>
 <CAE-0n500y-n+ZjasYQRAa3JgamQG1c+Aqn0YiX-i0L-w6C4dbQ@mail.gmail.com>
 <3d052733-3600-b6eb-baf3-d8806a150af3@quicinc.com>
 <CAE-0n53oMnnn7rOPEiibc=XM52z9THDc9jYhe3x3C_AsLtmARQ@mail.gmail.com>
 <81dcbf72-92bb-093a-da48-89a73ead820e@quicinc.com>
 <CAE-0n50NRiBNDjK2UrA_wOoRz3+3cKb4uiUiCw4t1F19Kw9EhA@mail.gmail.com>
 <20220827172655.GA14465@thinkpad>
 <a1b7c47c-9657-54bb-6b4e-1d98b3a65b91@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1b7c47c-9657-54bb-6b4e-1d98b3a65b91@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 29, 2022 at 11:01:58PM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 8/27/2022 10:56 PM, Manivannan Sadhasivam wrote:
> > On Fri, Aug 26, 2022 at 03:23:00PM -0500, Stephen Boyd wrote:
> > > Quoting Krishna Chaitanya Chundru (2022-08-25 06:52:43)
> > > > On 8/24/2022 10:50 PM, Stephen Boyd wrote:
> > > > > Quoting Krishna Chaitanya Chundru (2022-08-23 20:37:59)
> > > > > > On 8/9/2022 12:42 AM, Stephen Boyd wrote:
> > > > > > > Quoting Krishna chaitanya chundru (2022-08-03 04:28:53)
> > > > > > > > If the endpoint device state is D0 and irq's are not freed, then
> > > > > > > > kernel try to mask interrupts in system suspend path by writing
> > > > > > > > in to the vector table (for MSIX interrupts) and config space (for MSI's).
> > > > > > > > 
> > > > > > > > These transactions are initiated in the pm suspend after pcie clocks got
> > > > > > > > disabled as part of platform driver pm  suspend call. Due to it, these
> > > > > > > > transactions are resulting in un-clocked access and eventually to crashes.
> > > > > > > Why are the platform driver pm suspend calls disabling clks that early?
> > > > > > > Can they disable clks in noirq phase, or even later, so that we don't
> > > > > > > have to check if the device is clocking in the irq poking functions?
> > > > > > > It's best to keep irq operations fast, so that irq control is fast given
> > > > > > > that these functions are called from irq flow handlers.
> > > > > > We are registering the pcie pm suspend ops as noirq ops only. And this
> > > > > > msix and config
> > > > > > 
> > > > > > access is coming at the later point of time that is reason we added that
> > > > > > check.
> > > > > > 
> > > > > What is accessing msix and config? Can you dump_stack() after noirq ops
> > > > > are called and figure out what is trying to access the bus when it is
> > > > > powered down?
> > > > The msix and config space is being accessed to mask interrupts. The
> > > > access is coming at the end of the suspend
> > > > 
> > > > and near CPU disable. We tried to dump the stack there but the call
> > > > stack is not coming as it is near cpu disable.
> > > That is odd that you can't get a stacktrace.
> > > 
> > > > But we got dump at resume please have look at it
> > > > 
> > > > [   54.946268] Enabling non-boot CPUs ...
> > > > [   54.951182] CPU: 1 PID: 21 Comm: cpuhp/1 Not tainted 5.15.41 #105
> > > > 43491e4414b1db8a6f59d56b617b520d92a9498e
> > > > [   54.961122] Hardware name: Qualcomm Technologies, Inc. sc7280 IDP
> > > > SKU2 platform (DT)
> > > > [   54.969088] Call trace:
> > > > [   54.971612]  dump_backtrace+0x0/0x200
> > > > [   54.975399]  show_stack+0x20/0x2c
> > > > [   54.978826]  dump_stack_lvl+0x6c/0x90
> > > > [   54.982614]  dump_stack+0x18/0x38
> > > > [   54.986043]  dw_msi_unmask_irq+0x2c/0x58
> > > > [   54.990096]  irq_enable+0x58/0x90
> > > > [   54.993522]  __irq_startup+0x68/0x94
> > > > [   54.997216]  irq_startup+0xf4/0x140
> > > > [   55.000820]  irq_affinity_online_cpu+0xc8/0x154
> > > > [   55.005491]  cpuhp_invoke_callback+0x19c/0x6e4
> > > > [   55.010077]  cpuhp_thread_fun+0x11c/0x188
> > > > [   55.014216]  smpboot_thread_fn+0x1ac/0x30c
> > > > [   55.018445]  kthread+0x140/0x30c
> > > > [   55.021788]  ret_from_fork+0x10/0x20
> > > > [   55.028243] CPU1 is up
> > > > 
> > > > So the same stack should be called at the suspend path while disabling CPU.
> > > Sounds like you're getting hit by affinity changes while offlining CPUs
> > > during suspend (see irq_migrate_all_off_this_cpu()). That will happen
> > > after devices are suspended (all phases of suspend ops).
> > The affinity setting should not happen since DWC MSI controller doesn't support
> > setting IRQ affinity (hierarchial IRQ domain). In the migrate_one_irq()
> > function, there is a check for the existence of the irq_set_affinity()
> > callback, but the DWC MSI controller return -EINVAL in the callback. So this
> > is the reason the migration was still atempted?
> > 
> > A quick check would be to test this suspend/resume with GIC ITS for MSI since
> > it supports settings IRQ affinity and resides in a separate domain.
> > Chaitanya, can you try that?
> 
> Hi mani,
> 
> I tried with gic its there also I see same behavior.
> 

Okay

> The only which helps to comment out affinity in the following function.
> 
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 21b3ac2a29d2..042afec1cf9d 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -487,8 +487,9 @@ static int alloc_descs(unsigned int start, unsigned int
> cnt, int node,
> 
> 
> 
>                if (affinity) {
>                         if (affinity->is_managed) {
> -                               flags = IRQD_AFFINITY_MANAGED |
> -                                       IRQD_MANAGED_SHUTDOWN;
> +//                             flags = IRQD_AFFINITY_MANAGED |
> +//                                     IRQD_MANAGED_SHUTDOWN;
> +                               flags = 0;//IRQD_AFFINITY_MANAGED |
>                         }
>                         mask = &affinity->mask;
>                         node = cpu_to_node(cpumask_first(mask));
> 

The only solution I can think of is keeping the clocks related to DBI access
active or switch to another clock source that consumes less power if available
during suspend.

But limiting the DBI access using hacks doesn't look good.

Thanks,
Mani

> > > > If there is any other way to remove these calls can you please help us
> > > > point that way.
> > > I'm not sure. I believe genirq assumes the irqchips are always
> > > accessible. There is some support to suspend irqchips. See how the
> > > struct irq_chip::irq_suspend() function is called by syscore ops in the
> > > generic irqchip 'irq_gc_syscore_ops' hooks. Maybe you could add a
> > > syscore suspend/resume hook to disable/enable the clks and power to the
> > > PCI controller. syscore ops run after secondary CPUs are hotplugged out
> > > during suspend.
> > > 
> > > Or maybe setting the IRQCHIP_MASK_ON_SUSPEND flag can be used so that on
> > > irq migration nothing writes the irq hardware because it is already
> > > masked in the hardware earlier. I think the problem is that on resume
> > > we'll restart the irq from the first CPU online event, when you don't
> > > want to do that because it is too early.
> > > 
> > > I have another question though, which is do MSIs support wakeup? I don't
> > > see how it works if the whole bus is effectively off during suspend. If
> > > wakeup needs to be supported then I suspect the bus can't be powered
> > > down during suspend.
> > Wake up should be handled by a dedicated side-band GPIO or in-band PME message.
> > 
> > But I still wonder how the link stays in L1/L1ss when the clocks are disabled
> > and PHY is powered down. Maybe the link or phy is powered by a separate power
> > domain like MX that keeps the link active?
> We will come back to you on this.

Okay.

Thanks,
Mani

> > 
> > Thanks,
> > Mani
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்
