Return-Path: <linux-pci+bounces-18768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E979F7A04
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 12:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F918930C8
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 11:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B3F222591;
	Thu, 19 Dec 2024 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dlaHPBuC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F18B222D45
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734606309; cv=none; b=alW9elTqWFGtImNdvoIVX+XVanT36gsac81EqIcejbY02CElTQZPWNVFsfzm/BIICM91+Ay7GMvzkR6fsrosDIjGHW0sTxV04eXQ+nbeMvVAvRf/SFHXopQSwdapT76kLZj6SvepUEX0bc7KQVghrANbpQsEed/Xn58LzjPTW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734606309; c=relaxed/simple;
	bh=ts8JdaFOEr/E318Hf3FXavzKbiiDxmWmi7PrWTuAPYw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JnZhh3Ptlw43z/ldrBf1vX4ZvEDv9+LNS0n7+0ybXYug7j8FWcjX4uehGPscLCU1CW7ncJMaEZ/lUhgx/0zG2Ym4iU6QmLKocbZc6BCr60w31Zevyx5RjWGSfNAo0VEN7bC73E4WWanJtsQLquHTkm0uIM4f4KIEVtXDkKxCZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dlaHPBuC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734606307; x=1766142307;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ts8JdaFOEr/E318Hf3FXavzKbiiDxmWmi7PrWTuAPYw=;
  b=dlaHPBuCZY5o+Qdy6Uok7Jf0MOQwYhoR1yuCiRk6dqzJX+tHxfwm8lxp
   diW545gBzWEmHutp7Gh6K1SWK21K+0jU8NLH/9sFZMpuZmU0a12RlLCfJ
   LMUelDPFW72smhMTKTjQOAQ9nzpir3rafwzjOobWggjd9glNzQcJmKoGf
   aMQAOsoWr/e/t5IchGwaz9dfdj00tZdW9CKRrct7QNfwWpVJy3Kf32kpX
   kcSPX57o2LUJchfk5VOB8pl1iwCGbLmg4SGeipeqO5kCNgjsthMTn3NGo
   s6D2oW5yhPAwccvN210B8cZfBS7cttTTkLHyUtafraLzVHwVEFr6A9onH
   A==;
X-CSE-ConnectionGUID: +WH4AsOWTmW7IITQrgZk6g==
X-CSE-MsgGUID: yFqpOGusTB6Iy8WRi9uszQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46498855"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46498855"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 03:05:07 -0800
X-CSE-ConnectionGUID: MK5DMnwCT1uZuxAaKgn0BQ==
X-CSE-MsgGUID: VQb4EI4CRdWBGz3C+7ba5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="97954139"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.7])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 03:05:03 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 19 Dec 2024 13:05:00 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Krzysztof Wilczy??ski <kw@linux.com>, Bjorn Helgaas <helgaas@kernel.org>, 
    linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH for-linus v3 1/2] PCI: Honor Max Link Speed when determining
 supported speeds
In-Reply-To: <Z2POKvvGX7HZmqtP@wunner.de>
Message-ID: <f4b43cee-b029-1c78-2412-7a952e8e83a1@linux.intel.com>
References: <cover.1734428762.git.lukas@wunner.de> <fe03941e3e1cc42fb9bf4395e302bff53ee2198b.1734428762.git.lukas@wunner.de> <7bbd48eb-efaf-260f-ad8d-9fe7f2209812@linux.intel.com> <20241218234357.GA1444967@rocinante> <Z2POKvvGX7HZmqtP@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 19 Dec 2024, Lukas Wunner wrote:

> On Thu, Dec 19, 2024 at 08:43:57AM +0900, Krzysztof Wilczy??ski wrote:
> > > > The GENMASK() macro used herein specifies 0 as lowest bit, even though
> > > > the Supported Link Speeds Vector ends at bit 1.  This is done on purpose
> > > > to avoid a GENMASK(0, 1) macro if Max Link Speed is zero.  That macro
> > > > would be invalid as the lowest bit is greater than the highest bit.
> > > > Ilpo has witnessed a zero Max Link Speed on Root Complex Integrated
> > > > Endpoints in particular, so it does occur in practice.
> > > 
> > > Thanks for adding this extra information.
> > > 
> > > I'd also add reference to r6.2 section 7.5.3 which states those registers 
> > > are required for RPs, Switch Ports, Bridges, and Endpoints _that are not 
> > > RCiEPs_. My reading is that implies they're not required from RCiEPs.
> > 
> > Let me know how you would like to update the commit message.  I will do it
> > directly on the branch.
> 
> FWIW, I edited the commit message like this on my local branch:
> 
> -Endpoints in particular, so it does occur in practice.
> +Endpoints in particular, so it does occur in practice.  (The Link
> +Capabilities Register is optional on RCiEPs per PCIe r6.2 sec 7.5.3.)
> 
> In other words, I just added the sentence in parentheses.
> But maybe Ilpo has another wording preference... :)

Your wording is good summary for the real substance that is the spec 
itself. :-)

-- 
 i.


