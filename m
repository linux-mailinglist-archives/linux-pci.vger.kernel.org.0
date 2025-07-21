Return-Path: <linux-pci+bounces-32642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9226FB0C27B
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 13:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650531887C0C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 11:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEB81DED42;
	Mon, 21 Jul 2025 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BLuG+B7g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99D01DDC08
	for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096581; cv=none; b=eR5fJT59TQBNB2oAs93RSLGqdQtSOjzlVvv7De9L0cagD3VEw0bniGqmy1LwXOctl0lXJqFHiIHzf8qnjlEIn9ZsbgICFAU1615h9C1H/hxdT1dt+9/rWbqaS7KIy3p8+y2u4X9Ywk9jAGs8inSYGhilAz6qrNAvwlGOhzIu29o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096581; c=relaxed/simple;
	bh=bHEQspKrfpBAKVXfLJ9J/k88DCm6qVGXyw8JjUn4EjA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=H4frgvKONrybxDdKDnPvNUQ3PTs17+2MTLW86qo4l+caVMRVeC/9t1vaKhrgU9IUgGv37aCt+EaFlkONzeiLZN3nnhYIqnsY5ngG1lS90dKAXvkAPcoQqOm3LoqvDJNejNnwy9+kgGe/wx1SsWfWeE2WcoOAIC8SuQS3v959IQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BLuG+B7g; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so3463945a91.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 04:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753096579; x=1753701379; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bHEQspKrfpBAKVXfLJ9J/k88DCm6qVGXyw8JjUn4EjA=;
        b=BLuG+B7g6xP1nTeYAnkobW6T4GHiKmN2HxRvoXUrMHbR9FzmXffe5d96S4XXc5EH1q
         PGpCA9YGXowa6w0XInFM/KsRNIQz4xJMwe+e2ahmj26niWasfPjWJ2KwJprrTj7etqrC
         koo6Obtz42RNQpwuQZMdqYqTMwkXdQuwe/wWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753096579; x=1753701379;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHEQspKrfpBAKVXfLJ9J/k88DCm6qVGXyw8JjUn4EjA=;
        b=EbyUZqR0MNfyLdb33tQyZ742N3TiBDVVdxnN4W6x7VFTkx1R8oXjrjL2KualMZmPiG
         vY06rsQFBVdUrRFBKoKRNxdgfRninX71jWV9cMtzSLShcotOM03nblEN00ZZ97yXM+18
         ePhZp2Txlc9Vr3PzPATbvv2DlyBDBUhulb/WamfSIx0qneGyY9UfDEQRgPuhKwEjaXck
         IHHUI0yQcdXQD+9Yz1HrjqcKiDnHc+Lvgpkf+CwUt8Kyq1Hw1dn7NNcGRXbZFf9ExyBG
         razQHDTksMS9WpJdtNJZik6WJ0hbWVAlZqzsaAG5ZivXSB/sFTQwVdXhuRTlSXQDKZ2n
         zCaw==
X-Gm-Message-State: AOJu0YxKDbO2EM7Rdw1RbcgiASrO3ed03CUUxpXG+4g2SCmBVAmUa9cR
	2Gvvp8OTr5RNp5CkHUX9TolofD5P95oNuC2sBdTfKxtiV2EQscJSm3zi4EiH+UCYKkdBI++qHx7
	mekiVg6RpB1+I6BM/wA3r/9yBIHNAcNf0am8c2JSr4Aa3lzLd9r4kuQ==
X-Gm-Gg: ASbGncveFBAR1+2HtDiGZrKDjGKkbWr/22DK+YFouJRvTraaPDZxeQYnEg/ZopOwY7P
	Yf6DbJ4hhEo3A8tlsPyXn1dhAFoP9ce3Jt+grhIOMGJZsd/JHfss50vqCYIsmbLcejmlceVSeHU
	BUTsvkKvCFayP+acE6qtkqDa7BAKugeJn/YU/ofnyJUibgqlLO/KDmM6DAa+ezCBHTbHUflPLBY
	dDmyZbQ
X-Google-Smtp-Source: AGHT+IGLsmPhTjs5o9UzpNB4DkuFhSwm3j3by4dY8Jo0B5qnLBhFzQhpDoTncxUpdpyFVmYabrflB1foyX4Ub2haS8U=
X-Received: by 2002:a17:90a:fc46:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-31c9e7617d1mr32332564a91.17.1753096578697; Mon, 21 Jul 2025
 04:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Raghu Halharvi <raghu.halharvi@broadcom.com>
Date: Mon, 21 Jul 2025 16:46:07 +0530
X-Gm-Features: Ac12FXwFhbWr8EUDS6mgwGJ6m7bntVcYbjtDTrwGrVLsetWofSsELQUV2fMguQc
Message-ID: <CAEDZ0BRrt1TBu+Bwc0yK4x9OiK63zXa8ORg4SSdCLu-OLKcXOQ@mail.gmail.com>
Subject: Does linux kernel support PCIe System Firmware Intermediary(SFI)
To: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000db7041063a6e9a28"

--000000000000db7041063a6e9a28
Content-Type: multipart/alternative; boundary="000000000000d4c3a7063a6e9add"

--000000000000d4c3a7063a6e9add
Content-Type: text/plain; charset="UTF-8"

