Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806FF44E445
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 10:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbhKLJ71 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 04:59:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234778AbhKLJ71 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Nov 2021 04:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636710996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WxrAi7/iU9HpI4uD/sEf88WQfsgTnECF0i+pXrLm63E=;
        b=KIWVB70LJdpzVmzV24ggXYKkgLoFuQIDRiUTs4fVuselNSA5Z/VqP43HPyxiMUXNkPqwyq
        XiSyVQfgzdtk83S1bxyMfsii0esgZqR1XaahDMRaqIjG8ewESIZ+xoHrkvO/Wkis1IPfwh
        ixy7QvH0qpouvxsDO2WEoslFWGvO5dU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-ueKjipUcPuaWd2h-fA-zMA-1; Fri, 12 Nov 2021 04:56:35 -0500
X-MC-Unique: ueKjipUcPuaWd2h-fA-zMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0936C102C84E;
        Fri, 12 Nov 2021 09:56:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.245])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B7E95F4EC;
        Fri, 12 Nov 2021 09:56:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5F83018000AA; Fri, 12 Nov 2021 10:56:29 +0100 (CET)
Date:   Fri, 12 Nov 2021 10:56:29 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pciehp: fast unplug for virtual machines
Message-ID: <20211112095629.uoxfuhsvhicsdxgd@sirius.home.kraxel.org>
References: <20211111090225.946381-1-kraxel@redhat.com>
 <20211111115931-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111115931-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  Hi,

> > This patch adds the fast_virtual_unplug module parameter to the
> > pciehp driver.  When enabled (which is the default) the linux
> > kernel will simply skip the delay for virtual pcie ports, which
> > reduces the total time for the unplug operation from 6-7 seconds
> > to 1-2 seconds.
> 
> BTW how come it's still taking seconds, not milliseconds?

I've tackled the 5 seconds only, biggest chunk and easy target because
the only reason to have that is to allow operators press the attention
button again to cancel, so the risk to break something here is rather
low.

There are some more wait times elsewhere, to give the hardware the
time needed when powering up/down slots, which sum up to roughly one
second, and the time the driver needs to shutdown the device goes on
top of that (typically not much).

take care,
  Gerd

