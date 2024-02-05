Return-Path: <linux-pci+bounces-3126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BDE84AA3C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 00:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC721C246BC
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 23:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D821DA52;
	Mon,  5 Feb 2024 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+4vsT+d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8ED482F6;
	Mon,  5 Feb 2024 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707174307; cv=none; b=AnhouwySRQCFpDxp171ksAQkMZ+h/dRVBZbQUCb3BNvHwAAdUYxM/4kABhLAWdr2tvzr4hkx9wdwe4rdx+W+OH8X1WcWdfDyajszeYPeeBCZLhvb/zaeQ1O0V0irjfg2kK0clEiHQyAgg4Xj3GP+QHYYfeLABtoc8Ir/F96SlSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707174307; c=relaxed/simple;
	bh=s83lCuKokWH11mDshMciFhjc8wYrwZThNCAv4SF+2fU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L5FXLcTDOj4twY2Xd0n9LboLk+zawbx7ITHF2qUUk88KXO83u6WPHxYi0yqSq83Fy3J+qtNEvThzYOBSaFqyaArh+2CSNl3iA+45PZRbm3zAek8XsnaR6UwzkYhNkHhMrKz84yEVA4cBiHWrwP/uJkJIodezXmqDgC+OC9QO/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+4vsT+d; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707174305; x=1738710305;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=s83lCuKokWH11mDshMciFhjc8wYrwZThNCAv4SF+2fU=;
  b=a+4vsT+dvsrZDWFiskd5ErjDt+UPtKmgubUtNENZKVmEjAhZbLBHYeoc
   v8q1hCc1y8sTQx5bHS9lF0f0k+150BJ8EbwAcPj5hG4WAYdDEcqf8xVx8
   grOdP++o+/XAyr2RMy07vABPDwaWVsrjKGzbscTjpOjblhH0v4maOinbX
   phSsI1BsTHFAgxLaEVGv58dSNUin5UzrQu3wvDfne1ZL0eAlvPBtzEy+Y
   eJV3YVTxAE3jn02u6T9N1o63m8IeuZXDXxHcWJY8qrSW4+ObJX08CR1N+
   0VeqyiUsNRPVObD+Gbsnin7PcgwumWm6vlSvDYQO10fKsweeCZmGv05S0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11707866"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11707866"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 15:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="31924907"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 15:05:03 -0800
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
	by linux.intel.com (Postfix) with ESMTP id EA048580D9C;
	Mon,  5 Feb 2024 15:05:02 -0800 (PST)
Message-ID: <02938148545933dc9865ddbc5551e3e8a579d57e.camel@linux.intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable PCI PM's L1 substates of remapped
 PCIe Root Port and NVMe
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jian-Hong Pan <jhp@endlessos.org>, Johan Hovold <johan@kernel.org>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Nirmal Patel
 <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux@endlessos.org
