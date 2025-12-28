Return-Path: <linux-pci+bounces-43782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE89CE573B
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 21:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 945F93002A70
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 20:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB9216EB42;
	Sun, 28 Dec 2025 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="J12dmoJE"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D67824BD
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766954420; cv=none; b=XL/eGib5iKlX1dAn8oa3gc3o7tDloqhlhPkBq6Fu4nIr6jMxZE7EtbW7gRyrcZW6K++KimStPWZR9yo1t9MJJ5BiXvFVY9ZK5d/kg7jRMQngUwDx/iZPWU+y7QtgtbyGn1hLtIafC324VVc54XLQiQQOaHg4iaelnBmaBxT7WLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766954420; c=relaxed/simple;
	bh=NMCG/MYXfT/f1h/TWq7xauyVOpHxqgI6pgWJTStzw5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ1vR5bDC8jsu/Io5xm9NXDoqifgCHGyPt4bFwekW2SSgRYLAkTpTc1Rdu3mCkeIDnnBuRTLXcNUV2e1vLj6pRlAqG6lQ6tA3Uu5wkkw8KnGTUMYtqXpwiDXG/HIRE4beGExwPXnx7NBwgREXOp37u5sKXdszD7cp5Qe6TUlS2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=J12dmoJE; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id BF43A280189; Sun, 28 Dec 2025 21:34:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1766954043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IG8v5SZ0c82OXh9D/ldmyLpfzls8KbJ7OgfpiuXV+dY=;
	b=J12dmoJEDsGi5LmyrgGjonSzPF1y3R4uLUSyUnhyJk1Tgt5EXvTk4MwMK2BMt0f7I6Qb+z
	mQQ69xVQIHXB8i4QHszBGi8eqA8XUSg+9jksB7335bXMPDLifHfs94YrfV7WSGq8hhioOA
	ucf7nNOPs6+AMV44GbLRCZR3v/JdAsQ=
Date: Sun, 28 Dec 2025 21:34:03 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Brian Norris <briannorris@chromium.org>
Cc: linux-pci@vger.kernel.org, Brian Norris <briannorris@google.com>
Subject: Re: [PATCH pciutils] dump: Support `lspci -F -` for stdin
Message-ID: <mj+md-20251228.203122.39222.nikam@ucw.cz>
References: <20251202222315.2548516-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251202222315.2548516-1-briannorris@chromium.org>

Hi!

> From: Brian Norris <briannorris@google.com>
> 
> It can be useful to pipe raw config registers (lspci -x) from one system
> to another, so the latter system can do the parsing (lspci -vv -F ...).
> For example, one might do this if the former has a more limited / older
> version of lspci. Today, one has to write the contents to a file.
> 
> Support stdin via "-", so it's easier to run it through a pipeline, such
> as:
> 
>   ssh ${remote_host} old_lspci -xxx | new_lspci -vv -F -
> 
> A dash (-) is a common convention used by many other tools. If one
> really expected to access a file named "-", one can use "./-" or similar
> to disambiguate.

I like the idea, but please avoid closing stdin.

You probably want to refactor the parsing itself to a separate function.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe

