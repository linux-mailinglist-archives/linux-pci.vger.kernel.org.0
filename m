Return-Path: <linux-pci+bounces-33872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85894B22E74
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 19:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EFF1A260E3
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74382FA0FD;
	Tue, 12 Aug 2025 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLcPmm4F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE512882AB;
	Tue, 12 Aug 2025 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017960; cv=none; b=Ow+v+WQ8DAb69Ael6jZatqIMoxJl7JXaGeJ9Hh0cLT00QnkZ4Dk3BCe6VAS37YxELGeXeIHVOUF2VtMlbJ+n3XxBIBy6sSXCZZVjCChF4YYBLqQAmhQob81C4V+SeLe7F28ap3J4Xzb8A7eQREHKDqPrA4sCtm1iocjRG8i5mVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017960; c=relaxed/simple;
	bh=QG7yl+OjilKldnfrLrCLthek8RiczM5eXczR66KP9Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiTBuP+m5Scluye3ylYLKzdMWsV+vS+QM3/f3k6fxWjrXIb7NfL8wFiz+9VOn+Rrtu/xi326jlqKcdp5EDJLZWRDAFM4Eqb7NTqrkH8EHo0UFq7VtBEZ3Kgk+5yXqnR8GLBXj/JydvK6ekGlS4YaNPTLQON0wHefU6KtMw/LxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLcPmm4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EB0C4CEF6;
	Tue, 12 Aug 2025 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755017960;
	bh=QG7yl+OjilKldnfrLrCLthek8RiczM5eXczR66KP9Ig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LLcPmm4FxuZN9IuO5Mm3ufQP8b+kubAPSbN+GqlLnKUS/+IZgSxgiK/N5TIrELyvb
	 oRy+bMXzHKnDSNST/BjkfnjLChHLjJGEqWaaq2H4VTPX5Xm4za4mOh0TAbbHFbjiFf
	 pXDIvOQlrIeq/TF4k2Zoy44DRqmop4FqMn93QWw+ikf02SoY/s6xKdpoKh1orGRz+s
	 KCre5hg+zd0pswPZCrvyUJ4QxFYDxEc9dSvjVG0xYIv91APJ2sZMPjKmt92Y2fyI55
	 IR0gx2ab+w4mrBMvqif9lWG3dO8CXl3RBY4F/S99aSD7DifCKsDLvYfXe0FHF3KY8l
	 UAYoDP+k64SqQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6152faff57eso8981078a12.1;
        Tue, 12 Aug 2025 09:59:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSq6MeEOl3rTaTJffO4hO+971b7DKvw6RBuAf6CcF89WHgNVeZty4Ocfc1E9XpKOLMW41v5pdjRp6+@vger.kernel.org, AJvYcCUeaHtOp7Jj0vLqkFI+7b+94PJh+2XpuNMS3hXU/J+gG4n8DYSqXUyWxL0ZLmXN7eBsJ0XulNk/6HWVTZSf@vger.kernel.org, AJvYcCWTQ9vvS5urJ5avGJodl/cNTun0Wh50eOFk5QnEoJ17WUE4YwsNIptfvjLil6RWYrLCHenENakzy4zN@vger.kernel.org
X-Gm-Message-State: AOJu0YzSbvBwGPSgqDmAbnPRo8a175806s9gmwlR9TVvou7fmWINuEAq
	oun174viUqJuulCqbtDWJeGTbZ63RLzKfZLEApJUizPvWvtpjIsY0kZ/pikSFno1mS3Q6LH6QJZ
	jPQ6mLk/yV/2pFz61pApe5Z1K2RySAA==
X-Google-Smtp-Source: AGHT+IF1rFMvLqTw0zhBnEbF/24oh+pXC7Cyhcry2T0uiCBMH7+QMKcaZshDTGiUzXOGycYjeiwyJQZcWXyjV2prnqU=
X-Received: by 2002:a17:907:2d1e:b0:ad8:9257:573a with SMTP id
 a640c23a62f3a-afca4cba79emr5530366b.5.1755017958559; Tue, 12 Aug 2025
 09:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJms+YT8TnpzpCY8@lpieralisi> <c627564a-ccc3-9404-ba87-078fb8d10fea@amd.com>
 <aJrwgKUNh68Dx1Fo@lpieralisi> <e15ebb26-15ac-ef7a-c91b-28112f44db55@amd.com>
