Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685B54C36FD
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 21:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiBXUqj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 15:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiBXUqi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 15:46:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B76F82763CA
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 12:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645735566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xJkiVuDqLpP0r8DT6X5v+8nfBw19AQQbdmtTvgjsys=;
        b=TkAu5iVeDy0SFrjqBoy7TEJPi0N8d02csvVciRAdCcbCGwxOsevQlTz8Gom+LkN6iSVpZ2
        s4zGBdY/NgfdTSoucK+4Z2Oj8SiVHpwO/1tXQIm4qClAF+7/PzR4+7Ak/EJk7XbcL4Ab/0
        lJb0CYZ2HbM6HjjOBgEP0GAmIC6Z4Fc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-xgRCa9iCMK-7epQHkFlMPQ-1; Thu, 24 Feb 2022 15:46:05 -0500
X-MC-Unique: xgRCa9iCMK-7epQHkFlMPQ-1
Received: by mail-oi1-f197.google.com with SMTP id h25-20020a056808015900b002d6048692beso1892304oie.8
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 12:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=1xJkiVuDqLpP0r8DT6X5v+8nfBw19AQQbdmtTvgjsys=;
        b=iqQDQFU3USiAP+Rtz7c5BqzWLhnSLySkCgxRVDJ8UBWY0TpqbflRozHyvWr0HQ0j1y
         vII7am0AFBnxGMjE1SNyHzr80vPyJ/AAZR/BelHWSyXtx24LgIpwd4z4o8aTaeCc4fH8
         f/WPaRC8pH7/ozpUg9wnfTf2Bjiew/yNXQz5BLa1wTaHNHmxF37o8PHgw18MIRiT09EZ
         +fGwbdLD3510Cun+aNUKZl/8PG4ZZqluCM5tqtVLwLBXhp3LyPktpTojedBmS6U3Uq0/
         ef/uN7s3nrYWX8np6TjocoayAF26v9fulXQVsaLs/Q8L/D6Gw+TtYlqMSLf9kjrBisrY
         AWjA==
X-Gm-Message-State: AOAM532g4cyD5AUi4D6Iwc2vKXWThWCMz0qjH2EzwWQi54b1gYkMJwBR
        6xXM3vva0QyPTVIB18OUK1+qzdyiN6uyXOkMwPzOeqnzEu/Lyuf+XnHHiTwTQpdcbiN2yX7VKgn
        /oxVzbsOtdJst5U8S9iKQ
X-Received: by 2002:a05:6870:a8ab:b0:d2:cd36:7859 with SMTP id eb43-20020a056870a8ab00b000d2cd367859mr6833991oab.83.1645735564911;
        Thu, 24 Feb 2022 12:46:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzz4xGGAZJSkc7LhAo0lyQZngfUJtqj1zh+GjitSeyjotMwtIhB98xlzX/VXd3Nwyom9gJpFQ==
X-Received: by 2002:a05:6870:a8ab:b0:d2:cd36:7859 with SMTP id eb43-20020a056870a8ab00b000d2cd367859mr6833976oab.83.1645735564657;
        Thu, 24 Feb 2022 12:46:04 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id g12-20020a056870340c00b000d17b798ba9sm357988oah.34.2022.02.24.12.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:46:03 -0800 (PST)
Date:   Thu, 24 Feb 2022 13:46:02 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        saeedm@nvidia.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, kuba@kernel.org, leonro@nvidia.com,
        kwankhede@nvidia.com, mgurtovoy@nvidia.com, maorg@nvidia.com,
        ashok.raj@intel.com, kevin.tian@intel.com,
        shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH V9 mlx5-next 10/15] vfio: Extend the device migration
 protocol with RUNNING_P2P
Message-ID: <20220224134602.74c250d0.alex.williamson@redhat.com>
In-Reply-To: <87czjc6w9k.fsf@redhat.com>
References: <20220224142024.147653-1-yishaih@nvidia.com>
        <20220224142024.147653-11-yishaih@nvidia.com>
        <87fso870k8.fsf@redhat.com>
        <20220224083042.3f5ad059.alex.williamson@redhat.com>
        <20220224161330.GA19295@nvidia.com>
        <20220224093542.3730bb24.alex.williamson@redhat.com>
        <87czjc6w9k.fsf@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 24 Feb 2022 17:53:59 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, Feb 24 2022, Alex Williamson <alex.williamson@redhat.com> wrote:
> > Chatting with Connie offline, I think the clarification that might help
> > is something alone the lines that the combination of bits must support
> > migration, which currently requires the STOP_COPY and RESUMING states.
> > The VFIO_MIGRATION_P2P flag alone does not provide these states.  The
> > only flag in the current specification to provide these states is
> > VFIO_MIGRATION_STOP_COPY.  I don't think we want to preclude that some
> > future flag might provide variants of STOP_COPY and RESUMING, so it's
> > not so much that VFIO_MIGRATION_STOP_COPY is mandatory, but it is
> > currently the only flag which provides the base degree of migration
> > support.  
> 
> Indeed.
> 
> >
> > How or if that translates to an actual documentation update, I'm not
> > sure.  As it stands, we're not speculating about future support, we're
> > only stating these two combinations are valid.  Future combinations may
> > or may not include VFIO_MIGRATION_STOP_COPY.  As the existing proposed
> > comment indicates, other combinations are TBD.  Connie?  Thanks,
> >
> > Alex  
> 
> Hm... "a flag indicating support for a migration state machine such as
> VFIO_MIGRATION_STOP_COPY is mandatory"?

TBH, I'm not sure this makes a substantive improvement.  We don't know
what those new flag bits will be used for, including which bit or bits
will combine to indicate a valid state machine.  Userspace written to
this spec needs to support STOP_COPY and optionally P2P as we're
stating.  Nothing really compels us to speculate general rules for
unknown future bit combinations.  Thanks,

Alex

