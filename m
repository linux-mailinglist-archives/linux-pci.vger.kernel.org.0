Return-Path: <linux-pci+bounces-41300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C09C60313
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 11:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C720F4E27DC
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABFF2877F7;
	Sat, 15 Nov 2025 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8HPcQ0P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9B32737F4
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763201083; cv=none; b=noA1p9CRjXZZviZ4D65HGXbspcNfHbRk5O4hpJ51Fi9Zkv1zixcrTVf11LpFhvx85OMR8r2MbWJN/XTG1jGnTRbwl65A3qT/VBZoeveg0UYYzL0OjdQH2B+NaiH0h6ElEC6BlXZSD2h1H2f4X/+nhT9u0zKpMxpB+tqxdVKBPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763201083; c=relaxed/simple;
	bh=zgjl9yCq9rPKjasEHPzdGjgJBDrAOD+3CpouL6oTMjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIUTnDis5bp+ZbhhJBY6kH+Ryb76jSRwIfLkHb+slEk/qVOJKbc4et61AtFJEm9+LxdjGC9tVKyZh78YXMKqdESFBh1MpMIydlFhDTUBGxv8QctqdJskk9N1Oi60OJqO94uzl3oIHU4B5sLGK3mbDsZBT/TUIBJHcCCsZ14UGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8HPcQ0P; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1949164a12.3
        for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 02:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763201080; x=1763805880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZhGFSTWU2Nki77TLqMBxYMwF/Hq7Nj2xup+lQAIdEs=;
        b=P8HPcQ0PRIOdgTyoXEu2GsIk1pmPsBbluE//rwRBzh4NTEYpsPrRy9TyybsnXH7yRD
         WDJS3A67tz0WHnrv+eiNvkqI2BrnCvtxmpea0SIvR/ZloXHydTn2gIsfmnK1UUWCsk32
         js6Ze3ZsjV3yd9FFNg6FGdafFLYyare6Fz4U2/MXDhaVRhZOE/OCk2a5vxU/HFmRrcgz
         T7mhnA9niCi288XHdwKOORn1bj3zT8fkL6/CCsymlva3XSedv59Klrtg7FanTbetEuA1
         /3FlVnqlq2HXwXob/jZ4DqjOzS4WKPzB93+R+GiNDQvXuMOxLo1QJDW5RgZ/4RU5HeVJ
         G5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763201080; x=1763805880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZhGFSTWU2Nki77TLqMBxYMwF/Hq7Nj2xup+lQAIdEs=;
        b=ku4zudnEgDAnFBe81eZwdIpe+8IxeeFZz4ydbd2A8QZXlm0vfrgd7Z08unhzGIyK0D
         Q8cRAxk28uSkNENUjqP9+cVrYVI54BKnKGwSZiJ7b3D85oVW0p7zOmUqvf4bSD/pkzwI
         HqObdi8B/dSMjUhpv5K+VfycHjti/b+1I7wFv6u63/RBmQ0Ml6xoeAitfFfA5JEZ8h9U
         ppoy404zW6Adp2Z+xlCPVAXvZ/bfknOwNCazixkPKLvvEdacTOpUR7+Y2DOjPTwBtosR
         R0sKzOTCpMfLBdYnobt9Ouac6sZETDN66FKqKNXa7pwoup/AulmKfgAYnF1V+wjkTMcw
         2LVg==
X-Forwarded-Encrypted: i=1; AJvYcCVI3qj8INh1OcEL7P4MtD4rU6o9GA7X+aPmY0UvckvRzpe01vVEY3lBJY44+EEEsWOW8Io4Sk0N2DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwJ0S2tpMWKSIkn1AFXwZikEVRIFHiKcfezwuYy8kYTeXFs2om
	8GdXXMCJ4TVUsD2/ghEv1JGW8yFtr+c7biEFl4pIAAXP+1Vnamyg7XTc
X-Gm-Gg: ASbGnctDLu7qyw2XgYPHE4PWmKcXM4dH0anRor/eEP0wgMMn/C7nWVW0yCUjw1gjtCN
	/FRsc44at0Z9O6fVM5Qrgv3HFBMibd8KpmDcOwEhCRhf92iLi0XBsGDiqgeo3Bl+/UYaiUhVrVR
	U36TDD7AHkN75p6JWP9ZP48iIXIeDPFom2KuS2q3QxX8AxCc88dXN6m88q1VgwlcBq+5OrkPMxj
	JZV8+a1e9/C4hhPF89Cpz4IWzTXkElP15eMPpPSvgg/15C3LRL3XcPkyEJSpw4eFjTzB7XmXqsF
	8dCMUHNDNmvQVJZ/jJfiKdJO1w70AqGBhjB3eGLBRFwfMrTOW1KPrFnngbN7Rs7hkFelbpCLZEb
	+UVw1WvsRJWYkPvP1V/77yh3ah/4fkYVaj4176n51TidrLHrSzl3FWTP6vzj2QraA0xf1RxRet2
	2Py1wNeKtx
X-Google-Smtp-Source: AGHT+IEN9KE2hfp03GE7uhiO9j7fRJeATScAJLPGVWT9cgl5CZeCVAf71AB1h38u4dnqNvb+75Hfxg==
X-Received: by 2002:a05:7300:c3a2:b0:2a4:3593:c7dd with SMTP id 5a478bee46e88-2a4abd4a140mr2291702eec.29.1763201079996;
        Sat, 15 Nov 2025 02:04:39 -0800 (PST)
Received: from geday ([2804:7f2:800b:a121::dead:c001])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d695821sm23290090eec.0.2025.11.15.02.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 02:04:39 -0800 (PST)
Date: Sat, 15 Nov 2025 07:04:33 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH 2/3] PCI: rockchip-host: comment danger of 5.0 GT/s speed
Message-ID: <aRhQMRjffbeCeArE@geday>
References: <cover.1763197368.git.geraldogabriel@gmail.com>
 <b04ed0deb42c914847dd28233010f9573d6b5902.1763197368.git.geraldogabriel@gmail.com>
 <c8a6d165-2cdd-cd0d-4bed-95dfa5ff30d2@manjaro.org>
 <aRhNIcGcQKp2ylqN@geday>
 <85d1543b-ea91-5f0f-59d6-e00fcf720938@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d1543b-ea91-5f0f-59d6-e00fcf720938@manjaro.org>

On Sat, Nov 15, 2025 at 11:01:21AM +0100, Dragan Simic wrote:
> On Saturday, November 15, 2025 10:51 CET, Geraldo Nascimento <geraldogabriel@gmail.com> wrote:
> > On Sat, Nov 15, 2025 at 10:30:49AM +0100, Dragan Simic wrote:
> > > Looking good to me, thanks for this patch!  There's no need
> > > to emit warnings here, because they'd be emitted already in
> > > the rockchip_pcie_parse_dt() function.
> > > 
> > > Please feel free to include
> > > 
> > > Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> > >
> > 
> > I disagree, I think the comment stands.
> > 
> > Even if we reduce to one line, ex:
> > 
> > + May cause damage
> 
> Ah, perhaps I wasn't clear enough, so let me clarify a bit.  The
> comment you added is fine, I just referred to no need for emitting
> a warning at that point, because it would be emitted already.

OK, I get it now so I think it's time to send v2 with all that in mind
:)

Thanks,
Geraldo Nascimento

