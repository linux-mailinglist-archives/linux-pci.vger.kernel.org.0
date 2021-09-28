Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FE141B535
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 19:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbhI1Rh2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 13:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbhI1Rh2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 13:37:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B0CC06161C
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 10:35:48 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k23-20020a17090a591700b001976d2db364so3409478pji.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4rpZbh5fY0GJmvqTpqKPOJUU3/CkuLxZ3x2vaW47gs=;
        b=wZ2qK0vDwa/x+WmO54A8bVqDnaE4MxcyOEaPNfghMs0xFBaF5wolp8j+kq8NVd53dl
         rsImtXgdg957L8wghBAufVSqgLyC4EmLedX89tGCu9hdbwa/j0bK+igN5QxEz+2sSMn4
         Jkpzph4lS6pupyWbeuUVoT7QYa/faQ1K5gWMxS69D0LVU584l+LYqEdHM36t5UUJP8KZ
         Ox8vtfVgQGLnLqDI7aAS7eftEkVJGtu441BAiHEGfxU6S8AyhzXUAUXd3857Wfq2hmsT
         U/DpbWTh0lWZxkH3nJrhEHTL0R210cPEJQldelq0QNJ765EUoU+wh6cTG8Wqc7Jl6mzu
         QXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4rpZbh5fY0GJmvqTpqKPOJUU3/CkuLxZ3x2vaW47gs=;
        b=VvZw1/eGesnvPrqLjckeVuw2APUBoa9LMSqtrpqcmW2y5s7sN/M4cswJ21Yh8lBmF1
         qAloMg0WQAx6evk3UUSH+mLaHmGrB595Bi8eYiCp5KWT7hxzjtIjvNW8pKZ3578OX7Rl
         Wlh3yATfqHYcZ/ZiePHOWbtLnReT+MOSuQ3I07Mr8zjANyohYpkfSsDeKj2EH+g7wWnc
         DNVFWXI9kv4yGhDAo550g/gA94JZ4LKWtu+LkE19WJHM0eUhYc2szN/3u7Gjpe1W7uwN
         zouthjKtnTvsvbjidDbYjFljCwivdT7W3A1UjghB6WebLdW8MXMyoDyFAlaXe94WuwPW
         RlhA==
X-Gm-Message-State: AOAM532R24ZYGpCog0vbiEZJYcmsgMOebSF1gFIbmkyCHwpe2gfQqOTb
        /rqsouqR+wgaHs27s3y2WqrezvbOaZDroIkgwRTrrg==
X-Google-Smtp-Source: ABdhPJw3YufFCASrMQKrr5qR62jfqEobEWU5JH/XKYq1dn6X8ous0KD9EnMyS9mGmOC2Zwa4E1WW3YScKPZdcYfFVq8=
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr1302865pju.8.1632850547865;
 Tue, 28 Sep 2021 10:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172647.72738-1-ben.widawsky@intel.com> <20210923172647.72738-5-ben.widawsky@intel.com>
In-Reply-To: <20210923172647.72738-5-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 28 Sep 2021 10:35:34 -0700
Message-ID: <CAPcyv4i7Dytarp3Hxi_ECtCU+Ve985dNCh07a8wJX0sTgCnR0Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cxl/pci: Refactor cxl_pci_setup_regs
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 23, 2021 at 10:27 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> In preparation for moving parts of register mapping to cxl_core, the
> cxl_pci driver is refactored to utilize a new helper to find register
> blocks by type.
>
> cxl_pci scanned through all register blocks and mapping the ones that
> the driver will use. This logic is inverted so that the driver
> specifically requests the register blocks from a new helper. Under the
> hood, the same implementation of scanning through all register locator
> DVSEC entries exists.
>
> There are 2 behavioral changes (#2 is arguable):
> 1. A dev_err is introduced if cxl_map_regs fails.
> 2. The previous logic would try to map component registers and device
>    registers multiple times if there were present and keep the mapping
>    of the last one found (furthest offset in the register locator).
>    While this is disallowed in the spec, CXL 2.0 8.1.9: "Each register
>    block identifier shall only occur once in the Register Locator DVSEC
>    structure" it was how the driver would respond to the spec violation.
>    The new logic will take the first found register block by type and
>    move on.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> ---
> Changes since v1:

No changes? Luckily git am strips this section...

Overall I think this refactor can be broken down further for
readability and cleanup the long standing problem that the driver maps
component registers for no reason. The main contributing factor to
readability is that cxl_setup_pci_regs() still exists after the
refactor, which also contributes to the component register problem. If
the register mapping is up leveled to the caller of
cxl_setup_pci_regs() (and drops mapping component registers) then a
follow-on patch to rename cxl_setup_pci_regs to find_register_block
becomes easier to read. Moving the cxl_register_map array out of
cxl_setup_pci_regs() also makes a later patch to pass component
register enumeration details to the endpoint-port that much cleaner.
