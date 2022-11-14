Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B7C628401
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 16:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiKNPeQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 10:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbiKNPeL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 10:34:11 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3151170;
        Mon, 14 Nov 2022 07:34:10 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id o8so7964228qvw.5;
        Mon, 14 Nov 2022 07:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOfoaOPTc0krweU3P8wUkVTnZoULqG3PmNlXhu4M7TI=;
        b=KY05PUqOp7FWcbU7eUfMaqVEef9rV8wBfLzgKHHluppi7/vDpdWTOIGrvfkqnqDDU2
         8n7f2mT4Zt4XV1XN9KPNNCcewmrgz1Sv4HBaQIi4vUkAM3lYehWLuMoA0WIRc8rlpEdq
         u6nkKIB9ijGdD7hx+wd0uukJ6zK0a16wXKRKP55+/9jE4xd2hJ5F7Fe5yrDW0QpC8WBl
         qMiXAhpdO4YllgFW4NhLrZFqx19l0DcvnqxMLEXwmOnu50wvOyo6mJCgSfK67I0VQEgJ
         +Mrm+ZxHTpsgHT55GjvVSQAehoHuSp0KeJYoo8Qi5Xe8uxJb4U+Cj5hmLHXnsqFqC3ew
         z/bA==
X-Gm-Message-State: ANoB5plRbehmcoiHx8zHLCm8enOR/KMg81r8oSnC4q7eOD7wpqxCjIOK
        FUC2SrZntK8ZkkLlTgarMcs33eEfWJzQnCtvAVA=
X-Google-Smtp-Source: AA0mqf6Nf71NA2JkPO/KxpfY/G2pWuerSOGZllPXl2qRNpfXA+FqSdXKHatBGpZ1xnWnxU3Yw6FuOoOu4fzhLgr8QcE=
X-Received: by 2002:a0c:e606:0:b0:4b1:a9ac:21de with SMTP id
 z6-20020a0ce606000000b004b1a9ac21demr12899948qvm.119.1668440049335; Mon, 14
 Nov 2022 07:34:09 -0800 (PST)
MIME-Version: 1.0
References: <5754039e-e3c6-cdb8-8d64-6332b0093940@amd.com> <20221111214209.GA748269@bhelgaas>
In-Reply-To: <20221111214209.GA748269@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Nov 2022 16:33:52 +0100
Message-ID: <CAJZ5v0g834K4ZBrEvhAbJhvGBVyq53nreG+xeBufXKQXA3VtrQ@mail.gmail.com>
Subject: Re: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Nov 11, 2022 at 12:58:28PM -0600, Limonciello, Mario wrote:
> > On 11/11/2022 11:41, Bjorn Helgaas wrote:
> > > On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
> > > > Firmware typically advertises that ACPI devices that represent PCIe
> > > > devices can support D3 by a combination of the value returned by
> > > > _S0W as well as the HotPlugSupportInD3 _DSD [1].
> > > >
> > > > `acpi_pci_bridge_d3` looks for this combination but also contains
> > > > an assumption that if an ACPI device contains power resources the PCIe
> > > > device it's associated with can support D3.  This was introduced
> > > > from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
> > > > D3 if power managed by ACPI").
> > > >
> > > > Some firmware configurations for "AMD Pink Sardine" do not support
> > > > wake from D3 in _S0W for the ACPI device representing the PCIe root
> > > > port used for tunneling. The PCIe device will still be opted into
> > > > runtime PM in the kernel [2] because of the logic within
> > > > `acpi_pci_bridge_d3`. This currently happens because the ACPI
> > > > device contains power resources.
>
> Wait.  Is this as simple as just recognizing that:
>
>   _PS0 means the OS has a knob to put the device in D0, but it doesn't
>   mean the device can wake itself from a low-power state.  The OS has
>   to use _S0W to learn the device's ability to wake itself.

It is.

> If that's enough, maybe we don't need to complicate this with all the
> Thunderbolt and device link stuff.  Which would be great, because the
> code change itself has nothing to do with those things.

Indeed.
