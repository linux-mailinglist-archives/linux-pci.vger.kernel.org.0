Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832F7785A29
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 16:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbjHWOPd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 10:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbjHWOPc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 10:15:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461CAE57;
        Wed, 23 Aug 2023 07:15:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692800128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tC3legbKEgh6GaaSn5yn0aimdQy2CL6olThV+is3i/s=;
        b=sRRyH1OEK1xpWU6ptY+xbUO0aV2vsPkBsmcJa6O4urXCbLGekvw7terr9WvATbiptHdkYf
        xt5yWFn6vPnZq61Oavlx5zIoX5KaSiqyIs6Trxn8rgn92dCTQRxKggCCP/J5flumSc2Mlf
        UBG6H4x1lwJMdidZ3o46qeqI6iHDlkPUG2F8TiH024VrILCJaBrQ1XMOVfK7x0uX7tDNHD
        DAbWJ5FL7R4vsisj4BwPYbO2yHkCPoofEKtxnx8fl5ZX9u4xtulo5QrAy4g9ofv6dFyKzE
        XkcWxyh5s22ZANx57zn1FadqYzi85hQRjRHxU9vHQV/l37T3PmTAvD9bkf5TBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692800128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tC3legbKEgh6GaaSn5yn0aimdQy2CL6olThV+is3i/s=;
        b=MavnPf9nYe9evfczAehjxfX9HzO8oe/uGl9hyapHj2jdVIqagf2I/DQx6+MNEOJdt5Fmw2
        eVxr+alc9JcjDhDw==
To:     =?utf-8?B?6buE5bCR5rOi?= <huangshaobo3@xiaomi.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     =?utf-8?B?5p2O6auY6bmP?= <chenwei29@xiaomi.com>,
        =?utf-8?B?5qKB5Lyf?= =?utf-8?B?6bmP?= <weipengliang@xiaomi.com>,
        =?utf-8?B?57+B6YeR6aOe?= <wengjinfei@xiaomi.com>,
        =?utf-8?B?54aK5Lqu?= <xiongliang@xiaomi.com>
Subject: Re: Subject: [PATCH] pci/msi: remove redundant calculation in
 msi_setup_msi_desc
In-Reply-To: <3ebf5d8032ad418da4f24516cd23406e@xiaomi.com>
References: <3ebf5d8032ad418da4f24516cd23406e@xiaomi.com>
Date:   Wed, 23 Aug 2023 16:15:27 +0200
Message-ID: <87bkexetfk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18 2023 at 07:26, =E9=BB=84=E5=B0=91=E6=B3=A2 wrote:

Your patch is corrupt:

 Applying: Subject: [PATCH] pci/msi: remove redundant calculation in msi_se=
tup_msi_desc
 error: corrupt patch at line 12

It's DOS mangled and whitespace damaged.

> Whether to support 64-bit address status has been calculated before,
> and the calculation result can be used directly afterwards, so use
> msi_attrib.is_64 to avoid double calculation.

I'm not seeing what this solves:

> -       if (control & PCI_MSI_FLAGS_64BIT)
> +       if (desc.pci.msi_attrib.is_64)

Both variants resolve to a test of a bit and a conditional instruction
on the result. It's exactly zero difference in terms of "calculation".

So all this does is change the memory location to test. Not more not
less. It does not generate better code and does not save anything.

Thanks,

        tglx