In-Reply-To: <e15ebb26-15ac-ef7a-c91b-28112f44db55@amd.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Aug 2025 11:59:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJF6s8GsGe1w6KEkeECab956YiBSFbdbHOiiCv2+v3MAA@mail.gmail.com>
X-Gm-Features: Ac12FXwQ-VolqLcu_Kk_NoubrTpWU2JGnruO8pHHND6fvG1ZgFz7YpsckQnOIjA
Message-ID: <CAL_JsqJF6s8GsGe1w6KEkeECab956YiBSFbdbHOiiCv2+v3MAA@mail.gmail.com>
Subject: Re: Issues with OF_DYNAMIC PCI bridge node generation
 (kmemleak/interrupt-map IC reg property)
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, maz@kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:53=E2=80=AFAM Lizhi Hou <lizhi.hou@amd.com> wrot=
e:
>
>
> On 8/12/25 00:42, Lorenzo Pieralisi wrote:
> > On Mon, Aug 11, 2025 at 08:26:11PM -0700, Lizhi Hou wrote:
> >> On 8/11/25 01:42, Lorenzo Pieralisi wrote:
> >>
> >>> Hi Lizhi, Rob,
> >>>
> >>> while debugging something unrelated I noticed two issues
> >>> (related) caused by the automatic generation of device nodes
> >>> for PCI bridges.
> >>>
> >>> GICv5 interrupt controller DT top level node [1] does not have a "reg=
"
> >>> property, because it represents the top level node, children (IRSes a=
nd ITSs)
> >>> are nested.
> >>>
> >>> It does provide #address-cells since it has child nodes, so it has to
> >>> have a "ranges" property as well.
> >>>
> >>> You have added code to automatically generate properties for PCI brid=
ges
> >>> and in particular this code [2] creates an interrupt-map property for
> >>> the PCI bridges (other than the host bridge if it has got an OF node
> >>> already).
> >>>
> >>> That code fails on GICv5, because the interrupt controller node does =
not
> >>> have a "reg" property (and AFAIU it does not have to - as a matter of
> >>> fact, INTx mapping works on GICv5 with the interrupt-map in the
> >>> host bridge node containing zeros in the parent unit interrupt
> >>> specifier #address-cells).
> >> Does GICv5 have 'interrupt-controller' but not 'interrupt-map'? I thin=
k
> >> of_irq_parse_raw will not check its parent in this case.
> > But that's not the problem. GICv5 does not have an interrupt-map,
> > the issue here is that GICv5 _is_ the parent and does not have
> > a "reg" property. Why does the code in [2] check the reg property
> > for the parent node while building the interrupt-map property for
> > the PCI bridge ?
>
> Based on the document, if #address-cells is not zero, it needs to get
> parent unit address. Maybe there is way to get the parent unit address
> other than read 'reg'?  Or maybe zero should be used as parent unit
> address if 'reg' does not exist?
>
> Rob, Could you give us some advise on this?

If there's no 'reg', then 'ranges' parent address can be used. If
'ranges' is boolean (i.e. 1:1), then shrug. Just use 0. Probably, 0
should just always be used because I don't think it ever matters.

From my read of the kernel's interrupt parsing code, only the original
device's node (i.e. the one with 'interrupts') address is ever used in
the parsing and matching. So the values in the parent's address cells
don't matter. If a subsequent 'interrupt-map' is the parent, then the
code would compare the original address with the parent's
interrupt-map entries (if not masked). That kind of seems wrong to me,
but also unlikely to ever occur if it hasn't already. And that code is
something I don't want to touch because we tend to break platforms
when we do. The addresses are intertwined with the interrupt
translating because interrupts used to be part of the buses (e.g ISA).
That hasn't been the case for any h/w in the last 20 years.