Date: Mon, 05 Feb 2024 15:05:02 -0800
In-Reply-To: <20240205224215.GA829734@bhelgaas>
References: <20240205224215.GA829734@bhelgaas>
Autocrypt: addr=david.e.box@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQENBF2w2YABCACw5TpqmFTR6SgsrNqZE8ro1q2lUgVZda26qIi8GeHmVBmu572RfPydisEpCK246rYM5YY9XAps810ZxgFlLyBqpE/rxB4Dqvh04QePD6fQNui/QCSpyZ6j9F8zl0zutOjfNTIQBkcar28hazL9I8CGnnMko21QDl4pkrq1dgLSgl2r2N1a6LJ2l8lLnQ1NJgPAev4BWo4WAwH2rZ94aukzAlkFizjZXmB/6em+lhinTR9hUeXpTwcaAvmCHmrUMxeOyhx+csO1uAPUjxL7olj2J83dv297RrpjMkDyuUOv8EJlPjvVogJF1QOd5MlkWdj+6vnVDRfO8zUwm2pqg25DABEBAAG0KkRhdmlkIEUuIEJveCA8ZGF2aWQuZS5ib3hAbGludXguaW50ZWwuY29tPokBTgQTAQgAOBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH7Mry1gl3p/NusIAK9z1xnXphedgZMGNzifGUs2UUw/xNl91Q9qRaYGyNYATI6E7zBYmynsUL/4yNFnXK8P/I7WMffiLoMqmUvNp9pG6oYYj8ouvbCexS21jgw54I3m61M+wTokieRIO/GettVlCGhz7YHlHtGGqhzzWB3CGPSJMwsouDPvyFFE+28p5d2v9l6rXSb7T297Kh50VX9Ele8QEKngrG+Z/u2lr/bHEhvx24vI8ka22cuTaZvThYMwLTSC4kq9L9WgRv31JBSa1pcbcHLOCoUl0RaQwe6J8w9hN2uxCssHrrfhSA4YjxKNIIp3YH4IpvzuDR3AadYz1klFTnEOxIM7fvQ2iGu5AQ0EXbDZgAEIAPGbL3wvbYUDGMoBSN89GtiC6ybWo28JSiYIN5N9LhDTwfWROenkRvmTESaE5fAM24sh8S0h+F+eQ7j/E/RF3pM31gSovTKw0Pxk7GorK
	FSa25CWemxSV97zV8fVegGkgfZkBMLUId+AYCD1d2R+tndtgjrHtVq/AeN0N09xv/d3a+Xzc4ib/SQh9mM50ksqiDY70EDe8hgPddYH80jHJtXFVA7Ar1ew24TIBF2rxYZQJGLe+Mt2zAzxOYeQTCW7WumD/ZoyMm7bg46/2rtricKnpaACM7M0r7g+1gUBowFjF4gFqY0tbLVQEB/H5e9We/C2zLG9r5/Lt22dj7I8A6kAEQEAAYkBNgQYAQgAIBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsMAAoJEH7Mry1gl3p/Z/AH/Re8YwzY5I9ByPM56B3Vkrh8qihZjsF7/WB14Ygl0HFzKSkSMTJ+fvZv19bk3lPIQi5lUBuU5rNruDNowCsnvXr+sFxFyTbXw0AQXIsnX+EkMg/JO+/V/UszZiqZPkvHsQipCFVLod/3G/yig9RUO7A/1efRi0E1iJAa6qHrPqE/kJANbz/x+9wcx1VfFwraFXbdT/P2JeOcW/USW89wzMRmOo+AiBSnTI4xvb1s/TxSfoLZvtoj2MR+2PW1zBALWYUKHOzhfFKs3cMufwIIoQUPVqGVeH+u6Asun6ZpNRxdDONop+uEXHe6q6LzI/NnczqoZQLhM8d1XqokYax/IZ4=
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-05 at 16:42 -0600, Bjorn Helgaas wrote:
> On Mon, Feb 05, 2024 at 11:37:16AM -0800, David E. Box wrote:
> > On Fri, 2024-02-02 at 18:05 -0600, Bjorn Helgaas wrote:
> > > On Fri, Feb 02, 2024 at 03:11:12PM +0800, Jian-Hong Pan wrote:
> > ...
>=20
> > > > @@ -775,6 +773,14 @@ static int vmd_pm_enable_quirk(struct pci_dev
> > > > *pdev,
> > > > void *userdata)
> > > > =C2=A0	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT,
> > > > ltr_reg);
> > > > =C2=A0	pci_info(pdev, "VMD: Default LTR value set by driver\n");
> > >=20
> > > You're not changing this part, and I don't understand exactly how LTR
> > > works, but it makes me a little bit queasy to read "set the LTR value
> > > to the maximum required to allow the deepest power management
> > > savings" and then we set the max snoop values to a fixed constant.
> > >=20
> > > I don't think the goal is to "allow the deepest power savings"; I
> > > think it's to enable L1.2 *when the device has enough buffering to
> > > absorb L1.2 entry/exit latencies*.
> > >=20
> > > The spec (PCIe r6.0, sec 7.8.2.2) says "Software should set this to
> > > the platform's maximum supported latency or less," so it seems like
> > > that value must be platform-dependent, not fixed.
> > >=20
> > > And I assume the "_DSM for Latency Tolerance Reporting" is part of th=
e
> > > way to get those platform-dependent values, but Linux doesn't actuall=
y
> > > use that yet.
> >=20
> > This may indeed be the best way but we need to double check with our
> > BIOS folks.=C2=A0 AFAIK BIOS writes the LTR values directly so there
> > hasn't been a need to use this _DSM. But under VMD the ports are
> > hidden from BIOS which is why we added it here. I've brought up the
> > question internally to find out how Windows handles the DSM and to
> > get a recommendation from our firmware leads.
>=20
> We want Linux to be able to program LTR itself, don't we?=C2=A0 We
> shouldn't have to rely on firmware to do it.=C2=A0 If Linux can't do
> it, hot-added devices aren't going to be able to use L1.2, right?

Agreed. We just want to make sure we are not conflicting with what BIOS may=
 be
doing.

David

