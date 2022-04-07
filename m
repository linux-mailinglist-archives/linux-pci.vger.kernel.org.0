Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380264F879D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 21:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiDGTEM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 15:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiDGTEM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 15:04:12 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5F722EB16;
        Thu,  7 Apr 2022 12:02:11 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2db2add4516so72800737b3.1;
        Thu, 07 Apr 2022 12:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGD1/P1eXCqhTH9MB1Py6yMHa/YFvYh5c7tHdx0u8Pk=;
        b=av2WMsDE+fRA9olKRhATLjT5Jk7jMYeOKORh97SxOTh1so26WXzl5GII3FenxgV3Uy
         Ootd3G2R+KrWK1CeuPFw+5CwzpHhiM6mN0IL1bbt9N4DJW1r0v35dYWbLDXKeuDyjjtg
         2sSFVskr5dkuyumzObRxsm6UM8a8PC4odSwVkh5/Kjp1vKc34oIy50gVPN6VGRwRWy+J
         5w/5CNTRvqiUgRt+VMDrDauNEdTHURK1Hx748MBGwCRhm0x9ywKcIpD8L3N0EDD9D+hW
         eUIDHCOOmPZrhJ22rZUUgP5RL1Uwbf2gnYeg8lO5E1bklLQPo3dD+lF3axA5vHYt4xSd
         BE9w==
X-Gm-Message-State: AOAM531kTnVV+HB5JGeF0l/nYr+pbH1C4yIlCuCKnj4qnXSgNF4vsL5E
        EkS+Z/geVXsuCHRdb8wuYG/vuCiOOUzepk/Tt04=
X-Google-Smtp-Source: ABdhPJyPrwbHxRUQ/BZZDOo8gYVEpwEzdjyOfqe28o/yvRJgz1r6QhQB1JhX9AoyLAi7nmXy69UlHGSXkvsWBvPq4Dk=
X-Received: by 2002:a81:1549:0:b0:2eb:3dc7:bd16 with SMTP id
 70-20020a811549000000b002eb3dc7bd16mr12995239ywv.7.1649358130411; Thu, 07 Apr
 2022 12:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <4198163.ejJDZkT8p0@kreacher> <3623886.MHq7AAxBmi@kreacher> <YkwRjI0KvpmiJjvK@lahna>
In-Reply-To: <YkwRjI0KvpmiJjvK@lahna>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Apr 2022 21:01:59 +0200
Message-ID: <CAJZ5v0go9hLqv6Mcc5Ko770AU7sTYJQvgyjhGJ36AO1kURUnYA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PCI: PM: Avoid leaving devices in D0-uninitialized
 in pci_power_up()
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
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

On Tue, Apr 5, 2022 at 1:45 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Apr 04, 2022 at 05:41:13PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > In theory, pci_power_up() may leave a device in D0-uninitialized
> > during a transition from D3cold to D0.
> >
> > Say, a PCIe device depending on some ACPI power resources is put into
> > D3cold, so the power resources in question are all turned off.  Then,
> > pci_power_up() is called to put it into D0.
> >
> > It first calls pci_platform_power_transition() which invokes
> > platform_pci_set_power_state() to turn on the ACPI power resources
> > depended on by the device and, if that is successful, it calls
> > pci_update_current_state() to update the current_state field of
> > the PCI device object.  If the device's configuration space is
> > accessible at this point, which is the case if
> > platform_pci_set_power_state() leaves it in D0-uninitialized (and
> > there's nothing to prevent it from doing so), current_state will be
> > set to PCI_D0 and the pci_raw_set_power_state() called subsequently
> > will notice that the device is in D0 already and do nothing.
> > However, that is not correct, because it may be still necessary to
> > restore the device's BARs at this point.
> >
> > To address this issue, set current_state temporarily to PCI_D3hot
> > in the cases in which pci_raw_set_power_state() may need to do more
> > than just changing the power state of the device.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks, but on second thought, I'm not sure if this is the best way to
address the issue.

Basically, pci_power_up() is called in two places, in
pci_set_power_state() (for the transitions to D0) and in
pci_pm_default_resume_early().  In the latter case,
pci_restore_state() is called right after it and that covers BARs
restoration, so nothing more needs to be done in that case.

This means that pci_set_power_state() is the only place needing to
restore the BARs when going into D0 from D3hot or deeper and it is
better to move BARs restoration directly into it.  I'll update the
series accordingly and resend.

I also think that the mandatory delay is not needed at all when
pci_raw_set_power_state() is called for transitions D3cold -> D0,
because in that case either the device has been powered up via
platform_pci_set_power_state(), or via the bridge resume which takes
the delay into account.
