Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619994C90F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 10:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfFTILq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 04:11:46 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43940 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731103AbfFTILi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 04:11:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id m14so1304046qka.10
        for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2019 01:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TRkUooSd/UaA9IYdN/7znCXTQbIqRDk0LfQwmX0rHGI=;
        b=2AUBnw4K/dxPsBT0ACnhasZG6o3C2vb8NI8ADKu6mrlsxcT6D8GSweyjMItLvjcPTO
         M62MAuTrpywiNZfneUDtJE9m1ye7CaKoTfr/nnJ/Sqt4d1lFq2egRpWqfYT1PdQKLu2T
         CG2UBTbcwWnfcXCYTbc+Tm7LZ4FvZSyy+TIuzQPxe4eqyq0V1ycCXb0aZ9t2fhfYYqIU
         6xHgCk/2SkwH7csf+P9Hsrhf5iYORp3qq20hC/lACrebPy7bVxMpvvYlg94YnzyDclKG
         tcOvXjGKdGIoLMNJoy5goqb1k6GncA0CZf59lruSREYWZAqb8odPrrFXEBcxQ6XiEvYy
         FbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TRkUooSd/UaA9IYdN/7znCXTQbIqRDk0LfQwmX0rHGI=;
        b=hGPZFnDp35XqzNorqDk1SMiUYRgjbRQYfMWuelG+BwIuYrntWsC2rqNqQhjjysgrfY
         Es9z9c/n5KVQu5atMtIsWis/MXIeKc1FxDnWVx2ucPN2Br5bnlhpz/25vJzs+TrOywqb
         GKjFmmDJn6Q/vu2BvFNV3FaEG74ebGLa+aj6vWgfDCSs+31fYMvHrnrWCOYAYT3h/ktD
         5F01USyuBRcw97lKeOURHzld9D2Na4p0CTZXXgXIKQBJmX7ZcTHxW+0zV2fBiJmrROI0
         ljic67zLKGv2Z4Klu9YfKyNTCuoXLqzHCU5bmQsUErDkRHjiphM9046uEovG37b5PtPH
         RBjw==
X-Gm-Message-State: APjAAAUjKfSBs1SoireIyiESfu0QwkzPmNYPl6JksSFHEl6Q43cmTuoI
        /pHjM1EOdDsXEwXkHyLuH18PBCj/dvcHnqb3atCV/Q==
X-Google-Smtp-Source: APXvYqxOSWRsTHI+1qYV6tXZLhxzg82CDrJlzsurV+doJXHQ9bjAUDTq4iluEfM00odIArBgUTjNtLH0hVGOGcFASPQ=
X-Received: by 2002:a37:de07:: with SMTP id h7mr105593186qkj.41.1561018297544;
 Thu, 20 Jun 2019 01:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190620051333.2235-1-drake@endlessm.com> <20190620051333.2235-3-drake@endlessm.com>
 <20190620061038.GA20564@lst.de>
In-Reply-To: <20190620061038.GA20564@lst.de>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 20 Jun 2019 16:11:26 +0800
Message-ID: <CAD8Lp45ua=L+ixO+du=Njhy+dxjWobWA+V1i+Y2p6faeyt1FBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] nvme: rename "pci" operations to "mmio"
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-ide@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 2:11 PM Christoph Hellwig <hch@lst.de> wrote:
> The Linux NVMe driver will deal with NVMe as specified plus whatever
> minor tweaks we'll need for small bugs.  Hiding it behind an AHCI
> device is completely out of scope and will not be accepted.

Do you have any new suggestions for alternative ways we can implement
support for this storage configuration?

I tried to follow your earlier suggestions regarding faking a PCI bus
here: (or let me know if you had something different in mind...)
https://marc.info/?l=linux-pci&m=156015271021614&w=2
but it looks like that is not going to fly either :(

Daniel
