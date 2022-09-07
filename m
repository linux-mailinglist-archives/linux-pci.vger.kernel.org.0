Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5BB5B0DE2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiIGUPQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 16:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIGUPP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 16:15:15 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCF1796B5;
        Wed,  7 Sep 2022 13:15:13 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id g5so23196848ybg.11;
        Wed, 07 Sep 2022 13:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1oJyEVeDSMEzU8mzJzLtsZkHAbB0NAogPRJviWs53mc=;
        b=JaJuAW/zkO0BRLKkPQRVTpT8NHx5QbwjP/4m43UyXk75ppo+Oc2Qh0rC2Htsc5sUoX
         Idf9iPLSfVfo2En4tOq0H2KTEhZxHYC/Is25vET9zxPlMSckP0zVnUkpIUjHsG2rpk1e
         tiQSk2pLZ7AgFytWsJYNLi28PQp147TSF9VG+WTtnGu05packMeV5wm7ShvlCfheB3y5
         m3BKGp9eLlOILOTrwDZS+nyI2rFaH4rz63EuibsrciCXPFRSnso/QU+UtLkTSqwFJCZA
         4lr5jb4LmRX673b1zH9mcl8KJABEY/y3786nNw6Cu8UvgYKsVwPl64M/jqCFu2Nwerdp
         RJaQ==
X-Gm-Message-State: ACgBeo2js93oxAwrkLMVfxOwR2+vFFy1dpkV40fjQhYpLm/I0qmsexsh
        hYkHNTnuEL03YSSM1ewwJyLDqC0uafFLpKSeNnpCW1It
X-Google-Smtp-Source: AA6agR44k1MSykjRc0dv3X/leHDX8g+Y7u/O6ESkT5tUgej3zmngZDIeUCzr+Ye5tXhbkv5OnZ2zgWF0pQQbsH2s4GY=
X-Received: by 2002:a25:2785:0:b0:69b:b1d2:fd05 with SMTP id
 n127-20020a252785000000b0069bb1d2fd05mr4364345ybn.81.1662581712858; Wed, 07
 Sep 2022 13:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220831081603.3415-7-rrichter@amd.com> <20220907183709.GA136851@bhelgaas>
In-Reply-To: <20220907183709.GA136851@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Sep 2022 22:15:01 +0200
Message-ID: <CAJZ5v0jvxJT4B8GQ0O5AcEkn_KUH2qh=vKOONVJ-cd+1r-KoCw@mail.gmail.com>
Subject: Re: [PATCH 06/15] PCI/ACPI: Link host bridge to its ACPI fw node
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

On Wed, Sep 7, 2022 at 8:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Aug 31, 2022 at 10:15:54AM +0200, Robert Richter wrote:
> > A lookup of a host bridge's corresponding acpi device (struct
> > acpi_device) is not possible, for example:
> >
> >       adev = ACPI_COMPANION(&host_bridge->dev);
> >
> > This could be useful to find a host bridge's fwnode handle and to
> > determine and call additional host bridge ACPI parameters and methods
> > such as HID/CID or _UID.
> >
> > Make this work by linking the host bridge to its ACPI fw node.
>
> s/acpi device/ACPI device/ to match other "ACPI" usage
> s/fw node/fwnode/ (if it should match "fwnode handle" above)
>
> I guess this patch makes ACPI_COMPANION() work where it didn't before,
> right?  E.g., the two ACPI_COMPANION() uses added by this series
> (cxl_find_next_rch() and cxl_restricted_host_probe()).
>
> I'm not really clear on the strategy of when we should use acpi_device
> vs acpi_handle,

acpi_handle should be used for interactions with the ACPICA code, like
when AML is evaluated, and acpi_device for pretty much everything
else.

> but does this mean there's code in places like
> pci_root.c that should be reworked to take advantage of this?  That
> code evaluates _DSM and _OSC, but I think it currently uses
> acpi_handle for that.

That's fine.
