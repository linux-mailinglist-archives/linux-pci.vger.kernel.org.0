Return-Path: <linux-pci+bounces-17105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2529D3682
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 10:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC864B22BCB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0247118B46C;
	Wed, 20 Nov 2024 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTZO7Bom"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A606149C42
	for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093842; cv=none; b=FmILQKwbx1x7HuZRyvxR9X89qO90zCfQZtFnH4oIiSTUKQipaiq+1J6blW4XDC8pvSKgFNWjnM764QRqDHW2W50Kf+LbL6F2CBgFhw/R+nPYvp/YDYBpUt2WOhjvSM9RD20t05wRNQSPjsKOTp7Mn/ZMU8pzpyAOzkmElZJEK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093842; c=relaxed/simple;
	bh=r9Df1jAEVYS5hiP31sy2xYWwseN5Znujgavube+EU7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFr3phd2PLpykK4hqcWUFwz+0ea5f5qfFyY9QNm/PY9C/H7tN+faj/p7wxLgou9DQ6kjPaoMEmRuZI+en6w0e35ru5jqhThVYqUOkE2XQTplZq86ir4ujEdNIQbxXY8cy8BpoPxKZO2ect5iZcLsCc94TTLko7tCawCtQdtwAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTZO7Bom; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732093841; x=1763629841;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r9Df1jAEVYS5hiP31sy2xYWwseN5Znujgavube+EU7I=;
  b=eTZO7Bom0eDhfbQa9b5W/vOQ0oIKbqERu7k8r+w5PQC82DDV6a90V9y3
   jwV//SJftRNEILKCkYW7SMjiuGgdfor+lp8EOshRrgWMkzqhKE7kr5EPJ
   pxCUFxmwiE0CN5tmllw3fihA2N3ZdtrPL8V0tvqRvDRjjaqpjOp74M6VN
   J8kF1ruLEz9G6pox1tkE0aDAlkFVBGZV44KFzVujR1FuXyk69EiofHgIl
   Psv/OKkFdI05T1j/Cj2HVMK8eOHefV1JQ9l6iI2w65LZbiOZGe4QFFLlF
   vRmFaG0d+3bWPK5a9RVtasxSwwyzKzIoRskpZ66+JH3ZDzMXQhrbDu1uf
   w==;
X-CSE-ConnectionGUID: vn7VvMI7SaC657z4tWOmSQ==
X-CSE-MsgGUID: DBK0nKOeSjWASSPz0s289g==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42772878"
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="42772878"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 01:10:28 -0800
X-CSE-ConnectionGUID: ixzrOddiR7C8Oi1iPFKalA==
X-CSE-MsgGUID: 8Xow2j1wSYe/d9tNqMqEDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="120703999"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.246.20.233])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 01:10:27 -0800
Date: Wed, 20 Nov 2024 10:10:21 +0100
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, Lukas
 Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, Nirmal Patel
 <nirmal.patel@linux.intel.com>
Subject: Re: [PATCH v2 0/8] VMD add second rootbus support
Message-ID: <20241120101021.00007003@linux.intel.com>
In-Reply-To: <20241115174855.GA2045200@bhelgaas>
References: <20241115092256.2525264-1-szymon.durawa@linux.intel.com>
	<20241115174855.GA2045200@bhelgaas>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 11:48:55 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> The "BUS0" nomenclature seems heavily embedded in the vmd driver but
> is really a misnomer.  Maybe that reflects similar terminology in an
> internal spec?  Any hard-wiring of bus numbers reflects a property of
> the way a *Root Port* works, so using the right name will make this
> easier to understand, especially since there are other Root Ports with
> the same hard wiring.

Hi Bjorn,

It is named as BUS_0 and BUS_1 because it refers to kernel's
pci_create_root_bus()`, we simplified it for better code wrapping.

Looks like it confuses you, do you like ROOT_BUS0 and ROOT_BUS1 better?

I don't see better fit than "root bus" because we are creating new root buses
accordingly.

Internally, it is called as "VMD domain" and each VMD Domain is presented as
separate pci root bus.

The original naming is presented in the sysfs links:
- "domain" -> root bus 0
= "domain1" -> root bus 1

i.e:
domain -> pci10000:e0/pci_bus/10000:e0
domain1 -> pci10000:e1/pci_bus/10000:e1

Thanks,
Mariusz

