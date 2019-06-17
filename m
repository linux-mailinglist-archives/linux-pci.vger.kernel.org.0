Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCBB48D54
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 21:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfFQTCV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 15:02:21 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35644 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfFQTCV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 15:02:21 -0400
Received: by mail-ot1-f67.google.com with SMTP id j19so10594600otq.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Jun 2019 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BlHoKzaMfcTndlIUZpaHNLrZG84G4vKyhA8APL9TYlo=;
        b=GQLW4HsTHqCZEV9mnOjnMrJWlLsdN8IhjnBoXVeTWqMkmbCxk8sZBD5lQSSBonTJIM
         PQpLqvxmfSU97Mp7ZkXYfzmZvyaftV4da/a21l7cSiFjBd/MqoX/xe2Q1eES5mKJF5Gx
         CjLeVsYnpL1abS+tpATrdwoL8cfv1W46T/pNOxBw8rYqsvqcySs4doJJNlylxXen8sQu
         0tArKmv0hrkikKLc1DMK+s8fkM1rgXKen4eyLlfkzY9W6Wctk+b/3/fC7QVMsGZuOWHr
         vLKx/QLeQzPNSvOdmqkQgk5dMQpH8k73LtoVoK1CABRsAj/MA+31rF03f1vzZFLYB6Mk
         qStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BlHoKzaMfcTndlIUZpaHNLrZG84G4vKyhA8APL9TYlo=;
        b=T2z3HgMz2GTcoQWmU5VPTDThv3ZAKEcS02+OnxSEwoeXqdqZRr4oEXHpQ4RRQ9tX+K
         cUX6kwfVnT/yBPqLE1y0ufm8llfn+O4utbACi/jlyT2K9DnLjYWlNyq6snLVUfdyFySQ
         v/BSSuI2VkgwXQVOQrKK4Dcq3zYYuecdVK5zDkSwx1GjHCT9oCWmPwI6wy659LIxeDk4
         9MXPGjCSsELWA/3G+912Kvne67fbSj+D1slnoKQQOsChyDnjx60404rz1H//XJHlyhTt
         68jXYfiCiYi373+dTjPcGZUpiFLZZBUOpy6bW+/pA2f/5PZxL4IL4VisVcQ1Km3svZZq
         aYeQ==
X-Gm-Message-State: APjAAAU4XM5Uala8XTXptebf1e+hjU537QzZS4DbrCe1GAwmbU+J+qv7
        PBpdsRHP9SK2/OvDFcKXGpWQylTWK958f511EIQuGA==
X-Google-Smtp-Source: APXvYqzJpQgCLYpd5HiWxDsy1wcz73meBykPfY3oY8gVfhGSrrrXTjfeSfxjaTy4CC9Dtjp1KjOhC26LvRkxDcN1gDI=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr51912079otn.71.1560798140931;
 Mon, 17 Jun 2019 12:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de> <20190617122733.22432-8-hch@lst.de>
In-Reply-To: <20190617122733.22432-8-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 Jun 2019 12:02:09 -0700
Message-ID: <CAPcyv4hbGfOawfafqQ-L1CMr6OMFGmnDtdgLTXrgQuPxYNHA2w@mail.gmail.com>
Subject: Re: [PATCH 07/25] memremap: validate the pagemap type passed to devm_memremap_pages
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 17, 2019 at 5:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Most pgmap types are only supported when certain config options are
> enabled.  Check for a type that is valid for the current configuration
> before setting up the pagemap.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/memremap.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index 6e1970719dc2..6a2dd31a6250 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
> @@ -157,6 +157,33 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
>         pgprot_t pgprot = PAGE_KERNEL;
>         int error, nid, is_ram;
>
> +       switch (pgmap->type) {
> +       case MEMORY_DEVICE_PRIVATE:
> +               if (!IS_ENABLED(CONFIG_DEVICE_PRIVATE)) {
> +                       WARN(1, "Device private memory not supported\n");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +               break;
> +       case MEMORY_DEVICE_PUBLIC:
> +               if (!IS_ENABLED(CONFIG_DEVICE_PUBLIC)) {
> +                       WARN(1, "Device public memory not supported\n");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +               break;
> +       case MEMORY_DEVICE_FS_DAX:
> +               if (!IS_ENABLED(CONFIG_ZONE_DEVICE) ||
> +                   IS_ENABLED(CONFIG_FS_DAX_LIMITED)) {
> +                       WARN(1, "File system DAX not supported\n");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +               break;
> +       case MEMORY_DEVICE_PCI_P2PDMA:

Need a lead in patch that introduces MEMORY_DEVICE_DEVDAX, otherwise:

 Invalid pgmap type 0
 WARNING: CPU: 6 PID: 1316 at kernel/memremap.c:183
devm_memremap_pages+0x1d8/0x700
 [..]
 RIP: 0010:devm_memremap_pages+0x1d8/0x700
 [..]
 Call Trace:
  dev_dax_probe+0xc7/0x1e0 [device_dax]
  really_probe+0xef/0x390
  driver_probe_device+0xb4/0x100
  device_driver_attach+0x4f/0x60
