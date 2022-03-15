Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBC24DA032
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 17:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbiCOQiC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 12:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbiCOQiB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 12:38:01 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9AC25E90;
        Tue, 15 Mar 2022 09:36:49 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id y142so4123112ybe.11;
        Tue, 15 Mar 2022 09:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nFRu2fKR6Mv1eEPxkkcMlbdYCWw8b7Bcxs+GkGM7Y0=;
        b=CFpSLK/rR7NshRN0v6R4lnLfMOU46PQ4XaKCdywMqR4TZM/seThWEejMN1CnP+BgOm
         zVXh5SWCxJZFvmYAVUh6bDll6zP0Wzk+CjI1XVdHLdcB8XRB+2KMjHTY4yOrh7Cqp/dm
         4clt9twik/Lxk99JXFFQ4PvPiu1ZNUJqaUGjb06H023/RjUNIlIMIPUbW+z5YyhEtA9Y
         PstlS4I4l7twN72gDoMjDJICM2DOxGBHyRN5OjEtOuCJvNeQUEFevkdo0lkEu0Qp3DK9
         wpv0KLHBcZBhZmKq3+5uNtwABSlOcKotpWa5t/oTt0UBUxHLFo6CVFPjnj67Bd9s6aBi
         x0uQ==
X-Gm-Message-State: AOAM533u+9MHyUyt7eNe96wqL5LBopzwKzP0YNvJP1HhOIXfjOjVbZFR
        lC9qh9ahRYN4Bs3gHjlNoqrxgckfq1Gpo8TO9lgBbLVN
X-Google-Smtp-Source: ABdhPJz1PjrpiSacJRhqQNDuEZVrktPLHdgCQxKr/6T2ZUKWx0BPtC/JPakcJANyCunVnwHOBcCQlXV3q9ebVp62T+Y=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr23286184ybe.365.1647362208693; Tue, 15
 Mar 2022 09:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220315153252.4880-1-mario.limonciello@amd.com> <CAJZ5v0hFGjGYeAbA93joobgw1RMSbBD77=3mAExLPQX-dn=xKg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hFGjGYeAbA93joobgw1RMSbBD77=3mAExLPQX-dn=xKg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Mar 2022 17:36:37 +0100
Message-ID: <CAJZ5v0jc5Wjap0qY9pqvkxCxbRFy10mZdq+JMtuWAY-v1Mk_Zw@mail.gmail.com>
Subject: Re: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if device
 can wake from D3
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 15, 2022 at 5:35 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Mar 15, 2022 at 4:33 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > According to the Microsoft spec the _DSD `HotPlugSupportInD3` is
> > indicates the ability for a bridge to be able to wakeup from D3:
> >
> >   This ACPI object [HotPlugSupportInD3] enables the operating system
> >   to identify and power manage PCIe Root Ports that are capable of
> >   handling hot plug events while in D3 state.
> >
> > This however is static information in the ACPI table at BIOS compilation
> > time and on some platforms it's possible to configure the firmware at boot
> > up such that _S0W returns "0" indicating the inability to wake up the
> > device from D3 as explained in the ACPI specification:
> >
> >   7.3.20 _S0W (S0 Device Wake State)
> >
> >   This object evaluates to an integer that conveys to OSPM the deepest
> >   D-state supported by this device in the S0 system sleeping state
> >   where the device can wake itself.
> >
> > This mismatch may lead to being unable to enumerate devices behind the
> > hotplug bridge when a device is plugged in. To remedy these situations
> > that `HotPlugSupportInD3` is specified by _S0W returns 0, explicitly
> > check that the ACPI companion has returned _S0W greater than or equal
> > to 3 and the device has a GPE allowing the device to generate wakeup
> > signals handled by the platform in `acpi_pci_bridge_d3`.
> >
> > Windows 10 and Windows 11 both will prevent the bridge from going in D3
> > when the firmware is configured this way and this changes aligns the
> > handling of the situation to be the same.
> >
> > Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=s0w#s0w-s0-device-wake-state
> > Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
> > Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> No more comments from me:
>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or please let me know if I should pick it up.

> > ---
> > changes from v3->v4:
> >  * rework comment
> >  * only evaluate _S0W if necessary
> >  * drop static function with only one caller
> >
> >  drivers/pci/pci-acpi.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index a42dbf448860..e535dab2c888 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -977,6 +977,7 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >         const union acpi_object *obj;
> >         struct acpi_device *adev;
> >         struct pci_dev *rpdev;
> > +       unsigned long long ret;
> >
> >         if (acpi_pci_disabled || !dev->is_hotplug_bridge)
> >                 return false;
> > @@ -1003,7 +1004,21 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >                                    ACPI_TYPE_INTEGER, &obj) < 0)
> >                 return false;
> >
> > -       return obj->integer.value == 1;
> > +       if (!obj->integer.value)
> > +               return false;
> > +
> > +       /*
> > +        * If 'HotPlugSupportInD3' is set, but wakeup is not actually supported,
> > +        * the former cannot be trusted anyway, so validate it by verifying the
> > +        * latter.
> > +        */
> > +       if (!adev->wakeup.flags.valid)
> > +               return false;
> > +
> > +       if (ACPI_FAILURE(acpi_evaluate_integer(adev->handle, "_S0W", NULL, &ret)))
> > +               return false;
> > +
> > +       return ret >= ACPI_STATE_D3_HOT;
> >  }
> >
> >  int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> > --
> > 2.34.1
> >
