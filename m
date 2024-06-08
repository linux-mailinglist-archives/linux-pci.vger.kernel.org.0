Return-Path: <linux-pci+bounces-8491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064C990133D
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jun 2024 20:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B4EB21D36
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jun 2024 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCB01862;
	Sat,  8 Jun 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="CW1b61ep"
X-Original-To: linux-pci@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7EF1CA81
	for <linux-pci@vger.kernel.org>; Sat,  8 Jun 2024 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717871713; cv=none; b=Hp/lsJ4xGFIBdfajOWJmQ9frSMQ1CUhBJomP3016kS+FQFIQiyBxRB2Bxx88xb9V4AN5XktwOSthTO+sBSYt5YaEnoW5/+LceyFbE12FIve4s7j3LiOmJIWmCc5qHm/TZ5ej5CddRJ6l/JU5FUETtN4PdS+TrMvZx/WilXi3RkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717871713; c=relaxed/simple;
	bh=7qwZg0xQv1yAq9lcPdPS+qMT6BcA9jRN3lFG28qDQl4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IJB8EcDw5ab2V48krDf+2CGPbyybXkBcj0GPil/3VKdFMSokklyaBwdqPNnMQ9cLeLbUCZHAThKDI6imLryX5GFLKYhLwi6JPyE9q0BHhqMDtZaBI975RK4sVNZJYC8opQiCvYpV4z13t6Ai05nHNe6FTgaLtYi49BrpYkvGUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=CW1b61ep; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: from albireo.ucw.cz (albireo.ucw.cz [91.219.245.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: smtp-albireo)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id AE7F71C0099
	for <linux-pci@vger.kernel.org>; Sat,  8 Jun 2024 20:35:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1717871700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g8MD6LIbkpeDLHRQAiQ6JPEH+nePk6H5b4B9IHRgzOE=;
	b=CW1b61epSKVU2ZD7JC+EE9ChHPK9MFbtcJ9jw1TSh+wznGzCueWDpAqwDIvsfd92+TwJFe
	gV6imD0nMaRN6/E+z9zhx0pV20qV86Al8t+IDlad8N8pwCs1EE23l2sxAnhyfO5gsRxsPe
	RzXraNc2XYF3IG0vzAnPtrDM5wl0hGE=
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id 15CA1AC157A; Sat,  8 Jun 2024 20:35:00 +0200 (CEST)
Date: Sat, 8 Jun 2024 20:35:00 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: pciutils-3.13.0 released
Message-ID: <mj+md-20240608.183413.28680.albireo@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello, world!

I just released version 3.13.0 of the PCI Utilities.

Thus quoth the ChangeLog:

2024-05-30  Martin Mares <mj@ucw.cz>

	* Released as 3.13.0.

	* lspci decodes CXL 1.1 device link status information.
	  This requires a recent kernel which exports rcd_* atributes via
	  sysfs.

	* Further development of the pcilmr (the link margining utility)

	* Dump parsing supports 6-digit domain numbers.

	* Bug fixes in PCIe link state reporting.

	* Decode more fields in PCIe AER capability.

	* Fixed build on Linux systems with musl libc.

	* Updated pci.ids.

-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
Uncle Ed's Rule of Thumb:  Never use your thumb for a rule.

