Return-Path: <linux-pci+bounces-3670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FCF859330
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 23:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219751F21C5F
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 22:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E24A14A86;
	Sat, 17 Feb 2024 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="FmjMsH+o"
X-Original-To: linux-pci@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9442134A4
	for <linux-pci@vger.kernel.org>; Sat, 17 Feb 2024 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708210075; cv=none; b=LNPHkllih9gc2tLT5RBuF4I0X3vkOxT1ImQawnKEwTYleMUEETs4ShdAS19vTRe9eQ/o7MlsISZX4mFV8BXQE0Z5aEmaapOMIR74SwoPhE+wY+o3s1bkErzKgB/VbzNKwD/YD8zRz8hV3wONLU0unqdDYcYSB46OxRDBNxZeR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708210075; c=relaxed/simple;
	bh=qT1c1xZXJNP/gkt56aCN2GtzPttnxF+NXjfb33P1CH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMDSGAbtD9qodjZoXs/oJBeuCaxJm8foeYpkYwietCqO+zv3bgHtsjVgOvIUK/BUN6UhEZK4p8KM3oy4yb9auOw435HnO+4AFUc6pfffpkhoDMwgZIRW9oWy5mAYhpM6zwbfnAqHyTbqszOLJBJVC19cSiCHfuwC3fAk1AORQVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=FmjMsH+o; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: from albireo.ucw.cz (albireo.ucw.cz [91.219.245.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: smtp-albireo)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 3F8991C0084
	for <linux-pci@vger.kernel.org>; Sat, 17 Feb 2024 23:47:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708210064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jNhyVA9chHLHIQZcbQxaUt0mUDjnuHVwBBIVcjLG0vs=;
	b=FmjMsH+on272TO5acPx9Ja8HSbYPuAfX1i1fF6VyBa7t06Ls0lpANlU0IBo/YX2idurP80
	WSPtTHrXGCyud7dPBuXcXVuFII4ImmlRm6DopG2niNqKHO/2/75WziKnjQUFP+v7uLmgzu
	zibnL6mmAwMLKOajOw6b4nbbZZXPxKg=
Received: from ged.vojtech.kobylisy.czf (ged.vojtech.kobylisy.czf [10.32.184.6])
	by albireo.ucw.cz (Postfix) with ESMTP id E4FA5AC3C1D
	for <linux-pci@vger.kernel.org>; Sat, 17 Feb 2024 23:47:42 +0100 (CET)
Received: from mj (uid 1000)
	(envelope-from mj+f-170224@ucw.cz)
	id 3401c1
	by ged.vojtech.kobylisy.czf (DragonFly Mail Agent v0.13);
	Sat, 17 Feb 2024 23:47:42 +0100
Date: Sat, 17 Feb 2024 23:47:42 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Nikita Proshkin <n.proshkin@yadro.com>
Cc: linux-pci@vger.kernel.org, linux@yadro.com,
	Bjorn Helgaas <helgaas@kernel.org>,
	Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH v2 00/15] pciutils: Add utility for Lane Margining
Message-ID: <mj+md-20240217.224729.203057.ged@ucw.cz>
References: <20231227094504.32257-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227094504.32257-1-n.proshkin@yadro.com>

Hi!

Thanks, merged.

				Martin

