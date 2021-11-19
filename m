Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A4A456B27
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 08:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhKSH6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 02:58:33 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:43687 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKSH6c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 02:58:32 -0500
Received: by mail-ed1-f53.google.com with SMTP id w1so38951093edd.10;
        Thu, 18 Nov 2021 23:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J6zouXQGCHiuiXkAFB6eU4GAjZXCJ/oMOdOwBgVwDYw=;
        b=xppPnGott75WShq9cQ6T3D5k/VD7DjzaTSciCLfDCjY6Aya9ct4j0s71o9F1Eg6rf2
         Oyy75XhWQDbfQLdMDysAnb6zOJHMu4mRozpKQDRK8q4IgajMdjixTb3qK5MkDKDl/qDG
         ma+1eua4YIwBT+GP7wqe1e6q5BGZFHMx+y8dBzlSIWM5FWjKf54SYsoiYUpVu0ktF6Ds
         Un1ykJlziVQV98hGx86VCLCSplZ/7+BIsKEiQ8q6qxmFNoA3A1T+GgpPrvofr+81GSTQ
         ooC2JEwexwx35rfi3cx+MbD8NTDgwwM6s7w7bwNX3Dspeuh69OvFyKNRPjs/yQLkJP2S
         d72Q==
X-Gm-Message-State: AOAM530Te4QebBx2XmQNW9vaGqO65iUZz/Ce47InerJyGCbK6SnHB23f
        IY1KqMqqIa+IlrzXYEBuIbo=
X-Google-Smtp-Source: ABdhPJyaLgIE5MXPw6z4W7QfxaymO23vtqDU8e14fPSgYaopP0LzVaVJQiXBrMUYeIDbh4SxOgFf5g==
X-Received: by 2002:aa7:cf9a:: with SMTP id z26mr21601967edx.136.1637308530462;
        Thu, 18 Nov 2021 23:55:30 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id hv17sm881009ejc.66.2021.11.18.23.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:55:29 -0800 (PST)
Date:   Fri, 19 Nov 2021 08:55:28 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     "liuqi (BA)" <liuqi115@huawei.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com
Subject: Re: [PATCH v11 2/2] drivers/perf: hisi: Add driver for HiSilicon
 PCIe PMU
Message-ID: <YZdYcOYxta3FQFR8@rocinante>
References: <20211029093632.4350-1-liuqi115@huawei.com>
 <20211029093632.4350-3-liuqi115@huawei.com>
 <CAC52Y8Zc5oRRBDiZq+zQNGw2CbURN2SRsfW9ek_gw96qDHB1zw@mail.gmail.com>
 <acb5a232-dd09-9292-5b24-25e8e29e98e7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acb5a232-dd09-9292-5b24-25e8e29e98e7@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Qi,

Thank you for looking into things I've mentioned!

[...]
> > Would the above "bdf" be the PCI addressing schema?  If so, then we could
> > capitalise the acronym to keep it consistent with how it's often referred
> > to in the PCI world.
> > 
[...]
> got it, will change it to Bdf to keep the consistent, thanks.

Just to make sure - the "Bus, Device, Function" in the world of PCI usually
uses the acronym of "BDF", all uppercase letters.

> > [...]
> > > +static int __init hisi_pcie_module_init(void)
> > > +{
> > > +     int ret;
> > > +
> > > +     ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
> > > +                                   "AP_PERF_ARM_HISI_PCIE_PMU_ONLINE",
> > > +                                   hisi_pcie_pmu_online_cpu,
> > > +                                   hisi_pcie_pmu_offline_cpu);
> > > +     if (ret) {
> > > +             pr_err("Failed to setup PCIe PMU hotplug, ret = %d.\n", ret);
> > > +             return ret;
> > > +     }
> > 
> > The above error message could be made to be a little more aligned in terms
> > of format with the other messages, thus it would be as follows:
> > 
> >    pr_err("Failed to setup PCIe PMU hotplug: %d.\n", ret);
> > 
> > Interestingly, there would be then no need to add the final dot (period) at
> > the end here, and that would be true everywhere else.
> > 
> 
> thanks for your reminder , I'll fix that printout message to keep align.

Thank you!

Don't forget to drop the trailing dot after the error code (it makes it
easier to read or even parse in a script, etc.).

Again, thank you so much for working on this driver!  An amazing work!

	Krzysztof
