Return-Path: <linux-pci+bounces-38430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2757BE7113
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 10:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E6AF35B8CA
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 08:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC6926B764;
	Fri, 17 Oct 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=dxcv.net header.i=@dxcv.net header.b="DvQRhkir"
X-Original-To: linux-pci@vger.kernel.org
Received: from srv3.dxcv.net (srv3.dxcv.net [51.159.5.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98485334693;
	Fri, 17 Oct 2025 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.5.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688828; cv=none; b=hBgw49STttt408d/6nFBaMMEiwx/ew27g/oxiQEMECzRgTTUbkgOGtOzOWPMi6z2b9TYUoHiosK0MC0JQtKd7QW5TbJdKp5A4ZhWAjxVDzeEoYfiyIAKNnI/TB+ELkEMUYVxMo+KlpNBfBWAS2V7/563/Ppebz1Gx8cb6u/goNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688828; c=relaxed/simple;
	bh=IT/1H8bZG3gi4aXPPnDMBUEudCh+RZyhtqpbz3ot7ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kR1ktJ9KP3F+a6hUOOD/x7HTregLKwAwUP0L6MEEAaGxTdF6ypXGdkla1W40MRTteQjfkBKFC69jE8uQuK/7gTv5g1miGE0FIZRTSk013tjUJcrbGrpyncN1+/InxnwpR2VAOHpMveN2lN2ef+anLSr2NT06Lyxj2tb9sS1vD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dxcv.net; spf=pass smtp.mailfrom=dxcv.net; dkim=pass (4096-bit key) header.d=dxcv.net header.i=@dxcv.net header.b=DvQRhkir; arc=none smtp.client-ip=51.159.5.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dxcv.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxcv.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dxcv.net;
	s=email; h=Message-ID:Date:Subject:Cc:To:From:sender:reply-to;
	bh=IT/1H8bZG3gi4aXPPnDMBUEudCh+RZyhtqpbz3ot7ok=; t=1760688826; x=1761552826; 
	b=DvQRhkirYZ3pHJo8IRRjIXkswRlN8aINXHvzHsDhil3sateQA0Sla2ljKoZ8sbsPqG76kJzEbdN
	BJ0WbpKSFVokpcf/rwZKCCw48vDo5ezM9kJfRZqfQlvd68Qu2yiO4FVicdUa8LSswQ7KsWTaN8rCT
	Z8qF4sqhadglt21FFHOZ928vznONw+gjpf6dcajD0Bpl0G4ZGtdwFn/T69nmi8k8JjW7PXCZuiD9R
	8orlToBCWU0R+JV1D9KSPXEy5Nn7qWFEaPeFvAvc5d0qU60DnLACyvf3XJSQrHwqigVOsZMEt2sde
	pa63pksnOTBUMe5BKG19AgPxQf0EsANxgAmzhYVLoix0izo9mE9TYfmuBA0VorqE7rZak26Wde2KM
	ZYGOUzEotQXU7lrjWtWoQDKkuRjKcrPD0jb59DJ1DlFnnLCiOba0wUrVZl+mTmAZdhsZEq58HTjq7
	y1dNpJ/ajUlILwjglWjPd1xJlKvg14UBZBRiX/WA19a+2k/hCq/kMIdbFyG4gfXt998TBfkFEI7NV
	tED2IZpn5KiXqA23j6+HtsVcbCPkqhJeN1gnzJP3+b3dCzgXIrNBrV/RsvTIcom+kWMQB6FLQEKWy
	xNpykidj2cMkKffiHXIJEcU4XtIcqHrYgqw7HBuDGPGRgV+Cin/aTsqjXFzaXyBiCiEmk=;
Received: from static-css-csq-219011.business.bouyguestelecom.com ([176.175.219.11] helo=fareins.teamgreen.fr)
	by srv3.dxcv.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <herve@dxcv.net>)
	id 1v9euS-002YEz-1p;
	Fri, 17 Oct 2025 09:29:56 +0200
From: =?UTF-8?q?Herv=C3=A9=20D=2E?= <herve@dxcv.net>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	dlan@gentoo.org,
	inochiama@gmail.com,
	jonathan.derrick@linux.dev,
	kenny@panix.com,
	kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lists@sapience.com,
	looong.bin@gmail.com,
	lpieralisi@kernel.org,
	mani@kernel.org,
	nirmal.patel@linux.intel.com,
	robh@kernel.org,
	socketcan@hartkopp.net,
	tglx@linutronix.de,
	todd.e.brandt@intel.com,
	unicorn_wang@outlook.com,
	=?UTF-8?q?Herv=C3=A9?= <herve@dxcv.net>
Subject: Re: [PATCH] PCI: vmd: override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info()
Date: Fri, 17 Oct 2025 09:29:52 +0200
Message-ID: <20251017072954.6978-1-herve@dxcv.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016165541.GA989894@bhelgaas>
References: <20251016165541.GA989894@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I've tested the patch on a clean 6.17.3 tree, seems booting and running properly on my debian13 system.

you can include theses on the patch
Reported-by: Hervé <herve@dxcv.net>
Tested-by: Hervé <herve@dxcv.net>

Regards,
Hervé

