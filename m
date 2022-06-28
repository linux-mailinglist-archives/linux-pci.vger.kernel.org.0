Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7756E55E979
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347864AbiF1QFR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 12:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347743AbiF1QFE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 12:05:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372E517E2B
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 09:04:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95783617A5
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 16:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B008CC3411D;
        Tue, 28 Jun 2022 16:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656432244;
        bh=JKzY6V2NnNM/D6BPHnDVSZSJfNKbJjgAzIiir29z89M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uWt5J6gGhvMdR0BaRoLbkCV7fHEsqAX/9N+GHocv9INQ75MUfuhW3TEjO9FHpc3MO
         YG4wDzI8WYaejClMHx9cCOqHtJEXsOz3UZGZzUPQlNZ4n2sPzUrjRStE7h908iKbuI
         ykm/MhHETsYzSY1JUmOmPzBxw6gp009m0PyBPzLu9yyextJlI1f6HPIF2pkldkTpu5
         U/XBAYqDh1Tuk9tzDPrrHM/9wmgZg6HrxM4deWUrW1pr0aBOcvV+e69YX5Ps7Vgeyn
         hjABB+pYeaM5c1Ojk0agSS7nKzpwWa8gyyuAj99TEGs1fGJ9cCXqWTPw28pGSyYbPY
         myepPPBRXEmJg==
Date:   Tue, 28 Jun 2022 11:04:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V14 4/7] PCI: loongson: Don't access non-existant devices
Message-ID: <20220628160402.GA1842175@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dbddb05-a0b4-047e-8784-c89279221f20@loongson.cn>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 09:03:02PM +0800, Jianmin Lv wrote:
> On 2022/6/28 上午5:38, Bjorn Helgaas wrote:
> > On Fri, Jun 17, 2022 at 03:43:27PM +0800, Huacai Chen wrote:
> > > On LS2K/LS7A, some non-existant devices don't return 0xffffffff when
> > > scanning. This is a hardware flaw but we can only avoid it by software
> > > now.
> > 
> > We should say what *does* happen if we do a config read to a device
> > that doesn't exit.  Machine check, hang, etc?
> 
> The device is a hidden device(only for debug) that should not be
> scanned. If scanned in a non-normal way, the machine is hang(one
> case in ltp pci test can trigger the issue, which is explained
> below).

Reading the Vendor ID is the *normal* way to scan for a device.  It
seems that this hardware just hangs in some cases when the device
doesn't exist.

> > Generally speaking we only probe for functions > 0 if .0 is marked as
> > multi-function, so I guess this means 00:09.0 is marked as a
> > multi-function device, but config reads to 00:09.1 would fail?
> 
> Yes, definitely. Actually, the 00:09.0 is a single device, so fun1(09.1)
> will not be scanned(e.g. the fun1 will be not scanned on pci enumeration
> during kernel booting).
> 
> But, there is one situation: when running ltp pci test case on LS7A,
> the 00:08.2 is a sata controller(a valid device), and the bus number(0)
> and devfn(0x42) are inputted to kernel api pci_scan_slot(), which has
> clear note: devfn must have zero function. So, apparently, the inputted
> devfn's function is not zero, but 2, and then in the pci_scan_slot():
> 
>         for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn))
> {
>                 dev = pci_scan_single_device(bus, devfn + fn);
>                 ...
>         }
> 
> 08.2,08.3...and 09.1 will be scanned one by one, so the 09.1(fun1) is
> scanned.

Does the "((bus == 0) && (device >= 9 && device <= 20) && (function > 0))"
test catch *all* devfns where the hang occurs?  I wouldn't want to
only avoid the ones that LTP happens to use.  If we did that, a future
LTP change could easily break things again.  But I assume you know
exactly what devices are present on the root bus.

> > > -	if (priv->data->flags & FLAG_DEV_FIX &&
> > > -			!pci_is_root_bus(bus) && PCI_SLOT(devfn) > 0)
> > > +	if ((priv->data->flags & FLAG_DEV_FIX) && bus->self) {
> > > +		if (!pci_is_root_bus(bus) && (device > 0))
> > > +			return NULL;
> > > +	}
> > > +
> > > +	/* Don't access non-existant devices */
> > > +	if (!pdev_is_existant(busnum, device, function))
> > >   		return NULL;
> > 
> > Is this a "forever" hardware bug that will never be fixed, or should
> > there be a flag like FLAG_DEV_FIX so we only do this on the broken
> > devices?
> 
> No, the next new version LS7A will correct it, so maybe we can use
> FLAG_DEV_FIX-like to address it.

You should add the flag now instead of waiting for the new hardware.
Otherwise you may not remember or notice the need to make this
conditional on the hardware version, you'll wonder why the fixed
hardware doesn't enumerate devices correctly.

Bjorn
