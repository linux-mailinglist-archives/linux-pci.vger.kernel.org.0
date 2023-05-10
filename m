Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFF46FE182
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbjEJPYE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 11:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbjEJPYD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 11:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46CB2703
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2023 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683732200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iQz0FmqJ0fhhQVp092YrUUlwTUhSHWlf9UDAQ/T7kzA=;
        b=ik8ESORAgyBVZDpyLxhJY3PK7uCOvT0siu1pWv7LUwXSO0jgfSexOWLkENCvkWMl4NFUFg
        pu3YVAERnJnsSjvt02odRlUvUcCE9ChhZd+Fd6cxqZ9LS+SGpmVaq2FlgEddwg/PxiyJ3N
        RE+tA7IzKn/dcwNYsJ+PAvHf2UroflE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-ltTw3OeNMkWokl4KmYf6bQ-1; Wed, 10 May 2023 11:23:19 -0400
X-MC-Unique: ltTw3OeNMkWokl4KmYf6bQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3063394ae41so2631929f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2023 08:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683732198; x=1686324198;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQz0FmqJ0fhhQVp092YrUUlwTUhSHWlf9UDAQ/T7kzA=;
        b=BvwM1ZmfJDJVIskt/bBGG9E4Pp+q80RdKfY0vuMefN1uluqLHycJjEnkr3wckQoQRh
         CQGswGHHqpJFWmyLsFrc1XoLBnOaDR5GcJe/5RptXwgTZ/1jstgrxMPzhYYoeAOK/FgX
         zbkC/JSPvjll6Em9/eGVAQfgYkN8JguvzVvvSPYjueqW6BCc/WmUoD2MDmxgZi97tUoT
         t7wkocrJMO6CTjhZTQUU8tpbBcWx6Xa0RsemvdWbE+3WEgbAuj3btsGTcFPQP7OEDkqi
         eIVFGmVGUP1M/HemlbJDTzgzmJvhx8jypa/W/XUqVjHEh15popfdIrwqT2FKnim/Mt5D
         6I3w==
X-Gm-Message-State: AC+VfDxs2nl8slfMiwYMimbuEDFNfWbHF8BMjJZnZxWUHGU+CqSy4+h9
        QmIGP9wWBbf4J3GHjdf6H+hmTzPOhF2Fauu+YXrZg5kkZl5W2SkshRKFfa8vmN5TgMVwr1EXJMO
        TRrEso7Rg7No8FHEzlwUw
X-Received: by 2002:a5d:668c:0:b0:2fe:2775:6067 with SMTP id l12-20020a5d668c000000b002fe27756067mr13070918wru.28.1683732198397;
        Wed, 10 May 2023 08:23:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5OVnaJRiAA0cQBb92KuhDH69k4SVMEoaKebUn/GNPF4wmy0jKK0SNfVankDjgdH6JTuuX5bw==
X-Received: by 2002:a5d:668c:0:b0:2fe:2775:6067 with SMTP id l12-20020a5d668c000000b002fe27756067mr13070898wru.28.1683732198056;
        Wed, 10 May 2023 08:23:18 -0700 (PDT)
Received: from sgarzare-redhat ([217.171.72.110])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb11000000b003075428aad5sm17481409wrr.29.2023.05.10.08.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:23:17 -0700 (PDT)
Date:   Wed, 10 May 2023 17:23:14 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Zhuang Shengen <zhuangshengen@huawei.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        arei.gonglei@huawei.com, longpeng2@huawei.com,
        jianjay.zhou@huawei.com
Subject: Re: [PATCH] vsock: bugfix port residue in server
Message-ID: <ftuh7vhoxdxbymg6u3wlkfhlfoufupeqampqxc2ktqrpxndow3@dkpufdnuwlln>
References: <20230510142502.2293109-1-zhuangshengen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510142502.2293109-1-zhuangshengen@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
thanks for the patch, the change LGTM, but I have the following
suggestions:

Please avoid "bugfix" in the subject, "fix" should be enough:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes

Anyway, I suggest to change the subject in
"vsock: avoid to close connected socket after the timeout"

On Wed, May 10, 2023 at 10:25:02PM +0800, Zhuang Shengen wrote:
>When client and server establish a connection through vsock,
>the client send a request to the server to initiate the connection,
>then start a timer to wait for the server's response. When the server's
>RESPONSE message arrives, the timer also times out and exits. The
>server's RESPONSE message is processed first, and the connection is
>established. However, the client's timer also times out, the original
>processing logic of the client is to directly set the state of this vsock
>to CLOSE and return ETIMEDOUT, User will release the port. It will not

What to you mean with "User" here?

>notify the server when the port is released, causing the server port remain
>

Can we remove this blank line?

>when client's vsock_connect timeout，it should check sk state is

The remote peer can't trust the other peer, indeed it will receive an
error after sending the first message and it will remove the connection,
right?

>ESTABLISHED or not. if sk state is ESTABLISHED, it means the connection
>is established, the client should not set the sk state to CLOSE
>
>Note: I encountered this issue on kernel-4.18, which can be fixed by
>this patch. Then I checked the latest code in the community
>and found similar issue.
>

In order to backport it to the stable kernels, we should add a Fixes tag:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes

Thanks,
Stefano

>Signed-off-by: Zhuang Shengen <zhuangshengen@huawei.com>
>---
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 413407bb646c..efb8a0937a13 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1462,7 +1462,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			vsock_transport_cancel_pkt(vsk);
> 			vsock_remove_connected(vsk);
> 			goto out_wait;
>-		} else if (timeout == 0) {
>+		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
> 			err = -ETIMEDOUT;
> 			sk->sk_state = TCP_CLOSE;
> 			sock->state = SS_UNCONNECTED;
>-- 
>2.27.0
>

