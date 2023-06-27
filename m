Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A90873F77D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 10:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjF0IgW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 04:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjF0IgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 04:36:07 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91874B8
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 01:35:41 -0700 (PDT)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 14EF4423E6
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 08:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687854939;
        bh=cRPd42UjLsQHHlZk9zoi1NoFgO3UAhUdUSvEc9A0iZk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dmJu8jPzzyyvTdUNWV9vjdq1TsWOcIVodf5VrX41eGFs04e7s1zMx7m3uUw6e4Kkd
         9LYhzbVzCZdsMTvbAjAafOn1f4T9S/Ujj5R2XaPrhnc0eoNS2C3nPO6xGUyQ8/EJcq
         JzcAffZALUEAmp1Zi/1StX5LMsrrmNDq1jGrap196+3YG0CfwRfkUh+JRqjvx3KeDq
         dlXNEDwYOvuLdM1c3uO6aLEq+3nNu8DDX2zH5tftHNQRoA6mJHIGIf2lhpzlpC1mla
         bP3+00z6D7+OCT0M1D0gWYTzc/pgDsFGOcCmzUyRwOXnQHG4Jlt2/iHbC9jWH9j/VY
         zlCYW1RUyUjzw==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-262e04a6fd1so1270577a91.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 01:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687854937; x=1690446937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRPd42UjLsQHHlZk9zoi1NoFgO3UAhUdUSvEc9A0iZk=;
        b=Wfj6UJ/H4n7TJ/z2fEHjQhPYy6C/KZjbRjjDOxn/xJKsl+TDz2WXTbti/4jgBvI4OU
         1bOlP/K+KeGlEqOQCcJ86Sn0srJN9+Aj5VivYlC+6w1E4VI8r8doZZuZGjIzEUj/BJRZ
         rE4fLFLSuJvCG+lUuzcy8HcGy9QEl6K0aVy1VoaRsRt1BKXMKtWH3V3delrk4Kw5suxf
         EbZ1NseBuWnlsGrgKsWuZMdfw/SVwkRMAQcQjnEkqEkwXTKf0gDBOaB9rq3p1VxmeQho
         ZZl9rcd1nEfDyLDNblph3xdbFh+WkIAdCTT0L0QHpR1pa5YmjfN4PmbkRQx69XE/wy/U
         LCqw==
X-Gm-Message-State: AC+VfDx+ybySSlWQxRQlmJRbibkypxLd5c/Kahpc6DUwiT1ZCF0JtJJK
        Zq4ENK4NOBd1K2CT85ef3GMKTpypCzlMYpLb81dX8XwaH2cJlgo6g0ONQr0Yvb2v4DIGrG3dCY8
        TH43u2Q2Xw3XwsEI4eruD6UdXQJquFvyU8y2s678SQnf/TPcIjrOWHA==
X-Received: by 2002:a17:90b:38cf:b0:262:d4c8:cb3c with SMTP id nn15-20020a17090b38cf00b00262d4c8cb3cmr4511924pjb.49.1687854937513;
        Tue, 27 Jun 2023 01:35:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7MioXDYJkmV3SVO/wCnwnRIelqTF7AbSlaDlO1rO00diyGula96bz59WjKHfHlP5jECR7f1hwhWVHtmzuxmwQ=
X-Received: by 2002:a17:90b:38cf:b0:262:d4c8:cb3c with SMTP id
 nn15-20020a17090b38cf00b00262d4c8cb3cmr4511912pjb.49.1687854937083; Tue, 27
 Jun 2023 01:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <1b4b2c6c-8119-95fd-8958-dbbecc66510c@amd.com> <20230622230607.GA155247@bhelgaas>
In-Reply-To: <20230622230607.GA155247@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 27 Jun 2023 16:35:25 +0800
Message-ID: <CAAd53p4kH7E92++jabBhvsM_+M7Dpyk2JP+aoVdb_sxZn47eyQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        bhelgaas@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 23, 2023 at 7:06=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Jun 20, 2023 at 01:36:59PM -0500, Limonciello, Mario wrote:
> > <snip>
> > > > A variety of Intel chipsets don't support lane width switching
> > > > or speed switching.  When ASPM has been enabled on a dGPU,
> > > > these features are utilized and breakage ensues.
> > > Maybe this helps explain all the completely unmaintainable ASPM
> > > garbage in amdgpu and radeon.
> > >
> > > If these devices are broken, we need quirks for them.
> >
> > The problem is which device do you consider "broken"?
> > The dGPU that uses these features when the platform advertises ASPM
> > or the chipset which doesn't support the features that the device
> > uses when ASPM is active?
> >
> > With this problem I'm talking about the dGPU works fine on hosts
> > that support these features.
>
> Without more details about what's broken and when, I can't say.  What
> I *think* is that a device that doesn't work per spec needs a quirk.
> Typically it's a device that advertises a capability that doesn't work
> correctly.

Many silicon vendors use the same "PCI IP" and integrate it into their
own chip. That's one of the reason why the capability doesn't really
reflect what actually being support.
The vendors then send their private datasheet to system integrator so
BIOS can enable what's really supported.

So the logic is to ignore the capability and trust the default set by BIOS.

>
> > > > > > I think the pragmatic way to approach it is to (essentially)
> > > > > > apply the policy as BIOS defaults and allow overrides from
> > > > > > that.
> > > > >
> > > > > Do you mean that when enumerating a device (at boot-time or
> > > > > hot-add time), we would read the current ASPM config but not
> > > > > change it?  And users could use the sysfs knobs to
> > > > > enable/disable ASPM as desired?
> > > >
> > > > Yes.
> > > >
> > > Hot-added devices power up with ASPM disabled.  This policy would
> > > mean the user has to explicitly enable it, which doesn't seem
> > > practical to me.
> >
> > Could we maybe have the hot added devices follow the policy of
> > the bridge they're connected to by default?
> >
> > > > > That wouldn't solve the problem Kai-Heng is trying to solve.
> > > >
> > > > Alone it wouldn't; but if you treated the i225 PCIe device
> > > > connected to the system as a "quirk" to apply ASPM policy
> > > > from the parent device to this child device it could.
> > >
> > > I want quirks for BROKEN devices.  Quirks for working hardware is a
> > > maintenance nightmare.
> >
> > If you follow my idea of hot added devices the policy follows
> > the parent would it work for the i225 PCIe device case?
>
> That doesn't *sound* really robust to me because even if the default
> config after hot-add works, the user can change things via sysfs, and
> any configuration we set it to should work as well.  If there are
> land-mines there, we need a quirk that prevents sysfs from running
> into it.

For this case it means driver needs to provide a ASPM callback to flip
PTM based on ASPM sysfs.

Kai-Heng

> Bjorn
