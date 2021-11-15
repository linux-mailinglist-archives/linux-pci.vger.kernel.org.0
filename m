Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AAE45020E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 11:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKOKNe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 05:13:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237562AbhKOKMy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 05:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636970998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=spkFhHBfLWoUmEEFu9X0mCN465cERkwIsbNUF4+/SDk=;
        b=Zl35ubSOYy2oUl+oN1Onye8ToY43iqztZkttjeV49E4Tjwx7kHHraA3AxVxCx96wHseB2Z
        Ens6+m/e05z17XgI/wIjHZanKs3osgC29RUEK7YVU442BMGz9BGYOO5bgmOZRoZzoizHm1
        KQfHIkivtlmlCAtGx+OYpk3ccg0/w7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-4P8OZEEMO_C9S0E69bbHIQ-1; Mon, 15 Nov 2021 05:09:57 -0500
X-MC-Unique: 4P8OZEEMO_C9S0E69bbHIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59E1B87D545;
        Mon, 15 Nov 2021 10:09:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.245])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1653517C58;
        Mon, 15 Nov 2021 10:09:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5BF2918000A9; Mon, 15 Nov 2021 11:09:43 +0100 (CET)
Date:   Mon, 15 Nov 2021 11:09:43 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, mst@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pciehp: fast unplug for virtual machines
Message-ID: <20211115100943.ezvirlrxc2qzms3i@sirius.home.kraxel.org>
References: <20211111090225.946381-1-kraxel@redhat.com>
 <20211114163958.GA7211@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114163958.GA7211@wunner.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  Hi,

> Same for the 1 second delay in remove_board().  That's mandated by
> PCIe r5.0, sec. 6.7.1.8, but it's only observed if a Power Controller
> is present.  So just clear the Power Controller Present bit in the
> Slot Capabilities register and the delay is gone.

Well, the power control bit is a useful data channel.  qemu can use that
to figure whenever the guest uses the device (power is on) or not (power
is off).  And in case power is off anyway we can simply remove the
device without the attention button dance.

take care,
  Gerd

