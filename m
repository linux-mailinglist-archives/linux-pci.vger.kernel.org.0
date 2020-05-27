Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CDE1E3E19
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 11:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgE0JyI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 05:54:08 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:32817 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgE0JyH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2020 05:54:07 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MBltK-1jjLKT2c6m-00CDQl; Wed, 27 May 2020 11:54:05 +0200
Received: by mail-qv1-f47.google.com with SMTP id dh1so10830611qvb.13;
        Wed, 27 May 2020 02:54:05 -0700 (PDT)
X-Gm-Message-State: AOAM533l6opv8qtsuRCknZJWxN9mxqkxakKQZXRox1ZB6l8pPY/cujqk
        libGPswclU007e0F2M3O/sNDzmsOyV7OYa0nueM=
X-Google-Smtp-Source: ABdhPJwFY+9e2QwGxBuOVJhyvZzHkmdup67C33Hon0tX+xYCanXD6siiWNyzzW3vpc4K6tTqx9WsMyOJzXh6HoLxoPA=
X-Received: by 2002:a05:6214:370:: with SMTP id t16mr24222212qvu.197.1590573244279;
 Wed, 27 May 2020 02:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org> <20200527090007.GA179718@kroah.com>
In-Reply-To: <20200527090007.GA179718@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 11:53:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a35fjXt1F2hJygup5gWfjPHZTuU+VD69K5uzrNhhgu0Pw@mail.gmail.com>
Message-ID: <CAK8P3a35fjXt1F2hJygup5gWfjPHZTuU+VD69K5uzrNhhgu0Pw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7K2loUdsuzT4IObBECaTn5y/oTwu9Qnf7fQGq3o3+5XHTkSeubV
 RkTn504d1Z3tqqH5zotfEfCbYHNzcz7ngEoG4h5+ogwKwxhFOdzfXXT1uY0AWLucWB2PLHR
 dqkjxVfhTidDANOLpVF1+u7kI0XC3zFrDVIpU5sBiApHBh/4OxfJ/bzSbYnmnvJuFl8225L
 jAT9cXT8IQvkLTSHkfbQw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DbAEUAVsBkM=:7+j/lOP7swsqLFFxJSAwFf
 ItEC3r0lBQC310bf0/c3QzQbF84sZuRnNiMCBE8TLhSAeUv8xxYikqgF650oIKqNymmHdt004
 F08oVFVZ7aXRpfvfjzEqavIlw8j/Ba95gvaqi3+x/Ncc6rtSxY5xU7cOl9RynkZqVURxlYKLo
 4LH7Ws/t0aqA9WXGeQ3k1+u+lfkfcGVir/daeX3QTAXmKku/spJl4u1B+3c+clr1WnFVWg5ar
 oLk9Ow3KVtUp+KvVJAcvYPa9FuuzDVkUWrgvKr0EwP02DFcRzAqBdIRfvTMw003Rq6+4BIXyM
 am1JdeZ35CoJGUTxe538lEdwobpe8YPs8+jvs5R5+rqWmex/KC7FyTvX5WX6Gwu2+2v3aPQXj
 ZiZ1Ik7xwSRDWe0DgulC3XwlE5EyI/Yp8Zxx/dt3ETB7WyDtIX5DFfxAX26bQnIi0kh1S1kkm
 zJuSO4KrO8HvLJvF/BHhg5xEy1w03Mfq9JMNWZabgxKxd1+gnQw6QHxW3CElkr+t0N0nqD38R
 xu1XrBBdgctMN74gdHWvaIsNDLVASuOOxKKZBmBwebuQ9twv9IJdWU49lUPxaLRPaAkUq8kpb
 uP4EwQG4f7mreMQykVlroIbC+XRj3fdte3PFEs570mYw3gWbb2lsEmFtCV/0Hp+ndYulb/D58
 JgQwRg7AASPjMOo1Aat8IywGuyGp+RxqwQbKsofsnCas2HojPD37fSuxyCGj8RGqiLbn+02EY
 OQpuJmkC3a32velZ0MjS2ODlSOp8TPOGiGQhZsLoqwauWQCWJlkz9GL3Fzh4bHSiU5Q8VkJbg
 UJYRC664fnWhVVjS/xKOLJofbn8Sr9EmixSWQ3D+C4mSpPjUjU=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 27, 2020 at 11:00 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 26, 2020 at 07:49:07PM +0800, Zhangfei Gao wrote:
> > Some platform devices appear as PCI but are actually on the AMBA bus,
>
> Why would these devices not just show up on the AMBA bus and use all of
> that logic instead of being a PCI device and having to go through odd
> fixes like this?

There is a general move to having hardware be discoverable even with
ARM processors. Having on-chip devices be discoverable using PCI config
space is how x86 SoCs usually do it, and that is generally a good thing
as it means we don't need to describe them in DT

I guess as the hardware designers are still learning about it, this is not
always done correctly. In general, we can also describe PCI devices on
DT and do fixups during the probing there, but I suspect that won't work
as easily using ACPI probing, so the fixup is keyed off the hardware ID,
again as is common for x86 on-chip devices.

      Arnd
