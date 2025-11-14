Return-Path: <linux-pci+bounces-41246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9398C5DACC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 15:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7638335C53F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3878324B37;
	Fri, 14 Nov 2025 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXRAkBfS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5531BCA3
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763130914; cv=none; b=JxXIBi1zUC4ihuk2OSpg23ht/+PJaySQ+nnaPhvthbNAI7jEfYVdOY8tL7SsPJ9fbzv9Q3IQ8lIMw20M4q3+bFTtwPezi9h8QGKvimgFZReJG/A8ob/BUbJo/2eO4d4ZqZpam0LXtTxNa95OmFlUFuhqHIOt+ez+Znf+ts1hIeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763130914; c=relaxed/simple;
	bh=dWXLhPsJovH76m+UWdSFM19WXCf+smwi4mOSlHBAWM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JEEtA7J15r8g5GGDyyuMKM0qyKgqq01FsTJuO79WywiTnIlBE1mSa0KKR3ygkDA/qE+87AA4LV6PjJ+PKg9NcuZFVg3uiouw1X6Ytn+6eKgUO5VCt+2F22/43QvzT2DNDSnEKpGmqOnF94f9cpTJhkIW9Od7ZkwJUtT31RtXAAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dXRAkBfS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b32a5494dso1214639f8f.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 06:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763130911; x=1763735711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWXLhPsJovH76m+UWdSFM19WXCf+smwi4mOSlHBAWM0=;
        b=dXRAkBfSiyMfYZAJRzRwBxxmeM1R62eUIdzMH4Stwpo0ClJ9R+z/UCUn5ZiinRtG2d
         exO6qlnWDDZQe/opu4VT9ZIhdYDyevv6BI7A1i4/N0HbfsEwe/CjfBkrbW5LYMhaCsUK
         g0mt3tbBDDvtX/f9TJ1s55PCTluRyYLfqj7l0J2GPl9pP5bVTffdr4+i+NRUGIdVKZDJ
         JfiVUo1z6wZ94aAce6cbrR20ddoiRMgcKoMoai/lnGhX1CQvv1OUOiPRDSFfgu4C+EUW
         13DqtGhbgr2U5gVjZ9Kr+dhsj7e8KRnppTbFBC9vGyO8KpVIb0Lv5QQe25C15xheeG2L
         ZQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763130911; x=1763735711;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWXLhPsJovH76m+UWdSFM19WXCf+smwi4mOSlHBAWM0=;
        b=CNcCelfw0AXNxP1S6EtF04ReZVJ3R8FPFgdnDAsvTH4H6R7x9CCG4oJkYk9KWOgTtf
         VShLejJlOs4M1N8Scj9sPEe19uWdvRMHFcx44/d3KNn1dhiuGkcsT1Qq7p6RjwpMwyHc
         pddRjB2YNBz+U6HdvM4ZcdIYqFx/hQievcmcZGMVWqqGxoD1Yil3L13wp+irQneERQuX
         gpH+A+joV0wkIHaIeU7LAfyQiMqfADRB7cotdFcxN/BejjevtIZqtTEePKJUduqm5li0
         AsxZeUp+m8zSe2IoLgD99F4jTMdgiF19CrCF5tVv283Z/Q1anUUw0BBFskMMBXp2c1Wj
         4UHA==
X-Forwarded-Encrypted: i=1; AJvYcCXzkNJIsXZIF9xExLWcANoGCfJdoYXXLKqElxFRK+H6auXIOuh0P9Oqz1H0vxqBmpZoH1H/W4Ac+ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr9LoVoKKbO6V/4mJL2xVs2CiccqcZBdAJwQv91d0BlCRd6j17
	tBu+jeDmEfEpwFYo3fot0h7cu+jHzS3pcw101883bU+s/Fj/BVV7sPSxuLEjOqPfMLw=
X-Gm-Gg: ASbGncslAlBKPO9vHUGwvBIb8Kb75qrpfNOZKqW1gNSuFSeHn44lOL59GW5YSx35pvr
	vGTWc/FBoWuWSx8YSNV7zD+yYR1tAEHAGFhS4btmZRPIDHRlZiHUXWBvQo036GZJ0sIe2NPu0UA
	qY77lLZLkNx00ehQHvhD6jJYMT6o/MOCpsJZc3dJOa2pzzKIPMEY1jzYGFc1KpqsW3QyYrsHnxR
	ahVg4XM0PZNoZrHRXOJuWTzSkegkPPo+gxXN3yO/PiuYrY3jhDuuoHTakXF8j0Zv6SRa601FaNZ
	CRsSsJyC2rHAS/Ex8mNHh2HTXAnJ9MgKPecoQxLWKXoXSCOOjitHEJIRBTUt4ltENb+F7pCXzRn
	o4i/E4yAlNUTwNsGwyrsOtuCB09uT3uov0BfYT8J+gTfBaeE21TUtD2GDB0bHYXO+ncHyPs7Kxl
	xm
X-Google-Smtp-Source: AGHT+IHw5DY+d3JMXj0ehkwCi00kh1fcOQgwNxL358oZwa3xTlItactqY9kSp562T/u4HnhssT9g/A==
X-Received: by 2002:a05:6000:230b:b0:42b:40b5:e681 with SMTP id ffacd0b85a97d-42b593450f3mr3355692f8f.26.1763130910639;
        Fri, 14 Nov 2025 06:35:10 -0800 (PST)
Received: from draig.lan ([185.126.160.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b8a0sm10330771f8f.25.2025.11.14.06.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 06:35:09 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id CCE895F820;
	Fri, 14 Nov 2025 14:35:08 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Simon Richter <Simon.Richter@hogyros.de>,  Lucas De Marchi
 <lucas.demarchi@intel.com>,  Alex Deucher <alexander.deucher@amd.com>,
  amd-gfx@lists.freedesktop.org,  Bjorn Helgaas <bhelgaas@google.com>,
  David Airlie <airlied@gmail.com>,  dri-devel@lists.freedesktop.org,
  intel-gfx@lists.freedesktop.org,  intel-xe@lists.freedesktop.org,  Jani
 Nikula <jani.nikula@linux.intel.com>,  Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,  linux-pci@vger.kernel.org,  Rodrigo
 Vivi <rodrigo.vivi@intel.com>,  Simona Vetter <simona@ffwll.ch>,  Tvrtko
 Ursulin <tursulin@ursulin.net>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,  Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>,  =?utf-8?Q?Micha=C5=82?= Winiarski
 <michal.winiarski@intel.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] PCI: Change pci_dev variable from 'bridge' to
 'dev'
In-Reply-To: <20251113162628.5946-4-ilpo.jarvinen@linux.intel.com> ("Ilpo
	=?utf-8?Q?J=C3=A4rvinen=22's?= message of "Thu, 13 Nov 2025 18:26:20
 +0200")
References: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
	<20251113162628.5946-4-ilpo.jarvinen@linux.intel.com>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Fri, 14 Nov 2025 14:35:08 +0000
Message-ID: <87346gptr7.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:

> Upcoming fix to BAR resize will store also device BAR resource in the
> saved list. Change the pci_dev variable in the loop from 'bridge' to
> 'dev' as the former would be misleading with non-bridges in the list.
>
> This is in a separate change to reduce churn in the upcoming BAR resize
> fix.
>
> While it appears that the logic in the loop doing pci_setup_bridge() is
> altered as 'bridge' variable is no longer updated, a bridge should
> never appear more than once in the saved list so the if check can only
> match to the first entry. As such, the code with two distinct pci_dev
> variables better represents the intention of the check compared with the
> old code where bridge variable was reused for a different purpose.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

