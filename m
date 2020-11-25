Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B192C4162
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 14:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgKYNt4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 08:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgKYNtz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 08:49:55 -0500
X-Greylist: delayed 507 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Nov 2020 05:49:55 PST
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [IPv6:2001:7c0:2041:24::a:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D500C0613D4;
        Wed, 25 Nov 2020 05:49:55 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 3AB7560C9C;
        Wed, 25 Nov 2020 14:41:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
         h=content-language:content-type:content-type:in-reply-to
        :mime-version:user-agent:date:date:message-id:from:from
        :references:subject:subject:received:received; s=dkim; i=
        @tik.uni-stuttgart.de; t=1606311681; x=1608050482; bh=i9TWXDNtoR
        KLLrG9KRrq5j/4SjE+bbBjALademgWjKk=; b=Lryv3blbCU4s+jdKS6qZ2EvDtL
        x85EwNHlqFNuevqGCGFUiKhHLQq8RLg3C3luq9Aji94kH2sIiiS9qZ2bRKHsB98B
        HyAWqhIz3LAxXleqfPaXw3B/99ExwgfmV+BXhKZAL9WftadY7iViqzM1IEWcpa9K
        XK1sGN2C2gzKZhobK32MQAyHRSiG5f76+UmWaLUfUpoJJ697qDP+116l362zL93q
        qkdEk4B8i7GcAHi3KjOVDzYTv1xwx7akwfO5gmHBaEVs+PrNLi5izmD+l8Tw1BfR
        5UVB7oSIU9JF//AdeHMl46hJhz9hDxXW8fSsMfIVgaHEiP6IbLLoDVVtOVYw==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
        by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavisd-new, port 10031)
        with ESMTP id Fr45tlTCoT8D; Wed, 25 Nov 2020 14:41:21 +0100 (CET)
