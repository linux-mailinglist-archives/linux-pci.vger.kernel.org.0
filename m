Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2DD4C1B6E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 20:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244143AbiBWTJg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 14:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238499AbiBWTJf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 14:09:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 857B43BF8F
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 11:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645643346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A0l7dWH9mr2EBBTGKIoS4g90BKZT0X+i4ATV1Oxn87w=;
        b=KEgFZvZVO7hnmjijAF48xw0LxQaf3LLfYz/wqH8IohkmXn+VcZnvt9m3f5QyQg69H1IWMR
        a3pNtTjykTvWyKqWnGIKEsm/mBm+3Nyisp0dmuWjEAPg6eI7GPHR+3m41jzFqR0ZxbeShJ
        gFA4+ZID0V63AwuxRZ1TomMM8LEPfCQ=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-zX-qnrz6OVmtWY9yw9U0oQ-1; Wed, 23 Feb 2022 14:09:05 -0500
X-MC-Unique: zX-qnrz6OVmtWY9yw9U0oQ-1
Received: by mail-ot1-f72.google.com with SMTP id v7-20020a05683018c700b005af147b47beso8697647ote.22
        for <linux-pci@vger.kernel.org>; Wed, 23 Feb 2022 11:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=A0l7dWH9mr2EBBTGKIoS4g90BKZT0X+i4ATV1Oxn87w=;
        b=1iA41zuMumejFgsI3WsLCNbaVjz6aIG8BHfgol9pwKENPSi1REv1FSqjsUko18EwjN
         ba/raagJ2TELHWCwqJ5ylL8sRWJXj4mg8o4oAav0FWh1ObMlNAO7FgJ8j9mF+3rusm/4
         leJ/e8MIYCQKiKrYi/s13TYyFE+++ML8N1J7rN8YJWeTIge0cFAeY1JnphPXneQF/1ve
         DTLhnScgMoe0iNWpoXVwo92ryPExOANMPcn/Wp1NgYxuFkJy/9CGKUnHI3X7SqbR3Yxj
         /JC0QjzYcCo6yqOt5G/QBva6jdlk88DRyIWzEpG/TXiIsSzJtGbrf4PYruAU/S75IT9H
         GCew==
X-Gm-Message-State: AOAM5317g2JNo4VYW+nWsN/VOpqc46P4DRRlMwH6HtK1GrOvNxfJwbJG
        HrTGK1VhOwGrNgzVuQO6eHqQlODV6mRxqzlOWDnOXOAi9N/lg2NYQ6wpc8oCh2q6mEllEsoGnoq
        A9LqxtcyI8FnsFT2nTKJn
X-Received: by 2002:a05:6808:bcb:b0:2d4:2218:e85d with SMTP id o11-20020a0568080bcb00b002d42218e85dmr5275566oik.88.1645643344551;
        Wed, 23 Feb 2022 11:09:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzA2v8Zr3Bu6vB9e1SS3XIO697uWhHFKsK+11ZSxI5936qtok7IEcfQWFEWr1TFV+A1QMdyRA==
X-Received: by 2002:a05:6808:bcb:b0:2d4:2218:e85d with SMTP id o11-20020a0568080bcb00b002d42218e85dmr5275557oik.88.1645643344379;
        Wed, 23 Feb 2022 11:09:04 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id 68sm215774otg.41.2022.02.23.11.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:09:03 -0800 (PST)
Date:   Wed, 23 Feb 2022 12:09:02 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     <bhelgaas@google.com>, <jgg@nvidia.com>, <saeedm@nvidia.com>,
        <linux-pci@vger.kernel.org>, <kvm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <kuba@kernel.org>, <leonro@nvidia.com>,
        <kwankhede@nvidia.com>, <mgurtovoy@nvidia.com>, <maorg@nvidia.com>,
        <cohuck@redhat.com>, <ashok.raj@intel.com>, <kevin.tian@intel.com>,
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH V8 mlx5-next 06/15] net/mlx5: Introduce migration bits
 and structures
Message-ID: <20220223120902.57b2c32c.alex.williamson@redhat.com>
In-Reply-To: <20220220095716.153757-7-yishaih@nvidia.com>
References: <20220220095716.153757-1-yishaih@nvidia.com>
        <20220220095716.153757-7-yishaih@nvidia.com>
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

On Sun, 20 Feb 2022 11:57:07 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:
>  
> +enum {
> +	MLX5_SUSPEND_VHCA_IN_OP_MOD_SUSPEND_MASTER  = 0x0,
> +	MLX5_SUSPEND_VHCA_IN_OP_MOD_SUSPEND_SLAVE   = 0x1,
> +};
...
> +
> +enum {
> +	MLX5_RESUME_VHCA_IN_OP_MOD_RESUME_SLAVE   = 0x0,
> +	MLX5_RESUME_VHCA_IN_OP_MOD_RESUME_MASTER  = 0x1,
> +};

Please consider using more inclusive terminology.  Thanks,

Alex

