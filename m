Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299514E971D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 14:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiC1M42 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 08:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbiC1M41 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 08:56:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25E1B639F
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648472086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n7wqhrqv0FdZ4KBmLjSqSN81JRqAUm2fimeYZD6uZ/4=;
        b=XFn3nBfDRmB2onGjfO8yMdbpCejYhtQj9VV+A9x02RXxe2boGb5Ip9oKrDnBPMdCVO4E7B
        z9BVPLQ4dEHvK4A2O7uJMO+7D/Rc04jxqRkWwYHdczWIV7x3IN+gKLzERkPpQHgVQ0iRIE
        8cR7m269QDwtJJfjg0HLmqtc+pzAHZE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-MZbiEKi3NditsWexenL66g-1; Mon, 28 Mar 2022 08:54:44 -0400
X-MC-Unique: MZbiEKi3NditsWexenL66g-1
Received: by mail-ed1-f69.google.com with SMTP id x1-20020a50f181000000b00418f6d4bccbso8924368edl.12
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 05:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=n7wqhrqv0FdZ4KBmLjSqSN81JRqAUm2fimeYZD6uZ/4=;
        b=bLt+c5rLrVmFP5YQXSqzXe+6KxMjHyOwe/yTkSTE8L7OSvLrtDx55DibCxb3pCwmGU
         XESoELaC5ZNYd83Zq1X/tnexUNoTPyF8n1qAzfe8RKuIx8nZJFhGtSy7Scj7XVPRComH
         zPnrcF7EeC+SkK8y6ba7IYd/fuXc59LKg3qfBAdWB3NIpCRPmgBp9qzTjpMHng9Sp+dL
         gnet1xNoQT+gJ9LcVltSmvHrBFuUU35iyzIxIa/NZoWYCxzrJQ4vTmqI/FVW6H+/J/ER
         u8NPiEwFedVW2UNDkW649wc7e5uBeBXs0m3RUviupuWLEPLmCfoGKeFHLnfnBqZ54Q5S
         oshA==
X-Gm-Message-State: AOAM530gpuEB7rfGPt1I2DHYSC6/El0rqA5wcS7qmhliVH4+vR3VVzdX
        4SsJBjiSkdDtJjT32O2BIsZCgUXAjBwub6qqUdSZsN9D7ordytWvg6mnu0+TeEe7OchuPQ5Ca5d
        mAjv2Cg9MsVgSowsLgWZN
X-Received: by 2002:a05:6402:27d0:b0:419:5184:58ae with SMTP id c16-20020a05640227d000b00419518458aemr16129941ede.314.1648472083476;
        Mon, 28 Mar 2022 05:54:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyniz32Pe6v6boNoET8Zekct+f60xQoaPVtKO7pLnKOe4dIc3kIQJLK6BClAHAwVoMXviSnjg==
X-Received: by 2002:a05:6402:27d0:b0:419:5184:58ae with SMTP id c16-20020a05640227d000b00419518458aemr16129919ede.314.1648472083245;
        Mon, 28 Mar 2022 05:54:43 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id r1-20020a170906550100b006e116636338sm925771ejp.2.2022.03.28.05.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 05:54:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------GuF7eBCn104MUJu5Jqk3XUMq"
Message-ID: <f8e96f8a-c19c-6acd-2f54-688924f491e8@redhat.com>
Date:   Mon, 28 Mar 2022 14:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org
References: <623c13ec.1c69fb81.8cbdb.5a7a@mx.google.com>
 <Yjyv03JsetIsTJxN@sirena.org.uk>
 <4e9fca2f-0af1-3684-6c97-4c35befd5019@redhat.com>
 <Yjzua8Wye/3DHBKx@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Yjzua8Wye/3DHBKx@sirena.org.uk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a multi-part message in MIME format.
