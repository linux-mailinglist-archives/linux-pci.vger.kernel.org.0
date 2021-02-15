Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E05331BF63
	for <lists+linux-pci@lfdr.de>; Mon, 15 Feb 2021 17:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhBOQcW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Feb 2021 11:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhBOQa5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Feb 2021 11:30:57 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6D0C061756;
        Mon, 15 Feb 2021 08:30:16 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id h38so1645229ooi.8;
        Mon, 15 Feb 2021 08:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xZjHpynkO+jEqpoKJ7WUe4G5S6bqtxbRdwfSHl/HMrc=;
        b=jFo/wSwluSwMjlgb2z0JQRyhDpb3qIx8XNZ8qwfCj6NbhGG1ZoZO/yFSb3g3yGhis0
         5AReuZqH6EfN/tfoCx32nOFo7Ig9SCuPm2MtrLbfPjvh2KMpDLuajyIvdOWnVVfkhXrY
         XjwbovzeG4Mv96pwlYJ5AbIcAByssG1DRoO3CXM3zhprfBHdaOfBqu+hKinQAT7TxfBA
         bkhJNH6aEVGgs2F9y8QtbTnYy0QLgPY5rrAdzUTpbcTNvRpXCdiuwY7njJfwsAOAfSg9
         OoIjvVGnuZM5vxGZoIeW4W9rSz4TqN8/0nFKFCoHU8i94rRrFKn5I7f2X1bC5CDLbgqM
         go6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xZjHpynkO+jEqpoKJ7WUe4G5S6bqtxbRdwfSHl/HMrc=;
        b=QwCV3JqBZrSBCWoqE9HTNJr6zNACFX1ClV7vzXv2KoGKLdi27qbixi1XUi9212u0nM
         ycsvHczTUOaZlbspDsD1gAk6i3eji07at0Wx5NU2mRViC0dWTQu/3gCbZeR1arPWWA5i
         97s245IPj+PUSHZSTWwv9V4+HjPOPrA6aSfQlbYkvGrGlgXqT2uKTckKKjHR0LkW2SoM
         bG7vTY1X2CsH8O2tdLuoUOfpgOaB4gqxY9xuL4GmJ0K/kvXUHaz8kNsdxDoFILLNYf1n
         iD5XBqE46LYQzvuVzazp2fC62iJDc/DoQRXZdYQslJlmqmWQkKOK39Sy1a73mUjugaWY
         fgVA==
X-Gm-Message-State: AOAM532Adb1Kt+KcVMSAdR2PCWO0jUv44TUfR+0TkIcqdSVM//EjFri5
        Asq3pHvmmq0uEolM2aYX92M=
X-Google-Smtp-Source: ABdhPJxFxNxXETq3ks4F+XSxZSd8J7B6SpNWE+i6QDVDnydfjooydiKQhpY7tRCSKEA/Q+tkXCXvtg==
X-Received: by 2002:a4a:a105:: with SMTP id i5mr11372483ool.54.1613406615929;
        Mon, 15 Feb 2021 08:30:15 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f76sm2183491oig.52.2021.02.15.08.30.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Feb 2021 08:30:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 15 Feb 2021 08:30:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH v3 3/9] cxl/mem: Register CXL memX devices
Message-ID: <20210215163014.GA116265@roeck-us.net>
References: <20210212222541.2123505-1-ben.widawsky@intel.com>
 <20210212222541.2123505-4-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212222541.2123505-4-ben.widawsky@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 12, 2021 at 02:25:35PM -0800, Ben Widawsky wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Create the /sys/bus/cxl hierarchy to enumerate:
> 
> * Memory Devices (per-endpoint control devices)
> 
> * Memory Address Space Devices (platform address ranges with
>   interleaving, performance, and persistence attributes)
> 
> * Memory Regions (active provisioned memory from an address space device
>   that is in use as System RAM or delegated to libnvdimm as Persistent
>   Memory regions).
> 
> For now, only the per-endpoint control devices are registered on the
> 'cxl' bus. However, going forward it will provide a mechanism to
> coordinate cross-device interleave.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> (v2)

arm:allmodconfig, i386:allyesconfig, mips:allmodconfig:

drivers/cxl/mem.c:335:2: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
  335 |  writeq(cmd_reg, cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);

In file included from <command-line>:
drivers/cxl/mem.c: In function '__cxl_mem_mbox_send_cmd':
include/linux/compiler_types.h:320:38: error: call to '__compiletime_assert_266' declared with attribute error: FIELD_GET: mask is zero

and many similar errors.

Guenter
