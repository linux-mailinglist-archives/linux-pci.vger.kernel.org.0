Return-Path: <linux-pci+bounces-1545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CACD081FEC3
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 10:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123561C2225D
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 09:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C627210A18;
	Fri, 29 Dec 2023 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="EgbTzA5G"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4552010A01;
	Fri, 29 Dec 2023 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1703843173; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XKYrmvLuzmk/r08tvchrXv5qgEXmbsTjVRFcDnTVF+VvTVhfs5dIBb9e9uOlUZ30BfUQy+6UqUdJhwQM/WRUqROBflrZCcE1U3DzKGWNuSwuGJD/zQBWbRNvlEBXdE/u9aSpLg+mTJ7qdjHFyr8L8+mh1iyjqVG7yD0wwOkiLA8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1703843173; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=K7r5sOmsaLOjWS98lIO6mw48w74TdCOUpMHvWTK+zR8=; 
	b=mGnB4hjHctrZsrMyTkUnzLEBqgUS7g/WuXmPND8o9/5JvPncqUQ8HF5NhW722I/omznSqAPtIrZgjBWTPk9GUXxu5p9ag0tZRpneps5ksrkmXaUx7T8f9jXn1hsvFVHM73bt/dPq7eoW1di5v4My4TbXI4Poz5t1A3WiHMTfHO4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1703843173;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=K7r5sOmsaLOjWS98lIO6mw48w74TdCOUpMHvWTK+zR8=;
	b=EgbTzA5GwIo/K8TixJCJX5e0iNwIrOPXHDTfU+Q0A3o/Bct4YhfWgvBnPHi9XoZX
	p9YdMkr8h5fwEtnPlwrFwrL30wJu9x+dU803K/2jMpRlB7omuJWdUrqoJ92S06hRxNR
	X+URABNIXz1YFswM9Yi3QjZYz+z3tfYq8AmE4EnA=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1703843171327603.2461899337034; Fri, 29 Dec 2023 01:46:11 -0800 (PST)
Date: Fri, 29 Dec 2023 04:46:11 -0500
From: Li Chen <me@linux.beauty>
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: "Tom Joseph" <tjoseph@cadence.com>,
	"Parshuram Thombare" <pthombar@cadence.com>,
	"Pawel Laszczak" <pawell@cadence.com>,
	=?UTF-8?Q?=22Przemys=C5=82aw_Gaj=22?= <pgaj@cadence.com>,
	"Nadeem Athani" <nadeem@cadence.com>,
	"Siddharth Vadapalli" <s-vadapalli@ti.com>,
	"Kishon Vijay Abraham I" <kishon@ti.com>,
	=?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kwilczynski@kernel.org>,
	"Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
	"linux-pci" <linux-pci@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <18cb4f78be7.118217ede232604.6825928402358580565@linux.beauty>
In-Reply-To: <20231228134132.GA1486379@bhelgaas>
References: <20231228134132.GA1486379@bhelgaas>
Subject: Re: Is Cadence PCIe IP orphaned?
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Bjorn,

 ---- On Thu, 28 Dec 2023 08:41:32 -0500  Bjorn Helgaas  wrote --- 
 > Tom Joseph tjoseph@cadence.com> is listed as the maintainer of the
 > Cadence PCIe IP, but email to that address bounces and lore has no
 > correspondence from Tom in the past two years
 > (https://lore.kernel.org/all/?q=f%3Atjoseph).
 > 
 > Does anybody want to step up to maintain this?  Should we apply a
 > patch like the one below?

AFAIK, Cadence people are preparing to upstream their Gen5 controller and PHY drivers. They may update the maintainers when they do so.

Regards,
Li


