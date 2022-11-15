Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85BF628F66
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 02:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiKOBiU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 20:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiKOBiS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 20:38:18 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFAE14035
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 17:38:17 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id m6so12772294pfb.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 17:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uRHwywLkfYgiwyuhM73zhDUeOuHeX3Qo0gMrSbfQ8xs=;
        b=iIqfXYIEfgwIFNgM2TERDByaHq8qCGQOh8URe6ir0a48cJ0SXjL43BvSTvLbafJGEq
         RqJ1TWUYtj9X+RpOXM7aVmNAKM69z9l4ZTcwfgtc0eFpX9EP7wjru18DwoTR8yzInPyf
         djy92bvWhdrjwRcaO/arlG2OM5OFdl859Dz2mBky0ipN30ncS08tavPTDFr9MR/JGLIH
         9adjJaV+MD1aFkSttWd/OFxVbtlllPzDLqOT5oMJ3UTqCxecOllAraK0dWjHIXa/TsJk
         u2vtOOT6JAeiwh76tA0E/tepZVU1Tu7hfPBtilqS3gRRxBQWb1rU36sHV3ASTL+sW/TH
         1G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRHwywLkfYgiwyuhM73zhDUeOuHeX3Qo0gMrSbfQ8xs=;
        b=L5aPhuiAJGGaq8CZB4QL1o5k84H46gR2ND6limNumm2lKWZVb77FGNUwO+sQJg0fLL
         DIL+m9hxpOL+B3021LrjIiJAQUJSVWiqBCn07rMCKwZYnBlH5ZLXdRFmxkvt46l2oNLp
         QA92SThYk6VUaY2XPSLchs33mfJRX9Ab2dCzv0hLv1CrmzTB4IrV0ecB5evfHh5g11hA
         xB4d4txIDxE2FUhcY1oTQC4JYBPKEt3cCH2e6O9L7oZ53oTqzwFT8CUj5iOIAzXfKRJ8
         hUyriMfGF+sWpOaggHpsJ8h3KH3YWQQXev6+jcy28CE4wk65am0fyVTPPbrVlQC0K7+v
         InzA==
X-Gm-Message-State: ANoB5pluXjuqxd3AJHrhgL1OMCvJkxHujLrjGYziEytMV2O7lDtRA6oQ
        mVcRZZ1jGy09aWYpC48pnlWl6uWo4WTI9A==
X-Google-Smtp-Source: AA0mqf6L5Od0UE+/mMOh8VDkag5n+pEDUfNXOM137okchNP3oA17vxrRA4cSIDcdxUgozq1GkmoPUA==
X-Received: by 2002:a62:6283:0:b0:56e:989d:7410 with SMTP id w125-20020a626283000000b0056e989d7410mr16356853pfb.1.1668476296964;
        Mon, 14 Nov 2022 17:38:16 -0800 (PST)
Received: from [10.1.1.173] ([220.244.252.98])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090a020300b00205d85cfb30sm10319525pjc.20.2022.11.14.17.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 17:38:16 -0800 (PST)
Message-ID: <213e1035-b3c7-3d4c-5691-fd936a762745@gmail.com>
Date:   Tue, 15 Nov 2022 12:38:11 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] pci: hotplug: add dependency info to Kconfig
Content-Language: en-AU
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de
References: <20221113112811.22266-1-albert.zhou.50@gmail.com>
 <20221113112811.22266-2-albert.zhou.50@gmail.com>
 <Y3IafGm+ewR5LJL9@black.fi.intel.com>
From:   Albert Zhou <albert.zhou.50@gmail.com>
Autocrypt: addr=albert.zhou.50@gmail.com; keydata=
 xjMEYkX5gxYJKwYBBAHaRw8BAQdAsW8QQjKnmpKC5G1d1QFYNvd9ddMxwYZs+xTT0dyqvtbN
 JkFsYmVydCBaaG91IDxhbGJlcnQuemhvdS41MEBnbWFpbC5jb20+wosEExYIADMWIQRLx2w8
 czp1EBJaieEhj+NExaaGfQUCYkX5gwIbAwULCQgHAgYVCAkKCwIFFgIDAQAACgkQIY/jRMWm
 hn2rKAEAlOVVAsYIpmGTEng+e/HHT7JJjCjcX4lh+pFZdUy2DGgBAM/EwKNYoNB43H5EJpb8
 I68MS+ZZSQ3swJWAu1OJKXIJzjgEYkX5gxIKKwYBBAGXVQEFAQEHQNk/Nf/E1Uttgm29quUB
 Xgc9RDwqKTHbtHLS5SOkZzhUAwEIB8J4BBgWCAAgFiEES8dsPHM6dRASWonhIY/jRMWmhn0F
 AmJF+YMCGwwACgkQIY/jRMWmhn0KRwD7Bv1kWYB2m8c5tRQUg7i3zIaJ4kpfqMj4bwYQ9xEk
 e3oA/11CMCzdPMcoveB279og31mtUISG5mXMDJmiE4y61akN
In-Reply-To: <Y3IafGm+ewR5LJL9@black.fi.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fla4vPxPS9UjVHy0m4Gk0QY3"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fla4vPxPS9UjVHy0m4Gk0QY3
Content-Type: multipart/mixed; boundary="------------0C3LulBXUwkWM38RWSEZQnNn";
 protected-headers="v1"
From: Albert Zhou <albert.zhou.50@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de
Message-ID: <213e1035-b3c7-3d4c-5691-fd936a762745@gmail.com>
Subject: Re: [PATCH v2 1/2] pci: hotplug: add dependency info to Kconfig
References: <20221113112811.22266-1-albert.zhou.50@gmail.com>
 <20221113112811.22266-2-albert.zhou.50@gmail.com>
 <Y3IafGm+ewR5LJL9@black.fi.intel.com>
