Return-Path: <linux-pci+bounces-28010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803FFABC817
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 21:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9781B607D9
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD12A20F07E;
	Mon, 19 May 2025 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SPZupLWj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F1211710
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747684766; cv=none; b=O8Nk0KhQWzTRigrXk4RERy/oJBifgkwGiIDaTcb/DAb1JuCy3hPcsAYY2rJqxXvPDX47ytUiK2+Y8ucX1xi6QzsaaZVdtOmX9vsfnK6+uKMBK5JI1yb7J+fJB1OzQL+S+cECb1qVajPocYzuWjOvffJKKskkJxbfMl0hzm4nKGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747684766; c=relaxed/simple;
	bh=vLy30jcYOovnNHUaGOq5viwr7VbcOZQ414MpvOeR0Mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEoUjRBlLUksP5g6nN2fvTUDXnuX2hEuZXr+pge/O+f93IQXre//lRj68U7UZih4xp9PFGWRcEyA5venVOGJ894u5pLP5ZDcDLUh4MTcesg67fK4qlK+GDLJsIWTJzrqpPeD0hayAKK1Rq+DLlugNU2zdAQBSrFJ7e0vDapEZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SPZupLWj; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-328114b262aso29728941fa.3
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 12:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747684762; x=1748289562; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=71pTy4JUBRIW6KHUKuO6LuGuQYZTv7xbp4LfF/HWPgc=;
        b=SPZupLWjVaG5llL4nb4c5EtQO2zWzt2Ng43WPGESkCJmBdHvupcoOUc21Kfwi5EXfY
         iVrBp20t6Z1DXK1oV/snHcF2J3l9Hp2Dos5lmxvz8OG79fcfAxSEUlKCcl7+GIv8jHnC
         7JB5yousK1kMDdDCrL4NsXXHsSOByn4Oz26ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747684762; x=1748289562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71pTy4JUBRIW6KHUKuO6LuGuQYZTv7xbp4LfF/HWPgc=;
        b=uAiSGPfixCGfHOknd+fCipGrCPjUlTa5RD+pec9thWS+XKECndJfFwb50EnZT8uJpC
         8mx6MUcFJKyzSIFR+UMYot7i9BmyqAp1vaAOTSbyi6huJVXj9IEQwVugMU9VNTMkcX59
         aG/Y+eGkE+hxkG9hRK1wNNnSEVkSIFnaotQBdfR3KNld1vS89NPRs6nsmwn2LXlsnDGT
         GeB0PvpDqe7AGfZiV5SicFtlP3LtFbX0YJ4VnNE5r5eN04hxV8VVkxpYMIJmgtt2O61k
         SXySkfZuz3VjTal3jIHB5iIFA1qHk5s57ZCVwrP8Ta6BfceCIxZUuROQ2k88d+S+3EK0
         MtBA==
X-Forwarded-Encrypted: i=1; AJvYcCWTAbpQzleb/IbtHbybJEDUsTUKHK67jkxKoMLmj/RjNBBzpW01Dsd5gVOWU/MbCuQSViGCU5gq67w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCYccqDg6NqPPq+J3QeVG195W0kpyCZ9UZybxTLuvmYSy4RkhK
	UGiig0WUVAGHorfMpym5rJ905ItlfwG35lkoRXIWl2NjlLyOw15EfKYLEqdOYH0g9VCWDttrP8G
	t29MnZ1TDI8Il6o0mH77KbyVXeSNFDeKITrxDirj4tKh/a0ZktE6VMg==
X-Gm-Gg: ASbGnctgOuBRBAr3buIUDwFF4VVoI3SpT9ssI+iRXZYmUQwYUT+bvFQDv/MM79ituwV
	o1w8sGlWIIatsl2rUp/982nuaDuQ/JXQLBRqfrCxexGqPbwWzwdep1ej1t9zzgrX/C9nXFC0c8N
	5dS/bdXTii08c1aTrgdpw3m+I8egkTejlG+Q==
X-Google-Smtp-Source: AGHT+IFz+HSx0sPHxaqT/2ryZiLvwW0FGo7TvhCJVeAUt3Ijy/1TTMvCjDWpq7D5c4NehgvpI0/ArrAWEiUG2carwd8=
X-Received: by 2002:a2e:bc8e:0:b0:30b:e96a:7d69 with SMTP id
 38308e7fff4ca-328077b07f9mr49193121fa.35.1747684762489; Mon, 19 May 2025
 12:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com>
 <20250519140557.GA1236950@bhelgaas> <k3mfsjktgzcekqgsioap3hxjvjrjl3hjb77zz3zdwji4t7jptp@yg4jt27pzjbx>
 <CA+-6iNxFZpguwxC=EKpt0Qq4iuFpa2+Gh11AG5d05oeL8EiFsw@mail.gmail.com>
In-Reply-To: <CA+-6iNxFZpguwxC=EKpt0Qq4iuFpa2+Gh11AG5d05oeL8EiFsw@mail.gmail.com>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 19 May 2025 15:59:10 -0400
X-Gm-Features: AX0GCFskZakkvT379QbIWqiz9Yfh0axNrMhDWG_gmxbBb9JXZ3UKRtYyN9Ty-7U
Message-ID: <CA+-6iNxkYumAvk5G6KhYqON9K3bwxGn+My-22KZnGF5Pg8cgfA@mail.gmail.com>
Subject: Re: POSSIBLE REGRESSION: PCI/pwrctrl: Skip scanning for the device
 further if pwrctrl device is created
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, "'Cyril Brulebois" <kibi@debian.org>, 
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, 
	"'Nicolas Saenz Julienne" <nsaenz@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007999b60635829138"

