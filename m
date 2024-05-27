Return-Path: <linux-pci+bounces-7846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 407CD8D002A
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 14:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DF0284D1C
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 12:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149CB15DBD1;
	Mon, 27 May 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b="MlXMRPwp"
X-Original-To: linux-pci@vger.kernel.org
Received: from zdiv.net (xvm-107-148.dc0.ghst.net [46.226.107.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2B538FA6
	for <linux-pci@vger.kernel.org>; Mon, 27 May 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.226.107.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813434; cv=none; b=uj8mjrijhqMwH8z+LMkrqTCDcBj1zI+9gL4isoS9YjWhJc2ggGJZbW4obspAVmqHt6q5PJkkUGP6JyM25Cj9XD7AeqtHVtuKrx9dBB8OX6BSuTW68WINqPLdNUiOfQKAD0B8KaHTOAjFV7/rPDRXPKPNZoUVrzZ+nN3eEHYff9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813434; c=relaxed/simple;
	bh=2oGplsf2j9Qi60KB66pKQtRSwnhBU/HHCa7ji9plR9c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Au5jTnjYYLcERYMxP9aoNhCrSj/XP67SSzwPxFxMuTFcgf4Bk2C75aY3UfXq3EA36kKvcrdIgD4gWiBGgSYFhpXFucuFBh+hMt8+hQifOVyl7PlIEFJYF9GNM0Z5ZDQLeIXpE3OL+nzb56bnZIjLI9KExrPu3wFIooZw//4jJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zdiv.net; spf=pass smtp.mailfrom=zdiv.net; dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b=MlXMRPwp; arc=none smtp.client-ip=46.226.107.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zdiv.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zdiv.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zdiv.net; s=23;
	t=1716813423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2oGplsf2j9Qi60KB66pKQtRSwnhBU/HHCa7ji9plR9c=;
	b=MlXMRPwpBGJ8ZkJMP4XTTjKnExzMlDuWM5NasHpHCKN1SWS0vxJ2zwzpQyS/vYCvVtgedG
	AGWHA8L/w1z9mpToR7JgjlVqVkFtjbnfWkHbmQArEyuG65/0zd+SoxFMNAXgPW3o3EsaIH
	bU+nCB9+23VsOxx+fHvgg2M+D8X1VOmZH+bD1oHDMSbOxnO7djLWieCpjx+lzZbRr0FWFh
	ZCBI9ypJngi9PwogrBgsbPrLFZr6wDi3gaq1Rjv6+pSPmFwjHNr2XOfxnewbgPrpGJ2YAl
	FpWwZXPP1CKnWu2r5j7MCEeAqEYt3REJn2MBNFVLhYxPWVFIt0YWq0n3N6lJ/A==
Received: from localhost (91-160-75-97.subs.proxad.net [91.160.75.97])
	by zdiv.net (OpenSMTPD) with ESMTPSA id c6c9c188 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 12:37:03 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 14:37:03 +0200
Message-Id: <D1KFKEQO39IZ.2N51TG9E9X0N@zdiv.net>
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
Yes, it does work.


