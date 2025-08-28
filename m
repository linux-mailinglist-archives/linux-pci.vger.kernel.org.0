Return-Path: <linux-pci+bounces-34991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58938B39B76
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 13:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E717B5DDD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5131D30DEAB;
	Thu, 28 Aug 2025 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="ppUKXa/S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A02C2345
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380309; cv=none; b=KqPDCk+2tyqeQtO8o71GHHEFionqxGCBDS7ZAQTE0xb13Vl7Fwv7b/1AGw9llaxeMypJLHk/cgEAyyyzuEzpl3WQPPBOnf9xPwxxTce1CubVVj/EJXJQl36MJqnD7C1gdLWiMREMK2Z86fl0KSO6FM0DC9vWSwImK6gN6+Qw2Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380309; c=relaxed/simple;
	bh=gAeJYPiWvvW/0IyRkIBxLQARRkyu4B4Y9YGUAn6QIxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S9HCxlA+o2OQ9MTODpzaE2YwFnb/2okQtXpIwB2OoptmlCH+IYiIiveHPnSiMv8PEcINseNQV11NSL/c0wT1jBL5kx+VjKGghM4qPhC+P6/9vhn8S9KMq+a1SoWRU9FyJxkDmUdRq/2XdRukN0ZbY9m0Jwh2AmHoI1ILvwGMqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b=ppUKXa/S; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025082811245751f1879fc000020752
        for <linux-pci@vger.kernel.org>;
        Thu, 28 Aug 2025 13:24:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gAeJYPiWvvW/0IyRkIBxLQARRkyu4B4Y9YGUAn6QIxg=;
 b=ppUKXa/SF25VHu0ObymsZkYC4YZ2jSnCePYE5s6U+rMfKnDLC/YmU0oyNMgEjnmnT+EFvm
 aCqIHHmfIbxEyZqMamA1nVx7Pc0PaSQmO+/9eXxjR8WkNbsyeAKvxFWXKahghSXQGpL6lH1F
 DUGQx6hvEl3TXnBrOm+Y5NcvyAdE1PWTkM8ibq+JL2GRJrJwbINYH2fCSkWDX1UjqDu2IwA0
 IeURwhammbS8kR9Zq2xaBEohFhVgfcQdivDLS+xNUo7wbiFn/z0uD5lEafZ/R/zWwPmvrC/n
 mPxk7yqSx2nGy1bmyp7LIzONckMdbUy7qfiNaBXUZaFFqXXnXN0inu/g==;
From: huaqian.li@siemens.com
To: mani@kernel.org,
	arnd@arndb.de
Cc: baocheng.su@siemens.com,
	bhelgaas@google.com,
	christophe.jaillet@wanadoo.fr,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	diogo.ivo@siemens.com,
	helgaas@kernel.org,
	huaqian.li@siemens.com,
	jan.kiszka@siemens.com,
	kristo@kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lkp@intel.com,
	lpieralisi@kernel.org,
	nm@ti.com,
	oe-kbuild-all@lists.linux.dev,
	robh@kernel.org,
	s-vadapalli@ti.com,
	ssantosh@kernel.org,
	vigneshr@ti.com
Subject: Re: [PATCH v12 0/7] soc: ti: Add and use PVU on K3-AM65 for DMA
Date: Thu, 28 Aug 2025 19:24:34 +0800
Message-Id: <20250828112434.2310936-1-huaqian.li@siemens.com>
In-Reply-To: <yhbjfg7dqx3xud75rhwlhq7ayqa4d6wrsan2j7ki7ri3uynpeu@hdv2o33x4hdn>
References: <yhbjfg7dqx3xud75rhwlhq7ayqa4d6wrsan2j7ki7ri3uynpeu@hdv2o33x4hdn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer

Hi Mani,

Thanks for your offer to help with the patch series. Yes, let's proceed
with splitting the submission:

Please go ahead and take the dt-bindings through the PCI tree. That would
be helpful to get them established early.

Hi Arnd,

Could you please take care of the driver code with the cross-dependencies
through the arm-soc tree? The PCI controller driver has the API dependency
with the SoC driver as Mani pointed out. Could you let me know which specific
components of the series you would be willing to take?

Best Regards,
Li Hua Qian


