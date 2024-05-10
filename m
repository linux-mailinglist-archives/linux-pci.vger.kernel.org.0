Return-Path: <linux-pci+bounces-7325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 569B88C1F43
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 09:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D9D1C20D41
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 07:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A64415F322;
	Fri, 10 May 2024 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mCpBEAvr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mCpBEAvr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2C515ECEF;
	Fri, 10 May 2024 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715327314; cv=none; b=hoYBW8RGn2BXrbW8UPuYKqgyXkN+1cBD7gkjiqhU90RPVSBxymYorzI7V1PHDHCwfd+nJwsIQ27gW/31knMPfTm11iABmB2Oln2mntH94o0h8JXweEQdShu7Wx0MnDaU9sVEchEejrVEzFlKIUiogMT1sKuYdzxntIfB66ILyZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715327314; c=relaxed/simple;
	bh=OegCOaYo2ZMoCAcon3ZgxTonFDo/ULoFAXa2mqPDvU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A21ObKNZV6jfChCijpjjxnuf6snLgygrBLuvDZQLXsAHA+jvRqsnds19j2+ZRiy4gTEZmZKdp0fOslR1TLOmjtHCTLKlE3xX52N+1SfiiWrJOlldFSb8r7DD2TNORPrv4MKpJ7vueyuyjUzFyzOjXb7EzaSEfB2OgzGWc2r+UZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mCpBEAvr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mCpBEAvr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53F4161170;
	Fri, 10 May 2024 07:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715327310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OegCOaYo2ZMoCAcon3ZgxTonFDo/ULoFAXa2mqPDvU8=;
	b=mCpBEAvrYi4ed7oOhfELeIGhqjHno4X1j+Ev95BGTQLyQDoZDV87aCDznsyrezYd15EavY
	MY9gpbhdbUR7FOIT0A3vEkqps5LtOAOQAU2LsXAL9BDWscarb0VD7B0KbJ+ow+nyZSiyNY
	mUciW46qpReBmJhWOq0DMpf3hx+ShC8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mCpBEAvr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715327310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OegCOaYo2ZMoCAcon3ZgxTonFDo/ULoFAXa2mqPDvU8=;
	b=mCpBEAvrYi4ed7oOhfELeIGhqjHno4X1j+Ev95BGTQLyQDoZDV87aCDznsyrezYd15EavY
	MY9gpbhdbUR7FOIT0A3vEkqps5LtOAOQAU2LsXAL9BDWscarb0VD7B0KbJ+ow+nyZSiyNY
	mUciW46qpReBmJhWOq0DMpf3hx+ShC8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E754913A44;
	Fri, 10 May 2024 07:48:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bEe3Nk3RPWbhFwAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 10 May 2024 07:48:29 +0000
Message-ID: <9ebdcc0b-3775-4c5e-9ffb-f45d048281dd@suse.com>
Date: Fri, 10 May 2024 09:48:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC KERNEL PATCH v6 2/3] xen/pvh: Setup gsi for passthrough
 device
To: Jiqian Chen <Jiqian.Chen@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc: xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 Huang Rui <Ray.Huang@amd.com>
References: <20240419033616.607889-1-Jiqian.Chen@amd.com>
 <20240419033616.607889-3-Jiqian.Chen@amd.com>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20240419033616.607889-3-Jiqian.Chen@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Knae4IyoLuapUbvuflU12aH9"
