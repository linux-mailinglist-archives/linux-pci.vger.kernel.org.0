Return-Path: <linux-pci+bounces-21325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F88A3334A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 00:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E931681B0
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 23:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869032063F4;
	Wed, 12 Feb 2025 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RvHLY8Zc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA755209F53
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402442; cv=none; b=JW1MuHHL0uzbEWOCPR/u/T3mTsmdcEYWaU1mAkW56y6h+qfDsRiQ+KqqN22Yl129QB8CL/WslMhdCTGe3goUoRnkZmPYcf/S2PkGMxHNUXn+KF+U6mQBt11zxUcc39NX1USwuXDftO4w4IHhhySKK/c4ZNaR3oeypHoA5upbExg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402442; c=relaxed/simple;
	bh=RmvwiKc/GTiLxz2j4WNY8xtrC6lu37iGNSpl1BbXwlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiflZrXCXA2/8zNpnJ31KI/NGoufm5R6ibbk8QEwtRP+pYa1wzmRz0BuFkeZFjn+UGdzrygaTEbwERaJjXQ1AlTEh16SHZqoRHzm7aiwiBmjpEhZEzLNYeSFSxIJjVCromIxCEu40+v9NKWsGbBTLRAj2qOyJenocn31t0GkUlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RvHLY8Zc; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7f860a9c6so66551866b.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 15:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739402439; x=1740007239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmvwiKc/GTiLxz2j4WNY8xtrC6lu37iGNSpl1BbXwlc=;
        b=RvHLY8ZcWNifprqeLXH1yiXCY6rG21tLoWCSAECaWp6QnwrfJeqaxrNvXjWNoHh8Bg
         Dv+8W56bURFvS2vQdzee6XHf+pvO45CfX9dilA33Jb3fvz/TKUJtyMQdcm693btJiJP/
         A4FS4DMFf7LQ+BN1GP/CtKSV4xAcoV/UPP4LbX1/AoX6iVooO2FwAXlOj7Y9hkPohrdc
         1Fh93RhL6s+6FCHgVBGSss3swdjzAgVyNfJZ/nUrIhs02YDDmF1jLbjaCumN1y7YA/dh
         rUmDQnPkUx0EE7MWDIgB98qnfdtoEcMayGx/0A4DN87QGOFst1rPfUeQGixZs0SOedfl
         gzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739402439; x=1740007239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmvwiKc/GTiLxz2j4WNY8xtrC6lu37iGNSpl1BbXwlc=;
        b=NbQZcqYbsf6OT6ay0xXBYhz8VjwV/vkx3omBX4YnJWoFvTadnzfxvAZY/hzFqbfN/Z
         LuY/n2Pg/qy2algfO2GRjsJMFhwjFF0UIDpPA2wdawSi75y++5dmaPJILsKM2arm14lD
         afjgpaBzGsv74cjrQzUrIituLZXIulry4onD0gaZQBHTsM+ndvvyTENiPgsFmT1rw1uO
         RnrP/C/nrL587FkgDH1RwC4oKi13yUy2YNpfRnzwPopZh62HwGhVQilY0dZOtMoU/IF7
         kPBRijyhhI+n8VYjIcjDHyoxu2CJJA2JUfOgOJSMQypBQ/FIX/bK3g3c8j5AdBZqwDDC
         VQIA==
X-Forwarded-Encrypted: i=1; AJvYcCVegoxUIw2xU5hWcx7ScC5jIHJ0o1K7SibITI9BBTHBThB5iIhEfivNUjr05UUdb6/vvW/wLQvVa74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHOP8v6qGTnxM/1EdDL0ZMF5w2oT0txXDSS7unra3HJ5Atex5h
	LNTO/LyWk0Gwl6gUFwyhKkcM1fGLpFDlJjost6u/z8quW7VtUdQk/wzPIIGz2N5ZwHPATcSwAQ0
	0L6goGSo41IYJU9EwFwQUNsa8tDIJukMSJGqq
X-Gm-Gg: ASbGnctnkkHL2No0QB3vyMRi+onlLfsV130zMc9hZmMxkR1CS8gJox8odaxx+hyIuxi
	4ZdlmwPV0Wigz46IOsayS4CgOD3m59ooco6OpD0Cqn4zhnppaWHBcXQ02Lf3Y5VOxJwcKQSRhhM
	/6PhoT7kPNELqlo5riobPyuNDgrbM=
X-Google-Smtp-Source: AGHT+IFvQic4GqEWWLwDKGySmqdGQzs9qIEsk/Kbf3oiJyV9FL1ey54/8C67x8zjfwRzVZdSlMUYH/C0t7gBybUDmAM=
X-Received: by 2002:a17:907:3f0f:b0:ab7:b643:edd3 with SMTP id
 a640c23a62f3a-ab7f334ac51mr484469766b.11.1739402439088; Wed, 12 Feb 2025
 15:20:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-2-pandoh@google.com>
 <f1eb0909-b845-98c8-d81a-7069d352ffef@linux.intel.com>
In-Reply-To: <f1eb0909-b845-98c8-d81a-7069d352ffef@linux.intel.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Wed, 12 Feb 2025 15:20:27 -0800
X-Gm-Features: AWEUYZng8sBFlghUzhZ8gu2gS1hfp6hQWTXcvjsEXGDuGlr_8Hyof3yxBLxjqU4
Message-ID: <CAMC_AXU2zVU1yJKQ7yokj50Bk8p85CoGP_cC-+DZkJkaUPegtA@mail.gmail.com>
Subject: Re: [PATCH 1/8] PCI/AER: Remove aer_print_port_info
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 6:18=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> Is the first sentence lacking something, as "either" feels to require
> another option/alternative that is not present in the sentence? (I'm
> non-native myself)

Typo. Good catch. Will remove in v2.

Thanks,
Jon

