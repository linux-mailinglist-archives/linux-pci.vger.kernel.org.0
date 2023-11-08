Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366A87E597A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjKHOtW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 09:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjKHOtV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 09:49:21 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7364F19A5
        for <linux-pci@vger.kernel.org>; Wed,  8 Nov 2023 06:49:19 -0800 (PST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D067C406CB
        for <linux-pci@vger.kernel.org>; Wed,  8 Nov 2023 14:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1699454957;
        bh=iW5yD8IrL/EvmnRvX1rM0q7e3WsiujW0hTSr55hdc+k=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=fhSIrT9MaQccNRCuGgKQPv2A1vhBaT/ddV1/zKLDTXmXen29VacvkZaHmI6r3bBGl
         VOK95pghhDw/2SuUM6x17YoyTN4Jj9UhhGs03KEIa3BkKtPl+TgCctGWoK1tgF3vub
         aRIMkdPxFix25UTSWdu5Co34x0ErJYQNhF7ZouknDu9tzC1WC4aUEVurt6yv2weVEY
         pzhbx/JREvojLtbhAWa93Ke3XWIuvJg1uks8zJb7rB+A0YVUS8PvH25gfPE9FK3bMU
         nOay7c0NtTFfPQqIx6rsUaZMYVOVCpqCZT8ZjufR400qejFXgUh9dMF4d0t8wgRc7X
         QNfQAz7MVvqlA==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28003f0ecedso5291653a91.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Nov 2023 06:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699454956; x=1700059756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iW5yD8IrL/EvmnRvX1rM0q7e3WsiujW0hTSr55hdc+k=;
        b=OtDC0G2PWfqgmU4eWaZhCKVJJ+6htKe3E8JNgh0vZ5WZOZCfASYdDuKrLMBDtPeERR
         LR0movzhrfqhz6AdfciJ5XhHtv/krl5KOOmNinbx089dprw4zWGmMDWF+MtXwNC25574
         BcP6JmfbAsAKGUev5czlI31onS+FbaTQTxrT5drELe5zsYX1/KhcvTniicgrqG9RB9Hf
         YFrBnlT+pJdQCMrLoTRuR526zvzc4B94wgBMPaAKO0VBQQleHxKCeyszQTNDv7aZ0MP8
         ERB6W9ofV4KBfCgtcD0h4XBR1vAwQjR4hRT8rGGUDPgtKTS5uc59nuWDPk6/CbnaGkKp
         6Egw==
X-Gm-Message-State: AOJu0YwH23DH5Zp7BEK89xI6UZkkLV9JsLtwBvAZydpCsuS6Ua52Gq6A
        +h2GYMRN5z5WNpVrPyPL9GVV9eFTzZnsZd7+dD3pIJAdwjhBIGwg/t6tlj7FftvIaQZvZf87P10
        51vSY60Yi683uQI7VSBpFZs6HbDfnv4cxUvBKek8o0LLuiv3XMF8kcA==
X-Received: by 2002:a17:90b:17c1:b0:281:2634:f81e with SMTP id me1-20020a17090b17c100b002812634f81emr1953693pjb.37.1699454956422;
        Wed, 08 Nov 2023 06:49:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9+QcWHPEggNzaINA0s56LtMmceSHjlzz2eB3Z2qfiY6i6PToeaEJ2qqYhSTZrFw9LpwH0oIOhJzh5W7ccnyY=
X-Received: by 2002:a17:90b:17c1:b0:281:2634:f81e with SMTP id
 me1-20020a17090b17c100b002812634f81emr1953677pjb.37.1699454956074; Wed, 08
 Nov 2023 06:49:16 -0800 (PST)
MIME-Version: 1.0
References: <a623e811037972c7cdf1fe05fcb7ace2b445a323.camel@linux.intel.com> <20231107223037.GA303668@bhelgaas>
In-Reply-To: <20231107223037.GA303668@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 8 Nov 2023 16:49:04 +0200
Message-ID: <CAAd53p5CqviDy-Y3FxO2sP2-q+LjHzDOe6x6upuw+V5Jh3k0uQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD rootports
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org, orden.e.smith@intel.com,
        samruddh.dhope@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 8, 2023 at 12:30=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc Rafael, just FYI re 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe=
 features")]
>
> On Tue, Nov 07, 2023 at 02:50:57PM -0700, Nirmal Patel wrote:
> > On Thu, 2023-11-02 at 16:49 -0700, Nirmal Patel wrote:
> > > On Thu, 2023-11-02 at 15:41 -0500, Bjorn Helgaas wrote:
> > > > On Thu, Nov 02, 2023 at 01:07:03PM -0700, Nirmal Patel wrote:
> > > > > On Wed, 2023-11-01 at 17:20 -0500, Bjorn Helgaas wrote:
> > > > > > On Tue, Oct 31, 2023 at 12:59:34PM -0700, Nirmal Patel wrote:
> > > > > > > On Tue, 2023-10-31 at 10:31 -0500, Bjorn Helgaas wrote:
> > > > > > > > On Mon, Oct 30, 2023 at 04:16:54PM -0400, Nirmal Patel
> > > > > > > > wrote:
> > > > > > > > > VMD Hotplug should be enabled or disabled based on VMD
> > > > > > > > > rootports' Hotplug configuration in BIOS.
> > > > > > > > > is_hotplug_bridge
> > > > > > > > > is set on each VMD rootport based on Hotplug capable bit
> > > > > > > > > in
> > > > > > > > > SltCap in probe.c.  Check is_hotplug_bridge and enable or
> > > > > > > > > disable native_pcie_hotplug based on that value.
> > > > > > > > >
> > > > > > > > > Currently VMD driver copies ACPI settings or platform
> > > > > > > > > configurations for Hotplug, AER, DPC, PM, etc and enables
> > > > > > > > > or
> > > > > > > > > disables these features on VMD bridge which is not
> > > > > > > > > correct
> > > > > > > > > in case of Hotplug.
> > > > > > > >
> > > > > > > > This needs some background about why it's correct to copy
> > > > > > > > the
> > > > > > > > ACPI settings in the case of AER, DPC, PM, etc, but
> > > > > > > > incorrect
> > > > > > > > for hotplug.
> > > > > > > >
> > > > > > > > > Also during the Guest boot up, ACPI settings along with
> > > > > > > > > VMD
> > > > > > > > > UEFI driver are not present in Guest BIOS which results
> > > > > > > > > in
> > > > > > > > > assigning default values to Hotplug, AER, DPC, etc. As a
> > > > > > > > > result Hotplug is disabled on VMD in the Guest OS.
> > > > > > > > >
> > > > > > > > > This patch will make sure that Hotplug is enabled
> > > > > > > > > properly
> > > > > > > > > in Host as well as in VM.
> > > > > > > >
> > > > > > > > Did we come to some consensus about how or whether _OSC for
> > > > > > > > the host bridge above the VMD device should apply to
> > > > > > > > devices
> > > > > > > > in the separate domain below the VMD?
> > > > > > >
> > > > > > > We are not able to come to any consensus. Someone suggested
> > > > > > > to
> > > > > > > copy either all _OSC flags or none. But logic behind that
> > > > > > > assumption is that the VMD is a bridge device which is not
> > > > > > > completely true. VMD is an endpoint device and it owns its
> > > > > > > domain.
> > > > > >
> > > > > > Do you want to facilitate a discussion in the PCI firmware SIG
> > > > > > about this?  It seems like we may want a little text in the
> > > > > > spec
> > > > > > about how to handle this situation so platforms and OSes have
> > > > > > the
> > > > > > same expectations.
> > > > >
> > > > > The patch 04b12ef163d1 broke intel VMD's hotplug capabilities and
> > > > > author did not test in VM environment impact.
> > > > > We can resolve the issue easily by
> > > > >
> > > > > #1 Revert the patch which means restoring VMD's original
> > > > > functionality
> > > > > and author provide better fix.
> > > > >
> > > > > or
> > > > >
> > > > > #2 Allow the current change to re-enable VMD hotplug inside VMD
> > > > > driver.
> > > > >
> > > > > There is a significant impact for our customers hotplug use cases
> > > > > which
> > > > > forces us to apply the fix in out-of-box drivers for different
> > > > > OSs.
> > > >
> > > > I agree 100% that there's a serious problem here and we need to fix
> > > > it, there's no argument there.
> > > >
> > > > I guess you're saying it's obvious that an _OSC above VMD does not
> > > > apply to devices below VMD, and therefore, no PCI Firmware SIG
> > > > discussion or spec clarification is needed?
> > >
> > > Yes. By design VMD is an endpoint device to OS and its domain is
> > > privately owned by VMD only. I believe we should revert back to
> > > original design and not impose _OSC settings on VMD domain which is
> > > also a maintainable solution.
> >
> > I will send out revert patch. The _OSC settings shouldn't apply
> > to private VMD domain.
>
> I assume you mean to revert 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC
> on PCIe features").  That appeared in v5.17, and it fixed (or at least
> prevented) an AER message flood.  We can't simply revert 04b12ef163d1
> unless we first prevent that AER message flood in another way.

The error is "correctable".
Does masking all correctable AER error by default make any sense? And
add a sysfs knob to make it optional.

Kai-Heng

>
> Bjorn
>
> > Even the patch 04b12ef163d1 needs more changes to make sure _OSC
> > settings are passed on from Host BIOS to Guest BIOS which means
> > involvement of ESXi, Windows HyperV, KVM.
