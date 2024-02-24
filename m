Return-Path: <linux-pci+bounces-3979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923328627E5
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 23:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A94281F3F
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 22:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1E0C2D0;
	Sat, 24 Feb 2024 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="A05ielGo"
X-Original-To: linux-pci@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46BA4D58A
	for <linux-pci@vger.kernel.org>; Sat, 24 Feb 2024 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708812194; cv=none; b=I8aEQf7m9JALOvlxDHSvUIHl0MrSofhJVofMWwsL0NBFa3628fyBnfx6eFwB3p6IctiL9BMjJzvQ1oG3BJGd6ixcOOZHjR9jo9/OL2Ivk8iF2zRVJIxBeT7GTWPID+ueDxKuulWcnelypWXmjRJ7cwAXphOx4nIb0W8GTcRDyQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708812194; c=relaxed/simple;
	bh=9fDJS6drRd7WIOaAhnxp/3R83Mzg3rzD3b7ZUNQdZ6U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F0KwWvRRj0EQqpBNKPN+J1mYLAq1cjbVtBETo0LrWBpkl9QTrnaIZgXW8xr7MwDVtSjRt+KVcUlJN6ls3Or6mXBdSCEvePoJ/68PRlRqegT9LmSP59dPzWYPoCiqUPI2nsm4VMQl0RTGUc98ToU5If3YIhwZkgiDYB3xItZMOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=A05ielGo; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: from albireo.ucw.cz (albireo.ucw.cz [91.219.245.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: smtp-albireo)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id CD4911C007E
	for <linux-pci@vger.kernel.org>; Sat, 24 Feb 2024 23:03:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708812182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/g/xT+4HRq5XYjnikCVNQ4mviNwR08OlYj7aGowDNAM=;
	b=A05ielGo5E93yO/vjCxSQX3K2iWg7J4YAmAOznNhEwQeBa+or/1CC2/yPH1mzljLLb+iwB
	wxM1lezE9mVPO6vBYT2aK8nheZrkNx+PzTo/BQbgjXcN+lOVeoGd8c2+VsNygxUPfmxTrE
	tLVpzgYU4sZ3kZjcqL+2L5DbthUtpVA=
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id 8E8B3AC15BF; Sat, 24 Feb 2024 23:03:01 +0100 (CET)
Date: Sat, 24 Feb 2024 23:03:01 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: pciutils-3.11.0
Message-ID: <mj+md-20240224.220216.51503.albireo@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello, world!\n

I just released version 3.11.0 of the PCI Utilities.

Thus quoth the ChangeLog:

2024-02-24  Martin Mares <mj@ucw.cz>

	* Released as 3.11.0.

	* update-pciids now supports XZ compression. If libpci is configured
	  with support for compression, all downloaded files are recompressed
	  as gzip. Otherwise they are stored as plain text.

	* update-pciids now sends itself as the User-Agent.

	* Added a pcilmr utility for PCIe lane margining. Thanks to Nikita
	  Proshkin for contributing it.

	* Re-factored access to i386 ports on all relevant platforms.

	* Added i386 port access on OpenBSD.

	* Back-ends for Windows received many bug fixes and improvements.

	* ECAM back-end now scans ACPI and BIOS memory faster.

	* Linux systems without pread/pwrite are no longer supported
	  as they are hopefully long gone. This helps avoid the tricky check
	  for presence of pread which was found to fail on musl libc.

	* Improved decoding of PCIe control and status registers.

	* Decoding of CXL capabilities now supports up to CXL 3.0.

	* lspci now displays interrupt message numbers consistently across
	  different capabilities.

	* Cache of IDs resolved via DNS, which was located in ~/.pci-ids
	  by default, is now stored according to the XDG base directory
	  specification in $XDG_CACHE_HOME/pci-ids.

	* All source files now have SPDX license identifiers.

	* Internal: The "aux" fields of structs pci_access and pci_dev
	  reserved for use by back-ends were renamed to backend_data to better
	  reflect their meaning.

	* As usually, various minor bug fixes and updated pci.ids.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe

