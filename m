Return-Path: <linux-pci+bounces-6760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0488B551E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 12:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC64EB20987
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 10:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD882D05D;
	Mon, 29 Apr 2024 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwORV+FM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8828398;
	Mon, 29 Apr 2024 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386179; cv=none; b=cDYd0rDxYdHgC7BOqxyNoR7/qqm/iPAYk1t6gaCgViB/ew6tn6yzZyhOLLW1coHIWgLL0QpJLbR/T8ZYf4O4m46C9b3NaUPoIXyg5iJptbfQuDw6/TcIushvMQh0YeGnhTmlmoLu9aKEoWNyd0ebWx/qkIz9UxQVP+xqItK90Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386179; c=relaxed/simple;
	bh=gq2L+qagD+ctbJ1g03h2JM87K7EUppTIEWwY830mVMo=;
	h=From:Date:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=FszKUFPrartoiCyPmWqPI2UUulFYJmDTFCSUpQYQ5Vh20p7rEFGD4jO2VOVJkPBUw1Bh+16DkX35USO0eeJP0wCo5tMMSMMjp5okLu4K2Wk8+F6GZrLk+ckcwqIfp1QV46XNWJsxSNWmAqRAsUSFB/MOcfs3az7RaWuVMukPnzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwORV+FM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714386178; x=1745922178;
  h=from:date:to:cc:subject:message-id:mime-version;
  bh=gq2L+qagD+ctbJ1g03h2JM87K7EUppTIEWwY830mVMo=;
  b=JwORV+FM8nckhGKRrp9F0wmfiZsYoZVO+MG85KEN4wWvg2OSwkmGda3I
   3Pt6358NSovhgMvwXjMuzvZ86HRNiJgy+jukRSSqpsUSzyQuwJgZTpYVi
   zoN7x43Irqpwp/qLxzPLmpR/V97q3Yzl2lLD/WYeUpOn4cV8W7kz1Z7nb
   bDUPyXLAMaoS6cK8aZTIgpcjjCfbSEob3HqU6jrRkalY7cnnsaw/YN+p4
   CUe8dUKo9Uv3c52CI+Ux/Nfyxl/ScNv61VGdF8KOEHVinpzb10rwwRZn0
   NKuI0GvCL9ARLTKPIL5K5+SbRDBQgbZAJeQQwlcmCqn9Ub7hnyhQ95rAn
   A==;
X-CSE-ConnectionGUID: YaSJdj7CRZ2KB+kQtG79Yg==
X-CSE-MsgGUID: 8MNCFNhRR6iocIHVZ9vt5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="13827729"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="13827729"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:22:56 -0700
X-CSE-ConnectionGUID: lnQIrUnfT9GJEjU2pXHkRw==
X-CSE-MsgGUID: IrMbYg+TRdeC7MOd8b+6RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26474871"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:22:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Apr 2024 13:22:50 +0300 (EEST)
To: Ryder Lee <ryder.lee@mediatek.com>, 
    Jianjun Wang <jianjun.wang@mediatek.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org
cc: LKML <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org
Subject: pcie-mediatek slot calculation correct?
Message-ID: <9ea20705-8536-738b-4f1f-60feb2c092fa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi all,

I was doing Conf Type 0/1 helper generalization when I ran into this code 
in drivers/pci/controller/pcie-mediatek.c:

	u32 func = PCI_FUNC(port->slot);
	u32 slot = PCI_SLOT(port->slot << 3);

With that code, function is effectively duplicated into slot, is this 
correct behavior?

...Adjustments made in the history of this code fragment didn't exactly 
inspire confidence on the correctness of this code. :-/


-- 
 i.


