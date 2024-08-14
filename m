Return-Path: <linux-pci+bounces-11676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976B695215C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 19:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80348B21A90
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 17:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E6A1BD011;
	Wed, 14 Aug 2024 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YSIEWG22"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF41BD00E
	for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656948; cv=none; b=fPpZ4rQLTv8BJDfMXX/doxqUdz+NmlFqc7DE10c/Bd53U/nXeMNqtTb+IsoqiIpqsYXbxdEjqV44tFjq/fKM+q8JDId4fCe3unedERTl2FMX1M34CjOiZN0yM2VC2Xi1ufHK5NbkGuKdQCwVpq/aOXKAsAYUVCk9h/VZHuShPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656948; c=relaxed/simple;
	bh=oavrM/h2ln+yVMIGD7/d8ZFVSeMkWUXwi8JPVwq7I0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbEyDox1N8gDoAb2pQ/wnn54xZCF2A3hFIwld7iOBNDlAU95CmJITHSQIA0Z3Qs24rGotqiXidiO3peful2hXxVkgsiyy1YFW1Mwgd0vsjYs17l8Fw3e+nJPcgi0ND7nIKpPT3oGBHxRcnBeMj1BceIj0YmK9nTn0nBs7RVAJ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YSIEWG22; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so1755701fa.3
        for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2024 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723656945; x=1724261745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ToLK9w+9aOWL/aCInCzcvMAWEySoSQB3heKWKkGpgH8=;
        b=YSIEWG22JB6vrnJjRvgJ74Ula3a7Q7+KIkZd360wAdt8iMJ0Plqoe/egPnzOq9dLS8
         S5ly0rcp3Lhb/jEbM57qpu+pLrflvgL2Hjk6oaH+qmmoTuJtP8Xh2kGqtsp++wDIiLBj
         qJb3Y9tt9qlPfbaqVcRK8VaBcy52tkoZfGEYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723656945; x=1724261745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ToLK9w+9aOWL/aCInCzcvMAWEySoSQB3heKWKkGpgH8=;
        b=H+sagnbYGdXK1qyEdanz7LLcmWbi/tBd1T3oisI43I39hbEVylM01bkHNgZ52du2qn
         Xt+HS0NgbUAaiknRqJzJpmhWXe3BOpG0mcfktJihCCCtHddihoNjmBAGTX7Ktdsg7Q15
         PaysEE8zz2wg6sSJlMRLv1flv/S3n+ZEOxblkwGNEe8qS0gzIw09jYQRHu232wBAM23Z
         n5aP/b089l40JJRwRyyfxbzfqKuY9I8sX2NOEQBvNxCRmx9G9Xkxn0RcUEEBvi2o153u
         UHVV1zOTS3/4HMN1Pko2JGFIOQB7DRw+e5o+yV6CX3M3lG7Qt7eYVkTVddXBysm/6TOK
         w5KQ==
X-Gm-Message-State: AOJu0YyNnrj0jfZvGHReo1vyG0QrUSaIO/CvmmZ7YiP/AZiSR2Gu1HSw
	dOQ5GVi+YtaMuCVrTqTkMjsnjLnowBFZPW17U+fyW4Y9Y0sBSC5uc+XWSuPwwKCEfpD5JcxLoLN
	Wbp/NM0iT2fQU1vOY3DGGQpFn4aalXQV0wsz3
X-Google-Smtp-Source: AGHT+IEKOu6rB+CNuBMYzXhZa7JxTSVt5I53L3SkIY7qH0wZAkcLxMzooabfHiTVX8qxGb9DXNf5YogWrGhX0ThFvAI=
X-Received: by 2002:a2e:4609:0:b0:2f3:abca:8b0f with SMTP id
 38308e7fff4ca-2f3abca8c13mr17537591fa.27.1723656944495; Wed, 14 Aug 2024
 10:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-2-james.quinlan@broadcom.com> <e1002187-fca0-455c-840c-32489e5eadb4@kernel.org>
 <CA+-6iNzDcF3pA1T3FuGNS4NPn1RrjHxxAVStN6t++xDsx-wUXQ@mail.gmail.com> <c5b0e395-7f2b-4dca-9764-83d0878e99c6@kernel.org>
In-Reply-To: <c5b0e395-7f2b-4dca-9764-83d0878e99c6@kernel.org>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 14 Aug 2024 13:35:32 -0400
Message-ID: <CA+-6iNwgC8RtXu3g70kH8Lkw=LHT-6MtAbt=ZReq_wXp9nF6VA@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] dt-bindings: PCI: Cleanup of brcmstb YAML and
 add 7712 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, bcm-kernel-feedback-list@broadcom.com, 
	jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ed4db5061fa82702"

--000000000000ed4db5061fa82702
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 4:27=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 13/08/2024 00:07, Jim Quinlan wrote:
> > On Fri, Aug 2, 2024 at 2:43=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
> >>
> >> On 01/08/2024 00:28, Jim Quinlan wrote:
> >>> o Change order of the compatible strings to be alphabetical
> >>> o Use "maxItems" where needed.
> >>
> >> I asked at v3 and then in v4 about splitting this. You never responded
> >> to that comment, so sorry I won't be repeating the same thing in v5.
> >
> > I'm sorry Krzyszof, but I just reviewed your responses in V3 and V4
> > and I can't find you saying anything about splitting off the above two
> > bullet points.  Perhaps I am somehow losing email responses but all I
> > see is this in V3 is the following, where you ask me to do a squash,
> > not a commit:
> >
> >     [JQ] o Change order of the compatible strings to be alphabetical
> >     []KK] That's a cleanup. You can squash it with a previous patch.
> >
> > Now you did say in V3
> >
> >     [JQ] o Describe resets/reset-names before using them in rules
> >     [KK] That's a new commit.
> >
> > but this bullet item does not relate to the bullet points you have
> > highlighted in this email.    As for your responses to V4, I don't see
>
> It exactly relates to the quoted part. The comment is ALWAYS under exact
> part of your patch being questioned/commented.
>
> So first I said one part is cleanup and should be moved away. Then I
> explained that this part is a NEW COMMIT. New, so one more, different.
>
> I understand that this was not clear, but you never came with a question
> what did I mean.

Hello Krzysztof,

Sorry to bother you again but I want this to be clear.  This commit
contains the changes:

1. alphabetical order of compatible strings
2. maxItems
3.  maintainer change

Do you want  me to split off 3 since it is not a "cleanup"?  If not,
please specify.

Regards,
Jim Quinlan
Broadcom STB/CM

>
> Best regards,
> Krzysztof
>

--000000000000ed4db5061fa82702
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAofXOGT7pQrt/NPoHSf4LHt5gDXxxT
fWZKOdk83hfYKDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA4
MTQxNzM1NDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAFTe82bSkbEWLvrLeyMf/i+H1D7AdPKzkQvYHyCFCkqXN+Hdd
8BePy3uHg8bPBblM1nuySdVZYBHpAAkBzdg3XV/fkGGvjpxWzhNBIpvNsJUkzrU7R4Qg/8dSLBF9
Rt56rTtozrCp88OZQf6o1PvuBNjr5mAoaGhYH8YZdkzlVV2LkXE4ZvxNxWo9pSfBxpAT+LkY8K/3
rol6G0AZfv9DeDQuZWNE9dujqAOZYxbJt1rAbNrLgwxsFblNGbO0Fsd2WiJguj1w52rjgJth7CyF
EaEhGO9lFc2/aYJnpTgAYaSG3+En8hgk2x3ds/9GS7ZvpgdZwyVN1jEzs/94y/hfqw==
--000000000000ed4db5061fa82702--

