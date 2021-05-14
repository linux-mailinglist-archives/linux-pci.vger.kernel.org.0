Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2972D380BAF
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhENOWN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 10:22:13 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:40739 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbhENOWM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 10:22:12 -0400
Received: by mail-wm1-f45.google.com with SMTP id y124-20020a1c32820000b029010c93864955so1501138wmy.5
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 07:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l+Xsqgz8r2dyXtTsZX/G/2EHUi9zCFNcdvOGh/UOwmE=;
        b=nTq87SZOMK2M/ul8Ee6q2T0TvOF1FSEuFrc03YAwevGvltma78SWWGs/xSsbpcv0+A
         za4s72I0k76erKN48vk/PoYzK2rw2wUUdCnhfrnmk2m2xBh2FwAX5l8zTICEqWD9xm1A
         OL9TruaJy9tQmWfG26wRDuMb38PGP6l+3yGfHYMNH6bnRWN7jlQybsHyUPb3fs9qXLOR
         kT5Xl6BzddaSr7QXw1HGTcbS+HhgGaVlJnOLnRLq40qPhVzp4pdvdnBI57Iziz/9rFxG
         6p12m4EobHr2ysGY7DhyG4N0iPBxwRwaMBfBn3qo0wLWaMXBW/pgkn9eqyKBVma4ux5V
         B1hQ==
X-Gm-Message-State: AOAM530rznqwNTQ9uYNt1rcFn5+vU5F9JcZNiVBLMlwnNTi8WpWVL2aS
        EyIwSamswP6StYxNzMGxXbI=
X-Google-Smtp-Source: ABdhPJyLOTP5fdl/PeF4IX553/dJDdmFQroEltUfOXsoZ4DfxDkzN/fhSjJ1+6/JPVx/8ivpYkOfyw==
X-Received: by 2002:a05:600c:354b:: with SMTP id i11mr18480191wmq.102.1621002060660;
        Fri, 14 May 2021 07:21:00 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c15sm6752956wrd.49.2021.05.14.07.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:21:00 -0700 (PDT)
Date:   Fri, 14 May 2021 16:20:59 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH 1/5] PCI/portdrv: Don't disable pci device during shutdown
Message-ID: <20210514142059.GI9537@rocinante.localdomain>
References: <20210514080025.1828197-1-chenhuacai@loongson.cn>
 <20210514080025.1828197-2-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210514080025.1828197-2-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Huacai,

> Use separate remove()/shutdown() callback, and don't disable pci device

It would be "PCI" here in the above sentence and in the subject line.

> during shutdown. This can avoid some poweroff/reboot failures.

> The poweroff/reboot failures can easily reproduce on Loongson platforms.

Could be better as "can easily be reproduced" in the above.

> I think this is not a Loongson-specific problem, instead, is a problem
> related to some specific PCI hosts. On some x86 platforms, radeon/amdgpu
> devices can cause the same problem, and commit faefba95c9e8ca3a523831c2e
> ("drm/amdgpu: just suspend the hw on pci shutdown") can resolve it.

You might want to change the language to be more imperative in here, as
at the moment I am not sure if you actually have a solution to the
problem here, or you think you have one. :)
 
> As Tiezhu said, this occasionally shutdown or reboot failure is due to
> clear PCI_COMMAND_MASTER on the device in do_pci_disable_device().
> 
> drivers/pci/pci.c
> static void do_pci_disable_device(struct pci_dev *dev)
> {
>         u16 pci_command;
> 
>         pci_read_config_word(dev, PCI_COMMAND, &pci_command);
>         if (pci_command & PCI_COMMAND_MASTER) {
>                 pci_command &= ~PCI_COMMAND_MASTER;
>                 pci_write_config_word(dev, PCI_COMMAND, pci_command);
>         }
> 
>         pcibios_disable_device(dev);
> }
> 
> When remove "pci_command &= ~PCI_COMMAND_MASTER;", it can work well when
> shutdown or reboot. This may implies that there are DMA activities on the
> device while shutdown.
> 
> Radeon driver is more difficult than amdgpu due to its confusing symbol
> names, and I have maintained an out-of-tree patch for a long time [1].
> Recently, we found more and more devices can cause the same problem, and
> it is very difficult to modify all problematic drivers as radeon/amdgpu
> does (the .shutdown callback should make sure there is no DMA activity).
> So, I think modify the PCIe port driver is a simple and effective way.
> And as early discussed, kexec can still work after this patch.
> 
> [1] https://github.com/chenhuacai/linux/commit/8da06f9b669831829416a3e9f4d1c57f217a42f0
[...]

The above explanation and entire backstory is very helpful, but it might
be better to include it in the cover letter, and keep the commit message
here concise and only focused on what is being done here and why.

Krzysztof