--------------GuF7eBCn104MUJu5Jqk3XUMq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/24/22 23:19, Mark Brown wrote:
> On Thu, Mar 24, 2022 at 09:34:30PM +0100, Hans de Goede wrote:
> 
>> Mark, if one of use writes a test patch, can you get that Asus machine to boot a
>> kernel build from next + the test patch ?
> 
> I can't directly unfortunately as the board is in Collabora's lab but
> Guillaume (who's already CCed) ought to be able to, and I can generally
> prod and try to get that done.

Ok, Guillaume, can you try a kernel with commit 5949965ec9340cfc0e65f7d8a576b660b26e2535
("x86/PCI: Preserve host bridge windows completely covered by E820") + the 
attached patch added on top a try on the asus-C523NA-A20057-coral machine please
and see if that makes it boot again ?

Regards,

Hans

--------------GuF7eBCn104MUJu5Jqk3XUMq
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-x86-PCI-Limit-e820-entry-fully-covers-window-check-t.patch"
Content-Disposition: attachment;
 filename*0="0001-x86-PCI-Limit-e820-entry-fully-covers-window-check-t.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiODA4MGE2ZDJkODg5ODQ3OTAwZTE0MDhmNzFkMGMwMWM3M2Y1Yzk0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBNb24sIDI4IE1hciAyMDIyIDE0OjQ3OjQxICswMjAwClN1YmplY3Q6IFtQ
QVRDSF0geDg2L1BDSTogTGltaXQgImU4MjAgZW50cnkgZnVsbHkgY292ZXJzIHdpbmRvdyIg
Y2hlY2sgdG8gbm9uCiBJU0EgTU1JTyBhZGRyZXNzZXMKCkNvbW1pdCBGSVhNRSAoIng4Ni9Q
Q0k6IFByZXNlcnZlIGhvc3QgYnJpZGdlIHdpbmRvd3MgY29tcGxldGVseQpjb3ZlcmVkIGJ5
IEU4MjAiKSBhZGRlZCBhIGNoZWNrIHRvIHNraXAgZTgyMCB0YWJsZSBlbnRyaWVzIHdoaWNo
CmZ1bGx5IGNvdmVyIGEgUENJIGJyaWRlJ3MgbWVtb3J5IHdpbmRvdyB3aGVuIGNsaXBwaW5n
IFBDSSBicmlkZ2UKbWVtb3J5IHdpbmRvd3MuCgpUaGlzIGNoZWNrIGFsc28gY2F1c2VkIElT
QSBNTUlPIHdpbmRvd3MgdG8gbm90IGdldCBjbGlwcGVkIHdoZW4KZnVsbHkgY292ZXJlZCwg
d2hpY2ggaXMgY2F1c2luZyBzb21lIGNvcmVib290IGJhc2VkIENocm9tZWJvb2tzCnRvIG5v
dCBib290LgoKTW9kaWZ5IHRoZSBmdWxseSBjb3ZlcmVkIGNoZWNrIHRvIG5vdCBhcHBseSB0
byBJU0EgTU1JTyB3aW5kb3dzLgoKRml4ZXM6IEZJWE1FICgieDg2L1BDSTogUHJlc2VydmUg
aG9zdCBicmlkZ2Ugd2luZG93cyBjb21wbGV0ZWx5IGNvdmVyZWQgYnkgRTgyMCIpClNpZ25l
ZC1vZmYtYnk6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ci0tLQogYXJj
aC94ODYva2VybmVsL3Jlc291cmNlLmMgfCA2ICsrKysrLQogMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tl
cm5lbC9yZXNvdXJjZS5jIGIvYXJjaC94ODYva2VybmVsL3Jlc291cmNlLmMKaW5kZXggNmJl
ODJlMTZlNWY0Li5kOWVjOTEzNjE5YzMgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9y
ZXNvdXJjZS5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9yZXNvdXJjZS5jCkBAIC00Niw4ICs0
NiwxMiBAQCB2b2lkIHJlbW92ZV9lODIwX3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBz
dHJ1Y3QgcmVzb3VyY2UgKmF2YWlsKQogCQkgKiBkZXZpY2VzLiAgQnV0IGlmIGl0IGNvdmVy
cyB0aGUgKmVudGlyZSogcmVzb3VyY2UsIGl0J3MKIAkJICogbW9yZSBsaWtlbHkganVzdCB0
ZWxsaW5nIHVzIHRoYXQgdGhpcyBpcyBNTUlPIHNwYWNlLCBhbmQKIAkJICogdGhhdCBkb2Vz
bid0IG5lZWQgdG8gYmUgcmVtb3ZlZC4KKwkJICogTm90ZSB0aGlzICplbnRpcmUqIHJlc291
cmNlIGNvdmVyaW5nIGNoZWNrIGlzIG9ubHkKKwkJICogaW50ZW5kZWQgZm9yIDMyIGJpdCBt
ZW1vcnkgcmVzb3VyY2VzIGZvciB0aGUgMTYgYml0CisJCSAqIGlzYSB3aW5kb3cgd2UgYWx3
YXlzIGFwcGx5IHRoZSBlODIwIGVudHJpZXMuCiAJCSAqLwotCQlpZiAoZTgyMF9zdGFydCA8
PSBhdmFpbC0+c3RhcnQgJiYgYXZhaWwtPmVuZCA8PSBlODIwX2VuZCkgeworCQlpZiAoYXZh
aWwtPnN0YXJ0ID49IElTQV9FTkRfQUREUkVTUyAmJgorCQkgICAgZTgyMF9zdGFydCA8PSBh
dmFpbC0+c3RhcnQgJiYgYXZhaWwtPmVuZCA8PSBlODIwX2VuZCkgewogCQkJZGV2X2luZm8o
ZGV2LCAicmVzb3VyY2UgJXBSIGZ1bGx5IGNvdmVyZWQgYnkgZTgyMCBlbnRyeSBbbWVtICUj
MDEwTHgtJSMwMTBMeF1cbiIsCiAJCQkJIGF2YWlsLCBlODIwX3N0YXJ0LCBlODIwX2VuZCk7
CiAJCQljb250aW51ZTsKLS0gCjIuMzUuMQoK
--------------GuF7eBCn104MUJu5Jqk3XUMq--

