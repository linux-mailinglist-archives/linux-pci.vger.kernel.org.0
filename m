Return-Path: <linux-pci+bounces-7851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0E68D005A
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 14:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937181F22F8A
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 12:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239DE15E5AA;
	Mon, 27 May 2024 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b="IewfaAN+"
X-Original-To: linux-pci@vger.kernel.org
Received: from zdiv.net (xvm-107-148.dc0.ghst.net [46.226.107.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4347415E5D3
	for <linux-pci@vger.kernel.org>; Mon, 27 May 2024 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.226.107.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813915; cv=none; b=uHSYdGsmBIiN+y/RBPzBGVGrmTQaPKxIEUZqx1n+5K9hnxwHGj0bTQqp2/HpRXh4Xhk52DGL1v+wPMIm1JHTyQkJgeLW/JfxnN5Nnr8IGCTpMqoBcc8GAPvFQAEXLhzRSpcgJ7gBYytCz6+fEZEnvBDGeERZzFi4BKII1SUFyu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813915; c=relaxed/simple;
	bh=MUntTJ3JLA6Ly+GzkVacOizIZQ6oW5CCTHzkOfMuM8g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JZIQhSq9mxJh/kRcvoWqMWIkG2kZApBj9ZHfNZwMQ7z+T60W70KEVH/5zyebmR+dtql6uP/jq/LnsNyXU+6G6sG2f8bEEhQ9WqlvEKA0+uc8YF5pPgY3HScZP9bHPuB/PCI3/j52kii7OawIhCo+zuK7OTVFvLg1/LKk22SngcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zdiv.net; spf=pass smtp.mailfrom=zdiv.net; dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b=IewfaAN+; arc=none smtp.client-ip=46.226.107.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zdiv.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zdiv.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zdiv.net; s=23;
	t=1716813911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUntTJ3JLA6Ly+GzkVacOizIZQ6oW5CCTHzkOfMuM8g=;
	b=IewfaAN+GsTcE9Z7/V45q1fdYowASN6HSleIn9vnC73f8Vnph1f0NGp4Jkk7iGw4bXz4Kj
	7L0+l3yrKLhtJHfeTuaFXjE6tSi5bNnV05dXIhyW40sNP/xuK/rglFIzLyO8eIoZxXgAxi
	PBH6dv7LnxSBbpqtCEh8+ERvNmyXcbmuXlXvJ3VWerd2xhtdaCIFuljGi3AvhQMsaPXyar
	VExdQ4khv0ZsDYvxCJUuLH23GSBRis1n8XpL2Jx03g2tuqZDDUTawQ1yGnFUst8kVnZHLM
	77j2p2HG9/spJmq/2f0ifqfg0pLXhzvLKpzbskAWbThny+bnWRtAfV5o9rj85w==
Received: from localhost (91-160-75-97.subs.proxad.net [91.160.75.97])
	by zdiv.net (OpenSMTPD) with ESMTPSA id 06f01dae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 12:45:11 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 14:45:11 +0200
Message-Id: <D1KFQMUBKQTH.3NO3NAP5V39ZY@zdiv.net>
Cc: <linux-pci@vger.kernel.org>
Subject: Re: [RESEND PATCH] libpci: sysfs: Fix segmentation fault by
 including libgen.h
From: "Jules Maselbas" <jmaselbas@zdiv.net>
To: =?utf-8?q?Martin_Mare=C5=A1?= <mj@ucw.cz>
X-Mailer: aerc 0.17.0
References: <20240521080519.7833-1-jmaselbas@zdiv.net>
 <mj+md-20240527.123235.12093.nikam@ucw.cz>
In-Reply-To: <mj+md-20240527.123235.12093.nikam@ucw.cz>

On Mon May 27, 2024 at 2:33 PM CEST, Martin Mare=C5=A1 wrote:
> Hello!
>
> > On a musl-based system (Alpine-linux) the basename(3) function is not d=
efined
> > by including string.h with _GNU_SOURCE defined. However basename(3) cou=
ld be
> > defined by including libgen.h.
> >=20
> > On musl this is a problem than can lead to a segmentation fault, as I h=
ave
> > experienced. This issue is caused by basename(3) function being implici=
tly
> > declared and thus having, implicitly, a return type of int. Which in my=
 case
> > caused an erroneous sign extension of a pointer leading to a segmentati=
on
> > fault.
> >=20
> > Adding an include for libgen.h sound to me like a proper solution.
> > Also by doing so the `_GNU_SOURCE` defined is no longer needed.
>
> It should be fixed by commit 89cb2ae87236604b0e8ededd0fd7d9425c2d8cb6.
>
> Could you please check if it works for you?
nitpick / for the record:
it previously compiled with musl, gcc (13) only generated a warning,
but it should nolonger compile with gcc 14, as the warning is now an error.


