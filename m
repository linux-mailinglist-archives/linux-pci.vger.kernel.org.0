Return-Path: <linux-pci+bounces-18341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00319EFCA6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 20:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8161E28C147
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 19:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A667418FDB9;
	Thu, 12 Dec 2024 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVseI6q6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBCB188713
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032411; cv=none; b=usLRjKy+YQWk1KRFzS/L47/z27/ZeLn0qqLSk7tMKB2WimR+VLu8mDt0cXRhjRZY906DTw1Ipi5hdzWUBxFFyvlevtDeuKzSqROe1ahjxDBmO0cV+zUT7P+GEo4wkJqeTgvMmFbjgnO2UmF4O27CfhzI1Dh1RWjGmFwMAtQQqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032411; c=relaxed/simple;
	bh=MHiF9z41i8Gdza9scgzFm/kGb7WP/O5Vog4Z0wtj8cQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YVFUlMD8cMb49R3IJGy8dgV4fJypsRIK7WxhDXatLalNUD99xkcTWF81R53bbnsF/bG29v5tr3r0xoQmqX9DbNa79xSIYGpI3W48L8FG//kA+OOdX/zOyZY2xlymjKk/UXbVwkSaE4PYYOihNJpO9AM8Xut4GrOUQ1jYR/e17TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVseI6q6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D0BC4CECE;
	Thu, 12 Dec 2024 19:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734032411;
	bh=MHiF9z41i8Gdza9scgzFm/kGb7WP/O5Vog4Z0wtj8cQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eVseI6q6ivxyaGlVKb7uJoCDjJ4Iq9MJ0RjD6JAvR15IIvmRjbhwWyZthh8fN43vH
	 5cZ4zEOKLf8QwrKDMdEFPuqp0/ylw+10rQWWuTdA6qSDB1WpSv2t6yiieJN2jPlfj/
	 8c10HnvSQLjV92Z9wLnDUkzPmq0MgTUb25+B7KB2yAsE7AMXmINv19PVyaqm57js0C
	 hSnF6MBXAh3Uw/+TGAdHyYbGxthgF6MCOHFRysLIwCyTEw/h+jTesuwJigoxXvg4sK
	 bHxn8DIAJ0zRvAyVHv0ZqMhn57KOugINYRncjEQdIMHGVfsFnMpb6SzT2IvjJCgluc
	 Ob8J9Jn8w88Cg==
Message-ID: <0b01d64fa7f6f62d49f39447c5175b44a1011fd5.camel@kernel.org>
Subject: Re: [PATCH for-linus] PCI: Honor Max Link Speed when determining
 supported speeds
From: Niklas Schnelle <niks@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>, Bjorn Helgaas
 <helgaas@kernel.org>,  Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Ilpo Jarvinen
 <ilpo.jarvinen@linux.intel.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Date: Thu, 12 Dec 2024 20:40:07 +0100
In-Reply-To: <efafe0d864af49d2f496fc6543f619958630869f.camel@linux.ibm.com>
References: <20241212161103.GA3345227@bhelgaas>
	 <efafe0d864af49d2f496fc6543f619958630869f.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-12 at 17:58 +0100, Niklas Schnelle wrote:
> On Thu, 2024-12-12 at 10:11 -0600, Bjorn Helgaas wrote:
> > On Thu, Dec 12, 2024 at 09:56:16AM +0100, Lukas Wunner wrote:
> > > The Supported Link Speeds Vector in the Link Capabilities 2 Register
> > > indicates the *supported* link speeds.  The Max Link Speed field in
> > > the Link Capabilities Register indicates the *maximum* of those speed=
s.
> > >=20
> > > Niklas reports that the Intel JHL7540 "Titan Ridge 2018" Thunderbolt
> > > controller supports 2.5-8 GT/s speeds, but indicates 2.5 GT/s as maxi=
mum.
> > > Ilpo recalls seeing this inconsistency on more devices.
> > >=20
> > > pcie_get_supported_speeds() neglects to honor the Max Link Speed fiel=
d
> > > and will thus incorrectly deem higher speeds as supported.  Fix it.
> > >=20
> > > Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
> > > Reported-by: Niklas Schnelle <niks@kernel.org>
> > > Closes: https://lore.kernel.org/r/70829798889c6d779ca0f6cd3260a765780=
d1369.camel@kernel.org/
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >=20
> > Looks like you want this in v6.13?  Can we make commit log more
> > explicit as to why we need it there?  Is this change enough to resolve
> > the boot hang Niklas reported?
>=20
> As for if it fixes my hang I will test this later today when I come
> home. But even if it is not enough on its own, I believe that this will
> be needed as a prerequisite for the fix of my hang issue in that
> without this patch the dev->supported_speeds incorrectly shows multiple
> speeds as supported making it impossible to suppress probing of bwctrl
> for devices that only support a fixed speed.

Ok, gave this a test and as somewhat suspected this patch alone doesn't
fix my boot hang nor do I get more output (also tried Lukas suggestion
with early_printk).

Then I put my patch using the hweight8(dev->supported_speeds) > 1
condition suggested by Lukas on top and with both things work again. I
would now propose that once we've cleared up Ilpo's comment I sent a
series with both patches for you to easily pick together. If you prefer
I can of course also sent my patch stand alone.

Thanks,
Niklas

