Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB354DDEC6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 17:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238968AbiCRQYY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 12:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbiCRQX5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 12:23:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD011113D01
        for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2022 09:20:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mm4-20020a17090b358400b001c68e836fa6so4288077pjb.3
        for <linux-pci@vger.kernel.org>; Fri, 18 Mar 2022 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7RxkEp0zKHcFi3dOuAOsG89ByGBaaumTlGp+ArO9I4=;
        b=gpaOtnP4fvETeGQcWcobGtjWtPCR6duHSZ8VsD1bWBV5uzit+S1gHP0yLDB9SwD7/M
         cJQxIK8fplvT/QOh3ZBmPZmDvJg5N15p+rJDRQFFqFdAGt+D+RB6HUrrPqq+1aw3q0yZ
         XwSeSTZVj9Z5YmoSpZpZiGDN6y9QRVuhGJSmpohH5eKrqUXAMtqTCZzazdBHYmvs7kVM
         KTMYTsJGHTujL6Fn6OcRlgOfQ04krrHtDct/Xc9S6eNOs1mYzrH/umc0zB4sp3P7QMA6
         565C2W9dCYlITpOAj9z+G9imfmRcCJZyOF1S/DyqPBVdF+c0ZDeeewYJWo664PRZmh0f
         oLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7RxkEp0zKHcFi3dOuAOsG89ByGBaaumTlGp+ArO9I4=;
        b=Np2wo8GLwPv3tIjwG+Sbr1J6Lt2Wyv40vm/mCez4FFRFJDD6ankbXKLzf+bGbJ7OQa
         5/RR+GyRM4wcRJRl3YbuGSm9LwvBaBlCh9bTCVg/VJvSX0CXXGdDtbQB16bMIdP9Onha
         ha1NZUOGieAP2cByPz/HBYhz2uYC4L+1Tyz15OdyLLeB5L7addIc+Gvl0uggjWMCc+6y
         VQpylEEKw+Q1CeN2Jl9OvEdYcBEVUBP0bmoXlIS3j0pzgZtlQHRWB1fpJpaA6YFt5YQL
         m4NPpOmyTnIImZV+Hn8l7pDpFh4lrkVl+OjEhbKfTb4wjKOruUAWAb3ayQsxJinYKmsk
         JaPw==
X-Gm-Message-State: AOAM532s+QQimyhaKDXnyo4f9q/1UxHuOR6kbg9c30vQJP4LGZ9mXkpl
        zdFPCsEYLwyUImZLqVtPCVUg8Z8FghFUv4cbyKEh2U84c7Pa+w==
X-Google-Smtp-Source: ABdhPJxT9KFsSqQrDt2elqDYQotSuQp+/4kTOh5bXPtBTbAA9iZXoTBT53I9X/2NvIHOpxJlQJHUjeFImEwVP8SIBds=
X-Received: by 2002:a17:902:d504:b0:154:172:3677 with SMTP id
 b4-20020a170902d50400b0015401723677mr171162plg.147.1647620400388; Fri, 18 Mar
 2022 09:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164740405408.3912056.16337643017370667205.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220317173233.w76rkwyd2tzunltd@intel.com>
In-Reply-To: <20220317173233.w76rkwyd2tzunltd@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Mar 2022 09:19:49 -0700
Message-ID: <CAPcyv4jPQGwM06xi2ThRjypS0Ne4pg2zawkQ=VHEFw_MyvCXPQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] cxl/pci: Prepare for mapping RAS Capability Structure
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
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

On Thu, Mar 17, 2022 at 10:32 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-03-15 21:14:14, Dan Williams wrote:
> > The RAS Capabilitiy Structure is a CXL Component register capability
> > block. Unlike the HDM Decoder Capability, it will be referenced by the
> > cxl_pci driver in response to PCIe AER events. Due to this it is no
> > longer the case that cxl_map_component_regs() can assume that it should
> > map all component registers. Plumb a bitmask of capability ids to map
> > through cxl_map_component_regs().
> >
> > For symmetry cxl_probe_device_regs() is updated to populate @id in
> > 'struct cxl_reg_map' even though cxl_map_device_regs() does not have a
> > need to map a subset of the device registers per caller.
>
> This seems weird to me. You spent the first 4 or so patches consolidating the
> mapping into a nice loop only to break out an ID to do individual mappings
> again. Are you sure this is such a win over having discrete mapping functions?

The loop is still there. This allows cxl_port and cxl_pci to share all
the same logic save for a bitmap to select the block. You're angling
for a:

cxl_map_hdm_regs(&port->dev, regs, &map);

...? Internally that cxl_map_hdm_regs() should be sharing code with
cxl_map_ras_regs(), so as far as I can see "discrete mapping
functions" is just asking for the below, and I'd rather skip the extra
wrapper:

int cxl_map_hdm_regs(struct pci_dev *pdev,
                           struct cxl_component_regs *regs,
                           struct cxl_register_map *map)
{
    return cxl_map_component_regs(&port->dev, regs, &map,
BIT(CXL_CM_CAP_CAP_ID_HDM));
}
