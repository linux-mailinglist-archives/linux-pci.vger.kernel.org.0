Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041711D3FDC
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 23:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgENVXH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 17:23:07 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58283 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgENVXH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 17:23:07 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mk0BK-1ioyw50Yo4-00kL24 for <linux-pci@vger.kernel.org>; Thu, 14 May 2020
 23:23:05 +0200
Received: by mail-qk1-f169.google.com with SMTP id i14so401759qka.10
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2020 14:23:04 -0700 (PDT)
X-Gm-Message-State: AOAM533zgEhH7iTT1pmSTOQcKV6Y3D7cPZxhcKkPpaYwUgeLNLOqtLDM
        +OPAwF6zSNUcz2Z/Gab2JV8315JxJigo4DVlKSM=
X-Google-Smtp-Source: ABdhPJxiuVdNPldFByNKdgbwLtBXTlOC6bSY7guaejoVc6sCJoXmoF4j+kCot+mRehcSIh+NVyBLmLCmem6fnGcQIBY=
X-Received: by 2002:ae9:ed95:: with SMTP id c143mr383762qkg.394.1589491384045;
 Thu, 14 May 2020 14:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200513223859.11295-1-robh@kernel.org> <20200513223859.11295-2-robh@kernel.org>
In-Reply-To: <20200513223859.11295-2-robh@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 May 2020 23:22:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a274cLVFQWYHos41+J45mx3+Aidt3yYJvp5HvSTJgwAbQ@mail.gmail.com>
Message-ID: <CAK8P3a274cLVFQWYHos41+J45mx3+Aidt3yYJvp5HvSTJgwAbQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Fix pci_host_bridge struct device release/free handling
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:DbXg1g24Tq3bohmaEdMpkZfkSKPD+IDZrXNIIoAk14yBo9Na4GB
 Nj80SmvZQWKkzT8yR+90IxZ8N4OR8B9FgT9HcSV3wGc5gaFonoysUF4VLcs6vsrtCHNCAPG
 YhQXOFgW8GnPweZb3K+0qSSwW2aLrIVo/43AWMvhxvA+pSuOdDSlnGr6L7qwycUq1L4ZwE+
 lDWrToumcZ030f3WD/IIg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jKSGsDzkXXg=:RvnKlRC8khCqPO/7FoUBoD
 45yYuQ3HRGixKu3v2Lprkk73Sd7+qlQDo8kJvlHyFcB3hUSPzaQ/+OvEsT20QjTZAbAaGcLJg
 Hj604YnhpuBkBlmRrmUf23ccTEYKtl8+tDmyVDg9a4kS8LEHfeBMfpbUic1UGXiPvtJgm4Va6
 8EyHKBOWgE54FJFjAkI7So6F70hoDLEPP6Qt6QX1qre138KVQ4FV31+R1d/83SSgt3UscC5iI
 CWrOuKdRZaVvXJPAoD7P0VkLcVvuauzqucRjbVm7USXFKuFnqv4Ln/ttzzsfsWLEdnrKVplb6
 BvGZ+OOHKlSLgz80+SdKXD0BIDW2DVMe4Qee3ySfjAfhZ0/0HJEAYQ9kP/e5LXT/c+PEEu1PY
 AiENWxCsn/Y02RmK87cefd5IsGHtfy2bmm7DOdW0ANjSETTYVPmhRi8JvAEBGUBrwWeJOsbJj
 uzXYjakqvCemQ85BfkABa0LLVS37SKviJwnk5azayeYeKiE47cKhhgr9w9+cAugvOcrsSJwDo
 nrGEM7y0iBk6tBIioZoz73zFCGIb9Zo87YCKF5BM5rlGF43/Wh6LKLXC3bRkDPmApphXoG+Ij
 hRdRjq1rJXruHMgITd0kTwEDXi5r3rlxhMZ8A2cCFDUZcgVXhYpl4nzzizOajMBA0fJml+u/7
 ipmh1q6psJPBC6kYFEPVw06PcYyjYGvHgrX+ffKcX1GQFBzCfMUA5wrRqW2FiZ8Bs6gQ7hgfV
 iAmJTvGBI/PKcwtTs+Z4H8RNVP5UwyuBk2p1TFcX/MRalUGub0PibwaqGwzgPc2yFp3o6maBt
 ZCdQ/fqbIuc9b0JGsIGDSPi9I0/3/a54mkVgkreHyg+5QTjZ4o=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 14, 2020 at 12:39 AM Rob Herring <robh@kernel.org> wrote:
>
> The PCI code has several paths where the struct pci_host_bridge is freed
> directly. This is wrong because it contains a struct device which is
> refcounted and should be freed using put_device(). This can result in
> use-after-free errors. I think this problem has existed since 2012 with
> commit 7b5436635800 ("PCI: add generic device into pci_host_bridge
> struct"). It generally hasn't mattered as most host bridge drivers are
> still built-in and can't unbind.
>
> The problem is a struct device should never be freed directly once
> device_initialize() is called and a ref is held, but that doesn't happen
> until pci_register_host_bridge(). There's then a window between
> allocating the host bridge and pci_register_host_bridge() where kfree
> should be used. This is fragile and requires callers to do the right
> thing. To fix this, we need to split device_register() into
> device_initialize() and device_add() calls, so that the host bridge
> struct is always freed by using a put_device().
>
> devm_pci_alloc_host_bridge() is using devm_kzalloc() to allocate struct
> pci_host_bridge which will be freed directly. Instead, we can use a
> custom devres action to call put_device().
>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for working your way through that bit of code
and fixing my mistakes!

Your description makes a lot of sense and the code looks
reasonable, but I don't understand my own work enough any
more to be sure I didn't miss anything.

Acked-by: Arnd Bergmann <arnd@arndb.de>
