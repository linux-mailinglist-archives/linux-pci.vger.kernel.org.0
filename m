Return-Path: <linux-pci+bounces-4551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCA4873113
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 09:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3748B27DB8
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086B85D8ED;
	Wed,  6 Mar 2024 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ez6bQX5H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2C5D8E3
	for <linux-pci@vger.kernel.org>; Wed,  6 Mar 2024 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714923; cv=none; b=uhV7bgKBUnCdrjMoQnL+axe7kw+TQjmWfHYR2DUK+US61XsCKEgAdfG59bV6184wftBz8lsWkWS4YM55qhmpCl45X6xcbY0rCmKYhB5K6Kv0MZFNSFisST2H+l9VCR8h8bUijJBA88N1NG7jHvsLk5SeoW3utEK0Z3tCCenpCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714923; c=relaxed/simple;
	bh=wPJcMt9czU8S/KRgNJR9WUU4PL6FneJAhBauOiwGrYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFAhtucdYimBzATgZP8r3YqQ3WzWlA06kOmia6sht6hquRBytfTLU78mjo31d+HrB0d6Y4L3RnOr9+sMJezsPtEO6oWmDkONonNqoJxUWwDQZBPSQjdprDY4J3WjZxwTjBbJcKPiJVjqGZDu68rbUq+l4ncjXl19B8xhhlg3UAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ez6bQX5H; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso760152276.2
        for <linux-pci@vger.kernel.org>; Wed, 06 Mar 2024 00:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709714921; x=1710319721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPJcMt9czU8S/KRgNJR9WUU4PL6FneJAhBauOiwGrYc=;
        b=ez6bQX5HRSTrgYagVveNUnmh49t6CNBD8kz6yQNxTbammHOs13dxZBHGnm3wlYALt9
         KLlwq3x/L9bhP/9HSaCbKC/B6rUUmeT3ZPRlc+qCH5n6B3Sbxbnn4p/G0KcvMvKetPH+
         Bp+7Y482CbYEARzIPAVyUidzXJ1hh5A3PNHl1TrAGLawsTkDY4bXmTOjftvERbuM0hFQ
         Az8ot1a8z271KKFq6pexhmWnNC3okqgfJ1mV44jT+CrOf4ZRWggEd25w9F8y4RGO3B4P
         wJvBkt1LLssl3eZJ0bQzDOk/cRWRJLXVxrsKQ63SVOw76UMZuWTRHYuvkd8/yZqk5bJn
         7I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709714921; x=1710319721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPJcMt9czU8S/KRgNJR9WUU4PL6FneJAhBauOiwGrYc=;
        b=RfqqNFkSGSHbT1wYtTp5awIOyzVX6RS5raLbFv333QFdK56OjlooX4pQ0iDm/Ep6pw
         teYywMqxfP/oNXeOalI6uiYuw1jQzWZpaJxdoXcualhO8UQFWnxzQsEpBlYgX2OaL6NU
         91j5IAG4ZO/skvJWbfNR0aZwvcaTViUY9C4MKvTR7R8KfBTbkQNANt5EsRQ+0S0I1Bb+
         XCTGmoMMq7V5E0hQZIoG369P/f5iza7bEPnm7EjVFkJi1jD3mj4JWZCEIVw6b7dpInEk
         FgyR13Uf0Kfbu8l7quxZvXDh2pbMrNsF2A4LCiKbGZ8p68BkIQ268jMq1GRiQCyW76ja
         CkuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwZ2NiS3BsKBDzUC0sQr6gu1I9Hi7soQ2navcSlSMboSUC3dxRTDLcBuHSkYJVCTDdRbQD0njmIjEcdusKIvduFvX46Ybcn+7d
X-Gm-Message-State: AOJu0YweisVDxSbu0AawgY+aR7lBTx0drzKvs1Al0BWYtJfjIUdaQ7SK
	JG4cMfasUUd80w50RSR0umS9msHL15hMFzQSSf8a1NuYHqRgOxtcUpoVVvLWBL5Qmsjgz8V79Bt
	VowLv8Fr3K8LYQIzPVzUw955ic+Hcj16oRGK1nA==
