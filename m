Return-Path: <linux-pci+bounces-30490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEE2AE62DE
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 12:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E6E16B2A0
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 10:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4379C28136F;
	Tue, 24 Jun 2025 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3PYrtoQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764D01ADFFB;
	Tue, 24 Jun 2025 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762222; cv=none; b=L0gYBff9C0VQKmsZmhnC9G9Uj0/w4CU9feZqQuLtfvnjs+aVjV8/qpUb84z+SXgL4k9w6boGsoT1sLrGdJXhcmfcIVhxISAsm8P2S73gItu2u+b7SQ4FkL1hDMlKuvu9mYFFi0s9ajKTLokoGTfkxVdSfQX8Am49SMR+Fb3WjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762222; c=relaxed/simple;
	bh=dv6ZN9qLcc39VhlOnYfqWOhVKBnveT9waBSLrEElVx8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jhHcRCo9rjmB7DPFFAyThl62KZsWu/EGwzH/d3bvKI2WWRBww8O22cmZhCiXvmVDhUdFhdQ8nmPv8OZwzCicaAtH1+0I365kEMBU4Yca8IyO9jfcwFwToRzalVpuJFxdBcG1qMlsTJ6X7/i8WQnFmUGiyOUGje75oJtSt/ZZ4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3PYrtoQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750762221; x=1782298221;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dv6ZN9qLcc39VhlOnYfqWOhVKBnveT9waBSLrEElVx8=;
  b=M3PYrtoQw2Q3Y3UpwxgLkOzNE/Pjfq9u58YN1eAI7RiDopKcDwpi20QB
   38c05Ed24Ga7dy5ZB/Tpdme5mZtaY9lVKWIY0W1qVdVhUBihJcC0jbwEK
   ZeOObmQUEfkX43vhzzUahpFRV3MSS0if8cSZsIKJtysKo377fv+O5gTnV
   Fi7ygrHsa0x1n2D7SC6lO2iELof1+SWNvUlB5pQgF/7xjjOIV2FU077MP
   JSL43Egovs8nGCn3NIUX8copsPG+Z7rRa3Ias5UMd/oP0G/lSl+yzwRRv
   V6ccFChkCPzBY4DIh2TEZ1zlhLkVMXTemytHFr9xtTL8GMApz5kRtGyFY
   Q==;
X-CSE-ConnectionGUID: rlsl62z2SW+JqbDoPDCKUA==
X-CSE-MsgGUID: XJIXwVxtRy6NaxJ+Y1hZmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="64352256"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="64352256"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 03:50:20 -0700
X-CSE-ConnectionGUID: P3jobHMUQAe9pUeBJdc30Q==
X-CSE-MsgGUID: JnGhA3LFT8aHV12Y11RQCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="151306478"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.16])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 03:50:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Jun 2025 13:50:06 +0300 (EEST)
To: Jacky Chou <jacky_chou@aspeedtech.com>
cc: "bhelgaas@google.com" <bhelgaas@google.com>, 
    "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
    "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
    "mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
    "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
    "conor+dt@kernel.org" <conor+dt@kernel.org>, 
    "joel@jms.id.au" <joel@jms.id.au>, 
    "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, 
    "vkoul@kernel.org" <vkoul@kernel.org>, 
    "kishon@kernel.org" <kishon@kernel.org>, 
    "linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
    "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
    "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
    "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
    "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, 
    "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
    "elbadrym@google.com" <elbadrym@google.com>, 
    "romlem@google.com" <romlem@google.com>, 
    "anhphan@google.com" <anhphan@google.com>, 
    "wak@google.com" <wak@google.com>, 
    "yuxiaozhang@google.com" <yuxiaozhang@google.com>, 
    BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH 7/7] pci: aspeed: Add ASPEED PCIe host controller
 driver
In-Reply-To: <SEYPR06MB5134973F678EB5B163DD50809D79A@SEYPR06MB5134.apcprd06.prod.outlook.com>
Message-ID: <a618588d-54fe-69a9-27f7-7b19ba905a52@linux.intel.com>
References: <20250613033001.3153637-1-jacky_chou@aspeedtech.com> <20250613033001.3153637-8-jacky_chou@aspeedtech.com> <40d1c5bd-0457-55ea-2514-ba27e6a4c720@linux.intel.com> <SEYPR06MB5134973F678EB5B163DD50809D79A@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 23 Jun 2025, Jacky Chou wrote:

> > > +static bool aspeed_ast2700_get_link(struct aspeed_pcie *pcie) {
> > > +	u32 reg;
> > > +	bool link;
> > > +
> > > +	regmap_read(pcie->pciephy, PEHR_MISC_300, &reg);
> > > +	if (reg & CAPABILITY_GEN2) {
> > > +		regmap_read(pcie->pciephy, PEHR_MISC_344, &reg);
> > > +		link = !!(reg & LINK_STATUS_GEN2);
> > > +	} else {
> > > +		regmap_read(pcie->pciephy, PEHR_MISC_358, &reg);
> > > +		link = !!(reg & LINK_STATUS_GEN4);
> > 
> > While I don't entirely know the meaning of these bits, what if the link is not
> > using maximum speed it is capable of, does this check misbehave?
> > 
> 
> In our AST2700, there are gen4 RC and gen2 RC.
> Therefore, here will get capability to confirm it is gen2 or gen4.
> And the link status is in different register.

Okay, but then I'm a bit worried the naming of the defines as "Link 
Status" has a well-known meaning in PCIe Spec so it is confusing to call 
something else LINK_STATUS_*. Does that name come from some AST spec? In 
not, change the define naming. If yes, you should prefix it with so it is 
clear this is not referring to a generic PCIe thing and I suggest also 
adding a comment above those defines too so anyone looking them later 
won't wonder if you're just duplicating something from the PCIe spec.

-- 
 i.


