Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426684D0758
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 20:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245006AbiCGTMu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 14:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244986AbiCGTMr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 14:12:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBFF759A4B
        for <linux-pci@vger.kernel.org>; Mon,  7 Mar 2022 11:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646680311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbJb2hnF7RB31QQPcCB0cHRYiPJl+mMbTgOzYpqEqG4=;
        b=hhJszi7zWty7ydqM/W0evqWUOpa+kxs6MzLmHu7lWt+/4KVlXV32uQ++oJnNnVpIrk+hCu
        NVx9OaHDF10ee1Vzap5xXQP5k9/OrvgrzDtpfKehz4utmOFathmQNvRjxYJSvMMnwCmsZN
        4647BCNrcjYoQDFAkt+IvN0/BiTFYCE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-5EOv4MiRMuCvTmdhXhweiA-1; Mon, 07 Mar 2022 14:11:50 -0500
X-MC-Unique: 5EOv4MiRMuCvTmdhXhweiA-1
Received: by mail-oo1-f69.google.com with SMTP id 185-20020a4a1dc2000000b0031c074ab4b1so12162275oog.14
        for <linux-pci@vger.kernel.org>; Mon, 07 Mar 2022 11:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbJb2hnF7RB31QQPcCB0cHRYiPJl+mMbTgOzYpqEqG4=;
        b=x1a17rzv+h3hpopb9eXvx5weAU29uc3AZxULDsNGIt4oVCp7MDf3Z7GMK7tBd6EN2s
         K0IXkS6lJatBn2ZhSxvAp3RmVOjocgwxBsHc1QYHmxJZs32KWTPPP9xL/+VMfXPMetom
         znJbcZ9rr/H0kZWYrSy2ipvxjGtni3StmxAbQYdNXcTI9zXi0eXY6f6r88sxW3mf7D3I
         8Arcu6slqfBCeXpq3x3NeGRcGAI8Q6SZyjCZesvl21CI58x6CMbJP9x1RKBEQop2o4Mw
         AF1QVg5Tb2ukQ8/iV+3WrC9bPtAWogBiPbJilQILhw2JoyO0//ZwVK2FRs8Myx+aWiKq
         xJzQ==
X-Gm-Message-State: AOAM533GAzqnuMqlNNEm3rHNGFn0vIdZ3WfZRGbhC8ANbAxqBCZIB6/S
        dghKaoQQG/fM7xBFEpNr+9GD4we3YOIhaAMNjflzrJiaPSB4HbS9hWUDf4q8210I8UcZKKWRirT
        gqACx8vFpUgm88Ads+7va
X-Received: by 2002:a9d:6e04:0:b0:5af:6426:6d39 with SMTP id e4-20020a9d6e04000000b005af64266d39mr6603707otr.75.1646680309250;
        Mon, 07 Mar 2022 11:11:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrESkXA1V/9qY/xyUZhdUFyJNgxWEtqLu7JVFsEUrY4QNKlYbaQPLHPF8qRRFz3N5uWmV5CA==
X-Received: by 2002:a9d:6e04:0:b0:5af:6426:6d39 with SMTP id e4-20020a9d6e04000000b005af64266d39mr6603689otr.75.1646680309017;
        Mon, 07 Mar 2022 11:11:49 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id o2-20020a05687072c200b000d9ae3e1fabsm5888678oak.12.2022.03.07.11.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 11:11:48 -0800 (PST)
Date:   Mon, 7 Mar 2022 12:11:47 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-pci@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH vfio-next] PCI/IOV: Fix wrong kernel-doc identifier
Message-ID: <20220307121147.4a12f2a7.alex.williamson@redhat.com>
In-Reply-To: <8cecf7df45948a256dc56148cf9e87b2f2bb4198.1646652504.git.leonro@nvidia.com>
References: <8cecf7df45948a256dc56148cf9e87b2f2bb4198.1646652504.git.leonro@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon,  7 Mar 2022 13:33:25 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Replace "-" to be ":" in comment section to be aligned with
> kernel-doc format.
> 
> drivers/pci/iov.c:67: warning: Function parameter or member 'dev' not described in 'pci_iov_get_pf_drvdata'
> drivers/pci/iov.c:67: warning: Function parameter or member 'pf_driver' not described in 'pci_iov_get_pf_drvdata'
> 
> Fixes: a7e9f240c0da ("PCI/IOV: Add pci_iov_get_pf_drvdata() to allow VF reaching the drvdata of a PF")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/pci/iov.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 28ec952e1221..952217572113 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -49,8 +49,8 @@ EXPORT_SYMBOL_GPL(pci_iov_vf_id);
>  
>  /**
>   * pci_iov_get_pf_drvdata - Return the drvdata of a PF
> - * @dev - VF pci_dev
> - * @pf_driver - Device driver required to own the PF
> + * @dev: VF pci_dev
> + * @pf_driver: Device driver required to own the PF
>   *
>   * This must be called from a context that ensures that a VF driver is attached.
>   * The value returned is invalid once the VF driver completes its remove()

Applied to vfio next branch for v5.18 with acks from Randy and Bjorn.
Thanks,

Alex

