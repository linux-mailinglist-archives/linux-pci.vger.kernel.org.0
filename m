Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A9C78D18E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Aug 2023 03:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241508AbjH3BLm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 21:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbjH3BLQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 21:11:16 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AF783;
        Tue, 29 Aug 2023 18:11:14 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68bed286169so4309569b3a.1;
        Tue, 29 Aug 2023 18:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693357873; x=1693962673; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=am71R2qky8a6PNSlnd6gAGC+SFc1FXxSFKR0Xr/vvSc=;
        b=pMfInPpcsPSBTNiuG1N/vRUMWsymCo+7tQtn++J3pVRu0X1TfAkUX1ecjveCAtAz3I
         yeQu8SUnRVye//iAcuLyL3WpahedEp9N9PnTR+WUlbMnv862bH3zXyRLBWFv4U5ocROg
         AStz4vGCM2znOQri2lsASghhky3Mxi85BqZlwR6k0XrG/7vvEibVM5dCVIvCZE6HWRIA
         BjB5KgVVqg8Ct6L4N9hvOIVbKRsGlSn/7bzKuklcXs2RgwbMdWLBSBKgGz2l6ZN8T897
         TFWA+OtFRA/q/Jq641quLF/TVjrNw4mZBUTuqE+Ujp1o8tkXDfFd7/WxRfZzgyFfU0Nv
         cgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693357873; x=1693962673;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=am71R2qky8a6PNSlnd6gAGC+SFc1FXxSFKR0Xr/vvSc=;
        b=Y9LTezBOQVwAOlKiErAxARNlr0t/NVbpa4xLasOt/iL2GYsPB79kbFX5nOkkxgU+8N
         h4E/wOnV01N2Ec1B7kBrBB8fCsC8vRPtHWtbB8qJ1y7XXm6z/go3LjUGrbZhzONDJ7Ce
         LRvxkZwlL97gkq3n643pXmnW/sJYN+Q8GQDn4k5zud/ItJfJ/1KP9RUDJPVNTkrlS+DZ
         4ANr55C+LFcIgspyKgOrbgvY+Aa5dO0H1IyrqkFLeE8+idAeiu9Q9lrV0h9dcNW9f7H2
         I5uyYd1Y40FPqlQ9RyAgJZ1ZHVX/LNCcokKW/r26zwq8+Pv4+x+caLH+ph5w/NA30pDU
         lnzA==
X-Gm-Message-State: AOJu0Yw9DQI2vGGdX1gdtnCFmu5/sVLxCq5aI6XnF05okCCPwWjARKFO
        LDgztWS8w9eGBt8hxrWc7Yc=
X-Google-Smtp-Source: AGHT+IGW6Mnz5eiZOzB0GyC2Mxdqc4toEBDK29wnYzzWWxk/0O8RTvhbGwKvv+gZCMgY+cnRZ51JeQ==
X-Received: by 2002:a05:6a20:9497:b0:141:d640:794a with SMTP id hs23-20020a056a20949700b00141d640794amr889158pzb.39.1693357873498;
        Tue, 29 Aug 2023 18:11:13 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id jc17-20020a17090325d100b001aaf2e8b1eesm10032834plb.248.2023.08.29.18.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 18:11:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------aBQJrJJmhb2JJibgl8bG5LWq"
Message-ID: <88ffb216-96f9-f232-7fe5-48bf82e6aa70@gmail.com>
Date:   Wed, 30 Aug 2023 08:11:06 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ajay Agarwal <ajayagarwal@google.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brett Hassall <brett.hassall@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: upstream linux cannot achieve package C8 power saving
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a multi-part message in MIME format.
--------------aBQJrJJmhb2JJibgl8bG5LWq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> v6.5 (and at least v5.15, v5.19 and v6.4 as well) will not go to a higher power saving level than package C3.
> 
> With the inclusion of a patch that combines 3 Ubuntu commits related to VMD ASPM & LTR, package C8 is used.

