Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836113FD5C8
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 10:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241528AbhIAImm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 04:42:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46078 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241473AbhIAIml (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Sep 2021 04:42:41 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9331A224EE;
        Wed,  1 Sep 2021 08:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630485704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lY6W7YdH9RogZrDmgUL66tDU5fn1ekzHXvABU8NVPCk=;
        b=FDvA7u95dunxZ++Z2dqjc3UgCCiUDbMy7tOEsomdNbINdaVwegn64JBqyHT11g+CFg3gVG
        oHujdck7oVzYsAogsO2QZ/jC15Qq0r5ThseVCcDRwPx8/ofTetsvSz2daz6p14JUC1VDk4
        2Fd8IAjVnClzuh5EMG/n71Ard5twfI8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3C9CE13A1F;
        Wed,  1 Sep 2021 08:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 1DRsDMg8L2E2DwAAGKfGzw
        (envelope-from <jgross@suse.com>); Wed, 01 Sep 2021 08:41:44 +0000
Subject: Re: [PATCH v2] xen/pcifront: Removed unnecessary __ref annotation
To:     =?UTF-8?Q?Sergio_Migu=c3=a9ns_Iglesias?= <lonyelon@gmail.com>,
        konrad.wilk@oracle.com
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        bhelgaas@google.com, xen-devel@lists.xenproject.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Sergio_Migu=c3=a9ns_Iglesias?= <sergio@lony.xyz>
References: <20210830175305.13370-1-sergio@lony.xyz>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <f954f07b-a973-76a6-5f0e-c2eccb3be92d@suse.com>
Date:   Wed, 1 Sep 2021 10:41:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210830175305.13370-1-sergio@lony.xyz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EIBqyqtMK8vKu3EwJk8AW3qWpsEnLpuIY"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EIBqyqtMK8vKu3EwJk8AW3qWpsEnLpuIY
Content-Type: multipart/mixed; boundary="q5YoPOE5vfxmkzIPMs0UKHG5VMG0bWMJ2";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: =?UTF-8?Q?Sergio_Migu=c3=a9ns_Iglesias?= <lonyelon@gmail.com>,
 konrad.wilk@oracle.com
Cc: boris.ostrovsky@oracle.com, sstabellini@kernel.org, bhelgaas@google.com,
 xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Sergio_Migu=c3=a9ns_Iglesias?=
 <sergio@lony.xyz>
Message-ID: <f954f07b-a973-76a6-5f0e-c2eccb3be92d@suse.com>
Subject: Re: [PATCH v2] xen/pcifront: Removed unnecessary __ref annotation
References: <20210830175305.13370-1-sergio@lony.xyz>
In-Reply-To: <20210830175305.13370-1-sergio@lony.xyz>

--q5YoPOE5vfxmkzIPMs0UKHG5VMG0bWMJ2
Content-Type: multipart/mixed;
 boundary="------------20098A477538115561BD46D1"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------20098A477538115561BD46D1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 30.08.21 19:53, Sergio Migu=C3=A9ns Iglesias wrote:
> An unnecessary "__ref" annotation was removed from the
> "drivers/pci/xen_pcifront.c" file. The function where the annotation
> was used was "pcifront_backend_changed()", which does not call any
> functions annotated as "__*init" nor "__*exit". This makes "__ref"
> unnecessary since this annotation is used to make the compiler ignore
> section miss-matches when they are not happening here in the first
> place.
>=20
> In addition to the aforementioned change, some code style issues were
> fixed in the same file.
>=20
> Signed-off-by: Sergio Migu=C3=A9ns Iglesias <sergio@lony.xyz>

Pushed to xen/tip.git for-linus-5.15


Juergen

--------------20098A477538115561BD46D1
Content-Type: application/pgp-keys;
 name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Transfer-Encoding: quoted-printable
Content-Description: OpenPGP public key
Content-Disposition: attachment;
 filename="OpenPGP_0xB0DE9DD628BF132F.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOBy=
cWx
w3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJvedYm8O=
f8Z
d621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y=
9bf
IhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xq=
G7/
377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR=
3Jv
c3MgPGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsEFgIDA=
QIe
AQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4FUGNQH2lvWAUy+dnyT=
hpw
dtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3TyevpB0CA3dbBQp0OW0fgCetToGIQrg0=
MbD
1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbv=
oPH
Z8SlM4KWm8rG+lIkGurqqu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v=
5QL
+qHI3EIPtyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVyZ=
2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJCAcDAgEGFQgCC=
QoL
BBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4RF7HoZhPVPogNVbC4YA6lW7Dr=
Wf0
teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz78X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC=
/nu
AFVGy+67q2DH8As3KPu0344TBDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0Lh=
ITT
d9jLzdDad1pQSToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLm=
XBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkMnQfvUewRz=
80h
SnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMBAgAjBQJTjHDXAhsDBwsJC=
AcD
AgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJn=
FOX
gMLdBQgBlVPO3/D9R8LtF9DBAFPNhlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1=
jnD
kfJZr6jrbjgyoZHiw/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0=
N51
N5JfVRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwPOoE+l=
otu
fe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK/1xMI3/+8jbO0tsn1=
tqS
EUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuZGU+wsB5BBMBAgAjBQJTjHDrA=
hsD
BwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3=
g3O
ZUEBmDHVVbqMtzwlmNC4k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5=
dM7
wRqzgJpJwK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu5=
D+j
LRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzBTNh30FVKK1Evm=
V2x
AKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37IoN1EblHI//x/e2AaIHpzK5h88N=
Eaw
QsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpW=
nHI
s98ndPUDpnoxWQugJ6MpMncr0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZR=
wgn
BC5mVM6JjQ5xDk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNV=
bVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mmwe0icXKLk=
pEd
IXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0Iv3OOImwTEe4co3c1mwARA=
QAB
wsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMvQ/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEw=
Tbe
8YFsw2V/Buv6Z4Mysln3nQK5ZadD534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1=
vJz
Q1fOU8lYFpZXTXIHb+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8=
VGi
wXvTyJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqcsuylW=
svi
uGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5BjR/i1DG86lem3iBDX=
zXs
ZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------20098A477538115561BD46D1--

--q5YoPOE5vfxmkzIPMs0UKHG5VMG0bWMJ2--

--EIBqyqtMK8vKu3EwJk8AW3qWpsEnLpuIY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmEvPMcFAwAAAAAACgkQsN6d1ii/Ey9B
VQf9GD3+Dkl5gJyccur897+nZfeZsmoMHpvOmfVtaPU0CBegYsJwiGQvBxzxV7p1zx6dHvFPXltS
jD55+SnSAAaLUG8UvaHCERGaKlv+RQBjbJTFnxVbBad3nYanzLfGSyGbNxpJnBJeYWNIpY4Fnxv4
gRZUtpqO6zjYx6O0d3ma9ENVNfG8YOdcGBniQ2HebwrNLc73BZs9sdfD70R/ODxikHd/RpTxqgQA
80P/rein9eYq54aJzTyifGagTyznwZ/cbNr+BNYpAyKEZ28M3D1abgFqYayp6jndrG1JtVEan8Mc
cOU04sAiPy1ErjzFkSZppII+YOmvLdDwHxTeDAoNNA==
=3NDJ
-----END PGP SIGNATURE-----

--EIBqyqtMK8vKu3EwJk8AW3qWpsEnLpuIY--