X-Google-Smtp-Source: AGHT+IE/OGvZjx188gRZgR4wDRH/ncR9ek4Ya12dCwo+/8O0NkFRB5fPO64Z6CLWaYRIvZOAD10qAlCtxbCc4oLZ9dc=
X-Received: by 2002:a25:ae53:0:b0:dc7:42b8:2561 with SMTP id
 g19-20020a25ae53000000b00dc742b82561mr11571546ybe.34.1709714921292; Wed, 06
 Mar 2024 00:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305081105.11912-1-johan+linaro@kernel.org>
 <20240306063302.GA4129@thinkpad> <ZegZMNWxCnLbHDxP@hovoldconsulting.com> <20240306083925.GB4129@thinkpad>
In-Reply-To: <20240306083925.GB4129@thinkpad>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 6 Mar 2024 10:48:30 +0200
Message-ID: <CAA8EJppsbX=YXf1Z6Ud+YMnp2XnutN1hcb1T0KdAAWXFREVxXg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] arm64: dts: qcom: sc8280xp: PCIe fixes and GICv3
 ITS enable
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Mar 2024 at 10:39, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Mar 06, 2024 at 08:20:16AM +0100, Johan Hovold wrote:
> > On Wed, Mar 06, 2024 at 12:03:02PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Mar 05, 2024 at 09:10:55AM +0100, Johan Hovold wrote:
> > > > This series addresses a few problems with the sc8280xp PCIe
> > > > implementation.
> > > >
> > > > The DWC PCIe controller can either use its internal MSI controller =
or an
> > > > external one such as the GICv3 ITS. Enabling the latter allows for
> > > > assigning affinity to individual interrupts, but results in a large
> > > > amount of Correctable Errors being logged on both the Lenovo ThinkP=
ad
> > > > X13s and the sc8280xp-crd reference design.
> > > >
> > > > It turns out that these errors are always generated, but for some y=
et to
> > > > be determined reason, the AER interrupts are never received when us=
ing
> > > > the internal MSI controller, which makes the link errors harder to
> > > > notice.
> >
> > > > Enabling AER error reporting on sc8280xp could similarly also revea=
l
> > > > existing problems with the related sa8295p and sa8540p platforms as=
 they
> > > > share the base dtsi.
> > > >
> > > > After discussing this with Bjorn Andersson at Qualcomm we have deci=
ded
> > > > to go ahead and disable L0s for all controllers on the CRD and the
> > > > X13s.
> >
> > > Just received confirmation from Qcom that L0s is not supported for an=
y of the
> > > PCIe instances in sc8280xp (and its derivatives). Please move the pro=
perty to
> > > SoC dtsi.
> >
> > Ok, thanks for confirming. But then the devicetree property is not the
> > right way to handle this, and we should disable L0s based on the
> > compatible string instead.
> >
>
> Hmm. I checked further and got the info that there is no change in the IP=
, but
> the PHY sequence is not tuned correctly for L0s (as I suspected earlier).=
 So
> there will be AERs when L0s is enabled on any controller instance. And th=
ere
> will be no updated PHY sequence in the future also for this chipset.

Why? If it is a bug in the PHY driver, it should be fixed there
instead of adding workarounds.

>
> So yeah, let's disable it in the driver instead.
>
> > > > As we are now at 6.8-rc7, I've rebased this series on the Qualcomm =
PCIe
> > > > binding rework in linux-next so that the whole series can be merged=
 for
> > > > 6.9 (the 'aspm-no-l0s' support and devicetree fixes are all marked =
for
> > > > stable backport anyway).
> >
> > I'll respin the series. Looks like we've already missed the chance to
> > enable ITS in 6.9 anyway.
> >
>
> Sounds good, thanks!
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
>


--=20
With best wishes
Dmitry