X-Spam-Level: 
X-Spamd-Result: default: False [-8.40 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 53F4161170
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -8.40

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Knae4IyoLuapUbvuflU12aH9
Content-Type: multipart/mixed; boundary="------------O3s0i0TBCQzGkMudaipiCF2z";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc: xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 Huang Rui <Ray.Huang@amd.com>
Message-ID: <9ebdcc0b-3775-4c5e-9ffb-f45d048281dd@suse.com>
Subject: Re: [RFC KERNEL PATCH v6 2/3] xen/pvh: Setup gsi for passthrough
 device
References: <20240419033616.607889-1-Jiqian.Chen@amd.com>
 <20240419033616.607889-3-Jiqian.Chen@amd.com>
In-Reply-To: <20240419033616.607889-3-Jiqian.Chen@amd.com>

--------------O3s0i0TBCQzGkMudaipiCF2z
Content-Type: multipart/mixed; boundary="------------SncFPlxTg8DkoLMqUFXsOL99"

--------------SncFPlxTg8DkoLMqUFXsOL99
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMDQuMjQgMDU6MzYsIEppcWlhbiBDaGVuIHdyb3RlOg0KPiBJbiBQVkggZG9tMCwg
dGhlIGdzaXMgZG9uJ3QgZ2V0IHJlZ2lzdGVyZWQsIGJ1dCB0aGUgZ3NpIG9mDQo+IGEgcGFz
c3Rocm91Z2ggZGV2aWNlIG11c3QgYmUgY29uZmlndXJlZCBmb3IgaXQgdG8gYmUgYWJsZSB0
byBiZQ0KPiBtYXBwZWQgaW50byBhIGRvbVUuDQo+IA0KPiBXaGVuIGFzc2lnbiBhIGRldmlj
ZSB0byBwYXNzdGhyb3VnaCwgcHJvYWN0aXZlbHkgc2V0dXAgdGhlIGdzaQ0KPiBvZiB0aGUg
ZGV2aWNlIGR1cmluZyB0aGF0IHByb2Nlc3MuDQo+IA0KPiBDby1kZXZlbG9wZWQtYnk6IEh1
YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEppcWlhbiBD
aGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPiBSZXZpZXdlZC1ieTogU3RlZmFubyBTdGFi
ZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPg0KDQpUaGlzIHBhdGNoIGlzIGJyZWFr
aW5nIHRoZSBidWlsZC4NCg0KT24gQXJtIEkgZ2V0Og0KDQpJbiBmaWxlIGluY2x1ZGVkIGZy
b20gL2hvbWUvZ3Jvc3Mva29yZy9zcmMvZHJpdmVycy94ZW4veGVuLXBjaWJhY2svcGNpX3N0
dWIuYzoyMzowOg0KL2hvbWUvZ3Jvc3Mva29yZy9zcmMvaW5jbHVkZS94ZW4vYWNwaS5oOiBJ
biBmdW5jdGlvbiAneGVuX2FjcGlfc2xlZXBfcmVnaXN0ZXInOg0KL2hvbWUvZ3Jvc3Mva29y
Zy9zcmMvaW5jbHVkZS94ZW4vYWNwaS5oOjY3OjM6IGVycm9yOiAnYWNwaV9zdXNwZW5kX2xv
d2xldmVsJyANCnVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlk
IHlvdSBtZWFuICd4ZW5fYWNwaV9zdXNwZW5kX2xvd2xldmVsJz8NCiAgICBhY3BpX3N1c3Bl
bmRfbG93bGV2ZWwgPSB4ZW5fYWNwaV9zdXNwZW5kX2xvd2xldmVsOw0KICAgIF5+fn5+fn5+
fn5+fn5+fn5+fn5+fg0KICAgIHhlbl9hY3BpX3N1c3BlbmRfbG93bGV2ZWwNCi9ob21lL2dy
b3NzL2tvcmcvc3JjL2luY2x1ZGUveGVuL2FjcGkuaDo2NzozOiBub3RlOiBlYWNoIHVuZGVj
bGFyZWQgaWRlbnRpZmllciANCmlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5j
dGlvbiBpdCBhcHBlYXJzIGluDQptYWtlWzZdOiAqKiogWy9ob21lL2dyb3NzL2tvcmcvc3Jj
L3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjQ0OiANCmRyaXZlcnMveGVuL3hlbi1wY2liYWNr
L3BjaV9zdHViLm9dIEVycm9yIDENCm1ha2VbNV06ICoqKiBbL2hvbWUvZ3Jvc3Mva29yZy9z
cmMvc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0ODU6IA0KZHJpdmVycy94ZW4veGVuLXBjaWJh
Y2tdIEVycm9yIDINCm1ha2VbNF06ICoqKiBbL2hvbWUvZ3Jvc3Mva29yZy9zcmMvc2NyaXB0
cy9NYWtlZmlsZS5idWlsZDo0ODU6IGRyaXZlcnMveGVuXSBFcnJvciAyDQoNCkFkZGl0aW9u
YWxseSBJJ20gc2VlaW5nIHRoaXMgd2FybmluZyBvbiB4ODZfNjQ6DQoNCi9ob21lL2dyb3Nz
L2tvcmcvc3JjL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHZoLmM6OTc6NTogd2FybmluZzog
bm8gcHJldmlvdXMgDQpwcm90b3R5cGUgZm9yIOKAmHhlbl9wdmhfcGFzc3Rocm91Z2hfZ3Np
4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10NCiAgaW50IHhlbl9wdmhfcGFzc3Rocm91Z2hf
Z3NpKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQoNCg0KSnVlcmdlbg0K
--------------SncFPlxTg8DkoLMqUFXsOL99
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------SncFPlxTg8DkoLMqUFXsOL99--

--------------O3s0i0TBCQzGkMudaipiCF2z--

--------------Knae4IyoLuapUbvuflU12aH9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmY90U0FAwAAAAAACgkQsN6d1ii/Ey+H
2wf+PSgCmVegUuGJiEjtMEC4NGK5ZCd5/kTaohRVA1KDMrhKcLFgL5BnL6VjenRhYw0R18hcvloB
cRyQTUsx+1AKilmAulFK0GqxigUyGzN/wkBQvklWgaIQAkbeZ1RAyblB+wCRW2z5mp3zIue2k878
RLu6y39cURX53WvVDgvCUAIg+AjXNpkesMCBgxoWetlrR3GsjRj+g7RYRGcVG+rHQU8e7TCgyF6z
BvcrbDDSxyNkzyXYJQ2n58G1CGZ+cLRo2X+BWNiOOa/29nvZF8bRRji7RaDnJIgNd4kdAOVbYqSB
IFYKk7iULEiSyt/KZLOuYz37P4cgiaqqYXbw6+FCKA==
=eS2b
-----END PGP SIGNATURE-----

--------------Knae4IyoLuapUbvuflU12aH9--

