Return-Path: <linux-pci+bounces-19421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08172A0425A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B343165B2F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE141F0E36;
	Tue,  7 Jan 2025 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTe6Eu7J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087611DF749;
	Tue,  7 Jan 2025 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259783; cv=none; b=LROs7cRo4Q17k8R3xza1D+4yIQbiiPDzNLafxo9+/xQwvDju2dmcaEQOEEVc6U218TrTSVeKV1ZH/PAV/zRVvL2WKBmjJHaUBf1IglBR8Enfu3iDvOMvzmbTPOKaTh9M4R7uidnniJPCRUjrticD9bUFlkmq8HavyIKqplzCWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259783; c=relaxed/simple;
	bh=XumDMLAbqkhnyDz/dDcKcCAFPBsTz0nD1eivBz5CzY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlCzV6YPx+rYAPpMhyEQ5hKPRIEzi+lwZ2QcnIcnlBOKogkNukHJt3+ZmlH5Rp2RYSFCimPFTBR21eVqnM+i0YZAxpY2ErGVjqNna5oXy0BmsyYvDVDIJF8Mn77GZ17o1WunQfk1hBL4a74megArOXeMB6m9JfKIE0Fu7jZpmUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTe6Eu7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE8EC4CEE0;
	Tue,  7 Jan 2025 14:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736259782;
	bh=XumDMLAbqkhnyDz/dDcKcCAFPBsTz0nD1eivBz5CzY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QTe6Eu7J16nTxBgCqj+6qo7tGooq8zgvUUDbmHhrBhnwhbnw9i8K2sI06LixutNlj
	 JSSsAS074HXjv2PjWHt+gKpzJBDtCcqNSe6Vp52OqqnnmVbKQMf/AYPHQPRtlE2owH
	 RUfV7F70oJeJ4y9n0BJkgXR23LLRt5367PCiQZq9KoPcYhIZEWhzpdwhdFM2LL3VF3
	 9KEQfnT8MQohTq57LMRMu7UrIIBfvC9pdbXzFrdRmFHIvoPRalkMBnSIAs0cwAmO4Q
	 NGMDkwo0kcRHvd+MAhiIRhEGxq6Dz5GtBpBs9zHIitwFQZdNFfrFCgPqquzWOdSErZ
	 aiYQtGs7WDSFw==
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e53537d8feeso20618662276.0;
        Tue, 07 Jan 2025 06:23:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1lgXjxlT1AJQF2cfNadubMSAA6JO/KVclBPg4WddLThsTVLQ9kF1llRrEWEWJJIz0Cb3q8okCH4wyZoIiYA0=@vger.kernel.org, AJvYcCW2DD/CEsGYej6cirCPsNxglttqwNArFHGzOS7OV3e9SKximPxbeSKPjtvzX7tO8rTW/qokdeKNIsjqyZlt@vger.kernel.org, AJvYcCXB16D1ie0Dn5m+AwsdA7L2Yvd9ZjZDdZE31tPo8OLfx3lyk1wAvQ4K8I9cVqnV2b39oSn+WylwTepI@vger.kernel.org, AJvYcCXJEGVCFAMmiIbv8NnfDZk6Dl9zv1hTjnWXJR7DrJokFLls62Cb+9ikJRS4yS28zxMO3szFZLIcyZkhi8cCRA==@vger.kernel.org, AJvYcCXsLtiI7nJ66EAxXfWDhYZnWyx5luLx0crD9/NchB0j9ypIp9XvrGk7Nula2N7CRHDfqjjp+3sdpUvNYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoW2JGU75eG1oRPrhXCfqoAO6jK1cZG+C7oLAp8dU18Ojyr4aa
	T0c6oUgT+XqMlOlLv6rYuqZHqqXXRJwyRdrH0650taR9HawWUX4+oRTmSn7KYBrVrT4hKa1Ydlj
	TsTeikdPxbXrbQZT18v+SS/6Usg==
X-Google-Smtp-Source: AGHT+IGHo8fmWD04h+JCrYuXZlP1ao+KuFmwZqgSmkjvK6+8NoE9jk4fInapJpbRYcWa7knk2/MJBrcm65WQZmMzzsY=
X-Received: by 2002:a05:690c:d96:b0:6ef:805c:ea15 with SMTP id
 00721157ae682-6f3f815b496mr426649477b3.23.1736259781608; Tue, 07 Jan 2025
 06:23:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106093304.604829-1-krishna.chundru@oss.qualcomm.com> <20250106233246.GA116572@bhelgaas>
In-Reply-To: <20250106233246.GA116572@bhelgaas>
From: Rob Herring <robh@kernel.org>
Date: Tue, 7 Jan 2025 08:22:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKejDi-_4MfxZ8aT+pEcfsTTm36jfe6tBuNgkDdT_ZnTA@mail.gmail.com>
Message-ID: <CAL_JsqKejDi-_4MfxZ8aT+pEcfsTTm36jfe6tBuNgkDdT_ZnTA@mail.gmail.com>
Subject: Re: [PATCH V1] schemas: pci: bridge: Document PCI L0s & L1 entry
 delay and nfts
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, manivannan.sadhasivam@linaro.org, 
	krzk@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 5:32=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Mon, Jan 06, 2025 at 03:03:04PM +0530, Krishna Chaitanya Chundru wrote=
:
> > Some controllers and endpoints provide provision to program the entry
> > delays of L0s & L1 which will allow the link to enter L0s & L1 more
> > aggressively to save power.
>
> Although these are sort of related because FTS is used during L0s->L1
> transitions, I think these are subtle enough that it's worth splitting
> this into two patches.
>
> > As per PCIe spec 6 sec 4.2.5.6, the number of Fast Training Sequence (F=
TS)
> > can be programmed by the controllers or endpoints that is used for bit =
and
> > Symbol lock when transitioning from L0s to L0 based upon the PCIe data =
rate
> > FTS value can vary. So define a array for each data rate for nfts.
> >
> > These values needs to be programmed before link training.
>
> IIUC, the point of this is to program the N_FTS value ("number of Fast
> Training Sequences required by the Receiver" as described in PCIe
> r6.0, sec 4.2.5.1, tables 4-25, 4-26, 4-27 for TS1, TS2, and Modified
> TS1/TS2 Ordered Sets).
>
> During Link training, all PCIe components transmit the N_FTS value
> they require.  Sec 4.2.5.6 only describes the Fast Training Sequence
> from a protocol perspective.  The fact that the N_FTS value of a
> device may be programmable is device-specific.
>
> Possible text:
>
>   Per PCIe r6.0, sec 4.2.5.1, during Link training, a PCIe component
>   captures the N_FTS value it receives.  Per 4.2.5.6, when
>   transitioning the Link from L0s to L0, it must transmit N_FTS Fast
>   Training Sequences to enable the receiver to obtain bit and Symbol
>   lock.
>
>   Components may have device-specific ways to configure N_FTS values
>   to advertise during Link training.  Define an n_fts array with an
>   entry for each supported data rate.
>
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.=
com>
> > ---
> > - This change was suggested in this patch: https://lore.kernel.org/all/=
20241211060000.3vn3iumouggjcbva@thinkpad/
> > ---
> >  dtschema/schemas/pci/pci-bus-common.yaml | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schema=
s/pci/pci-bus-common.yaml
> > index 94b648f..f0655ba 100644
> > --- a/dtschema/schemas/pci/pci-bus-common.yaml
> > +++ b/dtschema/schemas/pci/pci-bus-common.yaml
> > @@ -128,6 +128,16 @@ properties:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      enum: [ 1, 2, 4, 8, 16, 32 ]
> >
> > +  nfts:
> > +    description:
> > +      Number of Fast Training Sequence (FTS) used during L0s to L0 exi=
t for bit
> > +      and Symbol lock.
>
> I think it's worth using the "number of Fast Training Sequences
> required by the Receiver" language from the spec to hint that these
> values will be used to program a component with the number of FTSs
> that it requires as a Receiver, and the component will advertise this
> number as N_FTS during Link training.
>
>   n_fts:

n-fts

Underscores are discouraged.

