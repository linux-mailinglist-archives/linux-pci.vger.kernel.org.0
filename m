Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C10C2C6175
	for <lists+linux-pci@lfdr.de>; Fri, 27 Nov 2020 10:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgK0JRL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Nov 2020 04:17:11 -0500
Received: from mxex2.tik.uni-stuttgart.de ([129.69.192.21]:37614 "EHLO
        mxex2.tik.uni-stuttgart.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727780AbgK0JRK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Nov 2020 04:17:10 -0500
X-Greylist: delayed 156943 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Nov 2020 04:17:07 EST
Received: from localhost (localhost [127.0.0.1])
        by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id E5F0D60CB8;
        Fri, 27 Nov 2020 10:17:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
         h=content-language:content-type:content-type:in-reply-to
        :mime-version:user-agent:date:date:message-id:subject:subject
        :references:from:from:received:received; s=dkim; i=
        @tik.uni-stuttgart.de; t=1606468623; x=1608207424; bh=gh7RsCRxaQ
        DGscDOCb20KvjkPWfrM38t85OmQRL1Aqc=; b=v4s+lJQnNOMJIRVqPDjyNnT5DM
        EEi3F5xPN7rB+JyrMgfmLYRBnHZWc2xgdSl4lj7eAXiaBXF7dhCzgluOKA+XLWiw
        XOdFLGJ55goxrzarVxcUVi0kmX94AAyaEujxKblqXblxjCKa35+fvEAx144vWGrO
        m5yshf5U3MNxog9SY95W2vDaTV9Xrz8QImcvgHwGwz4k/291oJ8jZyOXa02EFL+h
        KYy2U126FvhsYx4MpFk733XYAlvWnTS358Zq/oJRHrbpTLLmDenAl51tyqvxgf/r
        DqKjXKTS3/Z4CmUCpMDTOZ09PK/YUmZ3yXbe8CmTppdQ/TNl5ZVyLU0PyWDw==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
        by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavisd-new, port 10031)
        with ESMTP id UQzr3FplSyxf; Fri, 27 Nov 2020 10:17:03 +0100 (CET)
