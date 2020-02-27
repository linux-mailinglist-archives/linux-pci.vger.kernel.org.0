Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C20C17252D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2020 18:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgB0ReY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 12:34:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57716 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729678AbgB0ReX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2020 12:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582824862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIy4soTckrnNxIx60AnqK7b811MaH6RrRiwbpQXEFw0=;
        b=M3GFR0oOCJVc6u7Ht5kzByEtB+NrLn2EkGE5SA76mc8f0EiFz/XWJVlrfBeLfX7srzdVet
        rhxY1dIY18iefsxFjP5rwiHSlbH/7AIjXNI1deJvAyaXRONJedgnI2i3Qz4b1pIwp7wgV8
        wdS7cNQM9K/0SYhAH53CYqUM9FcnHMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-IVUUXeErOcCf36RRUaAqvA-1; Thu, 27 Feb 2020 12:34:16 -0500
X-MC-Unique: IVUUXeErOcCf36RRUaAqvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26AD2800D54;
        Thu, 27 Feb 2020 17:34:15 +0000 (UTC)
Received: from gondolin (ovpn-117-2.ams2.redhat.com [10.36.117.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAE625C578;
        Thu, 27 Feb 2020 17:34:10 +0000 (UTC)
Date:   Thu, 27 Feb 2020 18:34:07 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@dpdk.org, mtosatti@redhat.com,
        thomas@monjalon.net, bluca@debian.org, jerinjacobk@gmail.com,
        bruce.richardson@intel.com
Subject: Re: [PATCH v2 4/7] vfio: Introduce VFIO_DEVICE_FEATURE ioctl and
 first user
Message-ID: <20200227183407.74a5c5b4.cohuck@redhat.com>
In-Reply-To: <158213845865.17090.13613582696110253458.stgit@gimli.home>
References: <158213716959.17090.8399427017403507114.stgit@gimli.home>
        <158213845865.17090.13613582696110253458.stgit@gimli.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 19 Feb 2020 11:54:18 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> The VFIO_DEVICE_FEATURE ioctl is meant to be a general purpose, device
> agnostic ioctl for setting, retrieving, and probing device features.
> This implementation provides a 16-bit field for specifying a feature
> index, where the data porition of the ioctl is determined by the
> semantics for the given feature.  Additional flag bits indicate the
> direction and nature of the operation; SET indicates user data is
> provided into the device feature, GET indicates the device feature is
> written out into user data.  The PROBE flag augments determining
> whether the given feature is supported, and if provided, whether the
> given operation on the feature is supported.
> 
> The first user of this ioctl is for setting the vfio-pci VF token,
> where the user provides a shared secret key (UUID) on a SR-IOV PF
> device, which users must provide when opening associated VF devices.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci.c |   52 +++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h   |   37 +++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 8dd6ef9543ca..e4d5d26e5e71 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1180,6 +1180,58 @@ static long vfio_pci_ioctl(void *device_data,
>  
>  		return vfio_pci_ioeventfd(vdev, ioeventfd.offset,
>  					  ioeventfd.data, count, ioeventfd.fd);
> +	} else if (cmd == VFIO_DEVICE_FEATURE) {
> +		struct vfio_device_feature feature;
> +		uuid_t uuid;
> +
> +		minsz = offsetofend(struct vfio_device_feature, flags);
> +
> +		if (copy_from_user(&feature, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (feature.argsz < minsz)
> +			return -EINVAL;
> +
> +		if (feature.flags & ~(VFIO_DEVICE_FEATURE_MASK |
> +				      VFIO_DEVICE_FEATURE_SET |
> +				      VFIO_DEVICE_FEATURE_GET |
> +				      VFIO_DEVICE_FEATURE_PROBE))
> +			return -EINVAL;

GET|SET|PROBE is well-defined, but what about GET|SET without PROBE? Do
we want to fence this in the generic ioctl handler part? Or is there
any sane way to implement that (read and then write back something?)

> +
> +		switch (feature.flags & VFIO_DEVICE_FEATURE_MASK) {
> +		case VFIO_DEVICE_FEATURE_PCI_VF_TOKEN:
> +			if (!vdev->vf_token)
> +				return -ENOTTY;
> +
> +			/*
> +			 * We do not support GET of the VF Token UUID as this
> +			 * could expose the token of the previous device user.
> +			 */
> +			if (feature.flags & VFIO_DEVICE_FEATURE_GET)
> +				return -EINVAL;
> +
> +			if (feature.flags & VFIO_DEVICE_FEATURE_PROBE)
> +				return 0;
> +
> +			/* Don't SET unless told to do so */
> +			if (!(feature.flags & VFIO_DEVICE_FEATURE_SET))
> +				return -EINVAL;
> +
> +			if (feature.argsz < minsz + sizeof(uuid))
> +				return -EINVAL;
> +
> +			if (copy_from_user(&uuid, (void __user *)(arg + minsz),
> +					   sizeof(uuid)))
> +				return -EFAULT;
> +
> +			mutex_lock(&vdev->vf_token->lock);
> +			uuid_copy(&vdev->vf_token->uuid, &uuid);
> +			mutex_unlock(&vdev->vf_token->lock);
> +
> +			return 0;
> +		default:
> +			return -ENOTTY;
> +		}
>  	}
>  
>  	return -ENOTTY;
(...)

