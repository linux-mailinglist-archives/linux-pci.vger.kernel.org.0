Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75076523DC2
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 21:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbiEKTml (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 15:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347133AbiEKTmh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 15:42:37 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B3C63BC5
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 12:42:35 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 137so2661422pgb.5
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 12:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kpS1w2fOx6hNOJV17zPFMNfkKgAtaEh0y4CIPfiDOzc=;
        b=ArL3HsbvGAWQA7LnBXeYHOJ1XGz74DWFnWPML1iLJtK9ct6M4x6IWjHnXN5urtLdDu
         LbUJtYtl+OgU6rQnx8d4tHCnvrbAJwlTsE3q8S72nTA4LWCkM2gUxQvfVNhv4MCmZVWW
         Z3x0/K/DqZQ8xbdqjnHGb1LeT/PbXjsPRiqVzVj3IdCRBseTWaIae5yJI9VscGWRHNz0
         nCcMjO4QxUDb7WrznSxSkwqB03ocoFv9Y2HKKv5begPsJJvsGlPrPluVeT0N6A2fVJhL
         AesQKV+iht5TZz6FkGs3ocZuXz9uTyB45rWVUibXB2Zo/gMvFTG/pqrX/55DfARBJQBg
         6sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpS1w2fOx6hNOJV17zPFMNfkKgAtaEh0y4CIPfiDOzc=;
        b=BnBJmvFCZopatUIl9gveUpY3dHHGJHRLPTIkizX7CG0EzVBgFCpwBvJGCUD71Wy9Y/
         8eSS44KTDa9ByxQEUxoKw04aFxIq1ASz+MIrbpF3DEZUGaukPfIYKoUmk18D6usr10+T
         m0bpQX8QyqjugbrYQ8dqKApFNxzLJVTyBTgoLeJpLA6AiF2qSEDBIeWaZlol7aGfA4dF
         MHTe1Ps63tDoi9eQt+yt8jxth19f2GeZsREXtXnuvaRrzxqYk4ZsNXvtD0YClhsVcvdS
         JYc1ls6ScFxQibD0KPW/kP70zgjzmcZ0yuPqNPlvApoNylQupKOVzTcAuBnjDZcTP+RL
         J1DA==
X-Gm-Message-State: AOAM530TiNUySZRlzG+SRrnycUu5H2Z5NhCcRN2B9aUWO9VspPiqIYTh
        ilfj/iaTua2HEE7rfysRMW8d/BuOTlJFpj4kLTpE2A==
X-Google-Smtp-Source: ABdhPJxQDgGiyGxL/plUUrHaYJgEikd/Jfz77WGrfBNnYXwq313y9URICSHdhLabFcCBkDAfJX4gnni47bG2lkJLAqw=
X-Received: by 2002:a63:1117:0:b0:399:2df0:7fb9 with SMTP id
 g23-20020a631117000000b003992df07fb9mr22910769pgl.40.1652298154771; Wed, 11
 May 2022 12:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de> <20220509104806.00007c61@Huawei.com> <20220511191345.GA26623@wunner.de>
In-Reply-To: <20220511191345.GA26623@wunner.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 May 2022 12:42:24 -0700
Message-ID: <CAPcyv4idjqiY9CV=sghDbWqQS_PM2Z0xWxr2MsrMxS-XqU1F=w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gavin Hindman <gavin.hindman@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org, CHUCK_LEVER <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 11, 2022 at 12:14 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, May 09, 2022 at 10:48:06AM +0100, Jonathan Cameron wrote:
> > On Sat, 7 May 2022 12:18:48 +0200 Lukas Wunner <lukas@wunner.de> wrote:
> > > I'm still somewhat undecided on the kernel vs. user space question.
> >
> > Likewise.  I feel a few more prototypes are needed to come to clear
> > conclusion.
>
> Gavin Hindman (+cc) raised an important point off-list:
>
> When an IDE-capable device is runtime suspended to D3hot and later
> runtime resumed to D0, it may not preserve its internal state.
> (The No_Soft_Reset bit in the Power Management Control/Status Register
> tells us whether the device is capable of preserving internal state
> over a transition to D3hot, see PCIe r6.0, sec. 7.5.2.2.)

I think power-management effects relative to IDE is a soft spot of the
specification. If the link goes down then yes, IDE needs to be
re-established, but as far as I can see that's a policy tradeoff to
support runtime reset or support link encryption.

> Likewise, when an IDE-capable device is reset (e.g. due to Downstream
> Port Containment, AER or a bus reset initiated by user space),
> internal state is lost and must be reconstructed by pci_restore_state().
> That state includes the SPDM session or IDE encryption.
>
> If setting up an SPDM session is dependent on user space, the kernel
> would have to leave a device in an inoperable state after runtime resume
> or reset, until user space gets around to initiate SPDM.

Yes, this seems acceptable from the perspective of server platforms
that can make the power management vs security tradeoff.

>
> I think that would be a terrible user experience.  We've gone to great
> lengths to make reset recovery as seamless and quick as possible.
> (E.g. hot-plugged NVMe drives survive a reset without the driver being
> unbound, those would be prime candidates for IDE encryption.)
> It won't help the acceptance of IDE if it breaks that seamlessness.
>
> So that's a strong argument for an in-kernel SPDM implementation.

The SPDM message passing will always need to be supported in-kernel.
It's the certificate parsing and attestation flow that is proposed to
be in userspace. So perform CMA with userspace up-calls, and then
insert a key-id into the kernel for ongoing SPDM message passing.
