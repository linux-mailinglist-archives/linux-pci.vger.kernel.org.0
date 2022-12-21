Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE788652CF6
	for <lists+linux-pci@lfdr.de>; Wed, 21 Dec 2022 07:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiLUGlM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Dec 2022 01:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUGlL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Dec 2022 01:41:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596E3A448
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 22:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671604823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6GIXJfP6lLbkNCudO+mG156mH9R13EdyawfZqeVfjt4=;
        b=jUWB1gV4+rdWLZcNl0DLlWePGgyTub5ikvr7dFZP6QRrNuMYK89z+feA+Z8KTL9voSKPtB
        Chbne5/2s34gCdNsrRW/66H5xuUMBoE20z5muA4Tu0Rmmj7ZZaCyhB856FbZF/+ymD6COL
        C7DDCuFQ2oU+8BtXDzOQIOUJ21h49Gs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-27-WgnfqmekOBykyV9DLUfH-A-1; Wed, 21 Dec 2022 01:40:22 -0500
X-MC-Unique: WgnfqmekOBykyV9DLUfH-A-1
Received: by mail-qv1-f69.google.com with SMTP id o13-20020a056214108d00b004c6fb4f16dcso8186423qvr.6
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 22:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GIXJfP6lLbkNCudO+mG156mH9R13EdyawfZqeVfjt4=;
        b=LmOryzqMj0uDJ9DfY3xsaSo94fO50aGdi3F5SCsWhkcXJ5bTlrVeo+hG4bqsFobYok
         VB+4STXn1yZoBZXF6np0jmhjGZM/iGIoDSC/jhEJTvnArjtnsQY1dyKUHqLAcjuBWeES
         kZENsbh2cth758rW6DWZRQIJCRO0895/69nB7VKt9de9YZxg3XQotJeyQ056pr2cTSDx
         MJqQRXQLEoQTzRXVXiL6hyiEz7MiFVcCYM5OgGbCR0u94znh81ZD2x2W0eXbmooB5j5L
         IDXwZ384bVIPV0h0G1eULzWcXDPtmrRs7QgA6IUyRBRFSWQjXZB7WCq0bblolRKZUuRt
         K1EQ==
X-Gm-Message-State: AFqh2ko3icRTQ7V2kKt8vN5zAfQCvFd60TeQjclOIV072BOj9xlFnWVG
        zk1LjklZ/x5iTFNZ/bwbekuEBgd8oPEDGL8Mn5mIxRdCfRN/krdlr4cnHzfCgy803Kow2V0l+1G
        WNiY09x7hg8bqWqbTzeqA
X-Received: by 2002:ac8:7542:0:b0:3ab:28ea:d849 with SMTP id b2-20020ac87542000000b003ab28ead849mr890787qtr.10.1671604821279;
        Tue, 20 Dec 2022 22:40:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvY5Z6Nk+cW9c4QcsX8MAS54V9yZ+Jd55Y6+e6sz97Dtit25nevBX+Xt+gWUMZeniF5ZgyfTA==
X-Received: by 2002:ac8:7542:0:b0:3ab:28ea:d849 with SMTP id b2-20020ac87542000000b003ab28ead849mr890776qtr.10.1671604821067;
        Tue, 20 Dec 2022 22:40:21 -0800 (PST)
Received: from redhat.com ([37.19.199.117])
        by smtp.gmail.com with ESMTPSA id t15-20020ac86a0f000000b0039cc64bcb53sm8589408qtr.27.2022.12.20.22.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 22:40:20 -0800 (PST)
Date:   Wed, 21 Dec 2022 01:40:15 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        Jason Wang <jasowang@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, llvm@lists.linux.dev
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Message-ID: <20221221013907-mutt-send-email-mst@kernel.org>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <Y6HjpvDfIusAz2uS@dev-arch.thelio-3990X>
 <CAJs=3_B7WoERAiXPyvz=6d7O5rcwXMfWZJFsi_ds-OAemvfcgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs=3_B7WoERAiXPyvz=6d7O5rcwXMfWZJFsi_ds-OAemvfcgQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 20, 2022 at 06:46:20PM +0200, Alvaro Karsz wrote:
> Hi Nathan,
> 
> > This does not appear to be a false positive but what was the intent
> > here? Should the local name variables increase their length or should
> > the buffer length be reduced?
> 
> You're right, the local name variables and snprintf argument don't match.
> Thanks for noticing.
> I think that we should increase the name variables  to be
> SNET_NAME_SIZE bytes long.
> 
> How should I proceed from here?
> Should I create a new version for this patch, or should I fix it in a
> follow up patch?
> 
> Thanks,
> Alvaro


Please post a follow-up ASAP. I can squash myself if I rebase.

Thanks!

-- 
MST

