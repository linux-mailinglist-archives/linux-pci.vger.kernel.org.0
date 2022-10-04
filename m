Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D765F455C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Oct 2022 16:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJDOWM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Oct 2022 10:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJDOWI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2022 10:22:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AA92E9F4;
        Tue,  4 Oct 2022 07:22:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 504711F8F5;
        Tue,  4 Oct 2022 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664893321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=42bi1unQGYn1lsInsXMBa9R0CHgF5/C+iVUDGtawBmc=;
        b=sM4+w5wm4qmhUoUgajvx327zzug1G05RuXW+Ozve2KcaXk1nG48nyFRITpRc7uKKExxbco
        FI7MZ/1TAXQpoVh9XfM1axCF+Aeh7ItQxUASGNIlBOGv7n+rnKeMZYIzrMFFpU+9De7iOK
        /YFILCftFlrLicVz5P9qm9l38Yjn4SE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A976139EF;
        Tue,  4 Oct 2022 14:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IFEaBYlBPGOBdAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 14:22:01 +0000
Message-ID: <5aae9e7f-e2b4-f9b1-5357-eb648a9a9e0e@suse.com>
Date:   Tue, 4 Oct 2022 16:22:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] xen-pcifront: Handle missed Connected state
Content-Language: en-US
To:     Jason Andryuk <jandryuk@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220829151536.8578-1-jandryuk@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220829151536.8578-1-jandryuk@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------T110oCLNUe9jPKZIVpvY2h0i"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------T110oCLNUe9jPKZIVpvY2h0i
Content-Type: multipart/mixed; boundary="------------0Tg5yDesGhz24HIrkQaYeHGk";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jason Andryuk <jandryuk@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <5aae9e7f-e2b4-f9b1-5357-eb648a9a9e0e@suse.com>
Subject: Re: [PATCH] xen-pcifront: Handle missed Connected state
References: <20220829151536.8578-1-jandryuk@gmail.com>
In-Reply-To: <20220829151536.8578-1-jandryuk@gmail.com>

--------------0Tg5yDesGhz24HIrkQaYeHGk
Content-Type: multipart/mixed; boundary="------------s0SqXfzRTGnu0nAxhdf0bXGd"

--------------s0SqXfzRTGnu0nAxhdf0bXGd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkuMDguMjIgMTc6MTUsIEphc29uIEFuZHJ5dWsgd3JvdGU6DQo+IEFuIEhWTSBndWVz
dCB3aXRoIGxpbnV4IHN0dWJkb20gYW5kIDIgUENJIGRldmljZXMgZmFpbGVkIHRvIHN0YXJ0
IGFzDQo+IGxpYnhsIHRpbWVkIG91dCB3YWl0aW5nIGZvciB0aGUgUENJIGRldmljZXMgdG8g
YmUgYWRkZWQuICBJdCBoYXBwZW5zDQo+IGludGVybWl0dGVudGx5IGJ1dCB3aXRoIHNvbWUg
cmVndWxhcml0eS4gIGxpYnhsIHdyb3RlIHRoZSB0d28geGVuc3RvcmUNCj4gZW50cmllcyBm
b3IgdGhlIGRldmljZXMsIGJ1dCB0aGVuIHRpbWVkIG91dCB3YWl0aW5nIGZvciBiYWNrZW5k
IHN0YXRlIDQNCj4gKENvbm5lY3RlZCkgLSB0aGUgc3RhdGUgc3RheWVkIGF0IDcgKFJlY29u
ZmlndXJpbmcpLiAgKFBDSSBwYXNzdGhyb3VnaA0KPiB0byBhbiBIVk0gd2l0aCBzdHViZG9t
YWluIGlzIFBWIHBhc3N0aHJvdWdoIHRvIHRoZSBzdHViZG9tYWluIGFuZCB0aGVuDQo+IEhW
TSBwYXNzdGhyb3VnaCB3aXRoIHRoZSBRRU1VIGluc2lkZSB0aGUgc3R1YmRvbWFpbi4pDQo+
IA0KPiBUaGUgc3R1YmRvbSBrZXJuZWwgbmV2ZXIgcHJpbnRlZCAicGNpZnJvbnQgcGNpLTA6
IEluc3RhbGxpbmcgUENJDQo+IGZyb250ZW5kIiwgc28gaXQgc2VlbXMgdG8gaGF2ZSBtaXNz
ZWQgc3RhdGUgNCB3aGljaCB3b3VsZCBoYXZlDQo+IGNhbGxlZCBwY2lmcm9udF90cnlfY29u
bmVjdCAtPiBwY2lmcm9udF9jb25uZWN0X2FuZF9pbml0X2RtYQ0KPiANCj4gSGF2ZSBwY2lm
cm9udF9kZXRhY2hfZGV2aWNlcyBzcGVjaWFsLWNhc2Ugc3RhdGUgSW5pdGlhbGlzZWQgYW5k
IGNhbGwNCj4gcGNpZnJvbnRfY29ubmVjdF9hbmRfaW5pdF9kbWEuICBEb24ndCB1c2UgcGNp
ZnJvbnRfdHJ5X2Nvbm5lY3QgYmVjYXVzZQ0KPiB0aGF0IHNldHMgdGhlIHhlbmJ1cyBzdGF0
ZSB3aGljaCBtYXkgdGhyb3cgb2ZmIHRoZSBiYWNrZW5kLiAgQWZ0ZXINCj4gY29ubmVjdGlu
Zywgc2tpcCB0aGUgcmVtYWluZGVyIG9mIGRldGFjaF9kZXZpY2VzIHNpbmNlIG5vbmUgaGF2
ZSBiZWVuDQo+IGluaXRpYWxpemVkIHlldC4gIFdoZW4gdGhlIGJhY2tlbmQgc3dpdGNoZXMg
dG8gUmVjb25maWd1cmVkLA0KPiBwY2lmcm9udF9hdHRhY2hfZGV2aWNlcyB3aWxsIHBpY2sg
dGhlbSB1cCBhZ2Fpbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphc29uIEFuZHJ5dWsgPGph
bmRyeXVrQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9z
c0BzdXNlLmNvbT4NCg0KVGhlIG1vZGlmaWNhdGlvbnMgb2YgdGhlIGNvbW1pdCBtZXNzYWdl
IHJlcXVlc3RlZCBieSBCam9ybiBjYW4gYmUgZG9uZQ0Kd2hpbGUgY29tbWl0dGluZy4NCg0K
DQpKdWVyZ2VuDQoNCg==
--------------s0SqXfzRTGnu0nAxhdf0bXGd
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------s0SqXfzRTGnu0nAxhdf0bXGd--

--------------0Tg5yDesGhz24HIrkQaYeHGk--

--------------T110oCLNUe9jPKZIVpvY2h0i
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM8QYgFAwAAAAAACgkQsN6d1ii/Ey/o
yQf9ErjOFLhQE8b16zbrUJQVyiHzAMtNdoDmjSqLu0wb32KeMI+QvbXJwKSBa2EZqFJ3vMF6LMTO
i5kBCMmyd84LD7Jk7X8aZkWbj1QyYjcwNikyDGM1unGjS2ivdDJmEW+hGpJfJHwYHEJqljrzyYI0
0+tzXXMfhG81yFY75AWcyzgB/DEsDxuqyv/IVWfvUvjjM2XWd2O72HGrK5eMWql9tRDyQ+c5lcs9
zKi1WEc91kq7xRpTi5rjeOrKV9qs1QJN/EYhAFfiAeGD7Aom6uMScPQGi0D2adCZk4KOctpT1x9X
0Tmnx4tyXcyEkqOyy98BxafW/v7l1RR6TmUAtzrwyw==
=pPlS
-----END PGP SIGNATURE-----

--------------T110oCLNUe9jPKZIVpvY2h0i--
