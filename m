Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5A1403FB0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 21:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347517AbhIHTT1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 15:19:27 -0400
Received: from mout.web.de ([212.227.17.11]:38513 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350364AbhIHTTR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Sep 2021 15:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631128680;
        bh=XMJaA7hii4lFc1Oj17PE9d7UW6EqtSsUIIEhWk8AqBI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WIcahJKGkTECPUEPYpOVpy1VXf9LEabv5YACbzQFeAt3r87Ol8pnZF+VKl8ghmvFg
         D1/TaPdeXsBGY3d5+YNecsAMHHz4Um5wQHuG01/v5Nv3CTqeGNLWTJU6o0QqYB5jr9
         Yw8jge+8aSjt5GyOo3GsaVGwNHFdxo9J6UvkFyN8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.2.57] ([178.4.39.147]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LqDUa-1mt0Bc1OkK-00dk5D; Wed, 08
 Sep 2021 21:18:00 +0200
Subject: Re: QCA6174 pcie wifi: Add pci quirks
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210415195338.icpo5644bo76rzuc@pali>
 <20210525221215.GA1235899@bjorn-Precision-5520>
 <20210721085453.aqd73h22j6clzcfs@pali> <20210820232217.vkx6x6dpxf73jjhs@pali>
From:   Ingmar Klein <ingmar_klein@web.de>
Message-ID: <408e5b45-3eaa-fa13-318d-48f7d1ecdacf@web.de>
Date:   Wed, 8 Sep 2021 21:18:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210820232217.vkx6x6dpxf73jjhs@pali>
Content-Type: multipart/mixed;
 boundary="------------8F75D64A73209E14D253E132"
X-Provags-ID: V03:K1:pY8ItFlZSveZnCXTfyeoOs4lTLV8C5lBKgnbxZHxTebUZkleDK3
 yZWLczb/0B92Axng+roAAx6a8Ib9fKTLRRtOtVedblT4zQoWQ6vcnXCFFLrhWZeh/KSrtXP
 LBgv+JBaUh5Q/b2hcCyC9S5phnZfILhJ4FnmP1MjVc+VJ5X7Z0rwEI2vkaW/12JoX1INshE
 4QhqSK84o9TW+2V08emYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k0T3c47LDwg=:OGHawUgsP2bkL7NW0GwQ+L
 WZHDpq8BBavsRTT9XAGpcT64bLPFmSykYFMXjh/1Q5exGX4UyOm+IzR/sSDXQU32c43nNgc4W
 +z6XzaCtYABZtCwh6uhx6W2YXg877rohn7o1FwZPP/BJRwzLZ+vGCjZKgJc6w+bLF7uf/q0bk
 363wMGs8+axkC5AQKZTfqTCLIQIzyTnQWEjazs1vZzrUgw2zi1kcxD20JjmjjzIVNLrvvPIVj
 r95bVGfLYfdAj7HZRuDgFfmYfUgrueXXGhfxtjjL76rhSY7C3OSc9mr6N2LedzG7QfZKesY9b
 Q2MRfdgDECpOaMuwbMUJQYnffIbgsY7+q4V/YezO2UrUqAZYrJ8yuVDH0P3gCi/I5NcTogBS0
 tC1iWd0W7d6K6j7UTLRP04kemSY03jfIvp5iaIQzco0GrQ+dbxHTjq8v4B78u1+oT9yormnp+
 GbT+b1uoZV6wtdRL91hrw8spqrWmf2vCklnCVkXfb94LKHEOOhOMqkXceLpjYBrSi5dCnVUiR
 e0Vx1fB9umUxj9Nsmh1pdwZGRC0xvYxi28uhh0ELzjSa8oA6IM1xIX5GVZUdQLWCEo2dRgON7
 ewryJBqekYYDGe/atUZqPKDE0hoMNqQcGB64dUrP5iX4B9WOGiN5y48bH+Eo2HB5bdEYthefb
 2eY6WLADw1GEZRN11/GotIdNr28hws9Q0K/oybSo7t1cvJ1jYqQInuJlKwc1csBeK1yUhfK/3
 7oqzR7tqlpF48OtAIjhGnaKmYiaExTsJLaNGtdvb4Na8ow+q2na4wIMN09usPs8YbNGqQ0inB
 9vZUgEzIasE3dmAjyh1l58WO3mpYkghuR3KU8bsZj/7tfB+cHsSqaK7+6tu9JC6MbSvJ58c0b
 kyUD/uGzog80RbL1pgWVzKOiduAqhBiWcWf3t0wTk2GFzQgHypYwhZmiJz+IZCo39GPwpgVEl
 bsje4j+SN4Yz6EARvjaLUhgqK51rwQOIjANZhoso9jAILsnXTD4nLiNkw7sashUNM6LNqQZYB
 SfxUpYctL2ZFxVm4Cj/RsbT/U+bfZxqwSRXLwhr+MBjTfx+/RtCEsJRHszlsnlvuK2YnbMuFe
 RfLLP0upp/iUjs=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a multi-part message in MIME format.
--------------8F75D64A73209E14D253E132
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Am 21.08.2021 um 01:22 schrieb Pali Roh=C3=A1r:
> On Wednesday 21 July 2021 10:54:53 Pali Roh=C3=A1r wrote:
>> On Tuesday 25 May 2021 17:12:15 Bjorn Helgaas wrote:
>>> On Thu, Apr 15, 2021 at 09:53:38PM +0200, Pali Roh=C3=A1r wrote:
>>>> Hello!
>>>>
>>>> On Thursday 15 April 2021 13:01:19 Alex Williamson wrote:
>>>>> [cc +Pali]
>>>>>
>>>>> On Thu, 15 Apr 2021 20:02:23 +0200
>>>>> Ingmar Klein <ingmar_klein@web.de> wrote:
>>>>>
>>>>>> First thanks to you both, Alex and Bjorn!
>>>>>> I am in no way an expert on this topic, so I have to fully rely on =
your
>>>>>> feedback, concerning this issue.
>>>>>>
>>>>>> If you should have any other solution approach, in form of patch-se=
t, I
>>>>>> would be glad to test it out. Just let me know, what you think migh=
t
>>>>>> make sense.
>>>>>> I will wait for your further feedback on the issue. In the meantime=
 I
>>>>>> have my current workaround via quirk entry.
>>>>>>
>>>>>> By the way, my layman's question:
>>>>>> Do you think, that the following topic might also apply for the QCA=
6174?
>>>>>> https://www.spinics.net/lists/linux-pci/msg106395.html
>>>> I have been testing more ath cards and I'm going to send a new versio=
n
>>>> of this patch with including more PCI ids.
>>> Dropping this patch in favor of Pali's new version.
>> Hello Bjorn! Seems that it would take much more time to finish my
>> version of patch. So could you take Ingmar's patch with cc:stable tag
>> for now, which just adds PCI device id into list of problematic devices=
?
> Ping, gentle reminder...

Hi Pali and Bjorn,

here is the original trivial patch again.
For the moment, this could do.

Thank you!
Best regards,
Ingmar


--------------8F75D64A73209E14D253E132
Content-Type: text/plain; charset=UTF-8;
 name="qualcomm_qca6174_add_pci_quirks_signed_off.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="qualcomm_qca6174_add_pci_quirks_signed_off.patch"

U2lnbmVkLW9mZi1ieTogSW5nbWFyIEtsZWluIDxpbmdtYXJfa2xlaW5Ad2ViLmRlPgoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3F1aXJrcy5jIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMK
aW5kZXggNzA2ZjI3YTg2YThlLi5lY2ZlODBlYzViOWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
cGNpL3F1aXJrcy5jCisrKyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jCkBAIC0zNTg0LDYgKzM1
ODQsNyBAQCBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9BVEhFUk9T
LCAweDAwMzIsIHF1aXJrX25vX2J1c19yZXNldCk7CiBERUNMQVJFX1BDSV9GSVhVUF9IRUFE
RVIoUENJX1ZFTkRPUl9JRF9BVEhFUk9TLCAweDAwM2MsIHF1aXJrX25vX2J1c19yZXNldCk7
CiBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9BVEhFUk9TLCAweDAw
MzMsIHF1aXJrX25vX2J1c19yZXNldCk7CiBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJ
X1ZFTkRPUl9JRF9BVEhFUk9TLCAweDAwMzQsIHF1aXJrX25vX2J1c19yZXNldCk7CitERUNM
QVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9BVEhFUk9TLCAweDAwM2UsIHF1
aXJrX25vX2J1c19yZXNldCk7CiAKIC8qCiAgKiBSb290IHBvcnQgb24gc29tZSBDYXZpdW0g
Q044eHh4IGNoaXBzIGRvIG5vdCBzdWNjZXNzZnVsbHkgY29tcGxldGUgYSBidXMK
--------------8F75D64A73209E14D253E132--
