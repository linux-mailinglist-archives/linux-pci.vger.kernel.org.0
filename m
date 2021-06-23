Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F403B16EA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 11:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhFWJdr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 05:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230028AbhFWJdr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 05:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624440689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uoKxP6WJfMKdvV/ri4cCRJHkTaSzfh+UYio6Jvz7jjE=;
        b=R5SQD4jfMiiJnnIvmvUYacv/xAtleteih1PPEJV7tbxIgbWml5k4i6iESTw+n56ObkojX2
        cDEA1mI2pzs+uR7n+Pf0L3OKmvjQ97LewgrkERdKlJkd2LIfAvhuiSuIV4Dl9V3qGCFTJe
        21s5h72LS/DEQev5CGDQJPwZt98PiTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-fIknOGXQOXmCQ2p4G_Ju1g-1; Wed, 23 Jun 2021 05:31:27 -0400
X-MC-Unique: fIknOGXQOXmCQ2p4G_Ju1g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 347AAC7442;
        Wed, 23 Jun 2021 09:31:24 +0000 (UTC)
Received: from localhost (ovpn-113-66.ams2.redhat.com [10.36.113.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D55010016F8;
        Wed, 23 Jun 2021 09:31:16 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, bhelgaas@google.com,
        alex.williamson@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
        eric.auger@redhat.com, giovanni.cabiddu@intel.com,
        mjrosato@linux.ibm.com, jannh@google.com, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, schnelle@linux.ibm.com
Cc:     minchan@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, mcgrof@kernel.org,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        tglx@linutronix.de, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vfio: use the new pci_dev_trylock() helper to
 simplify try lock
In-Reply-To: <20210623022824.308041-3-mcgrof@kernel.org>
Organization: Red Hat GmbH
References: <20210623022824.308041-1-mcgrof@kernel.org>
 <20210623022824.308041-3-mcgrof@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Wed, 23 Jun 2021 11:31:15 +0200
Message-ID: <87pmwdlyfw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 22 2021, Luis Chamberlain <mcgrof@kernel.org> wrote:

> Use the new pci_dev_trylock() helper to simplify our locking.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/vfio/pci/vfio_pci.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

