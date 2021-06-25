Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632B13B465D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 17:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhFYPKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 11:10:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231937AbhFYPKC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 11:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624633661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70I67UUR2l1l5ABDLMfPTcfAZE4s0dqLocdRtDDYYyg=;
        b=WTP5nbX03MqLBRxU3lm1C/spQAj5MNrwD1J3U9DxXtQfSDVbwyfeWTyRk5iQGVTrxsMBTQ
        VFBU5jNq3oSbCdr2Q8ChYK8jmMtB7rG9rZdFKuvoLfmOstQE7JGrNL/cvxNi1j1YPrPoqr
        zonZsY4YWeQbWqwoiph1ZTy8zNOMMnE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-LFHaIhrVNFm8NYBfKPM-uQ-1; Fri, 25 Jun 2021 11:07:40 -0400
X-MC-Unique: LFHaIhrVNFm8NYBfKPM-uQ-1
Received: by mail-io1-f70.google.com with SMTP id p7-20020a5d8d070000b02904c0978ed194so7178296ioj.10
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 08:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=70I67UUR2l1l5ABDLMfPTcfAZE4s0dqLocdRtDDYYyg=;
        b=lnWOQaPkvl8DNE9sJ7Fck4nRQBzivN8lIu0X+jpTPen3xUjXyyFShBftJZO0n22Dvz
         BG7Hm/jxXVvtsP358Rdja8CTllg8BeI3rwGyIExqC/sE+Iq9HDuelPTK/hjzni+P+3rN
         oJWzOKo9t3cDcBv3brQSDt0zbuKxOav9kg6pYCn1eVCA3hal4FZlhiKOESmtov0dxh/3
         Oy9genZNsAGVbGaCXf1AZR0cc7U1J6eMf2wx6yp6CpOucDSjSXbvEgP4+S4QcZZLIW3y
         dxe18Z07Lqs4WFLCtQeqL2rW/2XOwNKSzKqOSgsGIK7AaUkxiwPTnbeqEbCSki2V5b84
         hu9Q==
X-Gm-Message-State: AOAM533NTk9yAPP77PmHpTpxD73jdIutdEvtZOrUPHGCIXbuWc5QON+p
        gb18GI1FvBQDCoHpcT+aHlOljPts3BFzpKv4Qczs9ZC4U1a32Y7TONZ6/tblCWoN38rBsyjRKnm
        vQO1CTDXKLlP9i4KVxZc2
X-Received: by 2002:a92:dc48:: with SMTP id x8mr8064583ilq.213.1624633659373;
        Fri, 25 Jun 2021 08:07:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzpGY3nuZwWGP/ZTrCtcdh/ZWkEKTSZ3SIg6FE6AkkM/6zfnITXUACUg++3TwlCd8O5LjNxA==
X-Received: by 2002:a92:dc48:: with SMTP id x8mr8064559ilq.213.1624633659232;
        Fri, 25 Jun 2021 08:07:39 -0700 (PDT)
Received: from redhat.com (c-73-14-100-188.hsd1.co.comcast.net. [73.14.100.188])
        by smtp.gmail.com with ESMTPSA id m13sm3367237iob.35.2021.06.25.08.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 08:07:38 -0700 (PDT)
Date:   Fri, 25 Jun 2021 09:07:37 -0600
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
Message-ID: <20210625090737.5a7549b3.alex.williamson@redhat.com>
In-Reply-To: <20210625090452.65474656.alex.williamson@redhat.com>
References: <20210623022824.308041-1-mcgrof@kernel.org>
        <20210625090452.65474656.alex.williamson@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 25 Jun 2021 09:04:51 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 22 Jun 2021 19:28:22 -0700
> Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > This v2 series addreses the changes requested by Bjorn, namely:
> > 
> >   - moved the new forward declarations next to pci_cfg_access_lock()
> >     as requested
> >   - modify the subject patch for the first PCI patch
> > 
> > Luis Chamberlain (2):
> >   PCI: Export pci_dev_trylock() and pci_dev_unlock()
> >   vfio: use the new pci_dev_trylock() helper to simplify try lock
> > 
> >  drivers/pci/pci.c           |  6 ++++--
> >  drivers/vfio/pci/vfio_pci.c | 11 ++++-------
> >  include/linux/pci.h         |  3 +++
> >  3 files changed, 11 insertions(+), 9 deletions(-)
> >   
> 
> Applied to vfio next branch for v5.14 with Bjorn's Ack, thanks!

(and Jason & Conny's R-b)

