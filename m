Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A847915BCDB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 11:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgBMKbx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 05:31:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24828 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729544AbgBMKbw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 05:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581589912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5wiOppB9p7o2+LrhfLKInqKamtbwe/Y8IWjhwi9gEA=;
        b=fj+fo+xzTo9MvcnFqVdoTfzbq2m6Ypths04Zd1T2MHaRWLWNAHti+Eqv/KcFtKwMqSCwoB
        xkZ6BtbijGMZ0Lwgq+h9/qCvbefltx1bGHE/ffPVcdveDGuMqgAmLSuWG8iKuo9q48CHja
        nKD1UzA9lQWPANc8Xg3Clyzjqu8S1tY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-QR_Qi3wCMVG9zfE8EGDsGw-1; Thu, 13 Feb 2020 05:31:43 -0500
X-MC-Unique: QR_Qi3wCMVG9zfE8EGDsGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4395E1005512;
        Thu, 13 Feb 2020 10:31:41 +0000 (UTC)
Received: from gondolin (ovpn-117-87.ams2.redhat.com [10.36.117.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D18875C102;
        Thu, 13 Feb 2020 10:31:36 +0000 (UTC)
Date:   Thu, 13 Feb 2020 11:31:33 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@dpdk.org, mtosatti@redhat.com,
        thomas@monjalon.net, bluca@debian.org, jerinjacobk@gmail.com,
        bruce.richardson@intel.com
Subject: Re: [PATCH 1/7] vfio: Include optional device match in
 vfio_device_ops callbacks
Message-ID: <20200213113133.4f562caf.cohuck@redhat.com>
In-Reply-To: <158146232551.16827.14170770732904274160.stgit@gimli.home>
References: <158145472604.16827.15751375540102298130.stgit@gimli.home>
        <158146232551.16827.14170770732904274160.stgit@gimli.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 11 Feb 2020 16:05:25 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> Allow bus drivers to provide their own callback to match a device to
> the user provided string.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/vfio.c  |   20 ++++++++++++++++----
>  include/linux/vfio.h |    4 ++++
>  2 files changed, 20 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