See Bugzilla for the full thread.

FYI, the attached proposed fix is the same as Brett's another BZ report [2].
I include it for upstreaming.

To Brett: Would you like to submit the proper, formal patch (see
Documentation/process/submitting-patches.rst for details)?

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217841
[2]: https://bugzilla.kernel.org/show_bug.cgi?id=217828

-- 
An old man doll... just what I always wanted! - Clara
--------------aBQJrJJmhb2JJibgl8bG5LWq
Content-Type: text/x-patch; charset=UTF-8; name="proposed.patch"
Content-Disposition: attachment; filename="proposed.patch"
Content-Transfer-Encoding: base64

Y29tbWl0IDk0OTFiZmEwYjFlNWY2NThlMDkxMzU3NTllN2ViYzM3M2Q5YTcyY2UKQXV0aG9y
OiBicmV0dC5oYXNzYWxsIDxicmV0dC5oYXNzYWxsQGdtYWlsLmNvbT4KRGF0ZTogICBUaHUg
QXVnIDI0IDE5OjI2OjM2IDIwMjMgKzEwMDAKCiAgICBjb21iaW5lZCBjb21taXQgb2Y6IDcx
MzE1YjhlIC0gVUJVTlRVOiBTQVVDRTogUENJL0FTUE06IEVuYWJsZSBBU1BNIGZvciBsaW5r
cyB1bmRlciBWTUQgZG9tYWluOyBkODNlNmY2ZSAtICBVQlVOVFU6IFNBVUNFOiBQQ0kvQVNQ
TTogRW5hYmxlIExUUiBmb3IgZW5kcG9pbnRzIGJlaGluZCBWTUQ7IDA2OWQwNTIzIC0gVUJV
TlRVOiBTQVVDRTogdm1kOiBmaXh1cCBicmlkZ2UgQVNQTSBieSBkcml2ZXIgbmFtZSBpbnN0
ZWFkCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpZS9hc3BtLmMgYi9kcml2ZXJzL3Bj
aS9wY2llL2FzcG0uYwppbmRleCA2NmQ3NTE0Y2ExMTEuLjI5ZjJmNjJhYWVmYSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9wY2kvcGNpZS9hc3BtLmMKKysrIGIvZHJpdmVycy9wY2kvcGNpZS9h
c3BtLmMKQEAgLTY4Miw3ICs2ODIsOCBAQCBzdGF0aWMgdm9pZCBwY2llX2FzcG1fY2FwX2lu
aXQoc3RydWN0IHBjaWVfbGlua19zdGF0ZSAqbGluaywgaW50IGJsYWNrbGlzdCkKIAlhc3Bt
X2wxc3NfaW5pdChsaW5rKTsKIAogCS8qIFNhdmUgZGVmYXVsdCBzdGF0ZSAqLwotCWxpbmst
PmFzcG1fZGVmYXVsdCA9IGxpbmstPmFzcG1fZW5hYmxlZDsKKwlsaW5rLT5hc3BtX2RlZmF1
bHQgPSBwYXJlbnQtPmRldl9mbGFncyAmIFBDSV9ERVZfRkxBR1NfRU5BQkxFX0FTUE0gPwor
CQkJICAgICBBU1BNX1NUQVRFX0FMTCA6IGxpbmstPmFzcG1fZW5hYmxlZDsKIAogCS8qIFNl
dHVwIGluaXRpYWwgY2FwYWJsZSBzdGF0ZS4gV2lsbCBiZSB1cGRhdGVkIGxhdGVyICovCiAJ
bGluay0+YXNwbV9jYXBhYmxlID0gbGluay0+YXNwbV9zdXBwb3J0OwpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvcXVpcmtzLmMgYi9kcml2ZXJzL3BjaS9xdWlya3MuYwppbmRleCBjNTI1
ODY3NzYwYmYuLmE3N2UyZTM4ZmE2YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvcXVpcmtz
LmMKKysrIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMKQEAgLTYwNDEsMyArNjA0MSw3MSBAQCBE
RUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHg5YTJkLCBk
cGNfbG9nX3NpemUpOwogREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURf
SU5URUwsIDB4OWEyZiwgZHBjX2xvZ19zaXplKTsKIERFQ0xBUkVfUENJX0ZJWFVQX0hFQURF
UihQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDlhMzEsIGRwY19sb2dfc2l6ZSk7CiAjZW5kaWYK
KworLyoKKyAqIEJJT1MgbWF5IG5vdCBiZSBhYmxlIHRvIGFjY2VzcyBjb25maWcgc3BhY2Ug
b2YgZGV2aWNlcyB1bmRlciBWTUQgZG9tYWluLCBzbworICogaXQgcmVsaWVzIG9uIHNvZnR3
YXJlIHRvIGVuYWJsZSBBU1BNIGZvciBsaW5rcyB1bmRlciBWTUQuCisgKi8KK3N0YXRpYyBi
b29sIHBjaV9maXh1cF9pc192bWRfYnJpZGdlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQorewor
CXN0cnVjdCBwY2lfYnVzICpidXMgPSBwZGV2LT5idXM7CisJc3RydWN0IGRldmljZSAqZGV2
OworCXN0cnVjdCBwY2lfZHJpdmVyICpwZHJ2OworCisJaWYgKCFwY2lfaXNfcm9vdF9idXMo
YnVzKSkKKwkJcmV0dXJuIGZhbHNlOworCisJZGV2ID0gYnVzLT5icmlkZ2UtPnBhcmVudDsK
KwlpZiAoZGV2ID09IE5VTEwpCisJCXJldHVybiBmYWxzZTsKKworCXBkcnYgPSBwY2lfZGV2
X2RyaXZlcih0b19wY2lfZGV2KGRldikpOworCWlmIChwZHJ2ID09IE5VTEwgfHwgc3RyY21w
KCJ2bWQiLCBwZHJ2LT5uYW1lKSkKKwkJcmV0dXJuIGZhbHNlOworCisJcmV0dXJuIHRydWU7
Cit9CisKK3N0YXRpYyB2b2lkIHBjaV9maXh1cF9lbmFibGVfYXNwbShzdHJ1Y3QgcGNpX2Rl
diAqcGRldikKK3sKKwlpZiAoIXBjaV9maXh1cF9pc192bWRfYnJpZGdlKHBkZXYpKQorCQly
ZXR1cm47CisKKwlwZGV2LT5kZXZfZmxhZ3MgfD0gUENJX0RFVl9GTEFHU19FTkFCTEVfQVNQ
TTsKKwlwY2lfaW5mbyhwZGV2LCAiZW5hYmxlIEFTUE0gZm9yIHBjaSBicmlkZ2UgYmVoaW5k
IHZtZCIpOworfQorREVDTEFSRV9QQ0lfRklYVVBfQ0xBU1NfSEVBREVSKFBDSV9WRU5ET1Jf
SURfSU5URUwsIFBDSV9BTllfSUQsCisJCQkgICAgICAgUENJX0NMQVNTX0JSSURHRV9QQ0ks
IDgsIHBjaV9maXh1cF9lbmFibGVfYXNwbSk7CisKK3N0YXRpYyB2b2lkIHBjaV9maXh1cF9l
bmFibGVfdm1kX252bWVfbHRyKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQoreworCXN0cnVjdCBw
Y2lfZGV2ICpwYXJlbnQ7CisJaW50IHBvczsKKwl1MTYgdmFsOworCisJcGFyZW50ID0gcGNp
X3Vwc3RyZWFtX2JyaWRnZShwZGV2KTsKKwlpZiAoIXBhcmVudCkKKwkJcmV0dXJuOworCisJ
aWYgKCFwY2lfZml4dXBfaXNfdm1kX2JyaWRnZShwYXJlbnQpKQorCQlyZXR1cm47CisKKwlw
b3MgPSBwY2lfZmluZF9leHRfY2FwYWJpbGl0eShwZGV2LCBQQ0lfRVhUX0NBUF9JRF9MVFIp
OworCWlmICghcG9zKQorCQlyZXR1cm47CisKKwlwY2lfcmVhZF9jb25maWdfd29yZChwZGV2
LCBwb3MgKyBQQ0lfTFRSX01BWF9TTk9PUF9MQVQsICZ2YWwpOworCWlmICh2YWwpCisJCXJl
dHVybjsKKworCXBjaV9yZWFkX2NvbmZpZ193b3JkKHBkZXYsIHBvcyArIFBDSV9MVFJfTUFY
X05PU05PT1BfTEFULCAmdmFsKTsKKwlpZiAodmFsKQorCQlyZXR1cm47CisKKwkvKiAzMTQ1
NzI4bnMsIGkuZS4gMHgzMDAwMDBucyAqLworCXBjaV93cml0ZV9jb25maWdfd29yZChwZGV2
LCBwb3MgKyBQQ0lfTFRSX01BWF9TTk9PUF9MQVQsIDB4MTAwMyk7CisJcGNpX3dyaXRlX2Nv
bmZpZ193b3JkKHBkZXYsIHBvcyArIFBDSV9MVFJfTUFYX05PU05PT1BfTEFULCAweDEwMDMp
OworCXBjaV9pbmZvKHBkZXYsICJlbmFibGUgTFRSIGZvciBudm1lIGJlaGluZCB2bWQiKTsK
K30KK0RFQ0xBUkVfUENJX0ZJWFVQX0NMQVNTX0VBUkxZKFBDSV9BTllfSUQsIFBDSV9BTllf
SUQsCisJCQkgICAgICBQQ0lfQ0xBU1NfU1RPUkFHRV9FWFBSRVNTLCAwLCBwY2lfZml4dXBf
ZW5hYmxlX3ZtZF9udm1lX2x0cik7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BjaS5o
IGIvaW5jbHVkZS9saW51eC9wY2kuaAppbmRleCA2MGI4NzcyYjViZDQuLmQzZjk2ZDExMTI1
MCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9wY2kuaAorKysgYi9pbmNsdWRlL2xpbnV4
L3BjaS5oCkBAIC0yNDUsNiArMjQ1LDggQEAgZW51bSBwY2lfZGV2X2ZsYWdzIHsKIAlQQ0lf
REVWX0ZMQUdTX05PX1JFTEFYRURfT1JERVJJTkcgPSAoX19mb3JjZSBwY2lfZGV2X2ZsYWdz
X3QpICgxIDw8IDExKSwKIAkvKiBEZXZpY2UgZG9lcyBob25vciBNU0kgbWFza2luZyBkZXNw
aXRlIHNheWluZyBvdGhlcndpc2UgKi8KIAlQQ0lfREVWX0ZMQUdTX0hBU19NU0lfTUFTS0lO
RyA9IChfX2ZvcmNlIHBjaV9kZXZfZmxhZ3NfdCkgKDEgPDwgMTIpLAorCS8qIEVuYWJsZSBB
U1BNIHJlZ2FyZGxlc3Mgb2YgaG93IExua0N0bCBpcyBwcm9ncmFtbWVkICovCisJUENJX0RF
Vl9GTEFHU19FTkFCTEVfQVNQTSA9IChfX2ZvcmNlIHBjaV9kZXZfZmxhZ3NfdCkgKDEgPDwg
MTMpLAogfTsKIAogZW51bSBwY2lfaXJxX3Jlcm91dGVfdmFyaWFudCB7Cg==

--------------aBQJrJJmhb2JJibgl8bG5LWq--