--0000000000007999b60635829138
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 2:25=E2=80=AFPM Jim Quinlan <james.quinlan@broadcom=
.com> wrote:
>
> On Mon, May 19, 2025 at 1:28=E2=80=AFPM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, May 19, 2025 at 09:05:57AM -0500, Bjorn Helgaas wrote:
> > > On Mon, May 05, 2025 at 01:39:39PM -0400, Jim Quinlan wrote:
> > > > Hello,
> > > >
> > > > I recently rebased to the latest Linux master
> > > >
> > > > ebd297a2affa Linus.Torvalds Merge tag 'net-6.15-rc5' of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> > > >
> > > > and noticed that PCI is broken for
> > > > "drivers/pci/controller/pcie-brcmstb.c"  I've bisected this to the
> > > > following commit
> > > >
> > > > 2489eeb777af PCI/pwrctrl: Skip scanning for the device further if
> > > > pwrctrl device is created
> > > >
> > > > which is part of the series [1].  The driver in pcie-brcmstb.c is
> > > > expecting the add_bus() method to be invoked twice per boot-up, but
> > > > the second call does not happen.  Not only does this code in
> > > > brcm_pcie_add_bus() turn on regulators, it also subsequently initia=
tes
> > > > PCIe linkup.
> > > >
> > > > If I revert the aforementioned commit, all is well.
> > > >
> > > > FWIW, I have included the relevant sections of the PCIe DT we use a=
t [2].
> > >
> > > Mani, Bartosz, where are we at with this?  The 2489eeb777af commit lo=
g
> > > doesn't mention a problem fixed by that commit; it sounds more like a=
n
> > > optimization -- just avoiding an unnecessary scan.
> > >
> > > 2489eeb777af appeared in v6.15-rc1, so there's still time to revert i=
t
> > > before v6.15 if that's the right way to fix this regression.
> > >
> >
> > We need to find out what is happening in the pcie-brcmstb driver first.=
 From
> > Jim's report, it looks like the driver expects add_bus() callback to be=
 invoked
> > twice, which seems weird.
>
> Hi Mani,
>
> The pci_ops add_bus() method is invoked once for bus 0 and once for
> bus 1. Note that our controller only has one port.  If I do "lspci" I
> get (our controller is on pci domain=3D=3D1):
>
> 0001:00:00.0 PCI bridge: Broadcom Inc. and subsidiaries Device 7712 (rev =
20)
> 0001:01:00.0 Ethernet controller: Broadcom Inc. ...
>
> It is the second invocation of add_bus() that has the brcmstb driver
> turning on the regulators and the subsequent link-up, and this call
> never happens with the 2489eeb777aff9 commit.

Hello Mani,

Actually, I don't think it is sufficient to just revert that one
commit.  If I checkout 6.14-rc1 and just bring in

06bf05d7349c PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_devi=
ce()

I get the following after getting the Linux prompt:

pci 0001:00:00.0: deferred probe pending: pci: supplier
1000110000.pcie:pci@0,0 not ready
pci 0001:00:00.0: deferred probe pending: pci: supplier
1000110000.pcie:pci@0,0 not ready

Basically, brcmstb already picks up and controls the regulator nodes
under the port driver node.  You folks are adding a new generic system
and we are stepping on one another's toes.  The problem here is that I
cannot seem to turn your system off using CONFIG_PWR* settings.

We would certainly be open to adopting your system when it meets our
requirements; such as turning off/on on regulators @suspend/resume,
and the ability to not do that if the downstream device has
device_may_wakeup(dev)=3D=3Dtrue.  But until then we need a way to disable
your system or allow brcmstb to "opt out".

AFAICT this regression does not affect the RaspberryPi SoCs, so it is
not a big deal for us if we take our time to fix this.   But if so, it
is incumbent on you folks to help me get past this regression.  Is
that reasonable?

Regards,
Jim Quinlan
Broadcom STB/CM




>
> Regards,
> Jim Quinlan
> Broadcom STB/CM
>
>
> >
> > If the fix takes time, then we can revert 2489eeb777af in the meantime.
> >
> > - Mani
> >
> > --
> > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D

--0000000000007999b60635829138
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
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICYDCC
AlwCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCrJHZXPHfoliWyw7eAbJcyOa9Qm1YE
IFBYIyL18+iLZTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA1
MTkxOTU5MjJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQBdM8sdEPT/9342QVkrKLvgvY/iKKce9eBcCR7aiga9dsZyIcRnnv6g3a10KzIHkEGa
60DSRy2YsZ1pL9SFuxFfaw1W1UulR4daCW5yWC19x5+atWrRKONcEZABXV410rCFYGFXLyiFRSvM
n4NLTFtm8LCrOAgOhJHizKy7SfA08Lmf+v1+SKsE1w7tMPKpiMCOM9BZF/TppT5/7MdiBWy0Oi1D
eb/7Nw3fLhkVu+duPub+BbMt5Hy0/m6iez8L79Q3+LnPUiILXECxDhUvi05dx2+5z+ToYERM3v+q
O8hcQENbIMo7FKfY1FXzUywsOuxBR50G/zQYJjuFdB2Tq4md
--0000000000007999b60635829138--

