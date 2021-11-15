Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3211F4501E6
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 11:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhKOKC4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 05:02:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236829AbhKOKCu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 05:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636970394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lt8vnfwUf+2wRUuIIg/z1Tzh6iD0Hl2ryprO+vMM6Rc=;
        b=NHrTs38kq080Cs8h7xFjxeSjDuF1XLfM4yUiJdew+EcqUHjxbgmaG7VWVmoa34RBTd6MGO
        RQQ/MIgkSbvsbtKazNIlU4PBOflfRsjH32T4Vj0g2vKjHB6qr/81MSRq92lNoRWYS+Nczx
        B91U7waK5XW05aPNfX41MVM7TUtGd6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-RFb2WsybPVS5Xj97UJAfMw-1; Mon, 15 Nov 2021 04:59:51 -0500
X-MC-Unique: RFb2WsybPVS5Xj97UJAfMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0D1F1015DA0;
        Mon, 15 Nov 2021 09:59:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.245])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2D2D60BE5;
        Mon, 15 Nov 2021 09:59:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B3EE318000A9; Mon, 15 Nov 2021 10:59:46 +0100 (CET)
Date:   Mon, 15 Nov 2021 10:59:46 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pciehp: fast unplug for virtual machines
Message-ID: <20211115095946.54tp5glmgfged3rz@sirius.home.kraxel.org>
References: <20211111090225.946381-1-kraxel@redhat.com>
 <20211114163958.GA7211@wunner.de>
 <20211114122249-mutt-send-email-mst@kernel.org>
 <20211114180604.GA23907@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114180604.GA23907@wunner.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  Hi,

> > This requires guest specific code though. Emulating the attention button
> > works in a guest independent way.
> 
> It sounds like you're using the Attention Button because it does
> almost, but not quite what you want for your specific use case.

Well, we want send a request to the guest to shutdown and poweroff the
device.

> Why don't you just trigger surprise-removal from outside the guest?

To give the guest a chance to shutdown the device gracefully?
Umount filesystems, flush data to disk.

Also guest stability.  Traditionally linux isn't very good at dealing
with surprise removal, although the situation is improving.

Emulating surprise-removal has been discussed too.  More as fallback
in case the guest doesn't respond to the attention button.  Right now
we don't have it but should be doable.  For some kinds of devices it
shouldn't be a problem to go straight to surprise-removal.

I'll go experiment with that.

take care,
  Gerd

