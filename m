Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1F6651CAA
	for <lists+linux-pci@lfdr.de>; Tue, 20 Dec 2022 09:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiLTIzK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Dec 2022 03:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiLTIzI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2022 03:55:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A17838AB
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 00:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671526466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5UexBayMe6AI+Hs5yA1OlvLAoluoNMOSv7goOJy2Ko8=;
        b=HYaXF/ZnJ33mGz30qLzfIQUc0FzZtnXY6is5gg2/4cnwhK45zgmcY6qj+vpfYA+GG+0iK6
        JAB8+ZyVmb0VCxGRCqNscUp5R2cEAdy1vYCS8VzA7fB1Mod8kH4Bkcc6SfgVTq3DdeMoTe
        HvlFXtitJtQHVe6XbQhL4tzuQuQFzm0=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-125-kbYUmnG7Mg2Kqyp3qpu8Ag-1; Tue, 20 Dec 2022 03:54:25 -0500
X-MC-Unique: kbYUmnG7Mg2Kqyp3qpu8Ag-1
Received: by mail-oo1-f71.google.com with SMTP id y25-20020a4a6519000000b004a398cd439bso5313502ooc.5
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 00:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UexBayMe6AI+Hs5yA1OlvLAoluoNMOSv7goOJy2Ko8=;
        b=QDaSQzOyqlzdA1aNtyFBkb4n3XZ1kJWtVF2YrkPTFuocfPIbAFX2JfdAvN8H1dugVt
         +DerSvGfGjAxu+ZpQWogrltd0zXCekp3rftQbDTQq05eXP4R/5Ce3R7utXJdUMDWpnAR
         E1kZXF14vrQci8sz7GJg+eT9nvSrTFKWUa5fsPu9ajQvHWEQIWtTuHWh/DgtV6WkQpVA
         rdgZk0FGqSbqY4oxs13YW2h+QMpBmDZSJRn+wEaFz9arfSthTB7KAG+LlEpBB/xTER0E
         v4RZkVx6+mYU7GwNHlqr5n0Wnt/ukgR4B3BLKmcUjpKUwtx7G30FN1C5viCo/myxcZRK
         nANQ==
X-Gm-Message-State: ANoB5pnJHSVEzxRFyRdWRLb3nWAPmw97zjcINJzDkQbcGLTXXhzvbb3p
        3do8aaORbn8MDePuRCxDWriVWBTPuFTi9v5PaTurJGW2mxJTzGPiiQlyI2tNVZ4aQnxlziSsLH8
        qycVD6aLduaMVnBL5e/llsbsXLc7uGoAAJVyE
X-Received: by 2002:a4a:b145:0:b0:49f:449a:5f6c with SMTP id e5-20020a4ab145000000b0049f449a5f6cmr33112257ooo.93.1671526464571;
        Tue, 20 Dec 2022 00:54:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7BR3395fR8pIO336Y3NbjHh2AmeHBRaBq20l/roQen6xvxw83TnPt4KOTRhVYaIFG94QZCn2UmhXn1jLKb18g=
X-Received: by 2002:a4a:b145:0:b0:49f:449a:5f6c with SMTP id
 e5-20020a4ab145000000b0049f449a5f6cmr33112254ooo.93.1671526464291; Tue, 20
 Dec 2022 00:54:24 -0800 (PST)
MIME-Version: 1.0
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com> <96d85666-106b-a43e-6115-b9959b4e3e66@redhat.com>
 <CAJs=3_DkqB=6MXfUd02j6kKXahS6AWLRes5NUjj9Wp9iRecewg@mail.gmail.com>
In-Reply-To: <CAJs=3_DkqB=6MXfUd02j6kKXahS6AWLRes5NUjj9Wp9iRecewg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 20 Dec 2022 16:54:13 +0800
Message-ID: <CACGkMEsUvukNxAmMF5zodKj+fo8XbVtB4N=0PZfjrbx0s_Acgg@mail.gmail.com>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 20, 2022 at 3:26 PM Alvaro Karsz <alvaro.karsz@solid-run.com> wrote:
>
> Hi Jason,
>
> > So I think we actually don't need to depend on HWMON here?
> >
> > hwmon.c is only complied when HWMON is enabled and we use IS_ENABLED to
> > exclude the hwmon specific does.
>
> We are not really depending on HWMON with "(HWMON || HWMON=n)"
> If HWMON=n, the driver can be compiled either as a module or built-in.
> If HWMON=y, the driver can be compiled either as a module or built-in.
> If HWMON=m, the driver will be forced to be compiled as a module.
>
> This technique allows us to use IS_ENABLED instead of IS_REACHABLE

Ok, right.

So

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>

