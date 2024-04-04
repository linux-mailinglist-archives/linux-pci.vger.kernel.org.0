Return-Path: <linux-pci+bounces-5722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A130898469
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 11:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444BA28D8D6
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76E474438;
	Thu,  4 Apr 2024 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qj7CQ2JS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FB28F7D;
	Thu,  4 Apr 2024 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712224292; cv=none; b=gFvoSTjpZpambtiplucToy40iTgKphs2cwtYIwDKYY/N6FalLiom3DWZFdXQgG4QUe9liX3PiaVRnnLMEyexrpxwzWixNgnmQ5k/FKgYnH4vI3X8apQhSPJaADl/qE7xRHIJQ/DRXlH+TMwBm1T/pG01fa0qxV0Z7/iAfebukoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712224292; c=relaxed/simple;
	bh=QXkkR+15Nk+Hzti1dm3lVDSpnwBTvtUHwgacoad2c0Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IEchrTZgcWNsItqKNKZAzrWwA8iYOrturHm/A1DeG7vfrKlA/PBb9e/bn7qyLB8Gs1dUfipXOFmmztSvkkv/Mf3skK+rHyZlLIGZuZi4YOz1GeZnpxrLxpjpYb4XYCKYnQvoQBo+1k5PhrltjR/1GAlkt7+WQga7acI/05t1Ig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qj7CQ2JS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712224292; x=1743760292;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QXkkR+15Nk+Hzti1dm3lVDSpnwBTvtUHwgacoad2c0Q=;
  b=Qj7CQ2JSi5Slr5b6W100qrMOzcC+zGCQewKp3L6H08G9NWqRJexY5YGp
   Krc8k7b1WBbe33z0vvs0YtZZN/67ektrx+4MCrOmizxsXwKnlaGp/cGyB
   5OiguhQ6j5ttKUpwpq0PSs7ZVjGtVS/s2nxMRfEAieQMFajADxYMdnFhB
   /65r9kX5IyzsGWCym04bR2XEnsjIJGsmDMs2nN17hC9kFe0l/OQX2qWqP
   02vbZOhg4JVNRDcDCP48drU1te+x+MHUZum9VJtYaZqvwHszVrR7cmFZC
   m5w9HADugAw3WBkBgqL/h4xHK2rHIZXICmuE+4qgENtv0HkKK8tuaoxLF
   Q==;
X-CSE-ConnectionGUID: 7B4gZy1nTeePolv4VVl5xg==
X-CSE-MsgGUID: 46/ue34OTzOl+2STJaL90w==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7393831"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7393831"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 02:51:30 -0700
X-CSE-ConnectionGUID: ZygVWsUXSny15fRqkdCyjw==
X-CSE-MsgGUID: 42Z4lqgpT3m7ucWMfJP/9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="19186529"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.26])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 02:51:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 4 Apr 2024 12:51:20 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] PCI: Add TLP Prefix reading into
 pcie_read_tlp_log()
In-Reply-To: <Zg50P2JcpvO8S-a7@wunner.de>
Message-ID: <cc4f4e53-22d3-b5b0-bc9d-3156bfec6652@linux.intel.com>
References: <20240403100206.4403-1-ilpo.jarvinen@linux.intel.com> <20240403100206.4403-2-ilpo.jarvinen@linux.intel.com> <Zg50P2JcpvO8S-a7@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-71238506-1712224280=:2725"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-71238506-1712224280=:2725
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 4 Apr 2024, Lukas Wunner wrote:

> On Wed, Apr 03, 2024 at 01:02:05PM +0300, Ilpo J=E4rvinen wrote:
> > pcie_read_tlp_log() handles only 4 TLP Header Log DWORDs but TLP Prefix
> > Log (PCIe r6.1 secs 7.8.4.12 & 7.9.14.13) may also be present.
> >=20
> > Generalize pcie_read_tlp_log() and struct pcie_tlp_log to handle also
> > TLP Prefix Log. The layout of relevant registers in AER and DPC
> > Capability is not identical but the offsets of TLP Header Log and TLP
>                 ^^^           ^^^
> Somehow this doesn't seem to make sense.  Is the "not" perhaps wrong here=
?

Hi Lukas,

How about changing it into plural and adding a comma:

The layouts of relevant registers in AER and DPC Capabilities are not=20
identical, but ...

Does that sound better?

> > Prefix Log vary so the callers must pass the offsets to
> > pcie_read_tlp_log().


--=20
 i.

--8323328-71238506-1712224280=:2725--

