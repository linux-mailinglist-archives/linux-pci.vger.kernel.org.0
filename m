Return-Path: <linux-pci+bounces-12308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 533FB9617EB
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 21:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF15E1F24C37
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 19:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30AD1D3627;
	Tue, 27 Aug 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iRD1GHJi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2713E1D2F5E
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786452; cv=none; b=jUqsQvihHfl6eqRgR8P6OTsld6AhefPFxY5DmV0r0+cLjTAbY8XaUfZEHYMn/qLE7tZ+ZdfGje3nOzpy4Znw7uSlBSPr61h/X1TGu9C2cggfM84q9OsOeQCG69EdsTGeCid1nJboHHUiG/0kvMXYNgJbAiqEONp3sgXNpeYu7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786452; c=relaxed/simple;
	bh=3mH3+hrfpE+plt/h/aWxU+a8+fsGU9PmWeIr6baIqVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYcw1OLDw8nmWcYU2aD3OHA79ukSiUIqQaU7nncbZQjuf1PDMh29CZwVMGjcBhYMGfYeC5id9Skpb3k97HKDppHk6st+kKQXz+vs+y4PDfFRD2/1LMsIINrI3ETlFFpnk2dJNdjxclT1K1jd4e5QsXKODRj0gS1AiP5WFK2JWxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iRD1GHJi; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c0a9f2b967so2944473a12.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724786446; x=1725391246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3mH3+hrfpE+plt/h/aWxU+a8+fsGU9PmWeIr6baIqVs=;
        b=iRD1GHJicufdihoFk+Gycu/hNuY2uq09zIpngHDsUWwYbZJbNAmZQne4ju+TlhdQEe
         FSjiXWrbM/yFPww200zIbAVlnfYWS39bqOh515Lsw3xXNAFA7d+bwBS1NSjI7xPG2EzO
         VyiuODX8z0GC7Zh/h/u4x7TzJ7edZJ2gsr2xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724786446; x=1725391246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mH3+hrfpE+plt/h/aWxU+a8+fsGU9PmWeIr6baIqVs=;
        b=ESvZGZPSfHboCnO664VFu8s3XlQORd6sEd+S0WvsCWarffR5sO4SddIsmej0/SNS4I
         mWb2FM64gV3T/zOx7G25Njy0CD5O3T6rik9PUtxmU0vb1pF64IqhCrLAIFLwhMb2cdFA
         CXVfUmD8jsantsX2RXikcDEh7tz965nZiDC+ASSjprWq9bNAWXTuvJ+/OftHtM/Cy8Me
         f6qRMLn8kBw3dcNdf4enJlvn5m98GiG95E2BA7PKo8h0gA+Eo8ptHninVH8avgCvL3k6
         PpWK83MVEygWzbSWsUcrLuJxCNh+adsUJRgxV3noKkSv/hkMav+4LpufyKIUKTzpRMzi
         dx/g==
X-Forwarded-Encrypted: i=1; AJvYcCWYwKxo6HxOqiTIOX9864y+1vAd5m5mixo3Kx5F71N7LcVKcXmR8qXUIZBKd8lYWQX0MVlnkyRQtdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwjI0S6Pf18z8sSyTbG/VRvZIRcXnxCWxBWvODpPhGeql4Kn0
	PNUCTKd3cTeaUZcNLECgssoNWfhSShj1LrecjVAmqtkKI1x3r6EX4q91U/W9opvDTkz7u50pBMk
	X1NXTG8f7Ie2ITz0GhQdZi5KO/ces96d4IP2D
X-Google-Smtp-Source: AGHT+IHyiblg8oxR6h2eIw4lJCDNv5/eXNMd6VvHXK6XtRQlmFUm646Al0OG/Iev8IhnoBSvJkXvDLMUCNp608Z1PPE=
X-Received: by 2002:a05:6402:354e:b0:5c2:106b:7191 with SMTP id
 4fb4d7f45d1cf-5c2106b7411mr511440a12.17.1724786446231; Tue, 27 Aug 2024
 12:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822204120.3634-1-wei.huang2@amd.com> <20240822204120.3634-12-wei.huang2@amd.com>
 <20240826132213.4c8039c0@kernel.org> <ZszsBNC8HhCfFnhL@C02YVCJELVCG>
 <20240826154912.6a85e654@kernel.org> <Zs3ny988Yk1LJeEY@C02YVCJELVCG> <20240827120544.383a1eef@kernel.org>
In-Reply-To: <20240827120544.383a1eef@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 27 Aug 2024 12:20:34 -0700
Message-ID: <CACKFLikctGq7Mg-7htmj=FUKcTXhaHsujJ32VCKnwDpKqNVv0A@mail.gmail.com>
Subject: Re: [PATCH V4 11/12] bnxt_en: Add TPH support in BNXT driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Wei Huang <wei.huang2@amd.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	alex.williamson@redhat.com, ajit.khaparde@broadcom.com, 
	somnath.kotur@broadcom.com, manoj.panicker2@amd.com, Eric.VanTassell@amd.com, 
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com, 
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com, 
	jing2.liu@intel.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000079aa200620af23ff"

--00000000000079aa200620af23ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 12:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:

> Not holding because API may not work, holding because (I thought)
> API isn't in place at all. If bnxt_queue_stop/bnxt_queue_start are in
> linux-pci please rewrite the patch to use those and then all clear
> from my PoV.

To be clear, the API is available in the linux-pci tree but the recent
patch from David to check for proper FW support is only in net-next:

97cbf3d0accc ("bnxt_en: only set dev->queue_mgmt_ops if supported by FW")

So we'll need to add this check for TPH also once the 2 trees are merged.

--00000000000079aa200620af23ff
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAckulXVqKaoPHIKj9Qaluh9u2hmZrAN
ZSUYxykCIdSHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDgy
NzE5MjA0NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQACqphtUml1ayKjEk6S7z0VHWEktD2jtpRoDkS3DlEQHKkeMiBf
He/KE6LqJm29/yTsinBwvsXmd4MwwD+zrdeyTBWfTWBW6bpu+iRuFF2HWVGa4UdrDwcRpjWNNm5v
AObwCdtxJ/CJ2NevwpRkUk4RJNR94N/3i/pR1ba1kZ7sFEgFpm7Wr2ieZm2L5S+3oPkJeg2roNph
r8ZRMfJgfdqvZF13tTjL8hByQ77B6t2RAHJP0lk3TWxNDm8GJeoDtVjwugJA4suCeXc5NsQT42ts
Ry8qurNecaAfWxhZMNiTsF8hbUIJEjDJhgT0QbFyjMltYA17Yv9hq/Q79zztlTvi
--00000000000079aa200620af23ff--

