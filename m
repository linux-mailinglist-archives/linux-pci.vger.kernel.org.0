Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C29413D8A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 00:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbhIUWaC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 18:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhIUWaC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 18:30:02 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05718C061574
        for <linux-pci@vger.kernel.org>; Tue, 21 Sep 2021 15:28:33 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id e16so925256pfc.6
        for <linux-pci@vger.kernel.org>; Tue, 21 Sep 2021 15:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xYHhkXmeAvv+RY+cKqcor3N4uuoLNJlnXiEQlSjFsqU=;
        b=Da7pK6yz4uDmfwgTxVCMuOmJbOAbU8yl7DvPGaO4REDOmKxFKjiZ6fYNzWaxgCnJlj
         B8tZlVv48PdL266f7kYazi+9TxivKTKDtc/gWUxURHPqGBEPmSEsoV7/Aft6gPCxKUIK
         BnFMFw+iZZ1TMQuJ1U+T1RaI1BC/MEYoR+fF8Imtan0GYsv7IOm15ldHU+t3zcDZqwMw
         Pu3pG7VXdIIX5dOrAxr8U/0k9Bq9mj0XryxPRkEz7C/EGEjPHBBbssLemB7XKG5exm0Q
         f4u6kpv94gAhLhqfq1fyVnzc+nXo4WY4QaH8VvtDCpTnc+y0DTLm+tM2102gRHYDjjU3
         7pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYHhkXmeAvv+RY+cKqcor3N4uuoLNJlnXiEQlSjFsqU=;
        b=yFH33UionCE/LxW3eSqu/RZ5/pwU6HuOdqfSAJJrt2dY05GFApGynoGEV6SctHHm0z
         2Aeg12PJAb2fgf8rKcGw4xmlsmVEd9k8lt0oARyO2WcAQDguZDzXwzpb4PWolg3kvCvk
         2bK/wk2ZzptS/c0Prn08+XW0NQYwZ+s6fztpBEWNztzRuLjEsgCw29EFfVmEu6fW7Lww
         Fvd8cpkT/sn8uDeM+Z8TGspBmY4anjxhI+IMLpf1/s4szlgaVE9SNatVimpTrwl6UiLH
         sQ/F64glAFCM6hujZNRtoRJ7bXLI+UR4EebTlSqK4DiHmZQxzl+ISTbTo6ocosKAr2Y0
         w0Lw==
X-Gm-Message-State: AOAM531g9auL0qCbeNUC6MRTgeKK5vi8vHTZ7ygV7ktPq/1VdPXgBggJ
        D6mJ5s5bJb0ucJNqE0+fgshQxLohhudd91a3dobONw==
X-Google-Smtp-Source: ABdhPJwk34nzb0W2HUoVAKlIDBHKPa3Z5iX5LW3la4BVxDEwamNN3EVylrWns1SpDPC0evltrHTDcPEqM8F5wWORoII=
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id
 b140-20020a621b92000000b003eb3f920724mr32904283pfb.3.1632263312473; Tue, 21
 Sep 2021 15:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210921220459.2437386-1-ben.widawsky@intel.com>
In-Reply-To: <20210921220459.2437386-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 21 Sep 2021 15:28:21 -0700
Message-ID: <CAPcyv4jyTDWGAUOmkumHBAN6K9t1c9hcCt6hCTo4POSybMOMSQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] cxl_pci refactor for reusability
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 21, 2021 at 3:05 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Provide the ability to obtain CXL register blocks as discrete functionality.
> This functionality will become useful for other CXL drivers that need access to
> CXL register blocks. It is also in line with other additions to core which moves
> register mapping functionality.
>
> At the introduction of the CXL driver the only user of CXL MMIO was cxl_pci
> (then known as cxl_mem). As the driver has evolved it is clear that cxl_pci will
> not be the only entity that needs access to CXL MMIO. This series stops short of
> moving the generalized functionality into cxl_core for the sake of getting eyes
> on the important foundational bits sooner rather than later. The ultimate plan
> is to move much of the code into cxl_core.
>
> Via review of two previous patches [1] & [2] it has been suggested that the bits
> which are being used for DVSEC enumeration move into PCI core. As CXL core is
> soon going to require these, let's try to get the ball rolling now on making
> that happen.
>
> [1]: https://lore.kernel.org/linux-cxl/20210920225638.1729482-1-ben.widawsky@intel.com/
> [2]: https://lore.kernel.org/linux-cxl/20210920225638.1729482-1-ben.widawsky@intel.com/
>
> Ben Widawsky (7):
>   cxl: Convert "RBI" to enum
>   cxl/pci: Remove dev_dbg for unknown register blocks
>   cxl/pci: Refactor cxl_pci_setup_regs
>   cxl/pci: Make more use of cxl_register_map
>   PCI: Add pci_find_dvsec_capability to find designated VSEC
>   cxl/pci: Use pci core's DVSEC functionality
>   ocxl: Use pci core's DVSEC functionality

I also found:

siov_find_pci_dvsec()

...and an open coded one in:

drivers/mfd/intel_pmt.c::pmt_pci_probe()

This one looks too weird to replace:

arch/x86/events/intel/uncore_discovery.c::intel_uncore_has_discovery_tables()

In any event I'd expect this cover to also be cc'd to those folks.
