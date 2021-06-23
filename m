Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0C53B201E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 20:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFWSTX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 14:19:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229759AbhFWSTX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 14:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624472224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zsnnWPBw158ioKHOEvs2KKkgeu539ulBwP58qKPdjxw=;
        b=ZXLaZ5Fsmga8OximBd+2rCCTqY/6vcsJ4hqegM4Fna1X3tYB1goe+zrA4OP9xhlLqahvZC
        +x/VGFlId7tBr8dSLmlJHBZb1J3nZvRiylBh+k7bomidXRSmUzqHrZwMlGd9nalz1aKopv
        DrG+qXJFiT3legUgmzfczbmyF8QML/0=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-Oy9cd9PYPTuFdGgspokcbg-1; Wed, 23 Jun 2021 14:17:03 -0400
X-MC-Unique: Oy9cd9PYPTuFdGgspokcbg-1
Received: by mail-ot1-f69.google.com with SMTP id k11-20020a056830242bb0290400324955afso1787940ots.14
        for <linux-pci@vger.kernel.org>; Wed, 23 Jun 2021 11:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zsnnWPBw158ioKHOEvs2KKkgeu539ulBwP58qKPdjxw=;
        b=nC2lGcd2O5z6dAReiFRdxpMIyN7U+lPUu3kl3187zk8+s7si0fXEGqujV9Is+TDUFA
         KFpoZCeB4k8FWVi3cfYP205yssBjWTcBW9jJMwY/142kEgIFvi9zEXI26UYFRG7zETsq
         nH6gpxMrFCuBA17P6PVWzME9GEPTc5hM/v+Zb4d+wCgapmaYowQpSd4otH/2KZSi8evV
         8OaSF298tgpr448paYi8vrilW3CoxHlLGlSgxVG4hs4VbQdO5bjovp68xP3F9OQG3TTa
         7s1jPgzk8E7iV1KHAm917t20j6zHSz2ysdkO6Bkwvv87T9VHWztZOBES07QascrtUbbf
         gCOQ==
X-Gm-Message-State: AOAM5327hPzJfTx/PJb6CIlxJ9aUuQrH4dBQROYnzcKodwUp7yDCSZWc
        N/AGAzmJ1FaL0d038Jx8eufr/wJG9OPbjiNKsCF6+gIt7x+dRKmP8pdu6nKvHRN9P0Lfb2VmRHv
        KDEOk/L20N8JeoprrUi8M
X-Received: by 2002:a54:4706:: with SMTP id k6mr888670oik.61.1624472222518;
        Wed, 23 Jun 2021 11:17:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL0YKbaTtBpyfI6uxPnb987mGgVkN6qd0BiEd/xyLXC74Z3rr1q+2jYxVhnQLadq7/gCiFPw==
X-Received: by 2002:a54:4706:: with SMTP id k6mr888659oik.61.1624472222401;
        Wed, 23 Jun 2021 11:17:02 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id e5sm102607oou.27.2021.06.23.11.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:17:02 -0700 (PDT)
Date:   Wed, 23 Jun 2021 12:17:00 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, bhelgaas@google.com
Cc:     cohuck@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
        eric.auger@redhat.com, giovanni.cabiddu@intel.com,
        mjrosato@linux.ibm.com, jannh@google.com, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, schnelle@linux.ibm.com,
        minchan@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] vfio: export and make use of pci_dev_trylock()
Message-ID: <20210623121700.4725e22f.alex.williamson@redhat.com>
In-Reply-To: <20210623022824.308041-1-mcgrof@kernel.org>
References: <20210623022824.308041-1-mcgrof@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 22 Jun 2021 19:28:22 -0700
Luis Chamberlain <mcgrof@kernel.org> wrote:

> This v2 series addreses the changes requested by Bjorn, namely:
> 
>   - moved the new forward declarations next to pci_cfg_access_lock()
>     as requested
>   - modify the subject patch for the first PCI patch

Looks ok to me and I assume by Bjorn's Ack that he's expecting it to go
through my tree.  I'll give a bit of time to note otherwise if that's
not the case.  Thanks,

Alex

> Luis Chamberlain (2):
>   PCI: Export pci_dev_trylock() and pci_dev_unlock()
>   vfio: use the new pci_dev_trylock() helper to simplify try lock
> 
>  drivers/pci/pci.c           |  6 ++++--
>  drivers/vfio/pci/vfio_pci.c | 11 ++++-------
>  include/linux/pci.h         |  3 +++
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 

