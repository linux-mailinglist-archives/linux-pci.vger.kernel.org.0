Return-Path: <linux-pci+bounces-28091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287AFABD5B2
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 12:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7EC3A717D
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054362749F7;
	Tue, 20 May 2025 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNj9CCko"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C392571C6;
	Tue, 20 May 2025 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747738768; cv=none; b=ohl0WaCXqXq6PRXjCnzxUn9ILMpdwB2/dcwAaog+fCmeLvzhKceJEVC1u1waoGPy3ZFY2IpBenJHkV4WWEuZrhl6pvmL1I7cMW/TyAnwzlZ+YoyuICmQgVPSU/WJ/awsUPgSUhK4LaIfzDBynOoo6rmS5i5ZsaOlTX4D8PSi34o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747738768; c=relaxed/simple;
	bh=l4iEXYcV8csXHHOj1KNHmvhvqNAfPwRVS8lQzLyZEss=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tFvicMll/Ao4GsJYcHAWeUFkL8qx/P8hHbxlUrNae0zQDmf0YRBfU4NiuGU0Y/IFWoQ43Rb1nguhpWDiUC3r4butgLtABupZb/KT14w9hDBomIsFM3lMKoo2dGb/9zhMqm16Vn62iVx4MqzrmUEByWjSItIIZZcOSASn5joEycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNj9CCko; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747738767; x=1779274767;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=l4iEXYcV8csXHHOj1KNHmvhvqNAfPwRVS8lQzLyZEss=;
  b=DNj9CCkoEToC++GXIxMtiPzCqVhjcaAUgWxoADXswGopvsyNtnb4IMUI
   419Momycxd93TlzBp8cxsR0upGJjvsV7kNfnAKmS697dfcZdSk3pGVJuj
   JcH5pu4UiXIehff60klC3Xddv5IRKiZWksOGAsRMDjGCGPCL1N0KEVnss
   uRSM0ER98EJFSSvOFHrnf72JG+j36sfRAh9ri5Dql4GMEX9pzD8Y6idpM
   CGBBFjQDIQy5tub3ksH+7K849P9p2CV+nhdZqdVGlXLfR79z3cIJ++bPn
   BXHiwXc3x0d9gLstu3WdJALvp5VQFu5OdPKGzS2WmPLaq5nlzt8QCL4wg
   g==;
X-CSE-ConnectionGUID: ODNJ/k/4Rpq/Rs8oSUfQaA==
X-CSE-MsgGUID: YOoNKrYTR2SFeOVNsx7Dcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="75067870"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="75067870"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:59:26 -0700
X-CSE-ConnectionGUID: 75p56i/uQLygPkRJ9zIKag==
X-CSE-MsgGUID: Bz8y70cdTEOwmBZJo11Zog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140167898"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 03:59:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 13:59:17 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>, Shuai Xue <xueshuai@linux.alibaba.com>
cc: rostedt@goodmis.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, helgaas@kernel.org, 
    bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de, 
    mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com, 
    naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com, 
    mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
In-Reply-To: <aCxdFm_BpgOTFFUv@wunner.de>
Message-ID: <15e8e19d-d471-69da-b928-afc20ee9a584@linux.intel.com>
References: <20250512013839.45960-1-xueshuai@linux.alibaba.com> <87b1f8c6-bd72-b1a8-40a6-bbf552552806@linux.intel.com> <650cd4e4-561b-4d50-9cf2-c601518c9b9f@linux.alibaba.com> <31693574-e8bc-9a56-bad0-6a22280c4b6b@linux.intel.com>
 <aCxdFm_BpgOTFFUv@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-557717680-1747738757=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-557717680-1747738757=:936
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 20 May 2025, Lukas Wunner wrote:

> On Tue, May 20, 2025 at 01:07:28PM +0300, Ilpo J=E4rvinen wrote:
> > On Tue, 20 May 2025, Shuai Xue wrote:
> > > , and the format of "Link Speed changed" is a bit different from=20
> > > "pci_hp_event".
> >=20
> > The difference is only because when the Link is down, there's no Link
> > Speed (obviously). Whenever a new device is hotplugged and it comes up,=
=20
> > there's also Link Speed for it which can be included into the trace eve=
nt.=20
> >=20
> > I think the trace event should have some special value for the fields t=
hat=20
> > are N/A due to Link being off. While it would be possible to create=20
> > separate events for speed changes and hotplug, I don't see any pros in=
=20
> > that approach over just having the N/A fields marked as such when the L=
ink=20
> > is Down.
>=20
> Link speed changes and device plug/unplug events are orthogonal,
> I don't think they should be mixed together in the same event.
>=20
> A link speed event can be signaled simultaneously to a plug event
> and then user space can decide in which type of event it's
> interested in.
>=20
> That also avoids the awkwardness of having N/A values for the
> link speed on unplug.

Fair enough.

--=20
 i.

--8323328-557717680-1747738757=:936--

