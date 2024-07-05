Return-Path: <linux-pci+bounces-9847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A459A928ADB
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 16:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D01C1F2395F
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B1414C58A;
	Fri,  5 Jul 2024 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CjP2RrqD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C413149E14
	for <linux-pci@vger.kernel.org>; Fri,  5 Jul 2024 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720190943; cv=none; b=ofldvxCm3ZCYjKbcsWntAbR8LdvSNPGyKU4879SHKpLGHNnZsMBZXEgCHb1D0QcUS2mb/uaFXjESOMC2uwPDlMnkvqpCN3ctcXqePtyTQLEBllmR7q2QBjnj9zcA/mTgOsAp6jszJg6OHcpL/NgVpp6M4VCj/AQ4EM6H/0o2ao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720190943; c=relaxed/simple;
	bh=7yKb72FQ12LEf/bnOXk0tiOa96B25qtgOdv9m+ppZl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0nn+FBh8+b+zYxtA5L0D0BF5rh9yyv24KKTucoVVq73/cRZHBI7kuWTtCdh8FLghCZGeDGc7UL+bns6yn8snrBsNxiozCJYa1pX/HeI40cVz5zVyfbZy6uyUxTOvwHCuZ/moAP6ZWctJ2jOogEyKhj1Sy0dda+B3rNO4eUWlKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CjP2RrqD; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ee4ae13aabso17952991fa.2
        for <linux-pci@vger.kernel.org>; Fri, 05 Jul 2024 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720190940; x=1720795740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hWrFXmb0hLRR4pTeLUu1I+sTEInc5n8JNHhVoXFYQBI=;
        b=CjP2RrqDae+lYAbSvC+w23/qAcKZd+Ef6n5p99rCQjjwmxTSCsMZS421Ux/NWyaJGV
         qOEq4TwSq5Ya4tXKWhaRCla6mEhCKgzArCgQJERfVIR5rRkqei4L9URtHkpURR9Lma4R
         mANNVwRfNPoHQ+TIUbXTypvL7QXs1TuHOEbBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720190940; x=1720795740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWrFXmb0hLRR4pTeLUu1I+sTEInc5n8JNHhVoXFYQBI=;
        b=nbcjki3KtuuSIVykqr6kzSJyXjySiEJee0r6yzPO9bYv6ahoPSdZEhLcGFdgSYCRZ8
         ynOJdWau3h3xJJKBwBnEPD4jVcAq7k/BPpe1UUz8QjgDuBp0/qGw5UYdkANBW2M595i/
         dr1qtWQd24uXuudFqlRy4jVCnKlzdPt5/0Vod2BpGc5wlaw6HECaCnt4YDRbqN2mtpJ+
         9mXrfrJepYHrbt/KKEZyvPIvMbPC2hfFbGoRTY5cS8mnGZEjW79ZGR8snShu2nj3AJFp
         dzCNPMrtz0JaSIkpFWqpOrG/b4Vfc1p5E1/8SHLTkBReg7fHQmm+1UgwB+pNmO9nv8/b
         vYYQ==
X-Gm-Message-State: AOJu0YwW8P76q8HAT1Ac+P4KTRSRNNNn2Fb3dd0iHBHKvltUnLztUJ2h
	z9s83c4jJndU9m9xfhqbKCWygVhWYhuFb9xa1yaCjFQYDKjqPdONTk7Z0dBk4rZx63yPjUicxVt
	uHaSO73CA0hKAuurQF2X1YMtQyQK7JQklzSOG
X-Google-Smtp-Source: AGHT+IG5AzyBBsGPDSPo85Ihz0Zv1yTsag8HC6OlcHdg1qx6oatrETmFc+eGgqcTB2I4RoKizGDx6Swp94S0MJEwLpY=
X-Received: by 2002:a2e:780b:0:b0:2ec:5ff1:227a with SMTP id
 38308e7fff4ca-2ee8ed8f49bmr31706371fa.17.1720190940063; Fri, 05 Jul 2024
 07:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703180300.42959-3-james.quinlan@broadcom.com> <54dc90df-fc31-457d-a18d-b2070b055d60@web.de>
In-Reply-To: <54dc90df-fc31-457d-a18d-b2070b055d60@web.de>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Fri, 5 Jul 2024 10:48:48 -0400
Message-ID: <CA+-6iNxqZRdknUVammcgDC2HUmacZSAkdJNVLba32Ujgsa9vpg@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] PCI: brcmstb: Use "clk_out" error path label
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Cyril Brulebois <kibi@debian.org>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Stanimir Varbanov <svarbanov@suse.de>, Jim Quinlan <jim2101024@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f4fcf4061c81291d"

--000000000000f4fcf4061c81291d
Content-Type: multipart/alternative; boundary="000000000000edf39c061c812975"

--000000000000edf39c061c812975
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 7:40=E2=80=AFAM Markus Elfring <Markus.Elfring@web.d=
e> wrote:

> > [-- Attachment #1: Type: text/plain, Size: 1685 bytes --]
>
> Can improved adjustments be provided as regular diff data
> (without an extra attachment)?
>

I'm not sure what you are referring to... I see no attachment in the copy
of this email I received, and I am sending my patches  with "git
send-email".

I will address your other comments in v3.

Regards,
Jim Quinlan
Broadcom STB/CM

>
>
> > Instead of invoking "clk_disable_unprepare(pcie->clk)" in
> > a number of error paths, we can just use a "clk_out" label
> > and goto the label after setting the return value.
>
> * Please improve such a change description with imperative wordings.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n94
>
> * How do you think about to use a summary phrase like
>   =E2=80=9CUse more common error handling code in brcm_pcie_probe()=E2=80=
=9D?
>
>
> =E2=80=A6
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> =E2=80=A6
> >       ret =3D reset_control_reset(pcie->rescal);
> > -     if (ret)
> > +     if (ret) {
> >               dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> > +             goto clk_out;
> > +     }
> >
> >       ret =3D brcm_phy_start(pcie);
> =E2=80=A6
>
> Does this software update complete the exception handling?
>
> Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?
>
>
> =E2=80=A6
> > @@ -1676,6 +1677,9 @@ static int brcm_pcie_probe(struct platform_device
> *pdev)
> >
> >       return 0;
> >
> > +clk_out:
> > +     clk_disable_unprepare(pcie->clk);
> > +     return ret;
> >  fail:
> =E2=80=A6
>
> I suggest to add a blank line before the second label.
>
> Regards,
> Markus
>

--000000000000edf39c061c812975
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 4, 2024 at 7:40=E2=80=AFA=
M Markus Elfring &lt;<a href=3D"mailto:Markus.Elfring@web.de">Markus.Elfrin=
g@web.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">&gt; [-- Attachment #1: Type: text/plain, Size: 1685 bytes --]<br>
<br>
Can improved adjustments be provided as regular diff data<br>
(without an extra attachment)?<br></blockquote><div><br></div><div>I&#39;m =
not sure what you are referring to... I see no attachment in the copy of th=
is email I received, and I am sending my patches=C2=A0 with &quot;git send-=
email&quot;.</div><div><br></div><div>I will address your other comments in=
 v3.</div><div><br></div><div>Regards,</div><div>Jim Quinlan</div><div>Broa=
dcom STB/CM</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
&gt; Instead of invoking &quot;clk_disable_unprepare(pcie-&gt;clk)&quot; in=
<br>
&gt; a number of error paths, we can just use a &quot;clk_out&quot; label<b=
r>
&gt; and goto the label after setting the return value.<br>
<br>
* Please improve such a change description with imperative wordings.<br>
=C2=A0 <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git/tree/Documentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n=
94" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/pub/scm/lin=
ux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patc=
hes.rst?h=3Dv6.10-rc6#n94</a><br>
<br>
* How do you think about to use a summary phrase like<br>
=C2=A0 =E2=80=9CUse more common error handling code in brcm_pcie_probe()=E2=
=80=9D?<br>
<br>
<br>
=E2=80=A6<br>
&gt; +++ b/drivers/pci/controller/pcie-brcmstb.c<br>
=E2=80=A6<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D reset_control_reset(pcie-&gt;rescal)=
;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pde=
v-&gt;dev, &quot;failed to deassert &#39;rescal&#39;\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto clk_out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D brcm_phy_start(pcie);<br>
=E2=80=A6<br>
<br>
Does this software update complete the exception handling?<br>
<br>
Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=9CC=
c=E2=80=9D) accordingly?<br>
<br>
<br>
=E2=80=A6<br>
&gt; @@ -1676,6 +1677,9 @@ static int brcm_pcie_probe(struct platform_devic=
e *pdev)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;<br>
&gt; +clk_out:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(pcie-&gt;clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 fail:<br>
=E2=80=A6<br>
<br>
I suggest to add a blank line before the second label.<br>
<br>
Regards,<br>
Markus<br>
</blockquote></div></div>

--000000000000edf39c061c812975--

--000000000000f4fcf4061c81291d
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAqKk8v66ut57olRk8bRN9jkZSdK5RV
kfRNSE7yoZ9/JjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MDUxNDQ5MDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAPqR9sRpAzTat3icuQMsL08lxIg8n5UQweMRYCkErIpxdKTAl
XZjvtjYtb+IPiECyaDQCtUQLBFRKFOQEJxBv0w310shPIaqOo+aTzM98cH7Zr6KPLLFYIbMY48R7
GJltcJ4+uPYzHgU8mDQjDBum1IUL32BJnzcNZxBR4ccWkd+6JVrJvu0ABpeDpl2fpRRQu/I/VvXj
i6thxxNn2vAn8mNZLZDj+34iM4AoOFJWya3m1Kyl+OMmj9G0yBg2EeVFesuu3Gs57JH03RZDFxcj
Fm8SBfBV4BKsNYhwarfI5i0jKSnV4+y3MrtTMpBv1PwGOjuJ6vW0CmVnZqylAdhtSw==
--000000000000f4fcf4061c81291d--

