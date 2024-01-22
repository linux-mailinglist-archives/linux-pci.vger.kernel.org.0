Return-Path: <linux-pci+bounces-2415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7F4836311
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 13:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAF81F219BE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 12:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD59B3D571;
	Mon, 22 Jan 2024 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frXLkzL0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D2D3D55C;
	Mon, 22 Jan 2024 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926036; cv=none; b=t7LmU6JNw/kGdgj3DyyN9XIhVcNMArZT/VLQ66wfMvMcOXD+l32XQwGwheabJVeG4RuF9XID2pLuYiZ30vKwmw0GMX1RW8tHi0t2yJiuPhmjbrgMXds/c0Sta8J5kD5UUP5bFxdETfh+76R1bmQ1idz3d69+BykmebpJiI+FrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926036; c=relaxed/simple;
	bh=Fst93YHEkoTT1MXwK0wHemZAw7gr0g5iyr/F8HZnIIM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=de+smXdzHJKokU4bt2i1b6Q9BLQjRcmuxFOdWiXXdz5HS/QhOJB7t6upOB2qdSXjSSKu7ZHiFV9i/XyiEBtUsYqKAdq4SzvtC3TSD1KA3EajXoMAU58kXTN5LEiraZrnbM1BJl7yqwriAHLgfjcqQf10OLpKa/fj6d0dqxQMOVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frXLkzL0; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705926035; x=1737462035;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Fst93YHEkoTT1MXwK0wHemZAw7gr0g5iyr/F8HZnIIM=;
  b=frXLkzL0VjVd39MyvrLetgsGYHs1X5wSqLS4MOJjOHrh6Ep1bFa0Z+dJ
   Q92er2gbiFW21gaxd6HELDswc+HvSqLOZEi2vuQqRe/q5+DG5nYCVWvAt
   akvqgINGixQl2/rik0JNlEdxUzlEsCBYPcSUdkhjzLtSTB6gKZua3v9/A
   sBosI2+6kKPQjNHV2JiX+6mcWGQXEcu7+w+7MJZeCflFMQYwJAU7h/fw1
   +Le0X5lYenV1cFk/9sE2mRMdJxrQbrO3VkhATwQDduzugQjEaEJyCOTPs
   3O7+WDYHJcUMZ7z7LztZGf45qoyBiobRYzHSLZRtFi1VIBGcepc5yN3FK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="432355872"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="432355872"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:20:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="958720646"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="958720646"
Received: from avulfx-mobl1.ger.corp.intel.com (HELO localhost) ([10.94.249.150])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:20:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 22 Jan 2024 14:20:25 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    Keith Busch <kbusch@kernel.org>, Dongdong Liu <liudongdong3@huawei.com>, 
    linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI/DPC: Fix TLP Prefix register reading offset
In-Reply-To: <20240119225923.GA191511@bhelgaas>
Message-ID: <ad91677a-cce3-03fe-c826-12f8d44e3466@linux.intel.com>
References: <20240119225923.GA191511@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1542941559-1705925767=:994"
Content-ID: <c10c0ccc-5b18-b509-a91c-8375ff8673c8@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1542941559-1705925767=:994
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <ac85c081-d4f5-e715-905e-e955db4eb39c@linux.intel.com>

On Fri, 19 Jan 2024, Bjorn Helgaas wrote:

> On Thu, Jan 18, 2024 at 01:08:15PM +0200, Ilpo J=E4rvinen wrote:
> > The TLP Prefix Log Register consists of multiple DWORDs (PCIe r6.1 sec
> > 7.9.14.13) but the loop in dpc_process_rp_pio_error() keeps reading
> > from the first DWORD. Add the iteration count based offset calculation
> > into the config read.
>=20
> So IIUC the user-visible bug is that we print only the first PIO TLP
> Prefix (duplicated several times), and we never print the second,
> third, etc Prefixes, right?

Yes.

> I wish we could print them all in a single pci_err(), as we do for the
> TLP Header Log, instead of dribbling them out one by one.

I've also done some work towards consolidating AER and DPC TLP=20
Header/Prefix Log handling which is when I found this bug (the reading=20
side is already done but printing is still pending).

> > Fixes: f20c4ea49ec4 ("PCI/DPC: Add eDPC support")
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-1542941559-1705925767=:994--

