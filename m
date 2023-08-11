Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2F2778906
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 10:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjHKIfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 04:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjHKIfI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 04:35:08 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FB12D69
        for <linux-pci@vger.kernel.org>; Fri, 11 Aug 2023 01:35:07 -0700 (PDT)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4C2A941BF9
        for <linux-pci@vger.kernel.org>; Fri, 11 Aug 2023 08:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691742906;
        bh=j+VhLT1PEgzO1srFP3LGEp7m6a2DNMmpqDUBO5tcKS8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=jrX+qVavllWH+hBM8XdQV/Oo1m//s+xhoCKieq1BRrQIXyM93ZRa4xLRUdZ+z+7rx
         JsNYExlygC/SsQMUP7dEctoZdTG2BqKZZrzwTLn8tGua5t15nr/NvApi6MNHrU514L
         T8BZvnFHQBzinDCoTx8QzdXcS2QbXeoZdTOjc1GnzI6t5oDQtj2EwPMXxmXOOEFPVD
         ooy8LaDwu6RLBjtShyDzOEhHH8xAuNTuxyFkb2mVFK17CzbJNx9tuEZxTdh3Z0qyoI
         Rpsryusy/G27js76xQtHWtme33Iy4CZ9mPTEj70QEB/SmPzORT8OCWk9G1st0/tYrY
         KjWFnZw/bWZBA==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26b139f4e2aso1639304a91.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Aug 2023 01:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691742905; x=1692347705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+VhLT1PEgzO1srFP3LGEp7m6a2DNMmpqDUBO5tcKS8=;
        b=lxa5Ahv5hv40olEcHenJfsrrZtrI7DsQw26vZr0ZqmF0gt5koSFCG1afZ/AtkjfiDz
         B5kDsjbZ7JAWBqcxBk2zStoKsgl2xQIsrn+DdtCXcruTSaxZeKpkaEDkYo2mBWICasA3
         4OkuTnXyM2K+yMNI9lVGCrSG2Iud9bQsYIGoFOsalwudkS4BWnR+XkPdzHbQipzPItKN
         Sxbu1753g6K3dDOK9ts98a/uw44UcqhLepimfwUKh5cb6zvWqe3N3XMzTXlFuh8yahPA
         F/E4bd6f2QvZ/sGopqyP8A1jPRx4CDJFAsvyAmnuQC1WMohJoE78PPairFZH8s7mHEOd
         Hl2g==
X-Gm-Message-State: AOJu0YwV7vbRD72oFKPvw/IzX13bViS/DOUCfmHXEA3frSDuH7yhZgd8
        QwHfflt2gY7I21aH2udcusrUIRD/qvySZu8ZB7Jv8kJsF+zF94KiE9LmGJLB7286yIOkD/foYIZ
        d/ciq8vpZAcVFk/F8DQF2MwJAw5AlQ6PbWLbkQ6QovB6I04yeacFekA==
X-Received: by 2002:a17:90b:1244:b0:269:14eb:653a with SMTP id gx4-20020a17090b124400b0026914eb653amr882772pjb.4.1691742904869;
        Fri, 11 Aug 2023 01:35:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM4M6K2z/NWa24PavF6fY5APms59SNpRMS+3PFSr9ffbY8cl6ex9ctpm/3OdmQqE943mbsEAH4MhvKKp8EIao=
X-Received: by 2002:a17:90b:1244:b0:269:14eb:653a with SMTP id
 gx4-20020a17090b124400b0026914eb653amr882765pjb.4.1691742904587; Fri, 11 Aug
 2023 01:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <dc44cb41-b306-f18a-c9fc-3d956777f722@amd.com> <20230718192450.GA489825@bhelgaas>
In-Reply-To: <20230718192450.GA489825@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 11 Aug 2023 16:34:52 +0800
Message-ID: <CAAd53p5PAhX6OO0xzaF5TKJ4qT6=nMjQqv5vZM=7rFKtgr-H=A@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        intel-wired-lan@osuosl.org, bhelgaas@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 19, 2023 at 3:24=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, Jul 17, 2023 at 11:51:32AM -0500, Limonciello, Mario wrote:
> > On 7/16/2023 10:34 PM, Kai-Heng Feng wrote:
> > > On Sat, Jul 15, 2023 at 12:37=E2=80=AFAM Mario Limonciello <mario.lim=
onciello@amd.com> wrote:
> > > > On 7/14/23 03:17, Kai-Heng Feng wrote:
>
> > > > > The main point is OS should stick to the BIOS default, which is t=
he
> > > > > only ASPM setting tested before putting hardware to the market.
> > > >
> > > > Unfortunately; I don't think you can jump to this conclusion.
>
> I think using the BIOS default as a limit is problematic.  I think it
> would be perfectly reasonable for a BIOS to (a) configure only devices
> it needs for console and boot, leaving others at power-on defaults,
> and (b) configure devices in the safest configuration possible on the
> assumption that an OS can decide the runtime policy itself.

This is not using BIOS as a "limit". OS is still capable of changing
the ASPM policy at boot time or runtime.
The main point is to find a "sane" setting for devices where BIOS
can't program ASPM.

>
> Obviously I'm not a BIOS writer (though I sure wish I could talk to
> some!), so maybe these are bad assumptions.
>
> > > > A big difference in the Windows world to Linux world is that OEMs s=
hip
> > > > with a factory Windows image that may set policies like this.  OEM
> > > > "platform" drivers can set registry keys too.
>
> I suppose this means that the OEM image contains drivers that aren't
> in the Microsoft media, and those drivers may set constraints on ASPM
> usage?
>
> If you boot the Microsoft media that lacks those drivers, maybe it
> doesn't bother to configure ASPM for those devices?  Linux currently
> configures ASPM for everything at enumeration-time, so we do it even
> if there's no driver.

This can be another topic to explore. But sounds like it can break things.

>
> > > I wonder if there's any particular modification should be improved fo=
r
> > > this patch?
> >
> > Knowing this information I personally think the original patch that sta=
rted
> > this thread makes a lot of sense.
>
> I'm still opposed to using dev_is_removable() as a predicate because I
> don't think it has any technical connection to ASPM configuration.

OK. So what should we do instead? Checking if the device is connected
to TBT switch?

Kai-Heng


>
> Bjorn
