Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AE24DA942
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 05:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiCPEYt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 00:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbiCPEYs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 00:24:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F9157B2A
        for <linux-pci@vger.kernel.org>; Tue, 15 Mar 2022 21:23:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mm23-20020a17090b359700b001bfceefd8c6so3993963pjb.3
        for <linux-pci@vger.kernel.org>; Tue, 15 Mar 2022 21:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QN5BxAjO70BpcDVhIOU50WJ7iElMmqxXJEcxNA1HN4=;
        b=b7YXFRuHZZRLLBmmY/+nh6IFtnx6uwJMkcK89RhxxPeK6zuceplk23SRpazNuQBIqL
         ctxp0R+z0FVeA3NbHfPbHL67kF6dzxkbd/II4SxBImJa6Gy7hPQ4dMT3vG00FcUfGuof
         IsfQGYUnZypru1UVLYEumWdAh3mq2z4PdVGwu0kkyd2HAzocbofCGqTyjxf3+U/IaSIG
         HzJDViODGkbVpI+LEbXnaJkn5+H/yU4JQim1Yh9VZutYUfBJKLK81bnEM04Y53gfLwol
         +8fIjjD02MY06mABtJTITm2RPYgEwpyjqWygNXzcE7ahzGxdnQGSjEJnPWiL6m7K6CxW
         wAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QN5BxAjO70BpcDVhIOU50WJ7iElMmqxXJEcxNA1HN4=;
        b=NVv+od7IuKK3FiPR2HevrFc1b19HCrpCRbcR4ovdlTta8Cy9RD2gZMRx+FW3haCpRK
         9W4ypAKvxG+GEopjCv4NA6is8lQnko6D4hP2RAx+biwK3TWL19GJ54X7aGVuS5AGgF8x
         WekzMLoWgP62tXvu/Kx7I9LczIFgxfTyvmhnCSLz9GuoCosUZuXKHx23YnfijlQnRyvy
         bkfSBAxK8Ln6mOG0AcInNxjYYZ9HUz69ZLC96wL+tNPLOWeAwhkurA5u5L29C7GEF7Lz
         k7w4gjQUY6E8z92m2eZk4C+2tin6n0UY39DDy+EeTccBsUKh9JXPWVRhcfAWU2pca1O4
         B2zQ==
X-Gm-Message-State: AOAM530yy4K3KwITkFwqf9M14QWK1oUuqt1szpDPnbkoG0JITh/SpTPa
        yCSmdM4K0nimaFwKBykjA6BmC6QIGR5I2esq9iRzsA==
X-Google-Smtp-Source: ABdhPJznDcFlJVdNMbsxVAO5sRQ1YIh+dEL9aBRO6eQu+nMMMdY5sRE4yU8E9k0oVv+GMDDusLjSd2LacGNI6nK20XM=
X-Received: by 2002:a17:90a:cf03:b0:1bf:7005:7d73 with SMTP id
 h3-20020a17090acf0300b001bf70057d73mr8157618pju.8.1647404614488; Tue, 15 Mar
 2022 21:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Mar 2022 21:23:23 -0700
Message-ID: <CAPcyv4g8EGEwtUw5MEZ3pHa8d6sDjKV1eOP2OfYSoUxW2DDQjg@mail.gmail.com>
Subject: Re: [PATCH 0/8] cxl/pci: Add fundamental error handling
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 15, 2022 at 9:14 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Add a 'struct pci_error_handlers' instance for the cxl_pci driver.
> Section 8.2.5.9 "CXL RAS Capability Structure" of the CXL 2.0
> specification defines the error sources considered in this
> implementation. The RAS Capability Structure defines protocol, link and
> internal errors which are distinct from memory poison errors that are
> conveyed via direct consumption and/or media scanning.
>
> The errors reported by the RAS registers are categorized into
> correctable and uncorrectable errors, where the uncorrectable errors are
> optionally steered to either fatal or non-fatal AER events. Table 224
> "Device Specific Error Reporting and Nomenclature Guidelines" in the CXL
> 2.0 specification outlines that the remediation for uncorrectable errors
> is a reset to recover. This matches how the Linux PCIe AER core treats
> uncorrectable errors as occasions to reset the device to recover
> operation.
>
> While the specification notes "CXL Reset" or "Secondary Bus Reset" as
> theoretical recovery options, they are not feasible in practice since
> in-flight CXL.mem operations may not terminate and cause knock-on system
> fatal events. Reset is only reliable for recovering CXL.io, it is not
> reliable for recovering CXL.mem. Assuming the system survives, a reset
> causes CXL.mem operation to restart from scratch.
>
> The "ECN: Error Isolation on CXL.mem and CXL.cache" [1] document
> recognizes the CXL Reset vs CXL.mem operational conflict and helps to at
> least provide a mechanism for the Root Port to terminate in flight
> CXL.mem operations with completions. That still poses problems in
> practice if the kernel is running out of "System RAM" backed by the CXL
> device and poison is used to convey the data lost to the protocol error.
>
> Regardless of whether the reset and restart of CXL.mem operations is
> feasible / successful, the logging is still useful. So, the
> implementation reads, reports, and clears the status in the RAS
> Capability Structure registers, and it notifies the 'struct cxl_memdev'
> associated with the given PCIe endpoint to reattach to its driver over
> the reset so that the HDM decoder configuration can be reconstructed.
>
> The first half of the series reworks component register mapping so that
> the cxl_pci driver can own the RAS Capability while the cxl_port driver
> continues to own the HDM Decoder Capability. The last half implements
> the RAS Capability Structure mapping and reporting via 'struct
> pci_error_handlers'.
>
> [1]: https://www.computeexpresslink.org/spec-landing
>
> ---
>
>
> Dan Williams (8):
>       cxl/pci: Cleanup repeated code in cxl_probe_regs() helpers
>       cxl/pci: Cleanup cxl_map_device_regs()
>       cxl/pci: Kill cxl_map_regs()
>       cxl/core/regs: Make cxl_map_{component,device}_regs() device generic
>       cxl/port: Limit the port driver to just the HDM Decoder Capability
>       cxl/pci: Prepare for mapping RAS Capability Structure
>       cxl/pci: Find and map the RAS Capability Structure
>       cxl/pci: Add (hopeful) error handling support
>
>
>  drivers/cxl/core/hdm.c    |   33 +++++----
>  drivers/cxl/core/memdev.c |    1
>  drivers/cxl/core/pci.c    |    3 -
>  drivers/cxl/core/port.c   |    2 -
>  drivers/cxl/core/regs.c   |  172 ++++++++++++++++++++++++++-------------------
>  drivers/cxl/cxl.h         |   36 +++++++--
>  drivers/cxl/cxlmem.h      |    2 +
>  drivers/cxl/cxlpci.h      |    9 --
>  drivers/cxl/pci.c         |  163 ++++++++++++++++++++++++++++++++-----------
>  9 files changed, 273 insertions(+), 148 deletions(-)
>
> base-commit: 74be98774dfbc5b8b795db726bd772e735d2edd4

Apologies, wrong base-commit, this series is based on that commit + this series:

https://lore.kernel.org/linux-cxl/164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com/
