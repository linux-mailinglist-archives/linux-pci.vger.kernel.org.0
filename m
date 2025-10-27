Return-Path: <linux-pci+bounces-39481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C62DC11FD5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 00:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AFC54EA09A
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 23:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E61132E695;
	Mon, 27 Oct 2025 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZLEYKlS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788B032E72F
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607352; cv=none; b=gHc9Gj7gW9TU1um5DClDShcTBYi3JEgHXJIVDDiJ83Th4W7k7u6nofqNffryn7dYoHV9OxOhgMshbiUsMXHdXp8cMFOojrxxxJ0Q+Cu+ZySmqQXcT3GQZQtC/PPe/ITqAc78KmvUQpvSWsjRGGUMoOPpPTIaD0c3KP9xiGCx1NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607352; c=relaxed/simple;
	bh=mJWc8tuamwRvKBHwqvZqDIpGBJpXDSGuAbIa52ymKvw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XATdFEewm+eHAwhCQpoGgYlq/wEBBCSu7MS17S9nej0ej0n5D/Xnvu+Z6YBTzjObLamEn5PdgqkOpdrpt9nAlsYyRTPf2Laoz+SFbsCR6Do+v9gMqlXnfELR5VT6cfVtFzkBBvbdasiGlRil5XYIalJFu8JA7fBo96p9jDxO1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZLEYKlS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4711b95226dso65514915e9.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 16:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761607349; x=1762212149; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mJWc8tuamwRvKBHwqvZqDIpGBJpXDSGuAbIa52ymKvw=;
        b=gZLEYKlSyaY7U9LEWIi47p19Q9/JOhfXOlb4Hdw+HXaZHLdu1LYjJvDkdaFXCk7XBU
         ZDrusxMzNEAbTalACjyz4XWHZ65PHNsDDYdsR2GYD0WyNc1+8UtxpMF82gJwoHnPU+G5
         5PdK0yOdmjWeQGhahsllfnBXrWTb3QkzbS7udTfBvUHwXv5lZdrWFHkEwidZAb+mbicz
         a7FCABirZVq6Ib3D1aLmAIjiqz8XMJX7THpALho+rA+H+SLNYMMJAMMNwiuMJaOatZ+W
         k4MscIy/Yh+TID/wg6A8Zhd61HkCVvxS+YR7giXlnsqdE9Z5zTTo3+acZGCsm6SnAmqg
         0jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761607349; x=1762212149;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJWc8tuamwRvKBHwqvZqDIpGBJpXDSGuAbIa52ymKvw=;
        b=SYR99hBuJTCVfE0ODsasxZkrq99MHMWkTOklwO8XZmCHnIax23rZrkz9zOCRt0NhW9
         ii3ArRKFjjwFOrd/35JUCOFwqtBbjKLKdo+1hSdQ1Gs+/iqRmwKu1cnj7Q7uNTGD4BLA
         VCKy/+yqmPdu227FiOv7vlkNFZjC7/QwcfSQJ0BpqmAyIIByAtAifX0AmRH2/Vp2aWe9
         0dewz82pWJOTkUKZX3zuzLA32Nfz4Q0HSaEgChNVTmvzWy5tV3HlRFuWCYJLaM4dDNmG
         ybfDhIxJO3dkfZqbnhD56wboFR9sglQ8G0acDJrvyDj5gVCPQyklc6TOSxRx3fdIGNKQ
         wM8A==
X-Forwarded-Encrypted: i=1; AJvYcCVY6Ca7QdH6oce1mYtqQrXzHFCeuVgnsZf2FUmcmRqfzEW8UCRZ1sm3+QxteDTfSPcrjB6/ceTgY6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz53r5cL5fxkbGqAzxg3r+/rg5hAUBO87A3m8yIeDN/k1Y8WGe7
	cIPWCelhq1LA7/2ZTuyePYSLYhBiObs6jdvoj7/JCLYImoSYb6+9/xtm
