Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A128B839EB
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 21:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfHFT5P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 15:57:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:59827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfHFT5P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Aug 2019 15:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565121390;
        bh=DsIqcheZq2E+baxpbFyRNd0674tff2lEsv+Ru11Kfcw=;
        h=X-UI-Sender-Class:From:To:Cc:References:Subject:Date:In-Reply-To;
        b=fdFuV57T+uwRmtPYGFOVXNRaqL3EuaYEGZ+o+PeisjQDWKrZDpUoDPlnT383J+r7y
         1Wp0uFl/r4ir6RPD30hIk0xFnL3/Vs0qE+fD47r1d/xmHydgVtNlAzbHeF4V2Nr8+t
         XdlntuacbCGbiesXMphFNuTnroAwHvs5tLZgV07k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mandree.no-ip.org ([79.229.32.156]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQXN-1iDJH63TUb-00sQ5N; Tue, 06
 Aug 2019 21:56:29 +0200
Received: from ryzen.an3e.de (localhost [IPv6:::1])
        by ryzen.an3e.de (Postfix) with ESMTP id CBE1D120172;
        Tue,  6 Aug 2019 21:56:27 +0200 (CEST)
From:   Matthias Andree <matthias.andree@gmx.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
References: <2857501d-c167-547d-c57d-d5d24ea1f1dc@molgen.mpg.de>
 <20190806093626.GF2548@lahna.fi.intel.com>
 <acca5213-7d8b-7db1-ff3c-cb5b4a704f04@molgen.mpg.de>
 <20190806113154.GS2548@lahna.fi.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.andree@gmx.de; prefer-encrypt=mutual; keydata=
 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
 H29L93g/7fa+B3v7
Subject: Re: [Regression] pcie_wait_for_link_delay (1132.853 ms @ 5039.414431)
Message-ID: <f1093e5c-2b90-c61c-7fed-437abda6ec6a@gmx.de>
Date:   Tue, 6 Aug 2019 21:56:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806113154.GS2548@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-GB
X-Provags-ID: V03:K1:d5M3dTdtVuZqSOW9cZ5gR6wA2AbaXKx/buD7s0MDLZcZCJFlEMJ
 UHHqpjtxD9+KuIXI5eo3sqO9M8vzPbE1S/pBs9pe7eU9AenTf3x9MCOyUGxgvDdAU/mHa07
 Rmd7LyTdGBElr/g8CX13R9sQOrJvDgo5yeWIFWy1DTXHHml8UeLkjV3IfdcHHn510dJrfGT
 5Cou4CvciEpuw8NWZ1Bjg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lsn9kpLXRGI=:MQS1ChqH/vLMqXIS7Kw+zV
 YIPv3fXRvsTVPSqyuIPHojy96u5KrWcVlHyumRbpb92xLnPHJTh0VeMEt/ZHGJ39mU4TyxuEd
 SFPitLgEnjEaM1DvuCT4QUUonA5LotBrjLkTKpg+zAItbIX9J2SHI7VpHFsFD9lAlhErpxL7h
 cboHLF/tvrhcFEMQDI/acTIE7iPnbiSnBwXvBszqxqDksWiuKPYNOsrgQAiJONLke9hJzlMYm
 u2qZBrfPLgTxLqAPUvL4Bo+r4gamD5H+GO4c2fAjLxvUp8AhqEKKzn0a4iOR3N7ytAqji1/5T
 QAwG9STYZxL4EQZxXYOkYifcNIWNq88NrDgBcy0P7MTEhQ4TFZh9hjCJ6rsEMhqiBEpCUMKXn
 Ej5fnpso6Sz2Q8EUAv7cHzqNesyn9vpmikUzR+fwpZkcIrODbjfSBHtC90J2/bfhTSPXOFZiT
 NfR7Bjr5OzbpZlyyNZNwDx5R5x/X+hWhEViPc6888yZHh20MLGpFlkgBb7Tl0R4nJMUnjD6BU
 6HLB2PviI8kram9UPiO25k+38AyaH7cng743BtZVqqm95yLnUocSqJDLLU6ndkE4ljVfyH0wj
 PdNQ5kFA4TfkhCKL5s8o6+21juV15uYb1hPFyub+sKa1zuU8CK/wUEu8uDGr68fJGoRM5f+j+
 01uiNha1Iwj+ZfrPsCyPB4xz+HQUyC17lFEvV+7oQmwcrL+/aTgG+BxFej8H0OdAWkABOvjId
 HCFi6HyrsOcU04ducebyXm9xsopo1fAcfqyYZJdA4b47iOVdFi1Yptoog3uTA+2DRQR6iQy/W
 TwI5FTXpQLROChUfU6XfcXt6StGeDOdT5KdtXTjc3OqY01vLX+ONuuLqMp1DuB6mgXvlYQ9Jt
 zn9cyKYvX3KF4gW5Jfv55R0y8EG75ZkvmWpCaKO2CggHdRc3tZZ/bH0I4FXchjjE6Er4ZaPXl
 RPbt2TSCrrrzG8kKGJifpf+yRLXH5L/+E2RlnW3SmC8TpzRC8ZhqpOOW/swDoLqK+1guKTTFp
 EkRxjNfJErEkTy9JTN8TilNtlO+KmN6JX0IX0qrXJjfUa5Cs743S2VVvh+AnkISsL+uPBRomX
 zPF1IzVwh+squfrmvPlCtc8oKIM94t9ZvKMbnG6YSdcb+rzg01yUl5bUIVuirmctgawc5KRyi
 3CW8M=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

TWlrYSwKCnJldmlld2luZyB0aGUgY29kZSBpbiB5b3VyIGNvbW1pdCwgY2FuIHdlIGRvdWJs
ZS1jaGVjayB0aGUgIiEiIGluICJpZgooIXBkZXYtPmltbV9yZWFkeSkiIGhlcmU/Cgo+IHN0
YXRpYyBpbnQgZ2V0X2Rvd25zdHJlYW1fZGVsYXkoc3RydWN0IHBjaV9idXMgKmJ1cykKPiB7
Cj7CoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBwY2lfZGV2ICpwZGV2Owo+wqDCoMKgwqDCoMKg
wqDCoCBpbnQgbWluX2RlbGF5ID0gMTAwOwo+wqDCoMKgwqDCoMKgwqDCoCBpbnQgbWF4X2Rl
bGF5ID0gMDsKPgo+wqDCoMKgwqDCoMKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KHBkZXYs
ICZidXMtPmRldmljZXMsIGJ1c19saXN0KSB7Cj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAoIXBkZXYtPmltbV9yZWFkeSkKCkkgaGF2ZSB6ZXJvIGNsdWUgb2YgUENJ
IChFeHByZXNzKSwgYnV0IHJlYWRpbmcgb3RoZXIgcGFydHMgb2YgeW91ciBwYXRjaCwKSSB0
aGluayBtaW5fZGVsYXkgc2hvdWxkIGJlIHplcm9lZCBpZiBpbW1fcmVhZHkgaXMgMSAoY3Vy
cmVudGx5IGl0IGlzCnplcm9lZCBpZiBpbW1fcmVhZHkgPT0gMCksCnVubGVzcyB0aGUgaGVh
ZGVyIGZpbGUgaGFzIGEgbWlzbGVhZGluZyBjb21tZW50LgoKKEkgaGFkIHRyaWVkIHJlbW92
aW5nIHRoZSAhIGJ1dCB0aGF0IGRpZG4ndCBmaXggbXkgc3lzdGVtLikKCj7CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWluX2RlbGF5ID0gMDsK
PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UgaWYgKHBkZXYtPmQzY29s
ZF9kZWxheSA8IG1pbl9kZWxheSkKPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBtaW5fZGVsYXkgPSBwZGV2LT5kM2NvbGRfZGVsYXk7Cj7CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocGRldi0+ZDNjb2xkX2RlbGF5ID4g
bWF4X2RlbGF5KQo+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG1heF9kZWxheSA9IHBkZXYtPmQzY29sZF9kZWxheTsKPsKgwqDCoMKgwqDCoMKg
wqAgfQo+Cj7CoMKgwqDCoMKgwqDCoMKgIHJldHVybiBtYXgobWluX2RlbGF5LCBtYXhfZGVs
YXkpOwo+IH0KClJlZ2FyZHMsCk1hdHRoaWFzCgo=
