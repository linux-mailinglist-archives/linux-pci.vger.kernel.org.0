Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2CA389A5D
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 02:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhETASB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 20:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhETASB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 20:18:01 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D35EC061574
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 17:16:40 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id et19so15449172ejc.4
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 17:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wHpPGTix+cKXCrGrbhMazXmP7v5I8Y6OBdgMIdDgvhA=;
        b=ddjXPOWYeIZbeFYwXcEC63OBolv0Le7Y/3f+AeeQyEff3Km9EwYGmtXpnyXGiu9igM
         qZK4wsjYojvgPZwHnLDwlZdlcYGTx79Yv6+bNOsDF8HJjnvQmFeUrmzYRiMk2zbaCfGt
         Cj7CkkD7egpsojx0Ws3boCrt5Tu6dPWB1vwcOaZ7sIGvUabHoWmRKp/wDwMKGvGiP4eH
         XhHuG9p11+NGXvnzMVC09P1bD9vZFYnaEuwYgkhz1ln6BuHwvZyIEOqK/LXMe80QBs/l
         MMHrxXy5RNRS6NmHjZ8ctfYyaaoanU3PUTiBtZrXhBcBZAjtATUiWR2bYi51vmgt+Pfq
         T8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wHpPGTix+cKXCrGrbhMazXmP7v5I8Y6OBdgMIdDgvhA=;
        b=T2PBHZNa8NgPskS3LLGks/9MclQtIWMaM0Z8E/JTcG1MbHmVOBLMv9YaIehHpRnqVZ
         ELAKpyJ8p5HOiwHfU/rhqAtOgiI6RKFnt4GZIyChg8Loj33awE9tHrryAEo0TRloDsV2
         woT2kxRLv0WtSE23Z93SSGI0ShBxTrmRcRadoEP/3Fm+0eMUXkpYYOXjEaaKiqyjHCGW
         rn2fTB3I4g6rU5JSi9teDFgXdalS1c9xbTVdh1HeEPOB74A9skvYCNSUQmkWTqJlrN0e
         19xzBnAck8jdVzwwyscD+1Rlkr8fknyfl3d1EFcUiO70fOvfz9XCwKIj6DNif9/36HaF
         gBjA==
X-Gm-Message-State: AOAM531YSRcCwVOsgGBZLFeCiQwyMmS2OS1Ah/OOfE3vQgn7n+4NIWjs
        gVUio0EvynUyrHPJDLXibHK9COz4H1+t9WYD64u/gQ==
X-Google-Smtp-Source: ABdhPJy13CyIvUgU0c4/iO5zJrtRsiJO2AdHbEsxqevLYm6s6ozZg/gRZOmI+Nik0P9z467XnR9IsNRPOcsBJjK2qHg=
X-Received: by 2002:a17:906:1d56:: with SMTP id o22mr1755770ejh.264.1621469799143;
 Wed, 19 May 2021 17:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
 <20210419165451.2176200-3-Jonathan.Cameron@huawei.com> <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
 <20210511175006.00007861@Huawei.com> <CAPcyv4j=uww+85b4AbWmoPNPry_+JLEpEnuywpdC8PonXmRmEg@mail.gmail.com>
 <20210514094755.00002081@Huawei.com> <CAPcyv4h_qSZq+sTAOTKDNsO3xPmq=65j8oO1iw0WdVFj8+XrOA@mail.gmail.com>
 <20210517094045.00004d58@Huawei.com> <CAPcyv4iQcV_U1qmQhXKM0RG9v-sAEPwtTxnv=P86yJrCH25k+w@mail.gmail.com>
 <20210518110403.000013e6@Huawei.com> <CAPcyv4g3JPtAHzemKdQiM44ZkZ_0u+U-UJ5mfeU3fKzRWuaDyQ@mail.gmail.com>
 <20210519161156.00003bf9@Huawei.com> <CAPcyv4j_oEWG1NG1wYryVt3-Gx8q2WwzP7_xhchsDARDR0zBEA@mail.gmail.com>
 <20210519172052.00002124@Huawei.com> <20210519173352.000026fe@Huawei.com>
 <CAPcyv4gUy0nNh-3y2wWVwM4AtO4F8OOJCtWz_ZH7Eu0H=oymuw@mail.gmail.com>
 <20210519180057.00002ac3@Huawei.com> <CAPcyv4ii3KC6MBBxJrnCUCm_JGS7ugL+JTFUu9QTBnPUhQFtfQ@mail.gmail.com>
 <20210519211818.00002acf@Huawei.com> <CAPcyv4hCCqEPzGKh4hyjHEBE3jDn9iTA_WUOZMFptHKrX-2J_A@mail.gmail.com>
In-Reply-To: <CAPcyv4hCCqEPzGKh4hyjHEBE3jDn9iTA_WUOZMFptHKrX-2J_A@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 May 2021 17:16:28 -0700
Message-ID: <CAPcyv4hRcdw1N2b1WsVOLqDwZQSt6o=fQsn=VPtA5gpJFY-Qgw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 19, 2021 at 4:51 PM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> > The short answer is that lock requirement, in the above note, rules
> > out safe direct userspace use of the DOE (unless we can tell the kernel
> > is not going to ever use it).
>
> Linux has the mitigation for that situation defined already. It's the
> mechanism for /dev/mem and pci-mmap exclusion: disable the driver to
> enable unfettered userspace access (modulo kernel-lockdown is
> disabled).
>

Note that when I say "driver" here, it need not necessarily be the
cxl_pci driver for the memory expander. For example, DOE functionality
could be handled by an aux-bus device+driver where that can be
unloaded without taking down the rest of the CXL driver.
