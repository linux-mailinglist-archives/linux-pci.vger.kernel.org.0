Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9084A44E592
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 12:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhKLLcE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 06:32:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233883AbhKLLcC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Nov 2021 06:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636716551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mWpX6S1S7t7oMXi+9chHuub2JTG8NEGR+ZhAheYJliY=;
        b=KhfO1AVyAg9JIuyi2HNAxKhiMHVpvmK0csz24h/C3fNQMd4enNR5D5fx8i9qjj8VIEa5ag
        KHlTAwBHh+XBzwhG9l/XulIX87fhXyTV0nEc1QsrTvT/j+PdRj4rt7to4X6SUG5Xh0hT4S
        Q51m53qeL5Z4ap/qDWiYuUESbtFx7QM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-JOLS9nosPfmUETqqJzFshQ-1; Fri, 12 Nov 2021 06:29:08 -0500
X-MC-Unique: JOLS9nosPfmUETqqJzFshQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A8431006AA0;
        Fri, 12 Nov 2021 11:29:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.245])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A64E560C05;
        Fri, 12 Nov 2021 11:29:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EFF7D18003BE; Fri, 12 Nov 2021 12:28:58 +0100 (CET)
Date:   Fri, 12 Nov 2021 12:28:58 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, mst@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] pciehp: fast unplug for virtual machines
Message-ID: <20211112112858.33bcm6jrvqb7z7uo@sirius.home.kraxel.org>
References: <20211111090225.946381-1-kraxel@redhat.com>
 <20211111215019.GA1332430@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111215019.GA1332430@bhelgaas>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  Hi,

> "Virtual" doesn't seem like quite the right descriptor here.  That's
> one use case, but I think the parameter should describe the actual
> *effect*, not the use case, e.g., something related to the delay after
> the attention button.

Well, it's enabled only for virtual pcie ports because I could hardly
enable it by default otherwise.

There is another delay in remove_board(), mst suggests removing that
too, and that surely would be something we can't do on physical
hardware ...

So I'd prefer to keep the name.

> If it's practical, I think it would be nicer to have a sysfs attribute
> instead of a kernel boot parameter.  Then we wouldn't have to reboot
> to change this, and it could be generalized to allow arbitrary delays,
> i.e., no delay, 5 seconds, or whatever the admin decides.

It's a module parameter so will show up in
/sys/module/pciehp/parameters/ and it is writable by root.

[ will address the other things mentioned in v2 ].

take care,
  Gerd

