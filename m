Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226304C7CE8
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 23:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiB1WHT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 17:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiB1WHO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 17:07:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7C25C4E39
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 14:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646085994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LW+d0gtxqXAjakKIGWcmifEtiCoe2QekVg+4keAltg=;
        b=ZQcDhle+kSZWyEdihfyKJCikmiCc1QREqsbFhf3Zh7JYqjNREv58TZ+ymnwvTuyzVHNYkP
        jagKGEnBXbOyiH9uOKxftWyZr6gCclWsa2NeEbh2zoPuOjO2/5N4HbhmhuyjsCKoYmPsXx
        TIB3oJwVZ+u2/ReGsFud8TSawgUN0g8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-W7_9Jwk2Or2vFx3lruVGUg-1; Mon, 28 Feb 2022 17:06:32 -0500
X-MC-Unique: W7_9Jwk2Or2vFx3lruVGUg-1
Received: by mail-ot1-f69.google.com with SMTP id c11-20020a056830348b00b005af30a0cee8so9963797otu.4
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 14:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LW+d0gtxqXAjakKIGWcmifEtiCoe2QekVg+4keAltg=;
        b=KnHTxk/+vzkWBnAmR2GySY5AQ1MITnuSg+Yh3VjFtwnna4fM1WDGD7YnahRMT0WX/f
         UjLHdgtdOjR5oVjy4kxsu6DubMy7p+SE3tfCN+9uiLKOGMlnEzUX5einZ8Dte7RMWac9
         M/1RmcJZ6UjYFLqWL2dyADkFPIYmCGV4MOsyViZ03I4eb2C3h+QWW3WOP698un2zyar/
         zKR/N4KDGQHY95m/Bl2fOiSoNRJggcITGfiGSMgMI6AGktJnKpLTu6WCiqBUDU2pgtWL
         xjIp5qgIUnPqcVvsVVD9/fFbT0g64y2vii5s2CQpwAmqYK5HAcWh80kNcfNq2E2HvnC5
         p9pQ==
X-Gm-Message-State: AOAM531h2QSGYAZbswr/RiGOPAWGChcWs/hHrCi79Bhy6OsT5jWGBieo
        QAK9+kHjTPg5Had1riV5yzRo1yMMpStoQfidRfVIKr4zC6Xdi0RYMJxqsAtNZ4+6TyT/nGUnrOh
        +jVwB7fotitOdELrckUVG
X-Received: by 2002:a05:6830:314d:b0:5af:fecc:538e with SMTP id c13-20020a056830314d00b005affecc538emr5635069ots.348.1646085991360;
        Mon, 28 Feb 2022 14:06:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFW1+83X6LvIg8c4ECGOmnmvfHMjqxq9s+M0gGRNVNvZ2qLWJBsQ0hgIVPGZj3LChgbRzMPQ==
X-Received: by 2002:a05:6830:314d:b0:5af:fecc:538e with SMTP id c13-20020a056830314d00b005affecc538emr5635030ots.348.1646085990790;
        Mon, 28 Feb 2022 14:06:30 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id bd14-20020a056808220e00b002d53f900b9csm7017463oib.30.2022.02.28.14.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 14:06:30 -0800 (PST)
Date:   Mon, 28 Feb 2022 15:06:28 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Dan Williams <dan.j.williams@intel.com>, rafael@kernel.org,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Li Yang <leoyang.li@nxp.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/11] vfio: Delete the unbound_list
Message-ID: <20220228150628.2c0077f4.alex.williamson@redhat.com>
In-Reply-To: <20220228005056.599595-10-baolu.lu@linux.intel.com>
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
        <20220228005056.599595-10-baolu.lu@linux.intel.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 28 Feb 2022 08:50:54 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> commit 60720a0fc646 ("vfio: Add device tracking during unbind") added the
> unbound list to plug a problem with KVM where KVM_DEV_VFIO_GROUP_DEL
> relied on vfio_group_get_external_user() succeeding to return the
> vfio_group from a group file descriptor. The unbound list allowed
> vfio_group_get_external_user() to continue to succeed in edge cases.
> 
> However commit 5d6dee80a1e9 ("vfio: New external user group/file match")
> deleted the call to vfio_group_get_external_user() during
> KVM_DEV_VFIO_GROUP_DEL. Instead vfio_external_group_match_file() is used
> to directly match the file descriptor to the group pointer.
> 
> This in turn avoids the call down to vfio_dev_viable() during
> KVM_DEV_VFIO_GROUP_DEL and also avoids the trouble the first commit was
> trying to fix.
> 
> There are no other users of vfio_dev_viable() that care about the time
> after vfio_unregister_group_dev() returns, so simply delete the
> unbound_list entirely.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/vfio/vfio.c | 74 ++-------------------------------------------
>  1 file changed, 2 insertions(+), 72 deletions(-)

Acked-by: Alex Williamson <alex.williamson@redhat.com>

