Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60D7911C10A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 01:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLLACe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 19:02:34 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43118 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfLLACe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2019 19:02:34 -0500
Received: by mail-il1-f194.google.com with SMTP id u16so411904ilg.10
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2019 16:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=UIxOY7IGmpjx+kE26Zz/AZHJvD4vpoM/26KSW9B7G64=;
        b=MRAabtMrFwq//yWxpmqVz0QeA+jhKSCexqhnRo+WmaV/ztdE0BwGgwq6jOr6/6yx4N
         7FECFrj2S5NuuSf99B4bLZ89U7EpDc/1zrKovI6NDSMznfRnLk4jI23HLz6zepIfCnUa
         qR5JxsRjwjIBVBbFqQlwXYhaxasoOUgM/8zkHvPfKW3G2oIDzQ04sdT352IxpArWUOJR
         BmZarmCCauiskIJn6XC1nSHgr8+Dcrq1KByJmD7cvN8PgBanUFKE0QH+f2zfPRc/o6pB
         x+V3ToGatXFue/GTFdMBFodt70hyCyd1qpxsUAJHgkz/rJU8CDUmLfbucflCDpIH9XI9
         L1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=UIxOY7IGmpjx+kE26Zz/AZHJvD4vpoM/26KSW9B7G64=;
        b=pb2HrbCSTIx+1oJtJMq5OZaKuSPW+ZnUl+TlMQqBLhuYjghieM7l5ZZeFD6AY7FSjB
         E9HZqUScw1eAfDzHHltC1A0KLrRReNi/UMZzpjC87mPghBq3E7Q0a4G75EL2lUt3So7+
         W9fl0R2CA42yDhHnQljN9HThy5pYSlMpBX6jCBdWViqo7De0T3zsNNqH8mMjHzCzMdWL
         1UsAm+M8WG77bLr8Dgag6pik5+1+xsX7KmOYF6Tt9FFtaVSbtaUHH4k0afhOb6VDbGnh
         QA3cJBRFmdFixdTrrD1bDDT/qdU3TJVbvIp2xawnt8eHe+KOynf+C5jtJ37oGJNsjKjs
         iHQA==
X-Gm-Message-State: APjAAAVDndZfHr5m0gbHg1hhA76kZbm6+oLFUW55Oxqx0V62GzjGEe+z
        U8WYlaOxO2e91UsWBWzzabY2tXhqku1UqYEm3q9DaJgr3aQ=
X-Google-Smtp-Source: APXvYqxrzqx0gk9Z/gY5wywz5gP5wWD4Na3DWMDckp2M1Nq0i6mWyvHDOpgIn65vbxfNGBOKaMP+dhzzxxpQ1F/+MSI=
X-Received: by 2002:a92:4694:: with SMTP id d20mr5653149ilk.149.1576108953011;
 Wed, 11 Dec 2019 16:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20191211223438.GA121846@google.com> <afbb14fb-e114-d6de-0bfe-d39be354842e@broadcom.com>
In-Reply-To: <afbb14fb-e114-d6de-0bfe-d39be354842e@broadcom.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Wed, 11 Dec 2019 18:02:21 -0600
Message-ID: <CABhMZUU82iRD67yQhpUG3MUx3s9WaZ=tAXA=QriEEjUkNbu22w@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: move quirks to driver
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Wei Liu <wei.liu@kernel.org>,
        linux-pci@vger.kernel.org, rjui@broadcom.com,
        Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 11, 2019 at 5:40 PM Ray Jui <ray.jui@broadcom.com> wrote:
>
>
>
> On 12/11/19 2:34 PM, Bjorn Helgaas wrote:
> > On Wed, Dec 11, 2019 at 05:45:11PM +0000, Wei Liu wrote:
> >> The quirks were originally enclosed by ifdef. That made the quirks not
> >> to be applied when respective drivers were compiled as modules.
> >>
> >> Move the quirks to driver code to fix the issue.
> >>
> >> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> >
> > This straddles the core and native driver boundary, so I applied it to
> > pci/misc for v5.6.  Thanks, I think this is a great solution!  It's
> > always nice when we can encapsulate device-specific things in a
> > driver.
> >
>
> Opps! I was going to review and comment and you are quick, :)
>
> I was going to say, I think it's better to keep this quirk in
> "pcie-iproc.c" instead of "pcie-iproc-platform.c".
>
> The quirk is specific to certain PCIe devices under iProc (activated
> based on device ID), but should not be tied to a specific bus
> architecture (i.e., platform vs BCMA).

I'm happy to move it; that's no problem.

> >> ---
> >>   drivers/pci/controller/pcie-iproc-platform.c | 24 ++++++++++++++++++
> >>   drivers/pci/quirks.c                         | 26 --------------------
> >>   2 files changed, 24 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
> >> index ff0a81a632a1..4e6f7cdd9a25 100644
> >> --- a/drivers/pci/controller/pcie-iproc-platform.c
> >> +++ b/drivers/pci/controller/pcie-iproc-platform.c
> >> @@ -19,6 +19,30 @@
> >>   #include "../pci.h"
> >>   #include "pcie-iproc.h"
> >>
> >> +static void quirk_paxc_bridge(struct pci_dev *pdev)
> >> +{
> >> +    /*
> >> +     * The PCI config space is shared with the PAXC root port and the first
> >> +     * Ethernet device.  So, we need to workaround this by telling the PCI
> >> +     * code that the bridge is not an Ethernet device.
> >> +     */
> >> +    if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> >> +            pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
> >> +
> >> +    /*
> >> +     * MPSS is not being set properly (as it is currently 0).  This is
> >> +     * because that area of the PCI config space is hard coded to zero, and
> >> +     * is not modifiable by firmware.  Set this to 2 (e.g., 512 byte MPS)
> >> +     * so that the MPS can be set to the real max value.
> >> +     */
> >> +    pdev->pcie_mpss = 2;
> >> +}
> >> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
> >> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
> >> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
> >> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
> >> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
> >> +
> >>   static const struct of_device_id iproc_pcie_of_match_table[] = {
> >>      {
> >>              .compatible = "brcm,iproc-pcie",
> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >> index 4937a088d7d8..202837ed68c9 100644
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -2381,32 +2381,6 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
> >>                       PCI_DEVICE_ID_TIGON3_5719,
> >>                       quirk_brcm_5719_limit_mrrs);
> >>
> >> -#ifdef CONFIG_PCIE_IPROC_PLATFORM
> >> -static void quirk_paxc_bridge(struct pci_dev *pdev)
> >> -{
> >> -    /*
> >> -     * The PCI config space is shared with the PAXC root port and the first
> >> -     * Ethernet device.  So, we need to workaround this by telling the PCI
> >> -     * code that the bridge is not an Ethernet device.
> >> -     */
> >> -    if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> >> -            pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
> >> -
> >> -    /*
> >> -     * MPSS is not being set properly (as it is currently 0).  This is
> >> -     * because that area of the PCI config space is hard coded to zero, and
> >> -     * is not modifiable by firmware.  Set this to 2 (e.g., 512 byte MPS)
> >> -     * so that the MPS can be set to the real max value.
> >> -     */
> >> -    pdev->pcie_mpss = 2;
> >> -}
> >> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
> >> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
> >> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
> >> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
> >> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
> >> -#endif
> >> -
> >>   /*
> >>    * Originally in EDAC sources for i82875P: Intel tells BIOS developers to
> >>    * hide device 6 which configures the overflow device access containing the
> >> --
> >> 2.20.1
> >>
