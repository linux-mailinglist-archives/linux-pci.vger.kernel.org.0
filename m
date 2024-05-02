Return-Path: <linux-pci+bounces-7021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B958B8B9F96
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 19:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99591C2243B
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 17:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C253F16D31F;
	Thu,  2 May 2024 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+riW7/f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B62EB11;
	Thu,  2 May 2024 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671275; cv=none; b=J0/wF/FNfTGfcgGuZwR4gefTAEfmLCe3CGFBC/cmCQaCV9WuPim7IqxQ2Q+mip6erIPIKkKSFJN5LO25nUaNbihY1AOJdw9BY2mnkAys2PCAurJ3g7N//WB1OL/zacTrWYGO5XxN01LBFVKMkaJOm6eanXlIFVYy/j+un1sjnuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671275; c=relaxed/simple;
	bh=+h6/LR4S3cVJNgFoVugMFRRM6TloFW7Vi20pmrGxXpA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tbgs81kQ6r02IqCd2n5IYJwM5ZWUzBQSl2DMj0yjPlBD0T7BfmTvKt8MqtYS0waX70ouUYKx1kE3SmNPYroraHTWlDOHgiEytayeSs9z12MNtNUoTnXKgu2c/IiM54zUucR3VtKUWq6WTSmRkTPUWUq6EjSyp9AzYL48E4lz/TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+riW7/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C236BC113CC;
	Thu,  2 May 2024 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714671275;
	bh=+h6/LR4S3cVJNgFoVugMFRRM6TloFW7Vi20pmrGxXpA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=R+riW7/fdD2hN81bSLI10S63tn2cpLV+vVta5eOUQ4fDfRkhVXBnHu63P6rEAUEIM
	 04AyOXl3ocfyKC8w2Pmy9mZ+uxETyiA0gRPwU3pWRTZ1OT1HoJT4m0TKly2ztwdHXb
	 bxGELm+ddNicgnUcbWDB8LMcf6tK3sI8hM0Do2r0zfg2FeHiiW8UjRo2K/AjqEYudY
	 jD9UO/2W60isI8EPISQSzUv0ZzXnyBi/NWDK2RBbXARSCupZBjs8dxCBSAXRM4eoRB
	 pezc+7FiUBOl/aWvh+1i70wNLE6Q0X54eX6ME0ZrzE0mzKk6FqnBmKvSMSUigIw1RT
	 g+29fAd9TMsCA==
Message-ID: <6af0488a5d845028978f57e63f3706f8899465cf.camel@kernel.org>
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
 <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 02 May 2024 10:34:33 -0700
In-Reply-To: <6632640bef65a_10c21294e3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <ce49c67c24f57ffab166d688a1c9e3139733f412.camel@kernel.org>
	 <20240429153138.GA681245@bhelgaas>
	 <662fe860eb889_1487294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	 <f5078550384a6b9be5a6d05415ea321332c7fb96.camel@kernel.org>
	 <6632640bef65a_10c21294e3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-01 at 08:47 -0700, Dan Williams wrote:
> PJ Waskiewicz wrote:
> > Buggy BIOS, that above value resolves to CX02.=C2=A0 In fact, it
> > *should* be
> > 49.=C2=A0 This is very much a bug in the ACPI arena.
>=20
> Ok, so back to this patch in question, my concern with upgrading:
>=20
> =C2=A0=C2=A0=C2=A0 dev_err(dev, "unable to retrieve _UID\n");
>=20
> ...to say "potentially buggy BIOS", is that same charge could be
> levied
> against all of the dev_warn() and dev_err() instances in
> drivers/cxl/acpi.c. So, it's not clear to me that cxl_acpi driver
> failures need to be more explicit.
>=20
> Otherwise, pretty much any ACPI hiccup message in the kernel would be
> candidate for claiming "BIOS is busted".

I really do like your patch you proposed a few weeks back.  I'm happy
to pull that and test it if you'd like to move forward on that instead.

Personally, I think the amount of discussion generated around this
simple "the BIOS is broken" should warrant some level of change to help
others not in-the-know to understand why their shiny new CXL devices
fell over on init.  Whatever that change looks like though, I'm not
married to any particular approach.

-PJ

