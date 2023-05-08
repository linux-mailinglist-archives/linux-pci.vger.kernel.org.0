Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E3A6FB46F
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 17:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjEHPxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 11:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjEHPxe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 11:53:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6610F97;
        Mon,  8 May 2023 08:53:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02C4F21DB3;
        Mon,  8 May 2023 15:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683561209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=enCmPKVL/QYyWJsvjc1siLNro32aXyEZpjP4ToWLEys=;
        b=ithED1KI1jXI4dpx1wT8kE5Q567qTNV290ZWYDHVsYekplRXDrxtJQ+EvU5F7c90fBjv19
        TB5/cxMwkMWg5B9aAl5f6H/hSokrfNUEno+6Xt156PNgM0Dk2JrTcpTPyZexNh7ip4e8ou
        tWXTL7Rb7w06LMHD/hNPWswPX0spdsY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 809EE1346B;
        Mon,  8 May 2023 15:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y8mUHfgaWWQfOQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 08 May 2023 15:53:28 +0000
Message-ID: <3ce78def-659c-a3c2-3633-26e5b0a212b1@suse.com>
Date:   Mon, 8 May 2023 17:53:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] x86/pci/xen: populate MSI sysfs entries
Content-Language: en-US
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ashok Raj <ashok.raj@intel.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230503131656.15928-1-mheyne@amazon.de>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230503131656.15928-1-mheyne@amazon.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qUSNF0DqSSSO09uggR0ul3al"
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qUSNF0DqSSSO09uggR0ul3al
Content-Type: multipart/mixed; boundary="------------2VgdL2ARHnFdKP06t0hm3NRa";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Marc Zyngier <maz@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Ashok Raj <ashok.raj@intel.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <3ce78def-659c-a3c2-3633-26e5b0a212b1@suse.com>
Subject: Re: [PATCH] x86/pci/xen: populate MSI sysfs entries
References: <20230503131656.15928-1-mheyne@amazon.de>
In-Reply-To: <20230503131656.15928-1-mheyne@amazon.de>

--------------2VgdL2ARHnFdKP06t0hm3NRa
Content-Type: multipart/mixed; boundary="------------5l1refLpYoFuAkuHwmsfSyyJ"

--------------5l1refLpYoFuAkuHwmsfSyyJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMDUuMjMgMTU6MTYsIE1heGltaWxpYW4gSGV5bmUgd3JvdGU6DQo+IENvbW1pdCBi
ZjVlNzU4ZjAyZmMgKCJnZW5pcnEvbXNpOiBTaW1wbGlmeSBzeXNmcyBoYW5kbGluZyIpIHJl
d29ya2VkIHRoZQ0KPiBjcmVhdGlvbiBvZiBzeXNmcyBlbnRyaWVzIGZvciBNU0kgSVJRcy4g
VGhlIGNyZWF0aW9uIHVzZWQgdG8gYmUgaW4NCj4gbXNpX2RvbWFpbl9hbGxvY19pcnFzX2Rl
c2NzX2xvY2tlZCBhZnRlciBjYWxsaW5nIG9wcy0+ZG9tYWluX2FsbG9jX2lycXMuDQo+IFRo
ZW4gaXQgbW92ZWQgaW50byBfX21zaV9kb21haW5fYWxsb2NfaXJxcyB3aGljaCBpcyBhbiBp
bXBsZW1lbnRhdGlvbiBvZg0KPiBkb21haW5fYWxsb2NfaXJxcy4gSG93ZXZlciwgWGVuIGNv
bWVzIHdpdGggdGhlIG9ubHkgb3RoZXIgaW1wbGVtZW50YXRpb24NCj4gb2YgZG9tYWluX2Fs
bG9jX2lycXMgYW5kIGhlbmNlIGRvZXNuJ3QgcnVuIHRoZSBzeXNmcyBwb3B1bGF0aW9uIGNv
ZGUNCj4gYW55bW9yZS4NCj4gDQo+IENvbW1pdCA2Yzc5Njk5NmVlNzAgKCJ4ODYvcGNpL3hl
bjogRml4dXAgZmFsbG91dCBmcm9tIHRoZSBQQ0kvTVNJDQo+IG92ZXJoYXVsIikgc2V0IHRo
ZSBmbGFnIE1TSV9GTEFHX0RFVl9TWVNGUyBmb3IgdGhlIHhlbiBtc2lfZG9tYWluX2luZm8N
Cj4gYnV0IHRoYXQgZG9lc24ndCBhY3R1YWxseSBoYXZlIGFuIGVmZmVjdCBiZWNhdXNlIFhl
biB1c2VzIGl0J3Mgb3duDQo+IGRvbWFpbl9hbGxvY19pcnFzIGltcGxlbWVudGF0aW9uLg0K
PiANCj4gRml4IHRoaXMgYnkgbWFraW5nIHVzZSBvZiB0aGUgZmFsbGJhY2sgZnVuY3Rpb25z
IGZvciBzeXNmcyBwb3B1bGF0aW9uLg0KPiANCj4gRml4ZXM6IGJmNWU3NThmMDJmYyAoImdl
bmlycS9tc2k6IFNpbXBsaWZ5IHN5c2ZzIGhhbmRsaW5nIikNCj4gU2lnbmVkLW9mZi1ieTog
TWF4aW1pbGlhbiBIZXluZSA8bWhleW5lQGFtYXpvbi5kZT4NCg0KUmV2aWV3ZWQtYnk6IEp1
ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQoNCg==
--------------5l1refLpYoFuAkuHwmsfSyyJ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------5l1refLpYoFuAkuHwmsfSyyJ--

--------------2VgdL2ARHnFdKP06t0hm3NRa--

--------------qUSNF0DqSSSO09uggR0ul3al
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRZGvgFAwAAAAAACgkQsN6d1ii/Ey93
MQf/cxKVXhKe0gAEAMln7DmZGr6S7zdybp9iDiXoHMLt9maAVZlKd7AoiwoDqsSRJCkaxoZWtPfC
1ShfFUXQrH3X+RXM0xoOZbwErxXDCnT06ZAtV4muq8RUWfw6wTppfnvd0t0WxuYhEtvdbU40zH0u
+K26n/zsBHSUygZ6kpnHLvMAI/BarkuOamBar8fkKQ3SxhKdOtpNWSn7UgmyvO0tDyepG3GciLy6
cMrI5ibjjWIOeOJD93KNpihT0QlSlVVfQ2MYr58QUyTmi4VLtIJ2LPI/H6whMc1d399u16pzjpfJ
gIE01xfP/1/0PoBJhnL3Y+9LNzY1ZGzF/iKfnTxP7Q==
=cQFh
-----END PGP SIGNATURE-----

--------------qUSNF0DqSSSO09uggR0ul3al--
