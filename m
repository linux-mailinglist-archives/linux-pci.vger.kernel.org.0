Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224AB46E223
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 06:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhLIFvF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 00:51:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232371AbhLIFvE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 00:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639028851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MTAn1ztGmocc9lVa3A3/+M3LMLwmgt1eLb7L68uXAdc=;
        b=E8Z6RRx5gT5mcb7jnlunYCPofg6v/fj9Nllwn14Cf8dAknjiD0JqIM1Ekxja1n9VTxQh16
        ZZ8DpvM24nX87vmOTf5kHRE0HwXuSEOXSfeJwKzPn6mugFwWBuVyWZVsQdONDwUcgiZxWN
        JqWQbY6nhU3/EZDP8ZmsLpQ9j9IOeV8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-t0BOBC6bPn-UG_jmTEbNBQ-1; Thu, 09 Dec 2021 00:47:29 -0500
X-MC-Unique: t0BOBC6bPn-UG_jmTEbNBQ-1
Received: by mail-lf1-f71.google.com with SMTP id o11-20020a056512230b00b0041ca68ddf35so2196889lfu.22
        for <linux-pci@vger.kernel.org>; Wed, 08 Dec 2021 21:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTAn1ztGmocc9lVa3A3/+M3LMLwmgt1eLb7L68uXAdc=;
        b=gmvqnQ74Hz4KET8YR495XfuyTHVaTpPpDXRCjLQ5hhvbglDhQfAfEy3bpTqcPm9pxt
         ZC/hWOtRftrgEronHgQ09tksowmcGa7zYtRReRST8oKDcPDO95Sbyvxa8DFE2r6V9e5S
         Zh2xt00aWb5e7Dy++83zfSKTmUdtsJD6hLH9x4qaX3g7iO1VgQF8jJG+uRQUlFeLxOLT
         eD+KoHQOTNOx33lTjDMekJAfbNz1BY3t6dALsW5svz7z3+JPt6GKPjql5XqDJXAaNv3V
         n8ktDhVrPvBrbpV/9EUmvoujBuZnqvyKojM8DS15RLVH66DqFunwhh2aFha0BuVkiync
         T0fQ==
X-Gm-Message-State: AOAM531Jg+WB0uTj9BJ91To/9ebHxZd8D+TCA1h2Odqb2f6EtwM68rbx
        6DquzBoaSYKc/tlS/yrtAL/6guXrFgL9UmcJfCgKrmMPZRDEkx/87tjvGxQn9MRNhFZR1xyba5C
        KSHCXdYG3TUsxdBaWXSq43jNKkbetYJsHqO0r
X-Received: by 2002:a2e:3012:: with SMTP id w18mr4000071ljw.217.1639028848420;
        Wed, 08 Dec 2021 21:47:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwq/umBaPtYwDOFSZQvlFRjjQexm+OmnMnO6A8JPT/yt1E5P3J0cUOqEOEr99euJsOw+HZezXtE5wjdaUSNzOc=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr4000032ljw.217.1639028848143;
 Wed, 08 Dec 2021 21:47:28 -0800 (PST)
MIME-Version: 1.0
References: <87v909bf2k.ffs@tglx> <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx> <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <20211201130023.GH4670@nvidia.com> <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx> <20211202135502.GP4670@nvidia.com>
 <BN9PR11MB527696C0E8D08680FFFB6BAB8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB527696C0E8D08680FFFB6BAB8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 9 Dec 2021 13:47:17 +0800
Message-ID: <CACGkMEv_b=WLUp1_fUtfaxo9_Y95x=u+Za2-sxTRrmXe-J_jRA@mail.gmail.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 9, 2021 at 1:41 PM Tian, Kevin <kevin.tian@intel.com> wrote:
>
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, December 2, 2021 9:55 PM
> >
> > Further, there is no reason why IMS should be reserved exclusively for
> > VFIO!
>
> This is correct. Just as what you agreed with Thomas, the only difference
> between IMS and MSI is on where the messages are stored. Physically
> it is unreasonable for the HW to check whether an interrupt is used for
> a specific software usage (e.g. virtualization) since it doesn't have such
> knowledge. At most an entry is associated to PASID, but again the PASID
> can be used anywhere.

Note that vDPA had the plan to use IMS for the parent that can have a
huge amount of instances.

Thanks

>
> The wording in current IDXD spec is not clear on this part. We'll talk to
> the spec owner to have it fixed.
>
> Thanks
> Kevin
>

