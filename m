Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F56660449F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 14:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiJSMJu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 19 Oct 2022 08:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiJSMJV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 08:09:21 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADA7E22ED;
        Wed, 19 Oct 2022 04:45:06 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id 137so14164173iou.9;
        Wed, 19 Oct 2022 04:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkeBWCcFMJNFjbaBfw9zUjyE7Y7cuaLWG97IUP/cIwE=;
        b=2uYsTnYGOhx+EBdGM4FFhNbO0y+B6rBtBistqOR6vJrLWSWSGn6HfvH9CjZhXDnWAu
         ETj00CuZL22d63tIeDwBEEeFzE0g0YVj8axeadGjz+AMj8/tEvzbIdNvBiNBCo2lD+S5
         jeTyWJP8Pg9iUaEVFgmiJoXV4XZBKZxj54pVkJrmNgRqadB7YN2bwDnZ8Y0yYQIZWvru
         UxI+xEPH7VbH5jpZnkJb3HwrO+jlbbbNukvZA6IeovWXd5ZkiEqmP++DQf3rXY1CkqFE
         LSeiJeO5mmfcYYmyErvRlHRiMo+rzgXZdynXXmHzFOmq6/xjzL8VlZsCEgO3r71bzEjf
         6y+w==
X-Gm-Message-State: ACrzQf1Nd7rpTXGFmbCby3Hnl5jOCbBw0K3zy0hq79K55IgkrRxDIjGF
        6RYTwGUWuLgSST7HNv4riW2z1/aH5DVnSt/ATrWXvnQv
X-Google-Smtp-Source: AMsMyM4thGGOyHBsHmCvvqQFnAaUTg02mrvN5eJOGsv40LHgyG4ZXauIIJtsE/iD/+LYK3PEcWkvYSqrgq7+QexcHUo=
X-Received: by 2002:a05:620a:158f:b0:6ee:93d5:e249 with SMTP id
 d15-20020a05620a158f00b006ee93d5e249mr5044929qkk.505.1666179338715; Wed, 19
 Oct 2022 04:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <12097002.O9o76ZdvQC@kreacher> <Y0+7Ug9Yh6J6uHVr@intel.com>
In-Reply-To: <Y0+7Ug9Yh6J6uHVr@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Oct 2022 13:35:26 +0200
Message-ID: <CAJZ5v0gKW9S29xS2+qkcopzYtZKTcM=ZT-Jjc4fnEJfu=oYKaw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PCI: Fix device reference counting in acpi_get_pci_dev()
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 19, 2022 at 11:02 AM Ville Syrjälä
<ville.syrjala@linux.intel.com> wrote:
>
> On Tue, Oct 18, 2022 at 07:34:03PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()") failed
> > to reference count the device returned by acpi_get_pci_dev() as
> > expected by its callers which in some cases may cause device objects
> > to be dropped prematurely.
> >
> > Add the missing get_device() to acpi_get_pci_dev().
> >
> > Fixes: 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")
>
> FYI this (and the rtc-cmos regression discussed in
> https://lore.kernel.org/linux-acpi/5887691.lOV4Wx5bFT@kreacher/)
> took down the entire Intel gfx CI.

Sorry for the disturbance.

> I've applied both fixes into our fixup branch and things are looking much
> healthier now.

Thanks for letting me know.

I've just added the $subject patch to my linux-next branch as an
urgent fix and the other one has been applied to the RTC tree.

> This one caused i915 selftests to eat a lot of POISON_FREE
> in the CI. While bisecting it locally I didn't have
> poisoning enabled so I got refcount_t undeflows instead.

Unfortunately, making no mistakes is generally hard to offer.

If catching things like this early is better, what about pulling my
bleeding-edge branch, where all of my changes are staged before going
into linux-next, into the CI?

> https://intel-gfx-ci.01.org/tree/drm-tip/index.html has a lot
> of colorful boxes to click if you're interested in any of the
> logs. The fixes are included in the CI_DRM_12259 build. Earlier
> builds were broken.

Thanks!
