Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DA14A68DA
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 00:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243025AbiBAX7W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 18:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbiBAX7W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 18:59:22 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D90C06173B
        for <linux-pci@vger.kernel.org>; Tue,  1 Feb 2022 15:59:22 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d18so16775042plg.2
        for <linux-pci@vger.kernel.org>; Tue, 01 Feb 2022 15:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+R2Zx0ML/EKvqqWNoD035jGto0p6Ur7g9Wctqz24S0=;
        b=UCunpy71JKDOit4ttSfjBKYqp5/RyIRc0W3fWcBS7EnSLrZb2hbPekd6WiumFNGxbh
         uPGdk1b0Ok+v1S4OwzGXWz2MlKPqTbvncVnPPAFf95ueNPFdrdjdIukRCnpDAd8pg6v9
         qDJ0BmaojFwpmc9JGdWv3Ev/NGxacfMe2u7ImmdJN9BZt1Sy1UpcbKhOQyIuOOsakmuZ
         aYq7fXuAoIGsP5owoVlJe+NAKN+zVi7LWwjWnfa8+I3gKpKZklaijbuKEmaYjtgQqvXC
         cDoPUBgKztx7w6I6NsQKZ7G0DLDdHiUA0qMW9N8shHqHgYvL6wEJyulS2kCwFuusPO7y
         OarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+R2Zx0ML/EKvqqWNoD035jGto0p6Ur7g9Wctqz24S0=;
        b=u4H1EELblvf1WGIxMSWj0r8sRIzxojN4wQ4b5ytF3BDp3/jB+l7G0OCI1WNoyZwpta
         dgkYf9hgzl7JikTrx5ap0S4uZFAi5bxRtO1/RLjI49UKKkAihmE0weFXCXHEKgU58Atq
         Xzk0ro3t9F0k0VOui/eqD9mD3OsTcLZLiv9N92gDxXzXA2lfE0ZKlp2F5zB9dlyGfbw2
         9J+N3zEaXU/mXP1Unl4dWOfeEzXpZjjJ7ndiZRVAQ8/PL8D0sgmksYPAmvOgP3lTJSzi
         HEmpKuLzNxtWw8Ew7MEFIVJHlT7QC0pTmT/OilVhMef4rlNQ+42ucncdnG7bz26z3zJ+
         QtVg==
X-Gm-Message-State: AOAM530mHUbvYrQ7psR1AQGZ6K1VvuqvkJ7hUAPEcwcDN4B8bMtTxbfl
        6Uds85lg+ZpRK783tEvC1mLnkrWnU3Wf+6RPyNO30Q==
X-Google-Smtp-Source: ABdhPJwnehpby8yp683SdJKAdL2F3StWXxd8JVVi5jbP7vbcqpz39az5sXc/ZEgCSo9OuFwSGV+fpFbdQQe0dYjLOZY=
X-Received: by 2002:a17:90b:3ece:: with SMTP id rm14mr912273pjb.220.1643759962079;
 Tue, 01 Feb 2022 15:59:22 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298428430.3018233.16409089892707993289.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220201153154.jpyxayuulbhdran4@intel.com>
In-Reply-To: <20220201153154.jpyxayuulbhdran4@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 1 Feb 2022 15:59:15 -0800
Message-ID: <CAPcyv4ibSpq6VyyBmMA=DqsQTPMP7a+2hv4Uvq7cghpBh+Sjog@mail.gmail.com>
Subject: Re: [PATCH v3 31/40] cxl/memdev: Add numa_node attribute
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 1, 2022 at 7:32 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-01-23 16:31:24, Dan Williams wrote:
> > While CXL memory targets will have their own memory target node,
> > individual memory devices may be affinitized like other PCI devices.
> > Emit that attribute for memdevs.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> This brings up an interesting question. Are all devices in a region affinitized
> to the same NUMA node? I think they must be - at which point, should this
> attribute be a part of a region, rather than a device?

This attribute is only here so that 'cxl list' can convey what CPU
node platform firmware might have affinitized the memory device. This
is for enumeration questions like, "how many memory devices are on
socket 0". The region NUMA node / affinity is wholly separate from
this number.
