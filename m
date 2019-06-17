Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40448AC9
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfFQRwC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:52:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35197 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFQRwC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:52:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so10183392otq.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Jun 2019 10:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GjmvPRW/EB2UZMiXQmlwdUn3cNZy7MEt9OXtWGJNxz0=;
        b=aTNnToCYbt/RLgFmZg1PIvrCe0JVP4C32RN5cfyMVp2zYXXYY11JnD0P5Xn5tfOK6Y
         voW3Syk7UYIIG5SF4LSMDVtOlpmEa0YxFfvlu8+J6wAb/HPFiX2GuYxqo+V2fpMpF+jS
         NlrpFBkRARTzBSJzVDZzE7bQS2UMHOvFRAjYRiT9xL8/lOeALYe1ebk8LfMUYkoFpZaD
         PAFxFM2FYNf4FyGaTFye24KEnD9WdtERxcyZTxLFaidHht03PVJNbu4TuZbdbzHMaWbM
         oEiXMcpcSzAKgjPufMTuJybkt3G4uT6kQCK3aNOgUOJV87J/VA4uKxPCVrEi1MqSqx3i
         hB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GjmvPRW/EB2UZMiXQmlwdUn3cNZy7MEt9OXtWGJNxz0=;
        b=nLwgnyAUcJrNU3gyFThdwBYpscaaTTvEcfVxPLfce3o3iFS4clelcUhzHufzQ7rm0g
         8C7P3qLikeo9NMAD9o5H+43nnAlz8mpr2i52y2QrjJKPQlw01pi/gVjtOEks4oeuyBO3
         l9D8STgvcHkEx8w7yAyS0F5pU/oo9QJu+CwjAPm0mYE6jVAorgPKeIszoW5gqrcNmfT9
         7Uk9TlPTAD+FHIJTeeG9vazZNXZxHWOi425z75NjOt+CGeabkjjKs72aRsQ4v9WQHD8b
         jnDjNV+uEKx8ahejuLymPIBwRLrA8Nx3lyyX2bily+PPIcEtZ0Q+CuyJuRqH9Epg3h6h
         lXtw==
X-Gm-Message-State: APjAAAXw7YBpoO++a42IHK85Zvw0atgcEEz0wtJVwjNKwLqXSpg1wMtV
        BLL/UeSGNf4nqlg/3XxcO6vKn833K1lc4AdwaZudbQ==
X-Google-Smtp-Source: APXvYqyhtBEP50oerFZs8TdK9nCsvOJRWYCWzRd2vhiNPfCpga0Ba5N2yHiBCHm+W4K6XflHhEhbg4A9IXDkc+ucm/c=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr54836696otn.247.1560793907524;
 Mon, 17 Jun 2019 10:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de> <20190617122733.22432-9-hch@lst.de>
In-Reply-To: <20190617122733.22432-9-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 Jun 2019 10:51:35 -0700
Message-ID: <CAPcyv4i_0wUJHDqY91R=x5M2o_De+_QKZxPyob5=E9CCv8rM7A@mail.gmail.com>
Subject: Re: [PATCH 08/25] memremap: move dev_pagemap callbacks into a
 separate structure
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 17, 2019 at 5:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The dev_pagemap is a growing too many callbacks.  Move them into a
> separate ops structure so that they are not duplicated for multiple
> instances, and an attacker can't easily overwrite them.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/dax/device.c              | 11 ++++++----
>  drivers/dax/pmem/core.c           |  2 +-
>  drivers/nvdimm/pmem.c             | 19 +++++++++-------
>  drivers/pci/p2pdma.c              |  9 +++++---
>  include/linux/memremap.h          | 36 +++++++++++++++++--------------
>  kernel/memremap.c                 | 18 ++++++++--------
>  mm/hmm.c                          | 10 ++++++---
>  tools/testing/nvdimm/test/iomap.c |  9 ++++----
>  8 files changed, 65 insertions(+), 49 deletions(-)
>
[..]
> diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/tes=
t/iomap.c
> index 219dd0a1cb08..a667d974155e 100644
> --- a/tools/testing/nvdimm/test/iomap.c
> +++ b/tools/testing/nvdimm/test/iomap.c
> @@ -106,11 +106,10 @@ EXPORT_SYMBOL(__wrap_devm_memremap);
>
>  static void nfit_test_kill(void *_pgmap)
>  {
> -       struct dev_pagemap *pgmap =3D _pgmap;

Whoops, needed to keep this line to avoid:

tools/testing/nvdimm/test/iomap.c:109:11: error: =E2=80=98pgmap=E2=80=99 un=
declared
(first use in this function); did you mean =E2=80=98_pgmap=E2=80=99?
