Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A151757A6F7
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 21:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbiGSTLv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 15:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiGSTLu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 15:11:50 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9104505F
        for <linux-pci@vger.kernel.org>; Tue, 19 Jul 2022 12:11:48 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id v15so14785866ljc.1
        for <linux-pci@vger.kernel.org>; Tue, 19 Jul 2022 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=7SV6cxwcWEiGaJqm53YhsvXnwanf2AoDb1dJfihwiuM=;
        b=LyZaBRYjZ++sF/ivAbWDNgvWsCy3Ft14NyOoQR7nkoiDkDNe3Mm4G1ZlumVbMlr9ZK
         fonUUJOrdmfTEy2gT9ZN0sfwora6dTjtX7MBJkfekJym8CM/Qqm2YF701dlXXvNMb6D5
         EB2sI0TeWQrJoENC/9VOMGh+vw9y0qpl301yracsbYSiGwI6VM6ie+RC6kZSPqYD7TWG
         PzIESqj+r3t3zoVvLdcsD8Xsxnscvk9GqXOH4BPMYboj7OjF182DCiSAgBvKhreR2NKL
         4zzmccw4giOeaIRzlPV0d0RQdLXQFnbO8nV2jR8Qcoizo9M9KmAAYZPP11F35qb5nEgV
         S32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=7SV6cxwcWEiGaJqm53YhsvXnwanf2AoDb1dJfihwiuM=;
        b=dqPAIoZJ27guPK7tmaFxZ8GAVT/RDacy8IFSsUTI2PkhsyaHxYNtoomb5DwKRyLIhE
         W/9BOvDOyySao0IkeikmNc4xmBqsOy6sO54JawNCHnukpnD78qrv3d8Lpkac6FKUfgK7
         5kvgWQX4/MNnitULUvMgHcfY5VEPq3KrArr4nL/eGZzgmtkLlg/CldOytiP+4VweXASs
         NK8vO/v2EQgFo45NYa0nNyVHEIAWf4TmqSOGxdopc+u9po46twQJ34Bqm/ZTkL84hO0N
         fc6HTKF/4kQXSA0psHpfAnD2GNl2CrVRU8sg3jAOOrhS9STMHkPtdtmTCQPyu9kXSzGy
         RkQg==
X-Gm-Message-State: AJIora/l5du+IwoK2nLgi7nr+kCDExXPWt2hBAyUlpyqyAPl4kZxhjxS
        LTBmxWz9NpLLOW/tK+uU4e+D6g==
X-Google-Smtp-Source: AGRyM1uOESYS4Whck2N14ZdE9rrXhBpV/yJJwFiLzXV44VcuHgb4mlzQgO/Ey/B75J9SexIskNAR5w==
X-Received: by 2002:a2e:bea8:0:b0:25d:610f:5c02 with SMTP id a40-20020a2ebea8000000b0025d610f5c02mr14787392ljr.186.1658257906647;
        Tue, 19 Jul 2022 12:11:46 -0700 (PDT)
Received: from [10.43.1.253] ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id p15-20020ac24ecf000000b0047f6f8f20dcsm2159491lfr.28.2022.07.19.12.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 12:11:46 -0700 (PDT)
Message-ID: <5e6b3acf-1909-de42-3da7-c591e23ab221@semihalf.com>
Date:   Tue, 19 Jul 2022 21:11:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] PCI/ASPM: Disable ASPM when save/restore PCI state
Content-Language: en-US
From:   Dmytro Maluka <dmy@semihalf.com>
To:     Victor Ding <victording@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Zide Chen <zide.chen@intel.com>
References: <20210311173433.GA2071075@bjorn-Precision-5520>
 <20210726220307.GA647936@bjorn-Precision-5520>
 <CANqTbdb_h_W+8kmh6s56deA8VKn6tO1KDJaS5Yasq5RFLtGUbQ@mail.gmail.com>
 <820dff42-67e4-32d2-a72f-9e9bdb70609e@semihalf.com>
In-Reply-To: <820dff42-67e4-32d2-a72f-9e9bdb70609e@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/18/22 18:21, Dmytro Maluka wrote:
> While we're at it, I'm also wondering why for the basic PCI config (the
> first 256 bytes) Linux on x86 always uses the legacy 0xCF8/0xCFC method
> instead of MMCFG, even if MMCFG is available. The legacy method is
> inherently non-atomic and does require the global lock, while the MMCFG
> method generally doesn't, so using MMCFG would significantly speed up
> PCI config accesses in high-contention scenarios like the parallel
> suspend/resume.
> 
> I've tried the below change which forces using MMCFG for the first 256
> bytes, and indeed, it makes suspend/resume of individual PCI devices
> with pm_async=1 almost as fast as with pm_async=0. In particular, it
> fixes the problem with slow GL9750 suspend/resume even without Victor's
> patch.
> 
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -40,20 +40,20 @@ const struct pci_raw_ops *__read_mostly raw_pci_ext_ops;
>  int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
>                                                 int reg, int len, u32 *val)
>  {
> -       if (domain == 0 && reg < 256 && raw_pci_ops)
> -               return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
>         if (raw_pci_ext_ops)
>                 return raw_pci_ext_ops->read(domain, bus, devfn, reg, len, val);
> +       if (domain == 0 && reg < 256 && raw_pci_ops)
> +               return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
>         return -EINVAL;
>  }
>  
>  int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
>                                                 int reg, int len, u32 val)
>  {
> -       if (domain == 0 && reg < 256 && raw_pci_ops)
> -               return raw_pci_ops->write(domain, bus, devfn, reg, len, val);
>         if (raw_pci_ext_ops)
>                 return raw_pci_ext_ops->write(domain, bus, devfn, reg, len, val);
> +       if (domain == 0 && reg < 256 && raw_pci_ops)
> +               return raw_pci_ops->write(domain, bus, devfn, reg, len, val);
>         return -EINVAL;
>  }
>  
> 
> Sounds good if I submit a patch like this? (I'm not suggesting it
> instead of Victor's patch, rather as a separate improvement.)

Ok, I found that a similar change was already suggested in the past by
Thomas [1] and got rejected by Linus [2].

Linus' arguments sound reasonable, and I understand that back then the
only known case of an issue with PCI config lock contention was with
Intel PMU counter registers which are in the extended config space
anyway. But now we know another case of such a contention, concerning
the basic config space too, namely: suspending or resuming many PCI
devices in parallel during system suspend/resume.

I've checked that on my box using MMCFG instead of Type 1 (i.e. using my
above patch) reduces the total suspend or resume time by 15-20 ms on
average. (I also had Victor's patch applied all the time, i.e. the ASPM
L1 exit latency issue was already resolved, so my test was about the PCI
lock contention in general.) So, not exactly a major improvement, yet
not exactly a negligible one. Maybe it's worth optimizing, maybe not.

Anyway, that's a bit of digression. Let's focus primarily on Victor's
ASPM patch.

[1]
https://lore.kernel.org/all/tip-b5b0f00c760b6e9673ab79b88ede2f3c7a039f74@git.kernel.org/

[2]
https://lore.kernel.org/all/CA+55aFwi0tkdugfqNEz6M28RXM2jx6WpaDF4nfA=doUVdZgUNQ@mail.gmail.com/

Thanks,
Dmytro
