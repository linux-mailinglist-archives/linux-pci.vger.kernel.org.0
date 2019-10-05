Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 866C1CC89C
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2019 09:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfJEHf6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Oct 2019 03:35:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:34785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfJEHf6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Oct 2019 03:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570260890;
        bh=IqQBTN6oLYYEnwtUFxRtOkUgGK+FmQ6e9thND80bFq4=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=XHbk02TnbXHPZwtiY8yuWoNwUI0PH4DX/vKQ5MeBCL8TCGB6InOkIKTOgCloXM08F
         DeLqMq/8qX2TF4v4TPCnqmOJRIyu646wwFqmbRgBeLiFgQKOjxUoHT7J0fkii4jqjx
         7hYlEQijc4iPQN4shxxC/LDe9heCBt0RU6znXVW8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mandree.no-ip.org ([79.229.35.161]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwwZX-1htN4M3Nu7-00yRvH; Sat, 05
 Oct 2019 09:34:49 +0200
Received: from ryzen.an3e.de (localhost [IPv6:::1])
        by ryzen.an3e.de (Postfix) with ESMTP id 971FA12016F;
        Sat,  5 Oct 2019 09:34:46 +0200 (CEST)
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191004123947.11087-1-mika.westerberg@linux.intel.com>
 <811277ae-bec1-1724-23ce-c13407bd79c5@gmx.de>
 <20191004130619.GI2819@lahna.fi.intel.com>
From:   Matthias Andree <matthias.andree@gmx.de>
Autocrypt: addr=matthias.andree@gmx.de; prefer-encrypt=mutual; keydata=
 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
 H29L93g/7fa+B3v7
Subject: Re: [PATCH v2 0/2] PCI: Add missing link delays
Message-ID: <ed169065-1a2a-4729-b052-6ec8b1bf4835@gmx.de>
Date:   Sat, 5 Oct 2019 09:34:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191004130619.GI2819@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US
X-Provags-ID: V03:K1:ZMNMSxUMs8fmmT5e5U6y/XzFo0OfMPy1T5Ua+QB0bskh3sKEvuU
 Wi5143jkMLewDKe+vhYcEfg86q1Chsycg56rEjAygfwefgvsiJ5iyfKv8HjvE43egC173TN
 Q6tIT4Q5BrGeR/aSb5RiC9eM+XWHMpJm5oQ4w1ZeK8+2wRh5gHdCE37hLIVZxLuT1ZUMs/U
 QDIxiKwsL0ZyjiY9Gs8xw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V5W0EYn0jc8=:S6VvYiugYlUr/2qySqEZWo
 ZEHOy9A4BEy95W5u/3tBeM8nbf0HjrB35dRpOWWGNKFoSmnxgTsgb+T5IIyedrU+HADwlgJ29
 9FYRlx6rtG/uKrqapOG+BU8CBUqifui8gWtpQnTw4uy/GZOcowyfDJ9yFNyWSJnLug4i1TpCb
 ZFuY4LWJD5sSOLkqO+hSv6Z1u/bFiqrPUrgZWO1+UDSdyMsurW9REIASCextXdmGTeo62VhGQ
 T44B9/lD5JCi8lm7mMGgRV8HKC2E0oshg+6n2LkKrYWNEUUk/VXfWWJsTfc/kDfCZgTeTCJnz
 pEhdhQVwE9Hcr6+lU3qKHED1lwL6xxqQHJIjhfM1eKSrwe7dcIlufhErIIGMxBMolKHokMmgj
 7XoSyR6pDbAApFUC+qJKrK72rR6mnBCaf5CATjH7zYkBMPNPK7LBcLsGxUrHHphwM6HiVWGTs
 sNFijNWKLJGIKYn2vK2fjUFoeztMMvO2F1gROslAAC+S7HDNZdJIJuc5skR+RdFZiQWBShUFA
 yh/9lVIzykQHHhnu6k8t4uBeUUZRf2073eVRU8/gf1QbqpLScwqMkQ+h9tv5HUOYwfjIRmY4e
 VGcfh6FpTXx+ihL5Mgie6M6noA3uxotIm1LThwWCDCHND/yurwmi8GjjhAt3mfdlrY2kYZBRJ
 FGsR6EApwJEKzh0DSR7N81/LJ6TkNDX7AJlB4aY5JeV328P4ZGEXBq1YP0B+AIESQcID3nKm9
 SGm+TJLKsahocWtixq2JCiq+chTsQPdwGbG8lhqGPohj+is7ozt0RlaulM1VHNneKaE/IwnWd
 YZsHGPjp4QWTtviTIZF6c0wLRoUnnfj3hqwxAAgzIyPyoyLO2Ln1RyeQoJO81B4LjVh5D9D3M
 oIMmKzuu12B/K5+wgcbfTXj0KFCqmmJIH7W+cQIWSYPjIVfuoLr5sAFwT7oj3RIc3utyYEL28
 w7cYeOe/8ggGEE1lPcjLyQYBTkXWnqWrQbM01vhYwMZc0n9DLyDP6eH5bWiHZulR+GjmY0sb0
 glqxHClSM894HGG8dgkKAsQabgmMpaC+8Vb3gGxWllorQCMi9cdc0bnqcwLvIBhUQHH7rTKha
 fjSYs3SMrOgrp68EWP/r8cWYz+sRlT8uvpF4EEgcofyy12lTKVqnRFkcXpm1RuFDNvX8yYH+Q
 1HPVH5X1B+8WXFw4MPAPzI5Sl1PQVvI+4cE+5kxzmNrDDVfNTbhYiWbojhVqGdfrTUP+ss84U
 UOqqADI/ezkmD5jK3IPJgp4iwlirrD3hCV/MfQFrscS474rEeVGbrknxJ3No=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QW0gMDQuMTAuMTkgdW0gMTU6MDYgc2NocmllYiBNaWthIFdlc3RlcmJlcmc6Cj4gT24gRnJp
LCBPY3QgMDQsIDIwMTkgYXQgMDI6NTc6MjFQTSArMDIwMCwgTWF0dGhpYXMgQW5kcmVlIHdy
b3RlOgo+PiBBbSAwNC4xMC4xOSB1bSAxNDozOSBzY2hyaWViIE1pa2EgV2VzdGVyYmVyZzoK
Pj4+IEBNYXR0aGlhcywgQFBhdWwgYW5kIEBOaWNob2xhcywgSSBhcHByZWNpYXRlIGlmIHlv
dSBjb3VsZCBjaGVjayB0aGF0IHRoaXMKPj4+IGRvZXMgbm90IGNhdXNlIGFueSBpc3N1ZXMg
Zm9yIHlvdXIgc3lzdGVtcy4KPj4gSnVzdCB0byBiZSBzdXJlOiBpcyB0aGlzIGludGVuZGVk
IHRvIGJlIGFwcGxpZWQgYWdhaW5zdCB0aGUgNS40LXJjKgo+PiBtYXN0ZXIgYnJhbmNoPwo+
IFllcywgaXQgYXBwbGllcyBvbiB0b3Agb2YgdjUuNC1yYzEuCgpJIGFtIHNvcnJ5IHRvIHNh
eSB0aGF0IEkgY2Fubm90IGN1cnJlbnRseSB0ZXN0IC0gbXkgY29tcHV0ZXIgaGFzIGEKR2VG
b3JjZSAxMDYwLTZHQiBhbiBubyBvbmJvYXJkL29uLWNoaXAgZ3JhcGhpY3MuClRoZSBudmlk
aWEgbW9kdWxlIDQzNS4yMSBkb2VzIG5vdCBjb21waWxlIGFnYWluc3QgNS40LXJjKiBmb3Ig
bWUgKDUuMy4xCndhcyBmaW5lKS4KCkZvciBzb21lIHJlYXNvbnMgSSBkb24ndCB1bmRlcnN0
YW5kLCBpdCBmaXJzdCBjb21wbGFpbnMgYWJvdXQgbWlzc2luZyBvcgplbXB0ecKgIE1vZHVs
ZS5zeW12ZXJzLCAod2hpY2ggSSBkbyBoYXZlIGFuZCB3aGljaCBoYXMgMTI5NjcgbGluZXMp
CmFuZCBpZiBJIGJ5cGFzcyB0aGF0IGNoZWNrLCBpdCBjb21wbGFpbnMgYWJvdXQgdW5kZWNs
YXJlZCBEUklWRVJfUFJJTUUKImhlcmUgKG91dHNpZGUgYSBmdW5jdGlvbikiIC0gc29ycnkg
Zm9yIHRoZSBHZXJtYW4gbG9jYWxlOgoKL3Zhci9saWIvZGttcy9udmlkaWEvNDM1LjIxL2J1
aWxkL252aWRpYS1kcm0vbnZpZGlhLWRybS1kcnYuYzo2NjI6NDQ6CkZlaGxlcjogwrtEUklW
RVJfUFJJTUXCqyBpc3QgaGllciAoYXXDn2VyaGFsYiBlaW5lciBGdW5rdGlvbikgbmljaHQK
ZGVrbGFyaWVydDsgbWVpbnRlbiBTaWUgwrtEUklWRVJfUENJX0RNQcKrPwrCoCA2NjIgfMKg
wqDCoMKgIC5kcml2ZXJfZmVhdHVyZXPCoMKgwqDCoMKgwqDCoCA9IERSSVZFUl9HRU0gfCBE
UklWRVJfUFJJTUUgfApEUklWRVJfUkVOREVSLArCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+fn5+fn4KwqDCoMKgwqDCoCB8wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRFJJVkVSX1BDSV9ETUEKCkkgbmVlZCBOT1QgdHJ5
IHRoaXMgaGFyZHdhcmUgd2l0aG91dCBudmlkaWEgcHJvcHJpZXRhcnkgZHJpdmVyLCBub3V2
ZWF1CmhhcyBhbHdheXMgYmVlbiB1bmRlcmZlYXR1cmVkIGFuZCBJIG5ldmVyIGdvdCBzdXNw
ZW5kL3Jlc3VtZSB3b3JraW5nCndpdGggaXQsIHNvIEkgZG9uJ3QgYm90aGVyIGVsc2UgaXQg
d291bGQgc2tldyB0aGUgZmluZGluZ3MuCgooU29tZW9uZSBsZXQgbWUga25vdyBpZiBzd2l0
Y2hpbmcgdG8gQU1EIDV4MDAgKFhUKSBpcyB3b3J0aHdoaWxlIG9yCnByZW1hdHVyZS4gVmVn
YSBhbmQgZWFybGllciBjb25zdW1lIHdheSB0b28gbXVjaCBwb3dlciB0byBib3RoZXIuIEkn
bQpub3QgYnV5aW5nIGEgbmV3IFBTVS4pCgoK
