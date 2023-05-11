Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399AF6FED7A
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 10:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbjEKIGZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 04:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjEKIGL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 04:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF5F4213
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683792322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TDguPfFBQ1A5HBLbGPkFIstEpZuKohqgknZXXQa2m5U=;
        b=XRSVCdTeLtNJV5gDvq+BSVg/tBc5cG9zczitwq4Q5Qg3UwtuNKdFZloq0ZlgQEP+lmyjrP
        nC5D6+o+qxTWvDxj8JIt2lkzreJAXyCO/BWPmqguPUDvvWJWT55jLTeTzKGSwLhwEx4sVQ
        mnRHE96PRAxOVZ7ib3++h508Fd4Ob+k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-JtZRZoHpOMKmYEl3LM4YCg-1; Thu, 11 May 2023 04:05:21 -0400
X-MC-Unique: JtZRZoHpOMKmYEl3LM4YCg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-307897bc279so3499912f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 01:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683792320; x=1686384320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDguPfFBQ1A5HBLbGPkFIstEpZuKohqgknZXXQa2m5U=;
        b=U031Ry2iC75/Q44EsohYo0xgSAa+N4+kmxeYX+FcTF3fgH8iQVW+za8MD86ny9lo3o
         30jmDtWzfsxUJd2IEgbYJ4yWhkhaK4NMI0SzFMMCHu29CnyNC2o564k71iZ8GprpbGto
         jW64KQ+pCEmyBBB2PhIH/FQEap6JYRCI8mfVj6p7IhhmxLAEXPpHKtqVhiDXmP1zeXHM
         T9/INBPw1GTalngJDkQ7CKvf5Qf2flOkqKBri/0l1in9Znt24LkPtq2OVwJPILUdMVto
         b6pWWESsZmHtO0w80kL7RBqBWGIyYqVgdFZeSvnKuxIol6e7fTkq2l06nx9xeMoa8PFX
         LhuQ==
X-Gm-Message-State: AC+VfDy1iSJMQG2FXK70g0DFldtRcT1yD1ZiESFkTUnk5CHWq1CjqYl3
        ChJfwFppITq1ZsdXqRfy/i6rTsEfezOotEZ1ZlXOhezsO+tTaaqyjTZfZRhsFHFtYI7zHkrnW0N
        9U1lmIm+bOSvQhrwt//JR
X-Received: by 2002:adf:dbd0:0:b0:306:39e3:8409 with SMTP id e16-20020adfdbd0000000b0030639e38409mr14427163wrj.49.1683792320330;
        Thu, 11 May 2023 01:05:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7l+BpAdb0iCMyJ1RUUM102Pj/7Li/+Avs0LqpRU6YbPaKu+/sEc+cIjTbpYXL8YuEmB9Vy/Q==
X-Received: by 2002:adf:dbd0:0:b0:306:39e3:8409 with SMTP id e16-20020adfdbd0000000b0030639e38409mr14427142wrj.49.1683792320001;
        Thu, 11 May 2023 01:05:20 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.69.175])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d65cd000000b0030789698eebsm15980169wrw.89.2023.05.11.01.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 01:05:19 -0700 (PDT)
Date:   Thu, 11 May 2023 10:05:16 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Zhuang Shengen <zhuangshengen@huawei.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        arei.gonglei@huawei.com, longpeng2@huawei.com,
        jianjay.zhou@huawei.com
Subject: Re: [PATCH] vsock: bugfix port residue in server
Message-ID: <oavxfpkinrpj7n24myvgmyq34aymvjm5lx3lqwhwxw6nbumam3@vwg76jsvjdaj>
References: <20230510142502.2293109-1-zhuangshengen@huawei.com>
 <ftuh7vhoxdxbymg6u3wlkfhlfoufupeqampqxc2ktqrpxndow3@dkpufdnuwlln>
 <f7ab6d78-1815-bd3e-c365-1bf054138366@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7ab6d78-1815-bd3e-c365-1bf054138366@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 11, 2023 at 03:03:24PM +0800, Zhuang Shengen wrote:
>Hi Stefano:
>
>在 2023/5/10 23:23, Stefano Garzarella 写道:
>>Hi,
>>thanks for the patch, the change LGTM, but I have the following
>>suggestions:
>>
>>Please avoid "bugfix" in the subject, "fix" should be enough:
>>https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes
>>
>>
>>Anyway, I suggest to change the subject in
>>"vsock: avoid to close connected socket after the timeout"
>>
>thanks for your suggestion, I will change the subject
>>On Wed, May 10, 2023 at 10:25:02PM +0800, Zhuang Shengen wrote:
>>>When client and server establish a connection through vsock,
>>>the client send a request to the server to initiate the connection,
>>>then start a timer to wait for the server's response. When the server's
>>>RESPONSE message arrives, the timer also times out and exits. The
>>>server's RESPONSE message is processed first, and the connection is
>>>established. However, the client's timer also times out, the original
>>>processing logic of the client is to directly set the state of 
>>>this vsock
>>>to CLOSE and return ETIMEDOUT, User will release the port. It will not
>>
>>What to you mean with "User" here?
>>
>The User means Client, I will delete the statement "User will release 
>the por", it indeed difficult to understand
>>>notify the server when the port is released, causing the server 
>>>port remain
>>>
>>
>>Can we remove this blank line?
>>
>OK
>>>when client's vsock_conqnect timeout，it should check sk state is
>>
>>The remote peer can't trust the other peer, indeed it will receive an
>>error after sending the first message and it will remove the connection,
>>right?
>>
>If this situation happend, the server will response a RST? Anyway the 
>connection will not established before timeout, The sk state wont be 
>ESTABLISHED.
>>>ESTABLISHED or not. if sk state is ESTABLISHED, it means the connection
>>>is established, the client should not set the sk state to CLOSE
>>>
>>>Note: I encountered this issue on kernel-4.18, which can be fixed by
>>>this patch. Then I checked the latest code in the community
>>>and found similar issue.
>>>
>>
>>In order to backport it to the stable kernels, we should add a Fixes tag:
>>https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes
>>
>>
>OK, I add a Fixes: d021c344051a ("VSOCK: Introduce VM Sockets") in the 
>new patch.
>
>I put the new patch with v2 title in the attachment, please check.

LGTM (great to have added the net tag!), but please post as plain text 
like v1.

Thanks,
Stefano

