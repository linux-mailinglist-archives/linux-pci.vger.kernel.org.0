Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD3262BD0B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 13:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiKPMHH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 07:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiKPMGv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 07:06:51 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5011C29C86;
        Wed, 16 Nov 2022 04:00:50 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id x13so11732420qvn.6;
        Wed, 16 Nov 2022 04:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLjn09SIm5W8Gdy8FxqMI+enAz3ipU2J5urg+CGsoDg=;
        b=eCCimOmXA9GTB1ElMIRtpNl+jr6pag4nT82xVGVNDKZjTPZJ29qT+ZiHDEaxllSStI
         4slzvLcItwlSvBTndqpMZZSDaGcfhpLZvW6HO6XHGqP4EOYSZwPVJtNH4Mqxagp6zFNM
         593hjKcQtn0ea/2+bMQ8ibOzaDoMzr49zzJdKj6BqmQcdrx0uNF7SLkxOc/MxNfOtO2B
         bJ2nTVkmpzU/k8r5X2B/BzJQZpa8U9za94IxMsVXfmcM8Q/ZmcFzJVnLenz7MJBKvZHc
         meARiSwMynJyi/pYUeRlB10/HBCofy9ZzXKUg/GG/0RQszBYJWzFlp3DjIb2+tc97zB3
         0tnw==
X-Gm-Message-State: ANoB5pkpfuewP7z693aMPrIG85Vdb9Fxpo0GE2g+54cJtrSku4N1NxQk
        mT20TtaHDP1uKslg9NDBppNpTNzJFRKzVFrqY6+nG97Y
X-Google-Smtp-Source: AA0mqf5iQnSi2WYAf3lvk6A5SWcouBkUCDGrperQwwzY6EkndjzlhDFA44ccIAvaQkqUC9rEbGGIq4eOvUxCKRSSgeI=
X-Received: by 2002:a0c:8043:0:b0:4c0:8055:fb5 with SMTP id
 61-20020a0c8043000000b004c080550fb5mr20815149qva.73.1668600048968; Wed, 16
 Nov 2022 04:00:48 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0g834K4ZBrEvhAbJhvGBVyq53nreG+xeBufXKQXA3VtrQ@mail.gmail.com>
 <20221116003739.GA1061657@bhelgaas>
In-Reply-To: <20221116003739.GA1061657@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Nov 2022 13:00:36 +0100
Message-ID: <CAJZ5v0gyVq0AOM1_kd3QWHj+jihL-vxBv=fcEJ_Zcp8QiOymcg@mail.gmail.com>
Subject: Re: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
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

On Wed, Nov 16, 2022 at 1:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Nov 14, 2022 at 04:33:52PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Nov 11, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Fri, Nov 11, 2022 at 12:58:28PM -0600, Limonciello, Mario wrote:
> > > > On 11/11/2022 11:41, Bjorn Helgaas wrote:
> > > > > On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
> > > > > > Firmware typically advertises that ACPI devices that represent PCIe
> > > > > > devices can support D3 by a combination of the value returned by
> > > > > > _S0W as well as the HotPlugSupportInD3 _DSD [1].
> > > > > >
> > > > > > `acpi_pci_bridge_d3` looks for this combination but also contains
> > > > > > an assumption that if an ACPI device contains power resources the PCIe
> > > > > > device it's associated with can support D3.  This was introduced
> > > > > > from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
> > > > > > D3 if power managed by ACPI").
> > > > > >
> > > > > > Some firmware configurations for "AMD Pink Sardine" do not support
> > > > > > wake from D3 in _S0W for the ACPI device representing the PCIe root
> > > > > > port used for tunneling. The PCIe device will still be opted into
> > > > > > runtime PM in the kernel [2] because of the logic within
> > > > > > `acpi_pci_bridge_d3`. This currently happens because the ACPI
> > > > > > device contains power resources.
> > >
> > > Wait.  Is this as simple as just recognizing that:
> > >
> > >   _PS0 means the OS has a knob to put the device in D0, but it doesn't
> > >   mean the device can wake itself from a low-power state.  The OS has
> > >   to use _S0W to learn the device's ability to wake itself.
> >
> > It is.
>
> Now I'm confused again about what "HotPlugSupportInD3" means.  The MS
> web page [1] says it identifies Root Ports capable of handling hot
> plug events while in D3.  That sounds kind of related to _S0W: If _S0W
> says "I can wake myself from D3hot and D3cold", how is that different
> from "I can handle hotplug events in D3"?

For native PME/hot-plug signaling there is no difference.  This is the
same interrupt by the spec after all IIRC.

For GPE-based signaling, though, there is a difference, because GPEs
can only be used directly for wake signaling (this is related to
_PRW).  In particular, the only provision in the ACPI spec for device
hot-add are the Bus Check and Device Check notification values (0 and
1) which require AML to run and evaluate Notify() on specific AML
objects.

Hence, there is no spec-defined way to tell the OS that "something can
be hot-added under this device while in D3 and you will get notified
about that".

> This patch says that if dev's Root Port has "HotPlugSupportInD3", we
> don't need _PS0 or _PR0 for dev.  I guess that must be true, because
> previously the fact that we checked for "HotPlugSupportInD3" meant the
> device did NOT have _PS0 or _PR0.
>
> [1] https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
