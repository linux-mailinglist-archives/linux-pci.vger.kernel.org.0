Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8FC22D6D1
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jul 2020 12:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgGYKiS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Jul 2020 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgGYKiR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Jul 2020 06:38:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A471AC0619D3;
        Sat, 25 Jul 2020 03:38:17 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n5so6770985pgf.7;
        Sat, 25 Jul 2020 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJ56c6nmQqVj8mVNtPqMdXID1rCLmg7gmIqtMEdX0+U=;
        b=E1ZIANVGCnyKen6Uoy9bgazzYKGvW4+NFRRIS5hzZvQk17FYNSicWMkk98f4dv81sZ
         0/hCFwYYCAjFgfFw4J9vHeR+0dn9FLy69hxG2KADD6hV8Rm8CKs1Wsac8NI8zQVa73Bi
         XzgQN6Yx8LyXjnsR9TqjIP2bhLHFUZsMtBCu/C8CuIP7AF+IL/SwdJ5J60dj/GLQ4Xyg
         A5I1Aql2uNd/7LhLF5IAGPZV3ilUCXkK1NTmz70Y+FLcg/8jG5f6w5L9fL17MOSY86c9
         ulkEvoYJOysV294zcFnmoHlhd9dY4BghapO6kZXUf9TnJ+wacunlk85Hk32iAyUvHVrn
         /CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJ56c6nmQqVj8mVNtPqMdXID1rCLmg7gmIqtMEdX0+U=;
        b=LgO+VB9hZr0slCg7vvzTpFOe0gIwzJFCX7mXIP+ZHi2RUp0r08JV4g2rKnFMD2OjQu
         hIvT5Q5aFDrOL0nxocwf5CuBYrEaCqcyy9Yqp/LgkRj4GVZKxX8TjrVX0cYMK04dvLRE
         U1MDikX1Sy93pNMFcasghHOCDw8ZliB8VWEBKqaYMkFSP1yFcPTQkSnWOrmF2UyzgVxg
         nYmL1m5mAQzF0ALmrni2pl5cIEuhgNtuZBjUxpcUUDljaoZN2+xuoNS9RedhZRT1pHj7
         r2ntgCiobDYSOeAxxGFjXUyAZMVSntrFnt9z1gL/Z0F7sCn6nmUycsa16v/3sQPTL5PJ
         MEXQ==
X-Gm-Message-State: AOAM532V7pHaAUyllysCpkSuwe1FAEF5nd6BIJ18ap6qlsnmwppaYSSL
        tjmp6JEVlO+e627/tBxp2XgcFhOQyOvjrbxZki7keRqR
X-Google-Smtp-Source: ABdhPJxfYVKX0ljoJL5iU4wWQUdFOpLy1xKNL/ec6P9RBalfMMJ09k+eBbnRCWMHeI4FdrobQxNwySRtW6rG1UwzVhs=
X-Received: by 2002:a63:ce41:: with SMTP id r1mr12293935pgi.203.1595673497218;
 Sat, 25 Jul 2020 03:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com> <12df4f8e6011cdbb5c0064576cb496151ecf8d5f.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <12df4f8e6011cdbb5c0064576cb496151ecf8d5f.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Jul 2020 13:38:00 +0300
Message-ID: <CAHp75VfLjQRfX9pXpFuA4uHqNcuwQNN7getjr3ro0JyHnVUJ9A@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] PCI/DPC: Move AER/DPC dependency checks out of DPC driver
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 25, 2020 at 7:01 AM
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Currently, AER and DPC Capabilities dependency checks is

are

> distributed between DPC and portdrv service drivers. So move
> them out of DPC driver.
>
> Also, since services & PCIE_PORT_SERVICE_AER check already
> ensures AER native ownership, no need to add additional
> pcie_aer_is_native() check.

...

>         if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> +           host->native_dpc &&
>             (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
>                 services |= PCIE_PORT_SERVICE_DPC;

Can you elaborate this change, please?

-- 
With Best Regards,
Andy Shevchenko
