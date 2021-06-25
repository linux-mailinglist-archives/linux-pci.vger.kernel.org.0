Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BFA3B464C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 17:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhFYPHS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 11:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231720AbhFYPHR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 11:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624633496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=orhFcVG1MGfwHWjH/fTT6Go2RQIksRFTwjLRhmT/3hw=;
        b=QtWWQOiAtyDbjjWDZFg+xoCyXM8jaN3dpbdL30rBdySyranjjprftfvwCYQYYvQyBf3aZX
        3k0mh4CfgjzvGIIBXJM2oaSVz48k+r7fTOUuMPtdmWre2YRtVSoW3mf7x+19KFNceqSHN6
        SjKpsU5yBrIZmrdUl2lhuhRBksZxw2s=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-9lQ54E6gMTaDThxdjbmf-g-1; Fri, 25 Jun 2021 11:04:55 -0400
X-MC-Unique: 9lQ54E6gMTaDThxdjbmf-g-1
Received: by mail-io1-f72.google.com with SMTP id 13-20020a05660220cdb02904e9d997e803so7166279ioz.20
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 08:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=orhFcVG1MGfwHWjH/fTT6Go2RQIksRFTwjLRhmT/3hw=;
        b=dpgOgZNy9aa8NjrNweh7DOxMRKwA66GNKUhupy60AcbkAhKmjYnflfHNyF0Nnl+uz0
         RUqS0ZYoNxojY5MC4uxJ3OVw/ovOmgcEv/5wCGUrQ6ItHlaMYobkRbGZuUkK4vHeBtxf
         lwIaG2wZAXsxl2eX30jM7OLzCscFR/U0/SlKQey6Nm+Dj61ov1+hXjkEv46CqmgstKZp
         afaC55jOt6Pa7astaxG2quPujm7os4d18ulKDqAkl8XQs1SWvvDk0YTpA/G96n6e52q2
         9iKvV4zOnW3VlcmQRN77Mgsu3j76okhwpMsDX2AsySqZIEMJKqh5U23lCEXJlihVW67w
         tGxg==
X-Gm-Message-State: AOAM533Bky8Jpt3Xl1Z0MIoQHMDV2tjqYPRZX0cMsh6lKhDU3HxdwgFJ
        etRkXw1v7HyB1ebsBGLnT2YjS0PL0r3P3g89zizqMfTnvctR8zqss3Jsu9szVVbuS8PEHbSixHl
        jHvLjd/lfpHYBgMj9ZGN9
X-Received: by 2002:a02:a99e:: with SMTP id q30mr9857369jam.69.1624633494316;
        Fri, 25 Jun 2021 08:04:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYvbFfAcxRLHUHXohN+O9jy6GPQekGuKcwjY7hFxQZ6CQzhObIbZVnZpOn59v+E7YfDtNaBQ==
X-Received: by 2002:a02:a99e:: with SMTP id q30mr9857343jam.69.1624633494192;
        Fri, 25 Jun 2021 08:04:54 -0700 (PDT)
Received: from redhat.com (c-73-14-100-188.hsd1.co.comcast.net. [73.14.100.188])
        by smtp.gmail.com with ESMTPSA id b23sm3437974ior.4.2021.06.25.08.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 08:04:53 -0700 (PDT)
Date:   Fri, 25 Jun 2021 09:04:51 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bhelgaas@google.com, cohuck@redhat.com, jgg@ziepe.ca,
        kevin.tian@intel.com, eric.auger@redhat.com,
        giovanni.cabiddu@intel.com, mjrosato@linux.ibm.com,
        jannh@google.com, kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        schnelle@linux.ibm.com, minchan@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, jeyu@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        tglx@linutronix.de, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] vfio: export and make use of pci_dev_trylock()
Message-ID: <20210625090452.65474656.alex.williamson@redhat.com>
In-Reply-To: <20210623022824.308041-1-mcgrof@kernel.org>
References: <20210623022824.308041-1-mcgrof@kernel.org>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
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
> 
> Luis Chamberlain (2):
>   PCI: Export pci_dev_trylock() and pci_dev_unlock()
>   vfio: use the new pci_dev_trylock() helper to simplify try lock
> 
>  drivers/pci/pci.c           |  6 ++++--
>  drivers/vfio/pci/vfio_pci.c | 11 ++++-------
>  include/linux/pci.h         |  3 +++
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 

Applied to vfio next branch for v5.14 with Bjorn's Ack, thanks!

Alex