Hello,

Not sure if this is the right forum but wanted to know if the Linux kernel
supports SFI/eSFI?

Regards
Raghu

--000000000000d4c3a7063a6e9add
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>Not sure if this is the right=C2=
=A0forum but wanted to know if the Linux kernel supports SFI/eSFI?</div><di=
v><br></div><div>Regards</div><div>Raghu</div></div>

--000000000000d4c3a7063a6e9add--

--000000000000db7041063a6e9a28
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVLgYJKoZIhvcNAQcCoIIVHzCCFRsCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKbMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGZDCCBEyg
AwIBAgIMCU5PIrbFgyuu2180MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MDkyNTE0MTAwN1oXDTI2MDkyNjE0MTAwN1owga0xCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEXMBUGA1UEAxMOUmFnaHUgSGFsaGFydmkxKjAo
BgkqhkiG9w0BCQEWG3JhZ2h1LmhhbGhhcnZpQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAKZ47Aaot8asxbuvXwXySvVpAr8EGf2Mh5erT51KYkpMcQDhkm9sxpdK
mgdgHAK4kH1I67mQy3RaEMVJ7oqSffoDtVcw4T8GeFETqp5rYVu5O0QGrYrFCCnrx+9zdog+Pavh
Q9xb8vqQRgNZeTulkvr0FxHUmdExlx0jwHzEMf+mZi3lz60JiVNv0GwaULFRyiOKNeGY0CofnIzi
mCnGN94BevxEkLawq1aHdiVo/wcQe2siEO892b6Ee2VycQAO1J5SAcbDKUaGdcrISXU1FKFFmRYq
p+GZ3VaagiEs8bDCSiIAPXe3mbIZh0fbaXQ6R+RqUdnO9qL+jKAX8XXpUfcCAwEAAaOCAdwwggHY
MA4GA1UdDwEB/wQEAwIFoDCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0dHA6Ly9z
ZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQwOQYIKwYB
BQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMzBlBgNV
HSAEXjBcMAkGB2eBDAEFAwEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBBBgNV
HR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAy
My5jcmwwJgYDVR0RBB8wHYEbcmFnaHUuaGFsaGFydmlAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoG
CCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQkK6Ai
DjZK8tB4SM50rdG0OzhfbDANBgkqhkiG9w0BAQsFAAOCAgEAiiTpitFV6vMrqY/21KDymGmFQTLk
1Fx0DLC90lv18HvUYplkx29FEvPQVZbepHkIsF8/YttS9ESBDOaSoZ5/pJ/ZLy1I1ECugnqML6+L
yWfq1w6zjIs1IsN7Vs5IoNRdBr6NkgMfHhOx9yWwfoIMYfBumf4SqpGgGtYs8EYMRylRSA+zxOcH
api65fSgYw+2+XVNOcVZg3+HNxX/5ACUcLM2by3+mANnrjxj5UwdDFgYVZMdpExw5fHQ5GM+VLSW
t2N1XMfQJMAEulT8AoQFRCwawedlI81I+tIc0wTYpQOh0xYUDTxmtxDbWlfL9NMk4plswvAl5cBa
5VJy0E+AVuLkwB02OI+2+O0UIJvaTbepEduotxyqNt5oJzmgqZZ3gqYr0cV7ZOeYAxeYxTSbl0zc
EMLSL1zyMfTdwgEadxKFEBfnha1GOMbkGdm97hxmA3GbANjSGoLQg+FuFb85TQzSO3HW2baFo1iW
uO6oQDa/nmzWa9HfkEyu35hxZx3Q2XTS0eEj/L7LNkef1H3e9KBOk5UZ+7d4enb0rfe//lkmRiVw
d71xM1eQFLg7qC2nxA2KNPSp4riYQyB+07u/sy/TkYAkYQqBcosBGY+lg70abCH5nCPjlVvsYXWG
ePYxD8D+T2e2mdacrxg5OocASDBZrXiFGBQQPxoo/VW7koMxggJXMIICUwIBATBiMFIxCzAJBgNV
BAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdD
QyBSNiBTTUlNRSBDQSAyMDIzAgwJTk8itsWDK67bXzQwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZI
hvcNAQkEMSIEIMNAPMtwL2VJu6iWlXBZMIPtidHHj/YFh2RnphrGnrLpMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDcyMTExMTYxOVowXAYJKoZIhvcNAQkPMU8w
TTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABHnbuMFPp2ZwUGDlW2rH/Fl
owkl1VSsdROHEIdIuaJAtqSIRDQB9JzOm+OKT8bjBMSKkVRZ+wef7lyQFkaUY50gxzEY6UAT+2j4
vrc5rlx+FRiJO70+1dn6/+ZwWDUZIIhBJ/COnogJL6MT94SaQIKY/LF5Ha7Iu24KAjpogFJGVPS9
Q7rDFmttmfZo6pU3YmZWOx1GYgLMPme34aq++Oo214VGQsm+5UAtxAKO1UeG7RYZdhoV6WiYsshl
rmkh63W4bb2nZUGE9DonzXH7rQXUAq8fjuSBM5/pntgaDK4leQxB20L1oSJYiR8awqE+sRuL8Mt2
xjYCEEdQyT73Xj8=
--000000000000db7041063a6e9a28--

