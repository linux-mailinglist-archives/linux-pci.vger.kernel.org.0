Return-Path: <linux-pci+bounces-41068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B19AC564A2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 09:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 777014EE890
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 08:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A1432F77C;
	Thu, 13 Nov 2025 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU0RMMAJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0B2FF663
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022448; cv=none; b=c2Tjxin2v853DZOiMHXVUZCfkGZEMIxgnElztmGt8RM6R/Lhs2jzKexNCOLBcTkY33mbdmAFNCaNJSdurFLbyJ39q00fMSRLVz9DQMBP31ronNAtQ0CoSBd573pA1HKTmDyZ6P3tICTlZbnmwOgEvoNv3g0LvGp05i/uqAyobM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022448; c=relaxed/simple;
	bh=d1qk7FVWVfRJhE+KtiEvk+u0EBagMhnk/HxpVt1YtfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDRI7KDYPM1wcaVPl7noedptC9mbQzG6LOg5v53sNQVPJmjCdnnlAetRva+ocmPbDWL6B6KQKHNzH2h3uE3TOKnnjq8RkT+JzVHFn8R0jKbxdGsaLExiklB5dVAIXgSCOIt81Cmpi0aSpaPPuhTN2tVwgMvicx8/ws6Z4VbsL48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU0RMMAJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2952d120da1so306625ad.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 00:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763022447; x=1763627247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1qk7FVWVfRJhE+KtiEvk+u0EBagMhnk/HxpVt1YtfA=;
        b=RU0RMMAJ9wpHrAru9L/W+udDUyeHe3q8RqqEClDkTbPU2m2+NIkxItBY/I1Upf/kk4
         2VGjgX0ShTE6d4GNhZG0zbYF/E+749jhNltSojdgEot3nXhbF4Kh7sFD7fVhkVOd2kkE
         wc3RyPcG1gVXuG3bJ7Oi3eDFxxdIEzNhnN/Se1ZHeJCZjVujdEMwTAR3JrniBZ8Ek8pV
         3KE2IrL3EGpn4tulc7q9anfApVtYRBbo36GCt1318i9o/SN1T+71oihsB1coZ1fXCZhY
         HmZwmNvyEJnIwVPNMuplg7/mNFDwHxi4ROFw45bxriMml7Rf1lKNiACzimViCJZpkYE2
         ikwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022447; x=1763627247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d1qk7FVWVfRJhE+KtiEvk+u0EBagMhnk/HxpVt1YtfA=;
        b=gDV30OVNs+J9NbeZXLrngtt6We4Jr0OJOdCl1btq/G6khivgjZVxMrIhXggbt2tl9r
         oGVoLRre7u2Eg1xJa6UcWe1DpQ4hHh8f1U07Tqp/cfloKe2KJfRk7pdXBxApoDe9iWPl
         +z0/dGHlVCOlU/s7t8VGycl3dbgVGwjgDLIboAaAmAtnaxaz1WtTwDwkSbXi4GaEzkKV
         0qPTLjQiH2ayojRG3pcUW2BYBtxlXIt/O7LUOPE5nzOdVpsZUwI/x9/cXthDUPxfh4M9
         jsj+qK3ojOPzv8WP0tPBrXk0qpm9wdqmlQI8ojGVcseKSfU78IsZqkBFTf4sDBqdVqRe
         imUA==
X-Forwarded-Encrypted: i=1; AJvYcCUszH23HM9lrNKIXHZ/Lm+bLRpJ8yfE5q1PvMRV6IB3m+fmOniLGymPDiBUty31scn1xQa8Q3w9NKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY9oSEoCXfq6UaWge8mo7vX0kksdzoG7lo6EvtHHqHnp8F7JXs
	TXQT1WnNpWh1I0csSy+cekbrV9SI9iUgma4Goo+gYx2aZXzBMjDyMUIIAj8hHVL5LVqt9rxfs36
	+yJkEDOnA8RPc/f6E0pNl1BRtcerRSFA=
X-Gm-Gg: ASbGncsfS68+3f9mMWfifGh1sMNGdphZdtq8ygih9mEDcOt24BIkNuY6ry90c8ZgQXy
	aak2N3W3pFRRJfRIdUpa8WvRY1GOFLPPmGJmPmnMTRkzJ0yaBwsjYi2FddXDTkkr6Kszv+hVrvW
	b6HHmuu8cOz3lLChqcGT65V7NeCtCNpAc1NHB0oUH6CYaoAhgKUuEQ3L1YSW28kLEhmOnnDze2N
	9nTidDZdutq3sWuPIvp9ufiDHmwBcTrIXO13GN0IRXw3Yzx++yrvGHRbaZ5NwfbWVxgP2trfHks
	5ixxReOuuJYVbB4Ba0EipPFyDY+92Y0/eCoPN9Z9u31U+UHRH23t4LxkdtWCHF7s9nXAa5tUcuw
	wfvw=
X-Google-Smtp-Source: AGHT+IGabKCaWKO8REK+43Eg4r6FgFxCqOu4BbB6BrKUf2h40WukUnS1SFQ2Rv/WiM0zMAyYUdxkiYVrqRkg5TTtI+w=
X-Received: by 2002:a17:902:f683:b0:290:c94a:f4c8 with SMTP id
 d9443c01a7336-2985b942248mr13558545ad.1.1763022446725; Thu, 13 Nov 2025
 00:27:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101214629.10718-1-mt@markoturk.info> <aRRJPZVkCv2i7kt2@vps.markoturk.info>
 <CANiq72kfy3RvCwxp7Y++fKTMrviP5CqC_Zts_NjtEtNCnpU3Mg@mail.gmail.com>
 <CANiq72=yQ1tn0MmxNHPO4qOiGm7xZzHJAdXFsBBwmFdsC37=ZA@mail.gmail.com> <DE7F6RR1NAKW.3DJYO44O73941@kernel.org>
In-Reply-To: <DE7F6RR1NAKW.3DJYO44O73941@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Nov 2025 09:27:14 +0100
X-Gm-Features: AWmQ_bnSp6sDCbEYJ3FC6kACZqmnj-bo2Avyv0Hf_y2c6mHRFhvWknBqrxsDf3E
Message-ID: <CANiq72=fr8tTYXz7Wd5AYr-1f+6ohggTfGBz5KWDE97675MP+A@mail.gmail.com>
Subject: Re: [PATCH] samples: rust: fix endianness issue in rust_driver_pci
To: Danilo Krummrich <dakr@kernel.org>
Cc: Marko Turk <mt@markoturk.info>, Dirk Behme <dirk.behme@de.bosch.com>, bhelgaas@google.com, 
	kwilczynski@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 9:22=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> I don't think we should do anything else; the cases where we need to deal=
 with
> big-endian devices for MMIO should be extremely rare -- rare enough that =
there
> aren't even corresponding *_be() implementations for all architectures.
>
> Given that, I think the proper fix is to drop the existing u32::from_le()=
 call
> (that ended up in the sample driver by accident) and properly document th=
e
> little-endian assumption of the MMIO backend.

Sounds good then, thanks!

Cheers,
Miguel

