Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C5F688E58
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 05:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjBCEBA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 23:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBCEA7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 23:00:59 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081911735
        for <linux-pci@vger.kernel.org>; Thu,  2 Feb 2023 20:00:58 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mf7so11998125ejc.6
        for <linux-pci@vger.kernel.org>; Thu, 02 Feb 2023 20:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/HZgcsGLlJMqHJzsZHwKbatB4fDlcPxMVd0rl/TShvQ=;
        b=QGNifnpjbp6/fa8XU4ec9HqrwNEbPbB2J8LFIdyTSe+w1+BTQSsGJtxQIG9+rOLCwF
         xiJeiuqJkiIz6ehKTRgHdnH8x5vX0jAlMpLjvFhhpY1mhy5PzgIDAQ8qH+jTzUsw6dtv
         p6NpaPkKlJZLIz10dXHArdxxLO2QVpCiIEyhKYjeECwcCJuLgMCBa2tI81NIwRJq1AHV
         HeEhx8S5zvY/RhKH3bnSOv8WT7FSuBzK4bSqHn+JZT6Yof+qnzDgmKISF3fczqH/J5tr
         W56NhevgI8byvA3GhnbiOb2wbgWE7/E+H7/ZiPg5/K7d/tElj9vNd8nOTc0GA2WqYGVq
         KNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HZgcsGLlJMqHJzsZHwKbatB4fDlcPxMVd0rl/TShvQ=;
        b=N13ALbjAzM2BB2IHd0tasL/ee8uYvF5S3tfAv14W5Z5URdBZDhcDECR4fJUTpLIFKc
         ufQgIbcqvXtGzl39Rq9vwJ8g1IdYLu9oXX7vJkFarqS906v8ZWKXUegJz4ScDXColfPz
         H+N37+d0ATvl0NkTuv/Lh3DeUB9iwmBqFwnXru2GD7Dp6sIuQq9xQrsuPbsuaA3aHdvr
         WFobHEC8Xezv4DXzTK5XTv5B2TRkgLgzWmP2On6xDuLyDKpCN0dg9c5PO/6WWuVmr1sZ
         fCDvtYQH5+5yCoTpuU9dOuGTS5nYT7/0oNzICt3J1x8N8NDKiTUkY/5+5jmCY9FYvfBq
         torw==
X-Gm-Message-State: AO0yUKUW/Zn7QighLwCCIAyMg3yzR45e4pV6sAbofNWlnl/JjgGUkIAU
        AsljCUfzN+eD5HKrYYIHLXsa+ZHXwZUk/ERf5WQ=
X-Google-Smtp-Source: AK7set8cd7jc7T2LEQGObEzNgmbjwUDRKmngIFcu2/V1YdqgKqiM5QsB3wADqBG3Os5tADP2l+MWD3/MSYcjA2Lgfxc=
X-Received: by 2002:a17:906:5494:b0:860:f9a6:8d57 with SMTP id
 r20-20020a170906549400b00860f9a68d57mr2531489ejo.287.1675396856465; Thu, 02
 Feb 2023 20:00:56 -0800 (PST)
MIME-Version: 1.0
References: <CAAhV-H5fgG5uV5Zy6BsmwPpuhuog_L11TjWr4A82nbAcmHSj2w@mail.gmail.com>
 <20230202203040.GA1964750@bhelgaas>
In-Reply-To: <20230202203040.GA1964750@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 3 Feb 2023 12:00:37 +0800
Message-ID: <CAAhV-H60bmz_oaWj5ZjM9mbcPtm4Z=8xu+FrEmJZ_Xer4WD8rA@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] PCI: Omit pci_disable_device() in .shutdown()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Fri, Feb 3, 2023 at 4:30 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Feb 02, 2023 at 09:27:03PM +0800, Huacai Chen wrote:
> > On Thu, Feb 2, 2023 at 2:17 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, Feb 01, 2023 at 12:30:17PM +0800, Huacai Chen wrote:
>
> > > > +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> > > > +{
> > > > +     if (pci_bridge_d3_possible(dev)) {
> > > > +             pm_runtime_forbid(&dev->dev);
> > > > +             pm_runtime_get_noresume(&dev->dev);
> > > > +             pm_runtime_dont_use_autosuspend(&dev->dev);
> > > > +     }
> > > > +
> > > > +     pcie_port_device_remove(dev);
> > >
> > > Thanks!  I guess you verified that this actually *does* call all the
> > > port service .remove() methods, right?  aer_remove(), dpc_remove(),
> > > etc?
> >
> > I have tested, but aer_probe(), dpc_probe() doesn't get called at
> > boot, so does aer_remove(), dpc_remove() when poweroff. I haven't got
> > the root cause but I will continue to investigate.
>
> We'll only call aer_probe() and dpc_probe() if the port supports those
> services and the platform has granted us control of them.  I don't
> know if your platform does.  It may support PCIe native hotplug
> (pcie_hp_init()) or PME (pcie_pme_init()).
When I use pcie_ports=native to boot kernel, I verified that
aer_remove() and pcie_pme_remove() are both called, while DPC and
HOTPLUG are both not supported.

Huacai
>
> Bjorn
