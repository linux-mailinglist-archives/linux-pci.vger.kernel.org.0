Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E3C46BC3E
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 14:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhLGNSx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 08:18:53 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43540 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhLGNSw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 08:18:52 -0500
Received: by mail-ot1-f46.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so17959772otu.10;
        Tue, 07 Dec 2021 05:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfXDYYEiGxp87T3EyqHAyK0PWg4THMdSURuOMjMkp2E=;
        b=qWSDyovrvKT9IlrnQWc+ZY9P83N0tDdDVH3Y3ukwkNIPPBJtbekDjSmTSH2JW483ei
         o0Ow2VOc6z1hsS1fruB5BQ5/ag62GGHdlMltnDld0YJlzI+fs4eZfjD7UYtpJncj7bqq
         ic5UqyPKjWaUTbKND7FtJXlFq/O08gZJUXmiYlbz3W/dxSIa/5EqqF17N2QPR3tmPgxr
         MQQZ5AHWwmT5Bju68AbJa+GQAzmZhe5Fls6zIQgeTdAvPdxMN/DZka41rewv2a9vYCU8
         MQrXwQxieKgWxb3GlUqP2WcTp+c07+vTLPZWIFYYPckerBBkvK7BXgf5s0aibumzcG5J
         AeSQ==
X-Gm-Message-State: AOAM531/1QIEAVPe9AJFm1g16nnW6yFq8EKuudRWq/D3YqIg1aFhtjEC
        qygdQz+/OyPLSzdTHiJpIoNq1zj1bS1pfx9SAfDVE+eA
X-Google-Smtp-Source: ABdhPJwD+j8An0P5SmSJIS4L9P9T3oqKE6v8OvDfUDIKoCv8JsVBQIbGF5jciS/BRqHe8p0pX975SX/Pi1canCVOC+c=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr35236711otf.198.1638882921366;
 Tue, 07 Dec 2021 05:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20211203031541.1428904-1-kai.heng.feng@canonical.com> <20211206231218.GA3843138@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20211206231218.GA3843138@dhcp-10-100-145-180.wdc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Dec 2021 14:15:04 +0100
Message-ID: <CAJZ5v0gUFY8fFKFhqmRHLKvaRA7mqDwkx7q=7soSGmu51dSD_Q@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: vmd: Honor ACPI _OSC on PCIe features
To:     Keith Busch <kbusch@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 7, 2021 at 12:12 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Dec 03, 2021 at 11:15:41AM +0800, Kai-Heng Feng wrote:
> > When Samsung PCIe Gen4 NVMe is connected to Intel ADL VMD, the
> > combination causes AER message flood and drags the system performance
> > down.
> >
> > The issue doesn't happen when VMD mode is disabled in BIOS, since AER
> > isn't enabled by acpi_pci_root_create() . When VMD mode is enabled, AER
> > is enabled regardless of _OSC:
> > [    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
> > ...
> > [    1.486704] pcieport 10000:e0:06.0: AER: enabled with IRQ 146
> >
> > Since VMD is an aperture to regular PCIe root ports, honor ACPI _OSC to
> > disable PCIe features accordingly to resolve the issue.
>
> At least for some versions of this hardare, I recall ACPI is unaware of
> any devices in the VMD domain; the platform can not see past the VMD
> endpoint, so I throught the driver was supposed to always let the VMD
> domain use OS native support regardless of the parent's ACPI _OSC.

This is orthogonal to whether or not ACPI is aware of the VMD domain
or the devices in it.

If the platform firmware does not allow the OS to control specific
PCIe features at the physical host bridge level, that extends to the
VMD "bus", because it is just a way to expose a hidden part of the
PCIe hierarchy.

The platform firmware does that through ACPI _OSC under the host
bridge device (not under the VMD device) which it is very well aware
of.