Received: from [IPv6:2001:7c0:2050:1:1::6] (unknown [IPv6:2001:7c0:2050:1:1::6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA;
        Wed, 25 Nov 2020 14:41:20 +0100 (CET)
Subject: Re: boot interrupt quirk (also in 4.19.y) breaks serial ports (was:
 [PATCH v2 0/2] pci: Add boot interrupt quirk mechanism for Xeon chipsets)
To:     Thomas Gleixner <tglx@linutronix.de>, sean.v.kelley@linux.intel.com
Cc:     bhelgaas@google.com, bp@alien8.de, corbet@lwn.net,
        kar.hin.ong@ni.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mingo@redhat.com, sassmann@kpanic.de, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200220192930.64820-1-sean.v.kelley@linux.intel.com>
 <b2da25c8-121a-b241-c028-68e49bab0081@tik.uni-stuttgart.de>
 <87zh35k5xa.fsf@nanos.tec.linutronix.de>
From:   "=?UTF-8?Q?Stefan_B=c3=bchler?=" 
        <stefan.buehler@tik.uni-stuttgart.de>
Autocrypt: addr=stefan.buehler@tik.uni-stuttgart.de; prefer-encrypt=mutual;
 keydata=
 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
 rwHRmQ==
Message-ID: <d512469f-de04-2f66-ca42-21ec3c5331ba@tik.uni-stuttgart.de>
Date:   Wed, 25 Nov 2020 14:41:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87zh35k5xa.fsf@nanos.tec.linutronix.de>
Content-Type: multipart/mixed;
 boundary="------------5DDA533774A88CDE3CBCA263"
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a multi-part message in MIME format.
--------------5DDA533774A88CDE3CBCA263
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi tglx,

On 11/25/20 12:54 PM, Thomas Gleixner wrote:
> Stefan,
> 
> On Wed, Sep 16 2020 at 12:12, Stefan Bühler wrote:
> 
> sorry for the delay. This fell through the cracks.
> 
>> this quirk breaks our serial ports PCIe card (i.e. we don't see any 
>> output from the connected devices; no idea whether anything we send 
>> reaches them):
>>
>> 05:00.0 PCI bridge: PLX Technology, Inc. PEX8112 x1 Lane PCI Express-to-PCI Bridge (rev aa)
>> 06:00.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 0 (Uart)
>> 06:00.1 Bridge: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 0 (Disabled)
>> 06:01.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART) function 0 (Uart)
>> 06:01.1 Bridge: Oxford Semiconductor Ltd OX16PCI954 (Quad 16950 UART)
>> function 0 (Disabled)
> 
> Can you please provide the output of:
> 
>  for ID in 05:00.0 06:00.0 06:00.1 06:01.0 06:01.1; do lspci -s $ID -vvv; done
> 

See attachment.

Also I boot the affected systems now with "pci=noioapicquirk", which
"solves" the issue too (instead of patching the kernel).

cheers,
Stefan

--------------5DDA533774A88CDE3CBCA263
Content-Type: text/plain; charset=UTF-8;
 name="oxford-serial-lspci.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="oxford-serial-lspci.txt"

MDU6MDAuMCBQQ0kgYnJpZGdlOiBQTFggVGVjaG5vbG9neSwgSW5jLiBQRVg4MTEyIHgxIExh
bmUgUENJIEV4cHJlc3MtdG8tUENJIEJyaWRnZSAocmV2IGFhKSAocHJvZy1pZiAwMCBbTm9y
bWFsIGRlY29kZV0pCglQaHlzaWNhbCBTbG90OiAxCglDb250cm9sOiBJL08rIE1lbSsgQnVz
TWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5n
LSBTRVJSKyBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZh
c3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0g
PlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiAzMiBi
eXRlcwoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDE2CglOVU1BIG5vZGU6IDAK
CUJ1czogcHJpbWFyeT0wNSwgc2Vjb25kYXJ5PTA2LCBzdWJvcmRpbmF0ZT0wNiwgc2VjLWxh
dGVuY3k9NjQKCUkvTyBiZWhpbmQgYnJpZGdlOiAwMDAwZTAwMC0wMDAwZWZmZgoJTWVtb3J5
IGJlaGluZCBicmlkZ2U6IGZiNDAwMDAwLWZiNGZmZmZmCglQcmVmZXRjaGFibGUgbWVtb3J5
IGJlaGluZCBicmlkZ2U6IGZmZjAwMDAwLTAwMGZmZmZmCglTZWNvbmRhcnkgc3RhdHVzOiA2
Nk1IeisgRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9bWVkaXVtID5UQWJvcnQtIDxUQWJvcnQt
IDxNQWJvcnQrIDxTRVJSLSA8UEVSUi0KCUJyaWRnZUN0bDogUGFyaXR5LSBTRVJSKyBOb0lT
QS0gVkdBLSBNQWJvcnQtID5SZXNldC0gRmFzdEIyQi0KCQlQcmlEaXNjVG1yLSBTZWNEaXNj
VG1yLSBEaXNjVG1yU3RhdC0gRGlzY1RtclNFUlJFbi0KCUNhcGFiaWxpdGllczogPGFjY2Vz
cyBkZW5pZWQ+CgowNjowMC4wIFNlcmlhbCBjb250cm9sbGVyOiBPeGZvcmQgU2VtaWNvbmR1
Y3RvciBMdGQgT1gxNlBDSTk1NCAoUXVhZCAxNjk1MCBVQVJUKSBmdW5jdGlvbiAwIChVYXJ0
KSAocHJvZy1pZiAwNiBbMTY5NTBdKQoJU3Vic3lzdGVtOiBPeGZvcmQgU2VtaWNvbmR1Y3Rv
ciBMdGQgT1gxNlBDSTk1NCAoUXVhZCAxNjk1MCBVQVJUKSBmdW5jdGlvbiAwIChVYXJ0KQoJ
Q29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3Rlci0gU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FT
bm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUisgRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1
czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRB
Ym9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJSW50ZXJydXB0
OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDE2CglOVU1BIG5vZGU6IDAKCVJlZ2lvbiAwOiBJL08g
cG9ydHMgYXQgZTBlMCBbc2l6ZT0zMl0KCVJlZ2lvbiAxOiBNZW1vcnkgYXQgZmI0MDcwMDAg
KDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9NEtdCglSZWdpb24gMjogSS9PIHBv
cnRzIGF0IGUwYzAgW3NpemU9MzJdCglSZWdpb24gMzogTWVtb3J5IGF0IGZiNDA2MDAwICgz
Mi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTRLXQoJQ2FwYWJpbGl0aWVzOiA8YWNj
ZXNzIGRlbmllZD4KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBzZXJpYWwKCjA2OjAwLjEgQnJp
ZGdlOiBPeGZvcmQgU2VtaWNvbmR1Y3RvciBMdGQgT1gxNlBDSTk1NCAoUXVhZCAxNjk1MCBV
QVJUKSBmdW5jdGlvbiAwIChEaXNhYmxlZCkKCVN1YnN5c3RlbTogT3hmb3JkIFNlbWljb25k
dWN0b3IgTHRkIE9YMTZQQ0k5NTQgKFF1YWQgMTY5NTAgVUFSVCkgZnVuY3Rpb24gMCAoRGlz
YWJsZWQpCglDb250cm9sOiBJL08tIE1lbS0gQnVzTWFzdGVyLSBTcGVjQ3ljbGUtIE1lbVdJ
TlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSKyBGYXN0QjJCLSBEaXNJTlR4
LQoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkIrIFBhckVyci0gREVWU0VMPW1l
ZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglO
VU1BIG5vZGU6IDAKCVJlZ2lvbiAwOiBJL08gcG9ydHMgYXQgZTBhMCBbZGlzYWJsZWRdIFtz
aXplPTMyXQoJUmVnaW9uIDE6IE1lbW9yeSBhdCBmYjQwNTAwMCAoMzItYml0LCBub24tcHJl
ZmV0Y2hhYmxlKSBbZGlzYWJsZWRdIFtzaXplPTRLXQoJUmVnaW9uIDI6IEkvTyBwb3J0cyBh
dCBlMDgwIFtkaXNhYmxlZF0gW3NpemU9MzJdCglSZWdpb24gMzogTWVtb3J5IGF0IGZiNDA0
MDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtkaXNhYmxlZF0gW3NpemU9NEtdCglD
YXBhYmlsaXRpZXM6IDxhY2Nlc3MgZGVuaWVkPgoKMDY6MDEuMCBTZXJpYWwgY29udHJvbGxl
cjogT3hmb3JkIFNlbWljb25kdWN0b3IgTHRkIE9YMTZQQ0k5NTQgKFF1YWQgMTY5NTAgVUFS
VCkgZnVuY3Rpb24gMCAoVWFydCkgKHByb2ctaWYgMDYgWzE2OTUwXSkKCVN1YnN5c3RlbTog
T3hmb3JkIFNlbWljb25kdWN0b3IgTHRkIE9YMTZQQ0k5NTQgKFF1YWQgMTY5NTAgVUFSVCkg
ZnVuY3Rpb24gMCAoVWFydCkKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXItIFNwZWND
eWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlIrIEZhc3RC
MkItIERpc0lOVHgtCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQisgUGFyRXJy
LSBERVZTRUw9bWVkaXVtID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVS
Ui0gSU5UeC0KCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAxNwoJTlVNQSBub2Rl
OiAwCglSZWdpb24gMDogSS9PIHBvcnRzIGF0IGUwNjAgW3NpemU9MzJdCglSZWdpb24gMTog
TWVtb3J5IGF0IGZiNDAzMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTRL
XQoJUmVnaW9uIDI6IEkvTyBwb3J0cyBhdCBlMDQwIFtzaXplPTMyXQoJUmVnaW9uIDM6IE1l
bW9yeSBhdCBmYjQwMjAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT00S10K
CUNhcGFiaWxpdGllczogPGFjY2VzcyBkZW5pZWQ+CglLZXJuZWwgZHJpdmVyIGluIHVzZTog
c2VyaWFsCgowNjowMS4xIEJyaWRnZTogT3hmb3JkIFNlbWljb25kdWN0b3IgTHRkIE9YMTZQ
Q0k5NTQgKFF1YWQgMTY5NTAgVUFSVCkgZnVuY3Rpb24gMCAoRGlzYWJsZWQpCglTdWJzeXN0
ZW06IE94Zm9yZCBTZW1pY29uZHVjdG9yIEx0ZCBPWDE2UENJOTU0IChRdWFkIDE2OTUwIFVB
UlQpIGZ1bmN0aW9uIDAgKERpc2FibGVkKQoJQ29udHJvbDogSS9PLSBNZW0tIEJ1c01hc3Rl
ci0gU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VS
UisgRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJC
KyBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNF
UlItIDxQRVJSLSBJTlR4LQoJTlVNQSBub2RlOiAwCglSZWdpb24gMDogSS9PIHBvcnRzIGF0
IGUwMjAgW2Rpc2FibGVkXSBbc2l6ZT0zMl0KCVJlZ2lvbiAxOiBNZW1vcnkgYXQgZmI0MDEw
MDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT00S10KCVJl
Z2lvbiAyOiBJL08gcG9ydHMgYXQgZTAwMCBbZGlzYWJsZWRdIFtzaXplPTMyXQoJUmVnaW9u
IDM6IE1lbW9yeSBhdCBmYjQwMDAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbZGlz
YWJsZWRdIFtzaXplPTRLXQoJQ2FwYWJpbGl0aWVzOiA8YWNjZXNzIGRlbmllZD4KCg==
--------------5DDA533774A88CDE3CBCA263--