In-Reply-To: <Y3IafGm+ewR5LJL9@black.fi.intel.com>

--------------0C3LulBXUwkWM38RWSEZQnNn
Content-Type: multipart/mixed; boundary="------------CAE3v5pCZi0B67z8DsU14ZZC"

--------------CAE3v5pCZi0B67z8DsU14ZZC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQvMTEvMjIgMjE6MzcsIE1pa2EgV2VzdGVyYmVyZyB3cm90ZToNCj4+ICsJZGVmYXVs
dCB5IGlmIFVTQjQNCj4+ICAgCWhlbHANCj4+ICAgCSAgU2F5IFkgaGVyZSBpZiB5b3UgaGF2
ZSBhIG1vdGhlcmJvYXJkIHdpdGggYSBQQ0kgSG90cGx1ZyBjb250cm9sbGVyLg0KPj4gICAJ
ICBUaGlzIGFsbG93cyB5b3UgdG8gYWRkIGFuZCByZW1vdmUgUENJIGNhcmRzIHdoaWxlIHRo
ZSBtYWNoaW5lIGlzDQo+PiAtCSAgcG93ZXJlZCB1cCBhbmQgcnVubmluZy4NCj4+ICsJICBw
b3dlcmVkIHVwIGFuZCBydW5uaW5nLiBUaHVuZGVyYm9sdCBhbmQgVVNCNCBQQ0kgY2FyZHMg
cmVxdWlyZQ0KPj4gKwkgIEhvdHBsdWcuDQo+IEkgd291bGQgbm90IHNheSB0aGV5ICJyZXF1
aXJlIiB0aGlzLiBQQ0llIGlzIGNvbXBsZXRlbHkgb3B0aW9uYWwgaW4gVVNCNA0KPiBzeXN0
ZW1zIGFuZCBpdCBpcyBwZXJmZWN0bHkgZmluZSB0byBoYXZlIGhvc3QgY29udHJvbGxlcnMg
b3INCj4gYWRkLWluLWNhcmRzIHRoYXQgZG9uJ3QgaGF2ZSBhIHNpbmdsZSBQQ0llIGFkYXB0
ZXIuDQo+IA0KPiBOb3Qgb2JqZXRpbmcgdGhlIHBhdGNoLCB0aG91Z2guIEZvciBMaW51eCBJ
IGd1ZXNzIGl0IG1ha2VzIHNlbnNlIHRvIGhhdmUNCj4gdGhpcyBsaWtlIHdoYXQgeW91IGFy
ZSBzdWdnZXN0aW5nLiBKdXN0IHBlcmhhcHMgY2hhbmdpbmcgdGhlIHdvcmRpcm5nDQo+IPCf
mIkNCg0KSG93IGFib3V0IOKAnFRodW5kZXJib2x0IGFuZCBVU0I0IHVzZSBIb3RwbHVn4oCd
DQoNCkRvIHlvdSBhZ3JlZSB3aXRoIHRoZSDigJxkZWZhdWx0IHkgaWYgVVNCNOKAnSBmb3Ig
UENJRVBPUlRCVVMsIEhPVFBMVUdfUENJX1BDSUUsIEhPVFBMVUdfUENJLg0KDQogRnJvbSBB
bGJlcnQgWmhvdQ0K
--------------CAE3v5pCZi0B67z8DsU14ZZC
Content-Type: application/pgp-keys; name="OpenPGP_0x218FE344C5A6867D.asc"
Content-Disposition: attachment; filename="OpenPGP_0x218FE344C5A6867D.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEYkX5gxYJKwYBBAHaRw8BAQdAsW8QQjKnmpKC5G1d1QFYNvd9ddMxwYZs+xTT
0dyqvtbNJkFsYmVydCBaaG91IDxhbGJlcnQuemhvdS41MEBnbWFpbC5jb20+wosE
ExYIADMWIQRLx2w8czp1EBJaieEhj+NExaaGfQUCYkX5gwIbAwULCQgHAgYVCAkK
CwIFFgIDAQAACgkQIY/jRMWmhn2rKAEAlOVVAsYIpmGTEng+e/HHT7JJjCjcX4lh
+pFZdUy2DGgBAM/EwKNYoNB43H5EJpb8I68MS+ZZSQ3swJWAu1OJKXIJzjgEYkX5
gxIKKwYBBAGXVQEFAQEHQNk/Nf/E1Uttgm29quUBXgc9RDwqKTHbtHLS5SOkZzhU
AwEIB8J4BBgWCAAgFiEES8dsPHM6dRASWonhIY/jRMWmhn0FAmJF+YMCGwwACgkQ
IY/jRMWmhn0KRwD7Bv1kWYB2m8c5tRQUg7i3zIaJ4kpfqMj4bwYQ9xEke3oA/11C
MCzdPMcoveB279og31mtUISG5mXMDJmiE4y61akN
=3D+2qf
-----END PGP PUBLIC KEY BLOCK-----

--------------CAE3v5pCZi0B67z8DsU14ZZC--

--------------0C3LulBXUwkWM38RWSEZQnNn--

--------------fla4vPxPS9UjVHy0m4Gk0QY3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRLx2w8czp1EBJaieEhj+NExaaGfQUCY3LtgwUDAAAAAAAKCRAhj+NExaaGfSas
AQDEdxJ0eKk2sJeu9knhbuMWWHm4yRWyYZ81kEW2dWsH1wEAoqIvB2FZWV3o1hXloM634nMYS00I
pv41WCerrYUCCQs=
=OHTl
-----END PGP SIGNATURE-----

--------------fla4vPxPS9UjVHy0m4Gk0QY3--
