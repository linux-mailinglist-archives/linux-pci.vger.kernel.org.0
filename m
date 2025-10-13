Return-Path: <linux-pci+bounces-37901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4E5BD39D6
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 16:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4502A3E1C7E
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 14:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE04E26F47D;
	Mon, 13 Oct 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oH/cHVe1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E4226F46F
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366115; cv=none; b=J1bk9z2bs7eMlNLiooDzdVQIslGAyOCLGr76iEcPIGNGQGoCMtLIf2XWAozQBZ3BMjJqjey8AwaupjPC3E1SSrWOEPwBuz+lWPC/ZJseweCA4qYz+sGFgEXKFEiTY3ZrPkhyQAtjIpngBS4QhfmFQ2ctoSZutRiS7OuL2cLMy9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366115; c=relaxed/simple;
	bh=LdPrQFWLdngdCRFa8TgdYUYi5uJJ0JS5ymRkQwnZqdE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q63SpnXAcIsKjAFu/Gh62VILJ1NyJDRDhiLlJS/BTJehBNl5CHVx04A4QWp0FMFOl0SiHA2ciCMWQlOlfAV3btMug4E9D0X6gQE/+drCAzSsH6QTTA592uc0XbCGRcwi9Pf8k9Y4HIWGQUGcrI/FdUDP4n2tGBM9uB4WzL/p5L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oH/cHVe1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760366114; x=1791902114;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LdPrQFWLdngdCRFa8TgdYUYi5uJJ0JS5ymRkQwnZqdE=;
  b=oH/cHVe19RVYjQTUiZ2xUHwnQnGd0PTGFphirMypW2MX6Vj0h1AHD8eh
   Q/bwR1ldHMmCKYvNcynBxNKTotjsOsaHwGMI7cMLo1O9qilewst8r00eB
   ZsZwWhDTA5w4yGWrre2vpSXiTVEOL2S0g/DAVZHagHcpm/HGtAFIzH1Oo
   S/l3impwgrEiMl6sisd/vPu7WzUSgpPCCWxa1vyI7OX2UbrAygttkKPRy
   jFaQ2q/h4eyww0NOoKD35nt94ubk43shYIuXD36DDf3TpdkFDxEmDtCCL
   rsZC1fB2P8ct7+EG7VePVfs9BM5cMTegRwtvCNUuQ6mPo4x+5AmvbuKe8
   w==;
X-CSE-ConnectionGUID: u+S8K4kgRJywXjw10FEjrA==
X-CSE-MsgGUID: 08WVzV8TQMueXA+N3KRfTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="72767491"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="72767491"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 07:35:13 -0700
X-CSE-ConnectionGUID: pPkK4IZTSKGHQcSQIcL/EQ==
X-CSE-MsgGUID: qGzxAnA8QDSwpYNO/C4MGw==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.77])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 07:35:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Oct 2025 17:35:06 +0300 (EEST)
To: Mario Limonciello <superm1@kernel.org>
cc: mario.limonciello@amd.com, bhelgaas@google.com, tzimmermann@suse.de, 
    Eric Biggers <ebiggers@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/VGA: Select SCREEN_INFO
In-Reply-To: <6dd53ff9-2398-4756-9c13-c082f1c01d4b@kernel.org>
Message-ID: <56b866bd-d1ad-3be3-a6a6-ed726aa1f9ef@linux.intel.com>
References: <20251013135929.913441-1-superm1@kernel.org> <f36a943e-73bb-97ce-83bc-56aa0e1b5267@linux.intel.com> <6dd53ff9-2398-4756-9c13-c082f1c01d4b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2104203397-1760366106=:933"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2104203397-1760366106=:933
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 13 Oct 2025, Mario Limonciello wrote:

> On 10/13/25 9:16 AM, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 13 Oct 2025, Mario Limonciello (AMD) wrote:
> >=20
> > > commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() wit=
h
> > > a screen info check") introduced an implicit dependency upon SCREEN_I=
NFO
> > > by removing the open coded implementation.
> > >=20
> > > If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_default(=
)
> > > would now return false.  Add a select for SCREEN_INFO to ensure that =
the
> > > VGA arbiter works as intended.
> > >=20
> > > Reported-by: Eric Biggers <ebiggers@kernel.org>
> > > Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
> > > Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() wit=
h a
> > > screen info check")
> > > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > > ---
> > >   drivers/pci/Kconfig | 1 +
> > >   1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > > index 7065a8e5f9b14..c35fed47addd5 100644
> > > --- a/drivers/pci/Kconfig
> > > +++ b/drivers/pci/Kconfig
> > > @@ -306,6 +306,7 @@ config VGA_ARB
> > >   =09bool "VGA Arbitration" if EXPERT
> > >   =09default y
> > >   =09depends on (PCI && !S390)
> > > +=09select SCREEN_INFO
> > >   =09help
> > >   =09  Some "legacy" VGA devices implemented on PCI typically have th=
e same
> > >   =09  hard-decoded addresses as they did on ISA. When multiple PCI d=
evices
> >=20
> > The commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() w=
ith
> > a screen info check") also changed to #ifdef CONFIG_SCREEN_INFO around =
the
> > call, but that now becomes superfluous with this select, no?
>=20
> Thanks! Will adjust.
>=20
> >=20
> > Looking into the history of the ifdefs here is quite odd pattern (only
> > the last one comes with some explanation but even that is on the vague
> > side and fails to remove the actual now unnecessary ifdef :-/):
> >=20
> > #if defined(CONFIG_X86) -> #if defined(CONFIG_X86) -> select SCREEN_INF=
O
> >=20
> > Was it intentional to allow building without CONFIG_SCREEN_INFO?
> >=20
>=20
> You mean in the VGA arbiter code?  Or just in general?

Here in the VGA arbiter. I'm just trying to understand why the #else part=
=20
was here post-337bf13aa9dda.

> There is a lot of
> other places that conditionalize code on CONFIG_SCREEN_INFO.  You don't "=
have"
> to build in the the VGA arbiter and presumably those are correct.
>=20

--=20
 i.

--8323328-2104203397-1760366106=:933--