X-Gm-Gg: ASbGnctS9i7eTuq6vhYmX+jObQP3seizC262o5YvZHNJD8OROIrIoWWMU2igznxIzWp
	clrpVdvRGBsd+x5RoeZPbZlIDGOTDrHOqo5wByHXurofir9qvVQFDBz1avoi0h6DftE/ghwVolL
	iWK5uDAV+Uh7664V87gWVFkWJBmz6l1OLCJTw6Qbc1pdINccNY83UohJPK7ZYP/R0UgpJCFmf9d
	bUqdiYVlImqQ6r9lnsLT580lGwQMwXSVpK7KURQcsIhGZXZtt/osQULbDx3UZXpXpUXZccNxrOx
	+h7O0i+gN3cW041C0nngT8YZdmc7unNPEtefr8LSsonkDCo3LKPC44dQbZwjE/0VAwdWIem8aBK
	hdzr6nj5/oAFtIqgs2mBn0esFEDDxeYc5eHiIsmd1fOJUKBST581yNm3KT/y2CUNy3x/CVDF8x+
	yfUwK13Ef+yod+JFTFY/jAzuk=
X-Google-Smtp-Source: AGHT+IGTSUIpvShoog+TN7Pzwlu9mDf4kFChPIBSClN9rsKLNQK1m4VTu25fdbNyZoOiI5cHKpmkOw==
X-Received: by 2002:a05:600c:3f0d:b0:46e:3f75:da49 with SMTP id 5b1f17b1804b1-47717e7a69amr9320825e9.37.1761607348617;
        Mon, 27 Oct 2025 16:22:28 -0700 (PDT)
Received: from vitor-nb.Home (bl19-170-125.dsl.telepac.pt. [2.80.170.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771900dad7sm4540145e9.6.2025.10.27.16.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 16:22:28 -0700 (PDT)
Message-ID: <2c3e4bdefb306dc89c15bebc549d854ea2b4cc32.camel@gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: PCI: ti,j721e-pci-host: Add
 optional regulator supplies
From: Vitor Soares <ivitro@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Vitor Soares <vitor.soares@toradex.com>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 27 Oct 2025 23:22:26 +0000
In-Reply-To: <20251020-kickass-fervent-capybara-9c48a0@kuoka>
References: <20251014112553.398845-1-ivitro@gmail.com>
	 <20251014112553.398845-2-ivitro@gmail.com>
	 <20251020-kickass-fervent-capybara-9c48a0@kuoka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

Thank you for the feedback.

On Mon, 2025-10-20 at 13:14 +0200, Krzysztof Kozlowski wrote:
> On Tue, Oct 14, 2025 at 12:25:48PM +0100, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> >=20
> > Add optional regulator supply properties for PCIe endpoints on TI SoCs.
> > Some boards provide dedicated regulators for PCIe devices, such as
> > 1.5V (miniPCIe), 3.3V (common for M.2 or miniPCIe), or 12V
> > (for high-power devices). These supplies are now described as optional
> > properties to allow the driver to control endpoint power where supporte=
d.
>=20
> Last sentence is completely redundant. Please do not describe DT, we
> all can read the patch. Driver is irrelevant here.
>=20
>=20
Ack, I will remove last sentence.

>=20
> How you described here and in descriptions, suggests these are rather
> port properties, not the controller.

You are right - these supplies power the PCIe slot/connector, not the contr=
oller
itself. However, as per my understanding, the current kernel practice is to
place slot supplies in the root complex node rather than the endpoint node.=
 as
seen in e.g.:
- imx6q-pcie.yaml
- rockchip-dw-pcie.yaml
- rcar-pci-host.yaml

This seems consistent with those existing bindings, but please let me know =
if
I=E2=80=99m overlooking something specific to this case.

>=20
> >=20
> > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > ---
> > =C2=A0.../devicetree/bindings/pci/ti,j721e-pci-host.yaml | 14 +++++++++=
+++++
> > =C2=A01 file changed, 14 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.ya=
ml
> > b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> > index c704099f134b..a20b03406448 100644
> > --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> > +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> > @@ -110,6 +110,18 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > =C2=A0
> > +=C2=A0 vpcie1v5-supply:
>=20
> How is it called in this device datasheet (not the board schematics)?

The TI SoC datasheet describes the controller interface but doesn=E2=80=99t=
 define these
external supply rails - they are board-level regulators specific to the slo=
t.

>=20
> > +=C2=A0=C2=A0=C2=A0 description: 1.5V regulator used to power PCIe inte=
rfaces,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 typically present on miniPCIe slots.
>=20
> Best regards,
> Krzysztof
>=20

Best regards,
Vitor Soares

