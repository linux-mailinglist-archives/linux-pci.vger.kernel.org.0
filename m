Return-Path: <linux-pci+bounces-5910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B6089D174
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 06:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7FD1F237BC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 04:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0F5657D5;
	Tue,  9 Apr 2024 04:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueNsqCBv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B71C64CEF;
	Tue,  9 Apr 2024 04:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712636576; cv=none; b=usszrl5GQO4iMuDRTF2aqgMVvRBzu5qC1qk4wnjBS0IR30jDIWU+2YNdDrVGMCzkSQH49Si2qP1n23xzdHychZGePji3nZkDQi64QoRghiFzQia7kktpalXsLCW19ZYD7vw10RBAkH4NG3sYLKm0sLBM/Yue5Zi7MJmzz/Fk7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712636576; c=relaxed/simple;
	bh=QnwHqeYJPBPK/Xrmgd4DuJ3QQvB+ALt1X1KUY4pf/QQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DDMXRnPH6fvx7wfRv0aQwWHtMI7e9texH0JyMRkNOXxhJ7gLFLQ38udVECIIivxNlLsLRceJx/rmbvUkN1XPtIj5muOebcEEVjceqCJ/vChX3Fp3IlLEu696DKlVMTIfDma5qPOtBZOPbdPvComzkk+qLsCEmVKCQLwhAJS9Kq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueNsqCBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13830C433A6;
	Tue,  9 Apr 2024 04:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712636576;
	bh=QnwHqeYJPBPK/Xrmgd4DuJ3QQvB+ALt1X1KUY4pf/QQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ueNsqCBvo3g2lE6VaS4QKVSd37rLTDVyopUkCqikwT27F0H4xcrMSIr4yOrRYJCNN
	 UPtPFryWlM6WDgOpWb2+CzL9ndiyg97AA1Hhokzv9geZ0P6KUa4e41HlKtYMIzC1ul
	 yacZwTT1hirJBe32nN12G3f7JJBzopFBQIl90S4JocESKaFDO8DGur2y203a7Jtmtb
	 friiHruhfy1/Gjdd+BHbUa5+OI+FgeG7Do2v3JNVgv72GvOPM3m3Exx5hjYfWWgeRr
	 pbQwnlz5YwxVfV6d5id9rES2j4UxcJrXPhlkB6cBPZk+mJyxGzQy+EONOUU3AXi7tF
	 dTrwgt82ZRkeQ==
Message-ID: <94bce3e14a32d017c0f8acb6726a3484fda01cfd.camel@kernel.org>
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lukas Wunner
	 <lukas@wunner.de>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 08 Apr 2024 21:22:55 -0700
In-Reply-To: <ZhRii1BAg86gccWM@snoopy>
References: <20240407210526.8500-1-ppwaskie@kernel.org>
	 <ZhMP-NBMb387KD4Y@wunner.de> <ZhNQa8wAflycciNA@snoopy>
	 <20240408093422.000062d9@Huawei.com> <ZhRFsUiDieY+HhfV@snoopy>
	 <6614575a1c15c_2583ad29476@dwillia2-xfh.jf.intel.com.notmuch>
	 <ZhRii1BAg86gccWM@snoopy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-08 at 14:32 -0700, PJ Waskiewicz wrote:
> >=20
> > Turns out that straightforward message is aleady a driver message,
> > but
> > it gets skipped in this case. So, I am thinking of cleanup /
> > clarification along the following lines:
> >=20
> > 1/ Lean on the existing cxl_get_chbs() validation paths to report
> > on
> > errors
> >=20
> > 2/ Include the device-name rather than the UID since if UID is
> > unreliable it does not help you communicate with your BIOS vendor.
> > I.e.
> > give a breadcrumb for the BIOS engineer to match the AML device
> > name
> > with the CEDT content.
> >=20
> > 3/ Do not fail driver load on a single host-bridge parsing failure
> >=20
> > 4/ These are all cxl_acpi driver init events, so consistently use
> > the
> > ACPI0017 device, and the cxl_acpi driver, as the originator of the
> > error
> > message.
> >=20
> > Would this clarification have saved you time with the debug?

I guess I should have asked: would you like me to pull this patch in
and give it a test on a known broken host?  I'm happy to do it.

-PJ


