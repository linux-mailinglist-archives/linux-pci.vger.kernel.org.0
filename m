Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6470FABB
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbjEXPsQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 11:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbjEXPsH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 11:48:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4223DE48;
        Wed, 24 May 2023 08:47:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C9F981F88C;
        Wed, 24 May 2023 15:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684943265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x7bQfub+mU8p72YGXdoxNHqyjDrsX69NoywxvxclMH8=;
        b=ZLIakZ7u2CeMvr4oXafV/pMx8QWHodGRVKibG2FSPeYru2saQa2v1oWy38l99Sn2qykzSu
        NHDQTj1egp/RtLTElQ92rCeW6T36wPDDbiPVC8Lx0Ty+Se0oSxZgPtV6S7mNkKmk1I7jxP
        IGOxYR7eaeECip5vg1o5V2ha9UFKqpk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D263133E6;
        Wed, 24 May 2023 15:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CsNdFaExbmRyUgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 24 May 2023 15:47:45 +0000
Message-ID: <c0f7cf97-f7ea-83f2-3a9c-f77f82dfb689@suse.com>
Date:   Wed, 24 May 2023 17:47:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] x86/pci/xen: populate MSI sysfs entries
Content-Language: en-US
To:     Maximilian Heyne <mheyne@amazon.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230503131656.15928-1-mheyne@amazon.de>
 <20230524154330.GA52988@dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230524154330.GA52988@dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tY7iSs0AlaL6tDi0XFsZuMcH"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------tY7iSs0AlaL6tDi0XFsZuMcH
Content-Type: multipart/mixed; boundary="------------h7YXw7ZzpCvooqKrwptAHfub";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Maximilian Heyne <mheyne@amazon.de>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marc Zyngier <maz@kernel.org>, "Ahmed S. Darwish" <darwi@linutronix.de>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <c0f7cf97-f7ea-83f2-3a9c-f77f82dfb689@suse.com>
Subject: Re: [PATCH] x86/pci/xen: populate MSI sysfs entries
References: <20230503131656.15928-1-mheyne@amazon.de>
 <20230524154330.GA52988@dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com>
In-Reply-To: <20230524154330.GA52988@dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com>

--------------h7YXw7ZzpCvooqKrwptAHfub
Content-Type: multipart/mixed; boundary="------------mkAVHjLtPHiTlxZTuoU0N2Fu"

--------------mkAVHjLtPHiTlxZTuoU0N2Fu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMDUuMjMgMTc6NDMsIE1heGltaWxpYW4gSGV5bmUgd3JvdGU6DQo+IE9uIFdlZCwg
TWF5IDAzLCAyMDIzIGF0IDAxOjE2OjUzUE0gKzAwMDAsIE1heGltaWxpYW4gSGV5bmUgd3Jv
dGU6DQo+PiBDb21taXQgYmY1ZTc1OGYwMmZjICgiZ2VuaXJxL21zaTogU2ltcGxpZnkgc3lz
ZnMgaGFuZGxpbmciKSByZXdvcmtlZCB0aGUNCj4+IGNyZWF0aW9uIG9mIHN5c2ZzIGVudHJp
ZXMgZm9yIE1TSSBJUlFzLiBUaGUgY3JlYXRpb24gdXNlZCB0byBiZSBpbg0KPj4gbXNpX2Rv
bWFpbl9hbGxvY19pcnFzX2Rlc2NzX2xvY2tlZCBhZnRlciBjYWxsaW5nIG9wcy0+ZG9tYWlu
X2FsbG9jX2lycXMuDQo+PiBUaGVuIGl0IG1vdmVkIGludG8gX19tc2lfZG9tYWluX2FsbG9j
X2lycXMgd2hpY2ggaXMgYW4gaW1wbGVtZW50YXRpb24gb2YNCj4+IGRvbWFpbl9hbGxvY19p
cnFzLiBIb3dldmVyLCBYZW4gY29tZXMgd2l0aCB0aGUgb25seSBvdGhlciBpbXBsZW1lbnRh
dGlvbg0KPj4gb2YgZG9tYWluX2FsbG9jX2lycXMgYW5kIGhlbmNlIGRvZXNuJ3QgcnVuIHRo
ZSBzeXNmcyBwb3B1bGF0aW9uIGNvZGUNCj4+IGFueW1vcmUuDQo+Pg0KPj4gQ29tbWl0IDZj
Nzk2OTk2ZWU3MCAoIng4Ni9wY2kveGVuOiBGaXh1cCBmYWxsb3V0IGZyb20gdGhlIFBDSS9N
U0kNCj4+IG92ZXJoYXVsIikgc2V0IHRoZSBmbGFnIE1TSV9GTEFHX0RFVl9TWVNGUyBmb3Ig
dGhlIHhlbiBtc2lfZG9tYWluX2luZm8NCj4+IGJ1dCB0aGF0IGRvZXNuJ3QgYWN0dWFsbHkg
aGF2ZSBhbiBlZmZlY3QgYmVjYXVzZSBYZW4gdXNlcyBpdCdzIG93bg0KPj4gZG9tYWluX2Fs
bG9jX2lycXMgaW1wbGVtZW50YXRpb24uDQo+Pg0KPj4gRml4IHRoaXMgYnkgbWFraW5nIHVz
ZSBvZiB0aGUgZmFsbGJhY2sgZnVuY3Rpb25zIGZvciBzeXNmcyBwb3B1bGF0aW9uLg0KPj4N
Cj4+IEZpeGVzOiBiZjVlNzU4ZjAyZmMgKCJnZW5pcnEvbXNpOiBTaW1wbGlmeSBzeXNmcyBo
YW5kbGluZyIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBNYXhpbWlsaWFuIEhleW5lIDxtaGV5bmVA
YW1hem9uLmRlPg0KPiANCj4gDQo+IEFueSBvdGhlciBmZWVkYmFjayBvbiB0aGlzIG9uZT8g
VGhpcyBpcyBkZWZpbml0ZWx5IGEgYnVnIGJ1dCBJIHVuZGVyc3RhbmQgdGhhdA0KPiB0aGVy
ZSBtaWdodCBiZSBkaWZmZXJlbnQgd2F5cyB0byBmaXggaXQuDQoNCkknZCBiZSBoYXBweSB0
byB0YWtlIHRoZSBwYXRjaCB2aWEgdGhlIFhlbiB0cmVlLCBidXQgSSB0aGluayB4ODYgbWFp
bnRhaW5lcnMNCnNob3VsZCBhdCBsZWFzdCBhY2sgdGhhdC4NCg0KDQpKdWVyZ2VuDQoNCg==

--------------mkAVHjLtPHiTlxZTuoU0N2Fu
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------mkAVHjLtPHiTlxZTuoU0N2Fu--

--------------h7YXw7ZzpCvooqKrwptAHfub--

--------------tY7iSs0AlaL6tDi0XFsZuMcH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRuMaAFAwAAAAAACgkQsN6d1ii/Ey/d
XQf+MHz9Oxk6qpS+Bteq2DR9mN3i32YwO+FxkAYG+F7obmnMtxktZFz4kLUeOW0JfyXIyZt4lE5i
CqCvVRcD9Ip8cJFlWGQH3n4pZPskE5J4bd0emu5zZJkSV6SZIFWmJwRpOPY4H2vx/Wi5jJgP+JDN
SRMbAe8K5JtW3nwky4hH3gGNBV20b4Z2JcI33AlS5rTvjjeQZBvFs+dFLtHCK6u/iLDfVQCEkO5p
+yeE3eUFdKTnaWxpFhkFSHz7PGLYSC7xsCKsrUbA4wcldye6xNu6vJTeMes5x+q48w9WUr10OtFD
VqxWSY0jO7BxQbw2+lmL9SX4aKIp7zHDkhwDt58LBw==
=8m3b
-----END PGP SIGNATURE-----

--------------tY7iSs0AlaL6tDi0XFsZuMcH--
