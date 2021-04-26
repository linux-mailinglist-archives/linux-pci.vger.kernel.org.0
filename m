Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8636B9D6
	for <lists+linux-pci@lfdr.de>; Mon, 26 Apr 2021 21:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbhDZTQ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Apr 2021 15:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238186AbhDZTQ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Apr 2021 15:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619464545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EHv0fIxmz1Q+mf+5JqjbH8u/oeuUq3vqULPyyQz5N/U=;
        b=ZZNRRGN38kzaPrPY5gBJyBAZDyl6EnCrv8qX7dDZh/wOzQAcGEbfKfBs+AqbOhzlWC6Spm
        TtOa0+l7qDs0DUGZAFr/Vh1rIZk7Hg7IGJFX0wsuzpo0oxlRjfdLZ6OBbPckf9s1Vv47Fe
        6CCoEY8nxSPzVfES8iOj1cbmRI/Kh5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-goOPhWKlOaWoyOe6agTp1A-1; Mon, 26 Apr 2021 15:15:41 -0400
X-MC-Unique: goOPhWKlOaWoyOe6agTp1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29369CC625;
        Mon, 26 Apr 2021 19:15:40 +0000 (UTC)
Received: from redhat.com (ovpn-113-225.phx2.redhat.com [10.3.113.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95A2219C78;
        Mon, 26 Apr 2021 19:15:39 +0000 (UTC)
Date:   Mon, 26 Apr 2021 13:15:38 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Shanker R Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH 1/1] PCI: Add pci reset quirk for Nvidia GPUs
Message-ID: <20210426131538.0b69c69b@redhat.com>
In-Reply-To: <20210426181943.GA1418150@infradead.org>
References: <20210423145402.14559-1-sdonthineni@nvidia.com>
        <ff4812ba-ec1d-9462-0cbd-029635af3267@kernel.org>
        <20210423093701.594efd86@redhat.com>
        <c758d8a8-4f8b-c505-118e-b364e93ae539@nvidia.com>
        <20210426181943.GA1418150@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 26 Apr 2021 19:19:43 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Apr 23, 2021 at 04:45:15PM -0500, Shanker R Donthineni wrote:
> > > specific platforms (embedded device?), and the failure mode of the SBR.  
> > These are not plug-in PCIe GPU cards, will exist on upcoming
> > server baseboards. Triggering SBR without firmware notification  
> 
> Please submit the quirks together with the actual support for the GPUs
> in the nouveau driver, as they are completely useless without that.

My default assumption would be that this resolves an issue with
assigning this device to a userspace or VM driver through vfio-pci, as
most in-kernel drivers don't make use of this interface themselves;
they often know more device specific ways to re-initialize hardware.
This reset path is also trivially accessible through pci-sysfs.  I
don't expect nouveau would have much use for this even if it did
include support for these devices.  Thanks,

Alex

