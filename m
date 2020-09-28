Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A4927A9FD
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 10:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgI1Ixa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 04:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgI1Ixa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 04:53:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4E2C0613CE;
        Mon, 28 Sep 2020 01:53:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z23so7337405ejr.13;
        Mon, 28 Sep 2020 01:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kkoZT428v3E17CNeS6GIKtbpEfIRBmIlsMliISEXSs=;
        b=I2U58rlCrLg+pag8kdZk+ww1w+86zHHTalccZqE84bO9tM3iYANpqbsXLKllhQVaKO
         F1L+98rv6HGbkMFKLZfgLD6BCQTflZNLwcGqyM3Zyr3xFLZ+9W+Q/ezZ+rn65zgxWMno
         HiqeAp0K/2BvOi7S2GTxcr7aHs9mBZk7mI6E0FW6BUwpsrgRrzy4cSnTYyu5PdwPYiRg
         qRFjSamR0s7iRWOLY0qh5txrrs9ZoPZ0bhcgExoPiXCT0JMpVXfSRSrQ+nu1V/hc4Sn+
         feGPLtBBnZ/piwuBk5tjiW/+0cluu4382/3yCLFeX3x+x+w4jCjwCJY6LxIndSc1lH/p
         tSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kkoZT428v3E17CNeS6GIKtbpEfIRBmIlsMliISEXSs=;
        b=OpXEXHy67g12RUqKFVPk1Kbtd51dk1QCUWfacrtjtJcG2vkS2XwPWsh2wDpoy/wj7/
         RbY5eK8POl1tnkfV55R1C7ncmHs6wKjhoXr2BUcI1DW7NMWWbGq627tyy2MwsSS23ytz
         wCvOugvHJyWMDX90K//1MBLfUcOLZj+TlIOaW6RYS/uOxrSZFo2pRqPyQ59vWx+WKIT2
         QZ4hhHO+6hB0pq3MiWpXT/y0//Zd7qi61soCmiGEqthFL7U9GQepgrn9fIJ0IcdBeLtK
         n/I7N6mzD8H0SvEtjv1TYMzSTbQBjnO8zdzW6/sfp4ChzxhWAaY01/pefirB+OWt6MsZ
         BJFg==
X-Gm-Message-State: AOAM531Jfg5a89Sqs3rskCkyAbFGPmUxHOk5Wulo92Ri5u1ZJ/aXZeuS
        IZsEP/NHeY4DCj/Kc+vhxxeM0IBhXVdRSjn0GAE=
X-Google-Smtp-Source: ABdhPJwCxSXZ9hIK8r5auprzJ028TF/aDrUk8tXqfCEz3u/dzssryhKaqeOlbP7Ugl9epysqNSD9hiofCsPfUoWUvNg=
X-Received: by 2002:a17:906:4cd6:: with SMTP id q22mr607603ejt.139.1601283208473;
 Mon, 28 Sep 2020 01:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200928040651.24937-1-haifeng.zhao@intel.com>
 <20200928040651.24937-4-haifeng.zhao@intel.com> <CAHp75VdzceN-aVEDJN1Vz9vyBcBoJDb4D9K_SpPrwqWfGzrXfQ@mail.gmail.com>
In-Reply-To: <CAHp75VdzceN-aVEDJN1Vz9vyBcBoJDb4D9K_SpPrwqWfGzrXfQ@mail.gmail.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Mon, 28 Sep 2020 16:53:17 +0800
Message-ID: <CAKF3qh3+7FkG9ZwPuwNeVisEb_v6+_7s0HGx2se47D+V67d8PQ@mail.gmail.com>
Subject: Re: [PATCH 3/5 V55555] PCI/ERR: get device before call device driver
 to avoid NULL pointer reference
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ethan Zhao <haifeng.zhao@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 28, 2020 at 4:46 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Sep 28, 2020 at 7:13 AM Ethan Zhao <haifeng.zhao@intel.com> wrote:
>
> Same comments as per v4.
> Also you have an issue in versioning here. Use -v<n> parameter to `git
> format-patch`, it will do it for you nicely.

Aha, git has got this function. I thought it was still manual
work..... great tip.!

Thanks,
Ethan

>
> --
> With Best Regards,
> Andy Shevchenko
