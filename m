Return-Path: <linux-pci+bounces-30297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE56AE2A2E
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 18:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E333B36F7
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 16:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8B57262A;
	Sat, 21 Jun 2025 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="G3EwfvGY"
X-Original-To: linux-pci@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665730E859
	for <linux-pci@vger.kernel.org>; Sat, 21 Jun 2025 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750522371; cv=none; b=YVd29VJBDaejskWvDM1kNNgj3qH7/zKkXjdulINNsvQo19pRyWYAKIPTF5cBT/cSdjdbvD9e4wxZdxE9j1hap3IjxLaros7sdc29FmMzZGFb8TyxVWFItYn25iWAitgx2rj7A540aStWiTx6in7OI2M/f7mmr9YUxKOrL7w4Lro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750522371; c=relaxed/simple;
	bh=iUAML1iZ6ZsHRKhp9cltGlbalqE1dwLtzgyWl+Gg5YU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d5tJgj7XDmQIxVC5ojghAfh67UE9O7uy1cvgsC7P4qw5UEiu8vLqmljHq7mymhEFeRMOrkotLgqHJFcBX/ZPedeP8LNF/IsesHirq3WcRsHGrtRrFPVSPBMRmUO8T8B34M9z3b7Vs9rMJsUxOavocKeXknsQfP+1Fy8FfGeG+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=G3EwfvGY; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: from albireo.ucw.cz (albireo.ucw.cz [91.219.245.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: smtp-albireo)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 6D1761C00A4
	for <linux-pci@vger.kernel.org>; Sat, 21 Jun 2025 18:12:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1750522359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q7NQ+YhvgjsasqlDkK2+eCcAj6GlwB0ewxgMaWEgw18=;
	b=G3EwfvGY5E9WGZayBjF0YPfdXuJTfBemFY7VtzeRxMCsqczobGtuBimygI8gaUYA5cRczN
	arShwOKUdxLsQrkQJ3umGdlrK4moGHKZeLQGuSE6uHldZCyrtyBYuQgMQZDn2H3V1sIN3J
	9sB4gRHeEDtHVBwAqgyP2o7lBOSvNao=
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id DAC4AAC07CB; Sat, 21 Jun 2025 18:12:38 +0200 (CEST)
Date: Sat, 21 Jun 2025 18:12:38 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: Released pciutils-3.14.0
Message-ID: <mj+md-20250621.161215.54756.albireo@ucw.cz>
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

I released version 3.14.0 of the pciutils.

From the changelog:

	* New capabilities are decoded: VirtIO SharedMemory, Physical Layer
	  16 to 64 GT/s, Flit Mode, Device 3, Intel vendor-specific.

	* ECAM now works on Windows and DJGPP.

	* The GNU/Hurd back-end works on 64-bit systems.

	* Added a new back-end for RT-Thread Smart OS.

	* <lib/header.h> got definitions of new classes and capabilities
	  from PCI Code and ID Assignment rev 1.18.

	* <lib/pci.h> can be included from C++ programs.

	* Updated pci.ids.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe

