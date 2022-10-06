Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9075F6A32
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 17:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiJFPCC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 11:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiJFPCC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 11:02:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000869C7FE;
        Thu,  6 Oct 2022 08:01:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 90A711F85D;
        Thu,  6 Oct 2022 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665068517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SmAmDb37SISjauoN4xpdMA0CBkVXMUvyHWIb/ERmsEQ=;
        b=A1G3cp62M0BwkAiSJtOVQwYsyv0M63UMB5KUE0mHXdg0QNaFplo4nTe2TURanFcH3K2s85
        WPjvT2bZOwg1EpsiLXrX/pZQBi4heYTO1vIujlMcqkEB2TgeiJoJv16yKi9gXhC9jncGaS
        XWoT7yCE8bfwVObe8QyIvER4MOpjhp4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A20A13AC8;
        Thu,  6 Oct 2022 15:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8sihCOXtPmP4eQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 06 Oct 2022 15:01:57 +0000
Message-ID: <d5e199ae-5da8-a25e-ff76-c3a1b05e0a01@suse.com>
Date:   Thu, 6 Oct 2022 17:01:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel@lists.xenproject.org
References: <20221006092929.30041-1-jgross@suse.com>
 <CAKf6xpvS20J0oz6vn+g47OBbKxEhAC8f2gyQ9otj+rOn+L9FOw@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] xen/pcifront: move xenstore config scanning into
 sub-function
In-Reply-To: <CAKf6xpvS20J0oz6vn+g47OBbKxEhAC8f2gyQ9otj+rOn+L9FOw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------YPi0Z3Xsawmw8vnE8qg0Q0OL"
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------YPi0Z3Xsawmw8vnE8qg0Q0OL
Content-Type: multipart/mixed; boundary="------------qsS4Y1csmvwjP5GAoenBHod8";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Bjorn Helgaas <bhelgaas@google.com>, xen-devel@lists.xenproject.org
Message-ID: <d5e199ae-5da8-a25e-ff76-c3a1b05e0a01@suse.com>
Subject: Re: [PATCH] xen/pcifront: move xenstore config scanning into
 sub-function
References: <20221006092929.30041-1-jgross@suse.com>
 <CAKf6xpvS20J0oz6vn+g47OBbKxEhAC8f2gyQ9otj+rOn+L9FOw@mail.gmail.com>
In-Reply-To: <CAKf6xpvS20J0oz6vn+g47OBbKxEhAC8f2gyQ9otj+rOn+L9FOw@mail.gmail.com>

--------------qsS4Y1csmvwjP5GAoenBHod8
Content-Type: multipart/mixed; boundary="------------0GZcOvDTc8ncAvQxBYsj0s8B"

--------------0GZcOvDTc8ncAvQxBYsj0s8B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMTAuMjIgMTU6MjksIEphc29uIEFuZHJ5dWsgd3JvdGU6DQo+IE9uIFRodSwgT2N0
IDYsIDIwMjIgYXQgNToyOSBBTSBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+IHdy
b3RlOg0KPj4NCj4+IHBjaWZyb250X3RyeV9jb25uZWN0KCkgYW5kIHBjaWZyb250X2F0dGFj
aF9kZXZpY2VzKCkgc2hhcmUgYSBsYXJnZQ0KPj4gY2h1bmsgb2YgZHVwbGljYXRlZCBjb2Rl
IGZvciByZWFkaW5nIHRoZSBjb25maWcgaW5mb3JtYXRpb24gZnJvbQ0KPj4gWGVuc3RvcmUs
IHdoaWNoIG9ubHkgZGlmZmVycyByZWdhcmRpbmcgYSBmdW5jdGlvbiBjYWxsLg0KPj4NCj4+
IFB1dCB0aGF0IGNvZGUgaW50byBhIG5ldyBzdWItZnVuY3Rpb24uIFdoaWxlIGF0IGl0IGZp
eCB0aGUgZXJyb3INCj4+IHJlcG9ydGluZyBpbiBjYXNlIHRoZSByb290LXh4IG5vZGUgaGFk
IHRoZSB3cm9uZyBmb3JtYXQuDQo+Pg0KPj4gQXMgdGhlIHJldHVybiB2YWx1ZSBvZiBwY2lm
cm9udF90cnlfY29ubmVjdCgpIGFuZA0KPj4gcGNpZnJvbnRfYXR0YWNoX2RldmljZXMoKSBh
cmUgbm90IHVzZWQgYW55d2hlcmUgbWFrZSB0aG9zZSBmdW5jdGlvbnMNCj4+IHJldHVybiB2
b2lkLiBBcyBhbiBhZGRpdGlvbmFsIGJvbnVzIHRoaXMgcmVtb3ZlcyB0aGUgZHViaW91cyBy
ZXR1cm4NCj4+IG9mIC1FRkFVTFQgaW4gY2FzZSBvZiBhbiB1bmV4cGVjdGVkIGRyaXZlciBz
dGF0ZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3Vz
ZS5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9wY2kveGVuLXBjaWZyb250LmMgfCAxMzMg
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgOTMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL3hlbi1wY2lmcm9udC5jIGIvZHJpdmVycy9wY2kveGVuLXBj
aWZyb250LmMNCj4+IGluZGV4IDY4OTI3MWM0MjQ1Yy4uYTY4ZTQ3ZGNkZDdlIDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9wY2kveGVuLXBjaWZyb250LmMNCj4+ICsrKyBiL2RyaXZlcnMv
cGNpL3hlbi1wY2lmcm9udC5jDQo+PiBAQCAtODE5LDc2ICs4MTksNzkgQEAgc3RhdGljIGlu
dCBwY2lmcm9udF9wdWJsaXNoX2luZm8oc3RydWN0IHBjaWZyb250X2RldmljZSAqcGRldikN
Cj4gDQo+PiAgICAgICAgICBlcnIgPSB4ZW5idXNfc2NhbmYoWEJUX05JTCwgcGRldi0+eGRl
di0+b3RoZXJlbmQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInJvb3RfbnVt
IiwgIiVkIiwgJm51bV9yb290cyk7DQo+PiAgICAgICAgICBpZiAoZXJyID09IC1FTk9FTlQp
IHsNCj4+ICAgICAgICAgICAgICAgICAgeGVuYnVzX2Rldl9lcnJvcihwZGV2LT54ZGV2LCBl
cnIsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIk5vIFBDSSBSb290
cyBmb3VuZCwgdHJ5aW5nIDAwMDA6MDAiKTsNCj4+IC0gICAgICAgICAgICAgICBlcnIgPSBw
Y2lmcm9udF9zY2FuX3Jvb3QocGRldiwgMCwgMCk7DQo+PiArICAgICAgICAgICAgICAgaWYg
KHJlc2NhbikNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGVyciA9IHBjaWZyb250X3Jl
c2Nhbl9yb290KHBkZXYsIDAsIDApOw0KPj4gKyAgICAgICAgICAgICAgIGVsc2UNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGVyciA9IHBjaWZyb250X3NjYW5fcm9vdChwZGV2LCAw
LCAwKTsNCj4gDQo+IEVhcmx5IGluIHBjaWZyb250X3Jlc2Nhbl9yb290KCksIHdlIGhhdmU6
DQo+IA0KPiAgICAgICAgICBiID0gcGNpX2ZpbmRfYnVzKGRvbWFpbiwgYnVzKTsNCj4gICAg
ICAgICAgaWYgKCFiKQ0KPiAgICAgICAgICAgICAgICAgIC8qIElmIHRoZSBidXMgaXMgdW5r
bm93biwgY3JlYXRlIGl0LiAqLw0KPiAgICAgICAgICAgICAgICAgIHJldHVybiBwY2lmcm9u
dF9zY2FuX3Jvb3QocGRldiwgZG9tYWluLCBidXMpOw0KPiANCj4gcGNpZnJvbnRfc2Nhbl9y
b290KCkgZG9lcyBzb21lIGFsbG9jYXRpb24sIGJ1dCB0aGUgbGF0ZXIgc2Nhbm5pbmcNCj4g
bWF0Y2hlcyB0aGF0IG9mIHBjaWZyb250X3Jlc2Nhbl9yb290KCkuICBTbyBJIHRoaW5rIHdl
IGNhbiBqdXN0IGFsd2F5cw0KPiBjYWxsIHBjaWZyb250X3Jlc2Nhbl9yb290KCkgYW5kIGl0
IHNob3VsZCBkbyB0aGUgcmlnaHQgdGhpbmcuICBUaGF0DQo+IGRyb3BzIHRoZSBuZWVkIGZv
ciB0aGUgcmVzY2FuIGJvb2xlYW4uDQoNCkhtbSwgd2l0aCBzb21lIG1vcmUgcGNpZnJvbnRf
cmVzY2FuX3Jvb3QoKSBhZGFwdGlvbiB0aGlzIHdpbGwgbWFrZSBpdA0KcG9zc2libGUgdG8g
ZHJvcCBldmVuIG1vcmUgY29kZSAoaS5lLiB0aGUgQ09ORklHX1BDSV9ET01BSU5TIGNoZWNr
IGluDQpwY2lmcm9udF9yZXNjYW5fcm9vdCgpLCBhcyB0aGUgb25lIGluIHBjaWZyb250X3Nj
YW5fcm9vdCgpIHdvdWxkIGJlDQplbm91Z2ggdGhlbikuDQoNCkknbGwgc2VuZCBvdXQgVjIg
c29vbi4NCg0KPiANCj4gUmVnYXJkbGVzcyBvZiB0aGUgYWJvdmUgaWRlYToNCj4gDQo+IFJl
dmlld2VkLWJ5OiBKYXNvbiBBbmRyeXVrIDxqYW5kcnl1a0BnbWFpbC5jb20+DQoNClRoYW5r
cy4gQXMgSSdtIGFib3V0IHRvIGNoYW5nZSB0aGUgcGF0Y2gsIEknbGwgZHJvcCB0aGUgUi1i
Lg0KDQoNCkp1ZXJnZW4NCg==
--------------0GZcOvDTc8ncAvQxBYsj0s8B
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------0GZcOvDTc8ncAvQxBYsj0s8B--

--------------qsS4Y1csmvwjP5GAoenBHod8--

--------------YPi0Z3Xsawmw8vnE8qg0Q0OL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM+7eQFAwAAAAAACgkQsN6d1ii/Ey+X
vQf7B4D1H8RrO9tYlsBJfV3G+8+r4cVAjjphzFF0aLQa7j82YAnjfU2Ge92pUzRq8BOzcagZaJwr
W5vWP9AOtS3ZLFMQO7igZcoxC/iAgd5UMjCU23hyEDQ7UipGc40y+2SiCKmPBnDdtURKWMrTLg3X
VRhOdnWw71aTJ75kD8p+jPbD/Rw0a7w4OvsaekSuV1j32DVtOkV/3fSkBrzQTMiEadV6K5jdIMM3
VsDU7/5zb8TxKz8f6Yt6jBft2I9gfmN1fpPzpoVlLt0rTQAjpmzC/Ebv9DkDQ4htFSjegTguxEWE
MRb0cBxkzAzgQ2V/kde6esmYXIOLOuNFdVx8CIDBUw==
=xL2k
-----END PGP SIGNATURE-----

--------------YPi0Z3Xsawmw8vnE8qg0Q0OL--
