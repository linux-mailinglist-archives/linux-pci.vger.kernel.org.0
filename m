Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2966FEC3D
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 09:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbjEKHEb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 03:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbjEKHEH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 03:04:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9186A79;
        Thu, 11 May 2023 00:03:42 -0700 (PDT)
Received: from dggpemm100016.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QH2r40mQ6zsRBN;
        Thu, 11 May 2023 15:01:40 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100016.china.huawei.com (7.185.36.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 15:03:33 +0800
Received: from [10.174.150.180] (10.174.150.180) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 15:03:33 +0800
Content-Type: multipart/mixed;
        boundary="------------SHVJ7X6OJBJvh5hGfukHDv1g"
Message-ID: <f7ab6d78-1815-bd3e-c365-1bf054138366@huawei.com>
Date:   Thu, 11 May 2023 15:03:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Zhuang Shengen <zhuangshengen@huawei.com>
Subject: Re: [PATCH] vsock: bugfix port residue in server
To:     Stefano Garzarella <sgarzare@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arei.gonglei@huawei.com>,
        <longpeng2@huawei.com>, <jianjay.zhou@huawei.com>
References: <20230510142502.2293109-1-zhuangshengen@huawei.com>
 <ftuh7vhoxdxbymg6u3wlkfhlfoufupeqampqxc2ktqrpxndow3@dkpufdnuwlln>
In-Reply-To: <ftuh7vhoxdxbymg6u3wlkfhlfoufupeqampqxc2ktqrpxndow3@dkpufdnuwlln>
X-Originating-IP: [10.174.150.180]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--------------SHVJ7X6OJBJvh5hGfukHDv1g
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stefano:

在 2023/5/10 23:23, Stefano Garzarella 写道:
> Hi,
> thanks for the patch, the change LGTM, but I have the following
> suggestions:
>
> Please avoid "bugfix" in the subject, "fix" should be enough:
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes 
>
>
> Anyway, I suggest to change the subject in
> "vsock: avoid to close connected socket after the timeout"
>
thanks for your suggestion, I will change the subject
> On Wed, May 10, 2023 at 10:25:02PM +0800, Zhuang Shengen wrote:
>> When client and server establish a connection through vsock,
>> the client send a request to the server to initiate the connection,
>> then start a timer to wait for the server's response. When the server's
>> RESPONSE message arrives, the timer also times out and exits. The
>> server's RESPONSE message is processed first, and the connection is
>> established. However, the client's timer also times out, the original
>> processing logic of the client is to directly set the state of this 
>> vsock
>> to CLOSE and return ETIMEDOUT, User will release the port. It will not
>
> What to you mean with "User" here?
>
The User means Client, I will delete the statement "User will release 
the por", it indeed difficult to understand
>> notify the server when the port is released, causing the server port 
>> remain
>>
>
> Can we remove this blank line?
>
OK
>> when client's vsock_conqnect timeout，it should check sk state is
>
> The remote peer can't trust the other peer, indeed it will receive an
> error after sending the first message and it will remove the connection,
> right?
>
If this situation happend, the server will response a RST? Anyway the 
connection will not established before timeout, The sk state wont be 
ESTABLISHED.
>> ESTABLISHED or not. if sk state is ESTABLISHED, it means the connection
>> is established, the client should not set the sk state to CLOSE
>>
>> Note: I encountered this issue on kernel-4.18, which can be fixed by
>> this patch. Then I checked the latest code in the community
>> and found similar issue.
>>
>
> In order to backport it to the stable kernels, we should add a Fixes tag:
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes 
>
>
OK, I add a Fixes: d021c344051a ("VSOCK: Introduce VM Sockets") in the 
new patch.

I put the new patch with v2 title in the attachment, please check.
Thanks,
Shengen

> Thanks,
> Stefano
>
>> Signed-off-by: Zhuang Shengen <zhuangshengen@huawei.com>
>> ---
>> net/vmw_vsock/af_vsock.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index 413407bb646c..efb8a0937a13 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -1462,7 +1462,7 @@ static int vsock_connect(struct socket *sock, 
>> struct sockaddr *addr,
>>             vsock_transport_cancel_pkt(vsk);
>>             vsock_remove_connected(vsk);
>>             goto out_wait;
>> -        } else if (timeout == 0) {
>> +        } else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 
>> 0)) {
>>             err = -ETIMEDOUT;
>>             sk->sk_state = TCP_CLOSE;
>>             sock->state = SS_UNCONNECTED;
>> -- 
>> 2.27.0
>>
>
--------------SHVJ7X6OJBJvh5hGfukHDv1g
Content-Type: text/plain; charset="UTF-8";
	name="0001-vsock-avoid-to-close-connected-socket-after-the-time.patch"
Content-Disposition: attachment;
	filename*0="0001-vsock-avoid-to-close-connected-socket-after-the-time.pa";
	filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiYTk4MjZjNTAxZDQ1Y2I0Njg4ZWI2NzkyNGFjNmRjODZjMTYwODhlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBaaHVhbmcgU2hlbmdlbiA8emh1YW5nc2hlbmdlbkBo
dWF3ZWkuY29tPgpEYXRlOiBXZWQsIDEwIE1heSAyMDIzIDIxOjM2OjQ2ICswODAwClN1Ympl
Y3Q6IFtQQVRDSCBuZXQgdjJdIHZzb2NrOiBhdm9pZCB0byBjbG9zZSBjb25uZWN0ZWQgc29j
a2V0IGFmdGVyIHRoZSB0aW1lb3V0Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTog
dGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4
Yml0CgpXaGVuIGNsaWVudCBhbmQgc2VydmVyIGVzdGFibGlzaCBhIGNvbm5lY3Rpb24gdGhy
b3VnaCB2c29jaywKdGhlIGNsaWVudCBzZW5kIGEgcmVxdWVzdCB0byB0aGUgc2VydmVyIHRv
IGluaXRpYXRlIHRoZSBjb25uZWN0aW9uLAp0aGVuIHN0YXJ0IGEgdGltZXIgdG8gd2FpdCBm
b3IgdGhlIHNlcnZlcidzIHJlc3BvbnNlLiBXaGVuIHRoZSBzZXJ2ZXIncwpSRVNQT05TRSBt
ZXNzYWdlIGFycml2ZXMsIHRoZSB0aW1lciBhbHNvIHRpbWVzIG91dCBhbmQgZXhpdHMuIFRo
ZQpzZXJ2ZXIncyBSRVNQT05TRSBtZXNzYWdlIGlzIHByb2Nlc3NlZCBmaXJzdCwgYW5kIHRo
ZSBjb25uZWN0aW9uIGlzCmVzdGFibGlzaGVkLiBIb3dldmVyLCB0aGUgY2xpZW50J3MgdGlt
ZXIgYWxzbyB0aW1lcyBvdXQsIHRoZSBvcmlnaW5hbApwcm9jZXNzaW5nIGxvZ2ljIG9mIHRo
ZSBjbGllbnQgaXMgdG8gZGlyZWN0bHkgc2V0IHRoZSBzdGF0ZSBvZiB0aGlzIHZzb2NrCnRv
IENMT1NFIGFuZCByZXR1cm4gRVRJTUVET1VULiBJdCB3aWxsIG5vdCBub3RpZnkgdGhlIHNl
cnZlciB3aGVuIHRoZSBwb3J0CmlzIHJlbGVhc2VkLCBjYXVzaW5nIHRoZSBzZXJ2ZXIgcG9y
dCByZW1haW4uCndoZW4gY2xpZW50J3MgdnNvY2tfY29ubmVjdCB0aW1lb3V077yMaXQgc2hv
dWxkIGNoZWNrIHNrIHN0YXRlIGlzCkVTVEFCTElTSEVEIG9yIG5vdC4gaWYgc2sgc3RhdGUg
aXMgRVNUQUJMSVNIRUQsIGl0IG1lYW5zIHRoZSBjb25uZWN0aW9uCmlzIGVzdGFibGlzaGVk
LCB0aGUgY2xpZW50IHNob3VsZCBub3Qgc2V0IHRoZSBzayBzdGF0ZSB0byBDTE9TRQoKTm90
ZTogSSBlbmNvdW50ZXJlZCB0aGlzIGlzc3VlIG9uIGtlcm5lbC00LjE4LCB3aGljaCBjYW4g
YmUgZml4ZWQgYnkKdGhpcyBwYXRjaC4gVGhlbiBJIGNoZWNrZWQgdGhlIGxhdGVzdCBjb2Rl
IGluIHRoZSBjb21tdW5pdHkKYW5kIGZvdW5kIHNpbWlsYXIgaXNzdWUuCgpGaXhlczogZDAy
MWMzNDQwNTFhICgiVlNPQ0s6IEludHJvZHVjZSBWTSBTb2NrZXRzIikKU2lnbmVkLW9mZi1i
eTogWmh1YW5nIFNoZW5nZW4gPHpodWFuZ3NoZW5nZW5AaHVhd2VpLmNvbT4KLS0tCiBuZXQv
dm13X3Zzb2NrL2FmX3Zzb2NrLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9uZXQvdm13X3Zzb2NrL2FmX3Zz
b2NrLmMgYi9uZXQvdm13X3Zzb2NrL2FmX3Zzb2NrLmMKaW5kZXggNDEzNDA3YmI2NDZjLi5l
ZmI4YTA5MzdhMTMgMTAwNjQ0Ci0tLSBhL25ldC92bXdfdnNvY2svYWZfdnNvY2suYworKysg
Yi9uZXQvdm13X3Zzb2NrL2FmX3Zzb2NrLmMKQEAgLTE0NjIsNyArMTQ2Miw3IEBAIHN0YXRp
YyBpbnQgdnNvY2tfY29ubmVjdChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2Fk
ZHIgKmFkZHIsCiAJCQl2c29ja190cmFuc3BvcnRfY2FuY2VsX3BrdCh2c2spOwogCQkJdnNv
Y2tfcmVtb3ZlX2Nvbm5lY3RlZCh2c2spOwogCQkJZ290byBvdXRfd2FpdDsKLQkJfSBlbHNl
IGlmICh0aW1lb3V0ID09IDApIHsKKwkJfSBlbHNlIGlmICgoc2stPnNrX3N0YXRlICE9IFRD
UF9FU1RBQkxJU0hFRCkgJiYgKHRpbWVvdXQgPT0gMCkpIHsKIAkJCWVyciA9IC1FVElNRURP
VVQ7CiAJCQlzay0+c2tfc3RhdGUgPSBUQ1BfQ0xPU0U7CiAJCQlzb2NrLT5zdGF0ZSA9IFNT
X1VOQ09OTkVDVEVEOwotLSAKMi4yNy4wCgo=

--------------SHVJ7X6OJBJvh5hGfukHDv1g--
