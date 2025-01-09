Return-Path: <linux-pci+bounces-19610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81E5A08084
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 20:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF452168DAF
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 19:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF6E1B0402;
	Thu,  9 Jan 2025 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Af52TlIa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE0E19067C
	for <linux-pci@vger.kernel.org>; Thu,  9 Jan 2025 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736450252; cv=none; b=VvmvUdkEyCkJTYC9aMp03ltSycIDCcrzzvrdlJY/khaREl0SJA7HpNtst4zloODDf1iubuxWP77hlf0wUh3nwfGvId0+lW7hZZfNTaNh/of4wk1HnJydFKA5rPSaVMqqyPGKHPSbEB4EAgxswN+vgTQyIqYaACCSda/FdI/F6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736450252; c=relaxed/simple;
	bh=JkLEo17KUAxHFSqsndBqs9VZOFc32UQCeg3AO2IS7PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gp+4RzAz1WZC0CqZluafs7z3W0wKqqHTZX7DEaRlxHnLE7/nylVgJWJZ3PL/vKB6fI6ynCukt6m7FLHnyP6xwt6b3uE0PyIyoOU0FwyOQD1qzhHwsd/ctijXg33c0N7iE/ZO0vZdP8/NwJcESQ8rz++bg4FAQGxejf0DgPQcjtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Af52TlIa; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso2127735a12.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Jan 2025 11:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736450249; x=1737055049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pfSGgKZn2WdVmYL0QC40X+GMWn55WSYJgOsa2VsrZE4=;
        b=Af52TlIam6UUC00Ld6H0h9Gp5GaSJYhFdqJ65qQYvoh/uGP1hHYYJ7+60iiKUEuK93
         OGHtwo9+4aLfibSfLHk0ItQ6fLRlckEKH22SkNLPbtX2mwSvT+3mfA6OvOcGiL1gB7m6
         mwh1DjG58tJxqlGoo4GEu4OA+iWF4kghRku1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736450249; x=1737055049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfSGgKZn2WdVmYL0QC40X+GMWn55WSYJgOsa2VsrZE4=;
        b=jCv0y8t2OuNaZIhrN92UEw7vRcbEFPEZZ/wZa/W5u1+aHJqf+ked4ncXu7zAH81qkr
         C9kBm0LS4jdJaBX7zKRpoXWfc2baNPcbV74hZb9Gm+kazQpOAHc2gZAgeADYGN0E9NE1
         lg1YbGf614zMQ7AVY7Iz0TpUYrVGWgwBU4Y5j9hIgMJt7kup+fC76t/zbCNI9f2NS8Wq
         GecvlJcjT2swLt/eE9WxIhBJ1HXMAsP7TnYeUwXqZir0CiJ+YwDlvSyV7KkaXPQ0i4O7
         QjqWrgGdeDpmYi+EwI3gWs1ckkC80NzgPKz7/Xhd1d2pme7uLE7lAFzVkIkTG6hPXRc2
         0BxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh4nEMjSh5AnNJHonqVzNSiJT/g2ozXq9u7K8QGFgrHNPtiZLGDdKAPDiJslYIos9iXzvRkKXnu20=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywze49CtyMBZlJEvv/r1iPNPp9sGglXzpLPR67RAjy/eNy6erVh
	fmaJ0v7So1yPrsDHuGNdc5HFao/GrXIbJM5qesGFz76GzqZ6nqyls4mRtsQ70wDqk+V3eveRXqI
	9KPoq6P9Q888YbDjK2B4RIXwX1ZTtpZCC2SEW
X-Gm-Gg: ASbGnctnCSmJYorFYgiochWScujdR0dmnuZ8vJVGVR17q4B3aqTE3vgJurNlT++EbnP
	dYNSHekcSIl+KCZRw4uMFfzPPLpzVhg/iveNt2g==
X-Google-Smtp-Source: AGHT+IHe6nVra9B5G0ue0S6KJwAXjNyEP1XQsua9Th7Uy0/LIL6iMwUx1oJgUwgJ1hzqY8Zm9iSs13eFa2B2wBMf+sk=
X-Received: by 2002:a05:6402:320b:b0:5d0:cfdd:2ac1 with SMTP id
 4fb4d7f45d1cf-5d972dfcbcfmr8024451a12.6.1736450248565; Thu, 09 Jan 2025
 11:17:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115200412.1340286-1-wei.huang2@amd.com> <20241115200412.1340286-2-wei.huang2@amd.com>
 <20241115140434.50457691@kernel.org> <68e23536-5295-4ae0-94c9-691a74339de0@kernel.org>
 <f1f6af31-7667-4416-95d0-2f59c91a1b62@amd.com>
In-Reply-To: <f1f6af31-7667-4416-95d0-2f59c91a1b62@amd.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 9 Jan 2025 11:17:16 -0800
X-Gm-Features: AbW1kvYDuqp5xvhpzi7zNFsUb7yr2gYuPctAvyRXOz90gm5xsZ8dFIsVhtkRatg
Message-ID: <CACKFLinrbYO71ahdmvHG+ZZaDk0zyZJXnRpq9YTE1JnZ=tc-Aw@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] bnxt_en: Add TPH support in BNXT driver
To: Wei Huang <wei.huang2@amd.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Jakub Kicinski <kuba@kernel.org>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, helgaas@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, asml.silence@gmail.com, 
	almasrymina@google.com, gospo@broadcom.com, ajit.khaparde@broadcom.com, 
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com, 
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004404f0062b4ad494"

--0000000000004404f0062b4ad494
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 11:09=E2=80=AFAM Wei Huang <wei.huang2@amd.com> wrot=
e:
>
> On 1/8/25 05:33, Jiri Slaby wrote:
> >
> > Based on the above, I assume a new version was expected, but I cannot
> > find any. So, Wei Huang, what's the status of this?
>
> Currently the Broadcom team is driving the changes for upstream bnxt. I
> will leave this question to them (Andy, Somnath, Michael).
>

We'll be sending the next version around the end of the week.  It will
include the NAPI disable/enable that we discussed here:

https://lore.kernel.org/netdev/5336d624-8d8b-40a6-b732-b020e4a119a2@davidwe=
i.uk/

Thanks.

--0000000000004404f0062b4ad494
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIE1+5fixUGP5qpkoZgr6iJUzvaPgKPmi
WijfmG/3SbNHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEw
OTE5MTcyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAbG1HUTIxYqH2ppyirFTjazfgTvOu60NlB63CTkUQznIYTLxz5
YVNVq21ZWqXesFKsMSEcD1QllvvIyBaTqJd84kVPfcAUBUx6J4Iq7/7DoBG/lMgEoIGR5KGjIT+9
xjAiVN1zolTmL/UM5o8eQWLWtNE6ZGrcl+x8V81BB0AP5FgC/US20vNMfHqlfgTa1yMPyQ7TNfy+
8kczUZYQKd/UuR4KoWy1MmuMV6JJTsxxYsqSYJEflBCadvU5BGlqw3x7+s6mNgAGTMcfmwmtumwZ
zNKJQLIcdtpzGs002nDcBrniukbRa+QO09N4YZJdZgCKGLIK0Iyyz/FjtHqvIR/y
--0000000000004404f0062b4ad494--