Received: from [IPv6:2001:7c0:2050:1:1::6] (unknown [IPv6:2001:7c0:2050:1:1::6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA;
        Fri, 27 Nov 2020 10:17:02 +0100 (CET)
From:   "=?UTF-8?Q?Stefan_B=c3=bchler?=" 
        <stefan.buehler@tik.uni-stuttgart.de>
To:     Thomas Gleixner <tglx@linutronix.de>, sean.v.kelley@linux.intel.com
Cc:     bhelgaas@google.com, bp@alien8.de, corbet@lwn.net,
        kar.hin.ong@ni.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mingo@redhat.com, sassmann@kpanic.de, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200220192930.64820-1-sean.v.kelley@linux.intel.com>
 <b2da25c8-121a-b241-c028-68e49bab0081@tik.uni-stuttgart.de>
 <87zh35k5xa.fsf@nanos.tec.linutronix.de>
 <d512469f-de04-2f66-ca42-21ec3c5331ba@tik.uni-stuttgart.de>
 <87blfjk7go.fsf@nanos.tec.linutronix.de>
Subject: Re: boot interrupt quirk (also in 4.19.y) breaks serial ports (was:
 [PATCH v2 0/2] pci: Add boot interrupt quirk mechanism for Xeon chipsets)
Message-ID: <7b54abab-fe38-4035-7c23-1f7456359c9e@tik.uni-stuttgart.de>
Date:   Fri, 27 Nov 2020 10:17:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87blfjk7go.fsf@nanos.tec.linutronix.de>
Content-Type: multipart/mixed;
 boundary="------------C95D686877BEE3CD8901C903"
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a multi-part message in MIME format.
--------------C95D686877BEE3CD8901C903
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi tglx,

On 11/27/20 12:45 AM, Thomas Gleixner wrote:
> Stefan,
> 
> On Wed, Nov 25 2020 at 14:41, Stefan Bühler wrote:
>> On 11/25/20 12:54 PM, Thomas Gleixner wrote:
>>> On Wed, Sep 16 2020 at 12:12, Stefan Bühler wrote:
>>> Can you please provide the output of:
>>>
>>>  for ID in 05:00.0 06:00.0 06:00.1 06:01.0 06:01.1; do lspci -s $ID -vvv; done
>>
>> 05:00.0 PCI bridge: PLX Technology, Inc. PEX8112 x1 Lane PCI Express-to-PCI Bridge (rev aa) (prog-if 00 [Normal decode])
>>      ...
>> 	Capabilities: <access denied>
> 
> Can you please run this as root so the Capabilities are accessible?

My bad, sorry. I did intend to run it as root, but should have checked
the output.  Again see attached file.


While we're at it: the EEPROM for the PEX8112 is:

00000000  5a 03 3c 00 10 00 00 00  00 00 00 00 b5 10 12 81  |Z.<.............|
00000010  64 00 20 00 00 00 00 01  04 00 01 00 0c 10 00 fe  |d. .............|
00000020  fe 03 20 10 f0 10 00 00  00 10 33 00 00 00 70 00  |.. .......3...p.|
00000030  00 00 11 00 48 00 00 00  00 00 34 00 50 00 00 00  |....H.....4.P...|
00000040  04 00 55 66 77 88                                 |..Ufw.|
00000046

(This is what the firmware tool provided to me writes, although I think 
the cards usually came pre-flashed with it.  They gave me the tool 
because on some cards the second function on OX16PCI954 was sometimes 
uninitialized, came up with device id 0x9511 "8-bit bus" 
(PCI_DEVICE_ID_OXSEMI_16PCI95N) and the kernel tries to treat it as UART 
too.)

I think some time ago I found a PDF to decode this here:
https://www.broadcom.com/products/pcie-switches-bridges/pcie-bridges/pex8112#documentation

But the broadcom site is completely broken right now (at least for me; 
there own search for "PEX 8112" links it, but then it says "not found").

Anyway, back then I decoded this to:

- `0x5A 0x03`: Magic Header, contains register and shared memory settings
- `0x003C` = 60 bytes for configs (10 registers):
  - `@0x0010`: `0x00000000` -- BAR0: Locate anywhere in 32-bit
  - `@0x0000`: `0x811210B5` -- Vendor `10B5`, Device `8112` (default)
  - `@0x0064`: `0x00000020` -- Device Capability: Enable "Support 8-bit Tag" field
  - `@0x0100`: `0x00010004` -- Power Budget Enhanced Capability Header (default)
  - `@0x100C`: `0x03FEFE00` -- PCI Control:
    - PCI-To-PCI Express Retry Count set to 0xFE (default: `0x80`)
    - PCI Express-to-PCI Retry Count set to 0xFE (default: `0x00`)
  - `@0x1020`: `0x000010F0` -- GPIO Control
    - GPIO[1-3] Output enable (GPIO[0] is Output enabled by default)
    - GPIO Diagnostic Select: `10b` (default: `01b`)
  - `@0x1000`: `0x00000033` -- Device Initialization (default)
  - `@0x0070`: `0x00110000` -- Link control: default
  - `@0x0048`: `0x00000000` -- Device-Specific Control (default 0)
  - `@0x0034`: `0x00000050` -- PCI Capability pointer `0x50` (default: `0x40`)
    - Skips (disables) Power Management Capability
    - Remaining: MSI and PCI Express
- `0x0004` bytes for shared memory:
  - `0x55`, `0x66`, `0x77`, `0x88`


TLDR: the most notable part probably being "disabling Power Management 
Capability" by the EEPROM.

cheers,
Stefan

--------------C95D686877BEE3CD8901C903
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
VG1yLSBEaXNjVG1yU3RhdC0gRGlzY1RtclNFUlJFbi0KCUNhcGFiaWxpdGllczogWzUwXSBN
U0k6IEVuYWJsZS0gQ291bnQ9MS8xIE1hc2thYmxlLSA2NGJpdCsKCQlBZGRyZXNzOiAwMDAw
MDAwMDAwMDAwMDAwICBEYXRhOiAwMDAwCglDYXBhYmlsaXRpZXM6IFs2MF0gRXhwcmVzcyAo
djEpIFBDSS1FeHByZXNzIHRvIFBDSS9QQ0ktWCBCcmlkZ2UsIE1TSSAwMAoJCURldkNhcDoJ
TWF4UGF5bG9hZCAxMjggYnl0ZXMsIFBoYW50RnVuYyAwCgkJCUV4dFRhZysgQXR0bkJ0bi0g
QXR0bkluZC0gUHdySW5kLSBSQkUtIFNsb3RQb3dlckxpbWl0IDI2LjAwMFcKCQlEZXZDdGw6
CVJlcG9ydCBlcnJvcnM6IENvcnJlY3RhYmxlLSBOb24tRmF0YWwtIEZhdGFsLSBVbnN1cHBv
cnRlZC0KCQkJUmx4ZE9yZC0gRXh0VGFnKyBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9vcC0g
QnJDb25mUnRyeS0KCQkJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRSZXEgNTEyIGJ5
dGVzCgkJRGV2U3RhOglDb3JyRXJyLSBVbmNvcnJFcnIrIEZhdGFsRXJyLSBVbnN1cHBSZXEr
IEF1eFB3ci0gVHJhbnNQZW5kLQoJCUxua0NhcDoJUG9ydCAjMCwgU3BlZWQgMi41R1Qvcywg
V2lkdGggeDEsIEFTUE0gTDBzIEwxLCBFeGl0IExhdGVuY3kgTDBzIDwxdXMsIEwxIDwxNnVz
CgkJCUNsb2NrUE0tIFN1cnByaXNlLSBMTEFjdFJlcC0gQndOb3QtIEFTUE1PcHRDb21wLQoJ
CUxua0N0bDoJQVNQTSBEaXNhYmxlZDsgUkNCIDY0IGJ5dGVzIERpc2FibGVkLSBDb21tQ2xr
LQoJCQlFeHRTeW5jaC0gQ2xvY2tQTS0gQXV0V2lkRGlzLSBCV0ludC0gQXV0QldJbnQtCgkJ
TG5rU3RhOglTcGVlZCAyLjVHVC9zLCBXaWR0aCB4MSwgVHJFcnItIFRyYWluLSBTbG90Q2xr
LSBETEFjdGl2ZS0gQldNZ210LSBBQldNZ210LQoJQ2FwYWJpbGl0aWVzOiBbMTAwIHYxXSBQ
b3dlciBCdWRnZXRpbmcgPD8+CgowNjowMC4wIFNlcmlhbCBjb250cm9sbGVyOiBPeGZvcmQg
U2VtaWNvbmR1Y3RvciBMdGQgT1gxNlBDSTk1NCAoUXVhZCAxNjk1MCBVQVJUKSBmdW5jdGlv
biAwIChVYXJ0KSAocHJvZy1pZiAwNiBbMTY5NTBdKQoJU3Vic3lzdGVtOiBPeGZvcmQgU2Vt
aWNvbmR1Y3RvciBMdGQgT1gxNlBDSTk1NCAoUXVhZCAxNjk1MCBVQVJUKSBmdW5jdGlvbiAw
IChVYXJ0KQoJQ29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3Rlci0gU3BlY0N5Y2xlLSBNZW1X
SU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUisgRmFzdEIyQi0gRGlzSU5U
eC0KCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1t
ZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJ
SW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDE2CglOVU1BIG5vZGU6IDAKCVJlZ2lv
biAwOiBJL08gcG9ydHMgYXQgZTBlMCBbc2l6ZT0zMl0KCVJlZ2lvbiAxOiBNZW1vcnkgYXQg
ZmI0MDcwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9NEtdCglSZWdpb24g
MjogSS9PIHBvcnRzIGF0IGUwYzAgW3NpemU9MzJdCglSZWdpb24gMzogTWVtb3J5IGF0IGZi
NDA2MDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTRLXQoJQ2FwYWJpbGl0
aWVzOiBbNDBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAxCgkJRmxhZ3M6IFBNRUNsay0g
RFNJLSBEMS0gRDIrIEF1eEN1cnJlbnQ9MG1BIFBNRShEMCssRDEtLEQyKyxEM2hvdCssRDNj
b2xkLSkKCQlTdGF0dXM6IEQwIE5vU29mdFJzdC0gUE1FLUVuYWJsZS0gRFNlbD0wIERTY2Fs
ZT0wIFBNRS0KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBzZXJpYWwKCjA2OjAwLjEgQnJpZGdl
OiBPeGZvcmQgU2VtaWNvbmR1Y3RvciBMdGQgT1gxNlBDSTk1NCAoUXVhZCAxNjk1MCBVQVJU
KSBmdW5jdGlvbiAwIChEaXNhYmxlZCkKCVN1YnN5c3RlbTogT3hmb3JkIFNlbWljb25kdWN0
b3IgTHRkIE9YMTZQQ0k5NTQgKFF1YWQgMTY5NTAgVUFSVCkgZnVuY3Rpb24gMCAoRGlzYWJs
ZWQpCglDb250cm9sOiBJL08tIE1lbS0gQnVzTWFzdGVyLSBTcGVjQ3ljbGUtIE1lbVdJTlYt
IFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSKyBGYXN0QjJCLSBEaXNJTlR4LQoJ
U3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkIrIFBhckVyci0gREVWU0VMPW1lZGl1
bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglOVU1B
IG5vZGU6IDAKCVJlZ2lvbiAwOiBJL08gcG9ydHMgYXQgZTBhMCBbZGlzYWJsZWRdIFtzaXpl
PTMyXQoJUmVnaW9uIDE6IE1lbW9yeSBhdCBmYjQwNTAwMCAoMzItYml0LCBub24tcHJlZmV0
Y2hhYmxlKSBbZGlzYWJsZWRdIFtzaXplPTRLXQoJUmVnaW9uIDI6IEkvTyBwb3J0cyBhdCBl
MDgwIFtkaXNhYmxlZF0gW3NpemU9MzJdCglSZWdpb24gMzogTWVtb3J5IGF0IGZiNDA0MDAw
ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtkaXNhYmxlZF0gW3NpemU9NEtdCglDYXBh
YmlsaXRpZXM6IFs0MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDEKCQlGbGFnczogUE1F
Q2xrLSBEU0ktIEQxLSBEMisgQXV4Q3VycmVudD0wbUEgUE1FKEQwKyxEMS0sRDIrLEQzaG90
KyxEM2NvbGQtKQoJCVN0YXR1czogRDAgTm9Tb2Z0UnN0LSBQTUUtRW5hYmxlLSBEU2VsPTAg
RFNjYWxlPTAgUE1FLQoKMDY6MDEuMCBTZXJpYWwgY29udHJvbGxlcjogT3hmb3JkIFNlbWlj
b25kdWN0b3IgTHRkIE9YMTZQQ0k5NTQgKFF1YWQgMTY5NTAgVUFSVCkgZnVuY3Rpb24gMCAo
VWFydCkgKHByb2ctaWYgMDYgWzE2OTUwXSkKCVN1YnN5c3RlbTogT3hmb3JkIFNlbWljb25k
dWN0b3IgTHRkIE9YMTZQQ0k5NTQgKFF1YWQgMTY5NTAgVUFSVCkgZnVuY3Rpb24gMCAoVWFy
dCkKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXItIFNwZWNDeWNsZS0gTWVtV0lOVi0g
VkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlIrIEZhc3RCMkItIERpc0lOVHgtCglT
dGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZTRUw9bWVkaXVt
ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUludGVy
cnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAxNwoJTlVNQSBub2RlOiAwCglSZWdpb24gMDog
SS9PIHBvcnRzIGF0IGUwNjAgW3NpemU9MzJdCglSZWdpb24gMTogTWVtb3J5IGF0IGZiNDAz
MDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTRLXQoJUmVnaW9uIDI6IEkv
TyBwb3J0cyBhdCBlMDQwIFtzaXplPTMyXQoJUmVnaW9uIDM6IE1lbW9yeSBhdCBmYjQwMjAw
MCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT00S10KCUNhcGFiaWxpdGllczog
WzQwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMQoJCUZsYWdzOiBQTUVDbGstIERTSS0g
RDEtIEQyKyBBdXhDdXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMissRDNob3QrLEQzY29sZC0p
CgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQ
TUUtCglLZXJuZWwgZHJpdmVyIGluIHVzZTogc2VyaWFsCgowNjowMS4xIEJyaWRnZTogT3hm
b3JkIFNlbWljb25kdWN0b3IgTHRkIE9YMTZQQ0k5NTQgKFF1YWQgMTY5NTAgVUFSVCkgZnVu
Y3Rpb24gMCAoRGlzYWJsZWQpCglTdWJzeXN0ZW06IE94Zm9yZCBTZW1pY29uZHVjdG9yIEx0
ZCBPWDE2UENJOTU0IChRdWFkIDE2OTUwIFVBUlQpIGZ1bmN0aW9uIDAgKERpc2FibGVkKQoJ
Q29udHJvbDogSS9PLSBNZW0tIEJ1c01hc3Rlci0gU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FT
bm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUisgRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1
czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRB
Ym9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTlVNQSBub2Rl
OiAwCglSZWdpb24gMDogSS9PIHBvcnRzIGF0IGUwMjAgW2Rpc2FibGVkXSBbc2l6ZT0zMl0K
CVJlZ2lvbiAxOiBNZW1vcnkgYXQgZmI0MDEwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJs
ZSkgW2Rpc2FibGVkXSBbc2l6ZT00S10KCVJlZ2lvbiAyOiBJL08gcG9ydHMgYXQgZTAwMCBb
ZGlzYWJsZWRdIFtzaXplPTMyXQoJUmVnaW9uIDM6IE1lbW9yeSBhdCBmYjQwMDAwMCAoMzIt
Yml0LCBub24tcHJlZmV0Y2hhYmxlKSBbZGlzYWJsZWRdIFtzaXplPTRLXQoJQ2FwYWJpbGl0
aWVzOiBbNDBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAxCgkJRmxhZ3M6IFBNRUNsay0g
RFNJLSBEMS0gRDIrIEF1eEN1cnJlbnQ9MG1BIFBNRShEMCssRDEtLEQyKyxEM2hvdCssRDNj
b2xkLSkKCQlTdGF0dXM6IEQwIE5vU29mdFJzdC0gUE1FLUVuYWJsZS0gRFNlbD0wIERTY2Fs
ZT0wIFBNRS0KCg==
--------------C95D686877BEE3CD8901C903--
