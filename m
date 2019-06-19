Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAFCA4B9BF
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 15:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfFSNYw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 09:24:52 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43100 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSNYv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 09:24:51 -0400
Received: by mail-oi1-f193.google.com with SMTP id w79so10527100oif.10;
        Wed, 19 Jun 2019 06:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PhOVk0YKQ9cisNARq7cyez5OukO5PZ5X/+LQ1VobwuY=;
        b=cUrwP5Al/llTNqWxWCsMlwZHbYXGTNb766l5QGDDxdUdlTg3MFfKJA4xR6JEyukUDg
         eA8B2Xr2rN+IEos14xIFuLUa5JxPry2GqTuWHKIradkGHas2TnjkqgPAx/S6g1kWQ7Zc
         MTHaBhxdraaciEJnd8vhleOA+Q0wAgQkJ5InGNhVizwtbEDY6PbSZJaWTDrplgGDwlSB
         nWLCjQkg60b2x/S8/5E/6jylmCzF5yGs7+IRhCyy7Ne3VWbURq/EJ3X8s+3DtzJfczcx
         CzWg+KND8yUzeIQh3qoJ24lLXwfNf/2ImIhT5u83d0yCwkmKEXAXLxMv6js33G+xRVAG
         Hixg==
X-Gm-Message-State: APjAAAVSTQpSoNXXiR9Ss9IVVB7pj7hATEqC8ncbYyOvgjDqFqjl3roO
        v8gR/Fj6GYexXOiM2YImIRbtvZNbzMHRcOIj5oU=
X-Google-Smtp-Source: APXvYqztIKwiAN0o5fiZ0wASv6XWajIafDc5Ax1IdXdYSuZberouBSB9M66/UPe3XoO9mtYVFuqrL+bbiQmHIXrOueQ=
X-Received: by 2002:aca:5a41:: with SMTP id o62mr2918613oib.110.1560950691069;
 Wed, 19 Jun 2019 06:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jun 2019 15:24:40 +0200
Message-ID: <CAJZ5v0gD2sCBKv4QXWSOg+smQryqamCaYUbVQZeMSpCoA1rkVg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] PCI / ACPI: Handle sibling devices sharing power resources
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 6:19 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi all,
>
> Based on a discussion regarding patch series I sent previously [1] to deal
> with sibling devices sharing ACPI power resources, I prepared a new
> reworked version according to the comments I got.
>
> To summarize, in Intel Ice Lake the Thunderbolt controller, PCIe root ports
> and xHCI all share power resources. When they are all in D3hot power
> resources (returned by _PR3) can be turned off powering off the whole
> block. However, there are two issues around this.
>
> Firstly the PCI core sets the device power state by asking what the real
> ACPI power state is. This results that all but last device sharing the
> power resources are in D3hot when the power resources are turned off. This
> causes issues if user runs for example 'lspci' because the device is really
> in D3cold so what user gets back is all ones (0xffffffff).
>
> Secondly if any of the device is runtime resumed the power resources are
> turned on bringing all other devices sharing the resources to
> D0uninitialized losing their wakeup configuration.
>
> This series aims to fix the two issues by:
>
>   1. Using the ACPI cached power state when PCI devices are transitioned
>      into low power states instead of reading back the "real" power state.
>
>   2. Introducing concept of "_PR0 dependent devices" that get runtime
>      resumed whenever their power resource (which they might share with
>      other sibling devices) gets turned on.
>
> The series is based on the idea of Rafael J. Wysocki <rafael@kernel.org>.
>
> [1] https://www.spinics.net/lists/linux-pci/msg83583.html
>
> Mika Westerberg (3):
>   PCI / ACPI: Use cached ACPI device state to get PCI device power state
>   ACPI / PM: Introduce concept of a _PR0 dependent device
>   PCI / ACPI: Add _PR0 dependent devices

LGMT overall, patch [2/3] can be simplified slightly IMO (already sent
comments for that one).

As far as I'm concerned, the other patches need not be updated.
