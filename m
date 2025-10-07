Return-Path: <linux-pci+bounces-37663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBF5BC1327
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 13:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290CC18834D7
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 11:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9B92550D8;
	Tue,  7 Oct 2025 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="e1frnRqI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC162D9EE4
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836219; cv=none; b=sNt1uhGeQcwOEZshyMwIxnxCi/JKQEFa5RfixKd5HU3/fqF1wMtiCOGVf6/k1vibDKQNqg4ura2hL1uVmK8VV3JYi07h/w7zpOMWjw4R7yrBs3hzZCCGqKl2ptPTQsKoCipYlf7lSpwaxOLvszwKeIabQchQNiahyH/gG4bT0SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836219; c=relaxed/simple;
	bh=TpJeOnUoOLw+CN76IYU70OlkPMEo6Sx6I6bv3quU3YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3ovHNN22cPAPv+dnUIa4nzeUzqXpMtau/soQQ0Cq5zLpbkHiYLy3utbdXH99KKWKsHJAPnxeGaNzV8dI4hnziAE2DZdVqhvs9EGfKBR/ezKJJidwS15hMZfwGOlwLOpVDHDkeWmPVFhBTuJqZ8kTY/Bk2IgXpKEu3Fp3uyXIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=e1frnRqI; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3306eb96da1so5121322a91.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 04:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1759836216; x=1760441016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TpJeOnUoOLw+CN76IYU70OlkPMEo6Sx6I6bv3quU3YU=;
        b=e1frnRqIeSUWFg9V78GKJzwIK0fneGStHvKOuvE3tZollSvJFoOixoDqiW2QyDtCBL
         50Z1W48WsgXRcLsXPaCHeTZJ6RH0o3SYn2kK+FqUfatXjVn9Ys8oNzNbOyGTIgTCTaCz
         Bdv8d0FiZqzOxvbx7cHbfR1DenNnkYm0Ou6Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759836216; x=1760441016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpJeOnUoOLw+CN76IYU70OlkPMEo6Sx6I6bv3quU3YU=;
        b=bOvxau2Uf/Vt4VIc8SDxMXOVaSgSYiQRVKE5wg9X7cQ0U2sSJ1B8HtxDReMs7AcmFp
         rJTnK4KIPyO2C4jMJV13uq1bAlHTbkeMA6+ipSFeENpf2pr1+QYGWjoLXALzY75lwJNL
         oYKnfJT368QC8rOHca2f+4uEq2WUd/ZCIm07yLOT4Nsq0JFI3WVlOXsiJgiPmsx85OQR
         2xEhc5hIVhJrVEsj+O7fYmU7zeUkDLd5ij+NTrxUtRCWgkOaTn68CN4e2WymsbFatb9g
         ZqNNFQatKgG8Or5uw9apZDLW6dqeu4miiDMR6lttsBf2QlYvAA4MI65adGFwrD+fkMsH
         WC2A==
X-Forwarded-Encrypted: i=1; AJvYcCVINySomuJaqtSK6l/N0tnTa2DplVAKmoeCBMIxmZ32FqKDqatRmZPlfS6Q6Vq7BxM0nvphVTYD9YA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxou5YlyCOd83CH6IJ+EDe1YJVypCbGUk7Y7/SBsop/sS9eTgqz
	8ZUdeIuUazbRbnN21sv5/Y+ZNS1mPt9myPwies1Ud5X4L7xmm1F+c+K8QuzcObd5T43Z5KZQn9/
	WsxOaambkHVuyhIG/ACp2mPtPp9S/1aCp2oGs1YuqSf7/XDOwmobdSSQ=
X-Gm-Gg: ASbGnctGa5lFkwusxFq5AQAaN3RCiiHjZaR1EpP0a1PC1VEyElp0zdSwkrYtPgYYqB8
	3BX5SXJSOFJMgbJXJ5UgLEIz1D4A+QaTbpjsgd/fnIbcVC6vWRsHDQx2iD1f9rdN9jX/GXtIGtF
	Z1pb8H+UzP97CS5vEiqfYhSyfxuJlTcf7Vj2Kb2DtjnwN2+4JJkDIAOISaYZP2ak20YZMMBc4O3
	A1tOwX79yDmKH7sYWyU6YZ5mDnIz8ur
X-Google-Smtp-Source: AGHT+IESCXXn6K/T88opj7JzvSx4+eiTbjz/XV8PoT8lX1Nd43fyg5hSHU3kcLz9D/gith95LtUTey7rw9SGLXhbOqQ=
X-Received: by 2002:a17:90b:3ece:b0:330:7f80:bbd9 with SMTP id
 98e67ed59e1d1-339c27f1a18mr18415931a91.31.1759836216299; Tue, 07 Oct 2025
 04:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007092313.755856-1-daniel@thingy.jp> <20251007092313.755856-4-daniel@thingy.jp>
 <CAMuHMdWDfNgUUh-uU7ZFKmmAccEMqDdfDpwRXQYmwjMG6O_Trg@mail.gmail.com>
 <46382bc6cab2196a79780a946bee96dde402ae31.camel@physik.fu-berlin.de> <CAMuHMdUUAEoN+KBnk=aY6UnkxXnFp8KY0BV8qQGfGip=nNtfaQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUUAEoN+KBnk=aY6UnkxXnFp8KY0BV8qQGfGip=nNtfaQ@mail.gmail.com>
From: Daniel Palmer <daniel@thingy.jp>
Date: Tue, 7 Oct 2025 20:23:25 +0900
X-Gm-Features: AS18NWCq_eV2IvEc3GKy8N26uH_9-vQmDw1mItucWkfRV0H0wQEVAB3YqjC82L8
Message-ID: <CAFr9PXk_evnt5g1rtpbnCEXBVBeW3pCJ_8S1DFz6ynfvJcXOgA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] m68k: amiga: Allow PCI
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-m68k@lists.linux-m68k.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Geert, Adrian,

On Tue, 7 Oct 2025 at 19:22, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Adrian,
>
> On Tue, 7 Oct 2025 at 11:41, John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Tue, 2025-10-07 at 11:37 +0200, Geert Uytterhoeven wrote:
> > > On Tue, 7 Oct 2025 at 11:33, Daniel Palmer <daniel@thingy.jp> wrote:

> > Isn't this what patch 5 does?

Sorry, I guess the ordering could have been better... There is also a
reference to the Kconfig symbol added in patch 5 in one of the earlier
patches.
If this has a hope of being merged I'll fix that for the next try.

Thanks,

Daniel

