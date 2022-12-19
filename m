Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA8D650A50
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 11:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiLSKpZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 05:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiLSKpX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 05:45:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E300E6301
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 02:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671446675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Reu6NRJwdKAI/LUu39/+1k6l1aGIPSvkajefprb2Rq4=;
        b=iO4jTAy4P6L8gP2p7c5BZzq035jBXER8qTK89PsrtI1OF5gL7xaPRh5ppyLKK8M/3A44kq
        xEor1upb/ZFo5VAsO0j7Sm2Dl9m1oVIls0Aa2c8xPtrGOFulAsIp6Zj2kt1o/L+Oz00MV2
        8BNCFX6nftC3il9vjT5e6oO+JWeNXzQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-255-moqWEgO4MXCq99GUis-qZQ-1; Mon, 19 Dec 2022 05:44:33 -0500
X-MC-Unique: moqWEgO4MXCq99GUis-qZQ-1
Received: by mail-qk1-f200.google.com with SMTP id h13-20020a05620a244d00b006fb713618b8so7071824qkn.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Dec 2022 02:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Reu6NRJwdKAI/LUu39/+1k6l1aGIPSvkajefprb2Rq4=;
        b=o3FEPGPbsbMkVqoUbNIlrF2GbMsrEY+YB2n32PLLI5R3m+3F/ztUMQS6uTWwr/RhMM
         ODMNW2vSBEKcbl7kw2Zu6DPIjNkFP6WjJTkpVUJJwZsZhRWPh+HokQdwfOXuoVIT+9+Y
         w2BYfbiyIfSK0305yZ19sSCIBZXCKRgS5wGyNcbPisFg0IUr8/WSmJNm5ConwBAhyIwM
         oFu/p8lOCCTISpvD/LebcItpjI4Gia3S3ZLRVix8Bu3hWmOUxHXtycg+u317RHr/v5Hs
         SN1RUSrG3wTtLIlwL+qDqUxbAFIe5mF99P44o9og3FnATn504grglsYzYp7wu0k//WVK
         NdkA==
X-Gm-Message-State: ANoB5pkMtcdsTe4349Pp4KP0dYY0T5Yf6j3vdta/wZX5lA7hZ0NdJBoI
        677hbbdkADZdmKb5gcR1Hwq2jtO3zXpSsMGsWYE+UqzHO/2xMFbchAU+ikJf97Kn43Iwbr8KeBc
        eCpnBByG5o2X3DyIT63M6
X-Received: by 2002:a05:622a:248b:b0:3a6:454f:4e3f with SMTP id cn11-20020a05622a248b00b003a6454f4e3fmr59822164qtb.7.1671446673027;
        Mon, 19 Dec 2022 02:44:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4MdILKCwus5PCnhvoaUL4i2rjze68GkRcU9GQwLpc+ka1EwGERY0zv8jKnKomaEy6NC6C7YA==
X-Received: by 2002:a05:622a:248b:b0:3a6:454f:4e3f with SMTP id cn11-20020a05622a248b00b003a6454f4e3fmr59822150qtb.7.1671446672763;
        Mon, 19 Dec 2022 02:44:32 -0800 (PST)
Received: from redhat.com ([45.144.113.29])
        by smtp.gmail.com with ESMTPSA id p24-20020a05620a133800b006faa2c0100bsm6655000qkj.110.2022.12.19.02.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:44:32 -0800 (PST)
Date:   Mon, 19 Dec 2022 05:44:27 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        bhelgaas@google.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Message-ID: <20221219054419-mutt-send-email-mst@kernel.org>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <20221219054321-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219054321-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 19, 2022 at 05:43:55AM -0500, Michael S. Tsirkin wrote:
> On Mon, Dec 19, 2022 at 10:35:11AM +0200, Alvaro Karsz wrote:
> > This commit includes:
> >  1) The driver to manage the controlplane over vDPA bus.
> >  2) A HW monitor device to read health values from the DPU.
> > 
> > Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> 
> As far as I can tell patches 1,2 are upstream right?
> So you can just post patch 3.

Oh my bad pls ignore.

