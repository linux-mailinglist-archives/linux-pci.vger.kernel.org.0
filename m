Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8BA15BD4D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 12:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgBMLEX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 06:04:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29408 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729544AbgBMLEX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 06:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581591862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OZ4tlf6//wOCBIAt4m6Y7TpUBEEEO0ab5g+2/3VhPeM=;
        b=NKrKyZFgm1oSFo4+x8wnnkOFFMoDHX79NlKeWjus1RWolPkGc8cRrasG8RNwQQmHwo6sti
        +ia/TNTGstSuxK9TqzeuW9oUemEr9UIkheTCVZSrgU7dMhFJc7GQuuIspJQ08IR00QymsZ
        6j+0fw2yg9z6WBZ3+a+L1ZFew2NzZms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-1H5askKAP-Wy3PBWUAbB9A-1; Thu, 13 Feb 2020 06:04:18 -0500
X-MC-Unique: 1H5askKAP-Wy3PBWUAbB9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 943A0107ACC4;
        Thu, 13 Feb 2020 11:04:16 +0000 (UTC)
Received: from gondolin (ovpn-117-100.ams2.redhat.com [10.36.117.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E94B5DA7B;
        Thu, 13 Feb 2020 11:04:11 +0000 (UTC)
Date:   Thu, 13 Feb 2020 12:04:08 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@dpdk.org, mtosatti@redhat.com,
        thomas@monjalon.net, bluca@debian.org, jerinjacobk@gmail.com,
        bruce.richardson@intel.com
Subject: Re: [PATCH 2/7] vfio/pci: Implement match ops
Message-ID: <20200213120408.15cd1d48.cohuck@redhat.com>
In-Reply-To: <158146233422.16827.5520548241096752615.stgit@gimli.home>
References: <158145472604.16827.15751375540102298130.stgit@gimli.home>
        <158146233422.16827.5520548241096752615.stgit@gimli.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 11 Feb 2020 16:05:34 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> This currently serves the same purpose as the default implementation
> but will be expanded for additional functionality.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci.c |    8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

