Return-Path: <linux-pci+bounces-26753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F35A9C8E6
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 14:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F0492342C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 12:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA372475C3;
	Fri, 25 Apr 2025 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTNSIKhW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4874E2472A4;
	Fri, 25 Apr 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745583894; cv=none; b=jE4CfyWLFgDLqDldRDR5nHj2ifiOsKAXKo6/7+gpfkvgI97zeFkUqDX8gzRXWJs5GWndFLtTDMvB+4Nj3M8DpWFBYikgdxNo6+6AV6VFxqOP8AT+nZK3gWN261XPp5No0kwd1r71iA2eGbO3J/C0Fbp299soG6Ub5oVDk9MkT0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745583894; c=relaxed/simple;
	bh=o0G2Agd2ibaLb8R6Vx4aLbFASWkHWp0MhHcs9AOgB4Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WtN3D7dkxEo4WKbfS8zRS/9pbjMDGgJyWjsUafUuWoEGPYp5VJiPFyG9qpy9N8KyVnuduaUm+XOmg6eUouVT8xLeYcpaBbd3IQc9ZNWsZGerk41C0li9xka3SubCKOq8xUEtlWFbkaC5bYzxid0xS5KGdjRKgUR/BPOElJPVvB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTNSIKhW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745583892; x=1777119892;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=o0G2Agd2ibaLb8R6Vx4aLbFASWkHWp0MhHcs9AOgB4Q=;
  b=cTNSIKhWxsRvZCRzQwB88RB+dXZvBsUL/a0t+cOfOSQeG8F8uFv7N3Qo
   Y6MWJB+gOcUGQ2rg3CU+0FuQlZZumlAcddOlVyoQZkF8a93qQkpUoUC4E
   oUFqDrYu3DT0YdNEa5n5qaN60MMrKULKdJ2N1Vksm8h2/9xXVC7as9ox9
   FA9K8dweUR0OFIAlNbvDQ20bE8Eaw8p/Fb5deuywV3jRaLpWQbywLNveb
   QWvr5bs1kiB2iIwpQwFZKUSn6weYB5FwzB4iUIFyllQNoA4cQuCazp6PR
   sP+FiM2KnG0OH1VXYR4vqRa1N5ec2dgWmk/WRgSYvTXg4zjjWvfQy4Asz
   Q==;
X-CSE-ConnectionGUID: ADDYL31+TjORD/XdoyzcGw==
X-CSE-MsgGUID: qKAk/pv7RvS8YaDTwNmfjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="58615646"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="58615646"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 05:24:51 -0700
X-CSE-ConnectionGUID: eGaKsxZvS+GeZKpa8TKIsQ==
X-CSE-MsgGUID: YGxb5wC5QmCgcvgYPUdp5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="132637150"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.154])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 05:24:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 25 Apr 2025 15:24:45 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v2 1/1] PCI/bwctrl: Replace lbms_count with PCI_LINK_LBMS_SEEN
 flag
In-Reply-To: <aAtgIfG8VG7vLDPN@wunner.de>
Message-ID: <e154f382-629e-f910-ea56-7cce262df079@linux.intel.com>
References: <20250422115548.1483-1-ilpo.jarvinen@linux.intel.com> <aAi734h55l7g6eXH@wunner.de> <87631533-312f-fee9-384e-20a2cc69caf0@linux.intel.com> <aAnOOj91-N6rwt2x@wunner.de> <e639b361-785e-d39b-3c3f-957bcdc54fcd@linux.intel.com>
 <aAtgIfG8VG7vLDPN@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2091258201-1745583885=:950"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2091258201-1745583885=:950
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 25 Apr 2025, Lukas Wunner wrote:
> On Thu, Apr 24, 2025 at 03:37:38PM +0300, Ilpo J=E4rvinen wrote:
> > On Thu, 24 Apr 2025, Lukas Wunner wrote:
> > >   The only concern here is whether the cached
> > >   link speed is updated.  pcie_bwctrl_change_speed() does call
> > >   pcie_update_link_speed() after calling pcie_retrain_link(), so that
> > >   looks fine.  But there's a second caller of pcie_retrain_link():
> > >   pcie_aspm_configure_common_clock().  It doesn't update the cached
> > >   link speed after calling pcie_retrain_link().  Not sure if this can
> > >   lead to a change in link speed and therefore the cached link speed
> > >   should be updated?  The Target Link Speed isn't changed, but maybe
> > >   the link fails to retrain to the same speed for electrical reasons?
> >=20
> > I've never seen that to happen but it would seem odd if that is forbidd=
en=20
> > (as the alternative is probably that the link remains down).
> >=20
> > Perhaps pcie_reset_lbms() should just call pcie_update_link_speed() as =
the=20
> > last step, then the irq handler returning IRQ_NONE doesn't matter.
>=20
> Why pcie_reset_lbms()?  I was rather thinking that pcie_update_link_speed=
()
> should be called from pcie_retrain_link().  Maybe right after the final
> pcie_wait_for_link_status().

My reasonale for having it in pcie_reset_lbms() is that LBMS is cleared
there which races with the irq handler reading LBMS. If LBMS is cleared=20
before the irq handler reads linksta register, it returns IRQ_NONE and=20
will misses the LBMS event. So this race problem is directly associated=20
with the write-to-clear of LBMS.

> That would ensure that the speed is updated in case retraining from
> pcie_aspm_configure_common_clock() happens to lead to a lower speed.
> And the call to pcie_update_link_speed() from pcie_bwctrl_change_speed()
> could then be dropped.
>
> PCIe r6.2 sec 7.5.3.19 says the Target Link Speed "sets an upper limit
> on Link operational speed", which implies that the actual negotiated
> speed might be lower.

While I don't disagree with that spec interpretation, in case of ASPM, the=
=20
question is more complex than that. The link was already trained to speed=
=20
x, can the new link training result in failing to train to x (in=20
practice).

The funny problem here is that all 3 places have a different, but good=20
reason to call pcie_update_link_speed():

1) pcie_reset_lbms() because of the LBMS race mentioned above.

2) pcie_retrain_link() because Link Speed could have changed because of=20
   the link training.

3) pcie_bwctrl_change_speed() because it asked to change link speed, and=20
   also due to the known HW issue that some platforms do not reliably send=
=20
   LBMS (I don't recall if it was interrupt triggering issue or issue=20
   with asserting LBMS itself, the effect is the same regardless).

In addition, in the code 3) calls 2) and 2) calls 1), which leaves=20
pcie_reset_lbms() as the function where all roads always lead to including=
=20
those that only call pcie_reset_lbms(). So if pcie_update_link_speed() is=
=20
to be placed not all those three places but only one, the best place seems=
=20
to be pcie_reset_lbms() as it covers all cases including those that only=20
calls it directly.

--=20
 i.

--8323328-2091258201-1745583885=:950--

