Return-Path: <linux-pci+bounces-20730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A7DA285D2
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 09:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F9316515F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 08:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535F22A4CA;
	Wed,  5 Feb 2025 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBM0I/rl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8C922A4C6;
	Wed,  5 Feb 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738745080; cv=none; b=C7WNQ46VvX4jXODeNfsFDEIMI4D2QSTUwd7VjP/Wdpqu8Y1YbyzcV9z8VH6V7K2T39z+odmX0hdFhOmkUV0fb2Lk/bsrh0nqhuvf3dcFV/o3NgQ3TtN1PY0vBlsKBjXqS6EduST1Tj4A4r8T6Rbat1kAGmqPe+wptD/5ZnO9uG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738745080; c=relaxed/simple;
	bh=TDI1x3pPPXADltJ6RYlbixxnTojq86IDBEnZD6rWzk4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kOCqMvy7HrlOkKmwR7bOk0kDFz1Ak5pgpocaIsMzfwCHzvwifjpWasN7X0VkwiPL3KgHOq5jE24lHbD+DacqBcw8u5av25gkU14wLj3K9JPGBLlW9TNothfO4r1NB3/Y88FrMR1jzDDhIwULx/yRwxXhFTQb+cJhAFiSMry/ZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBM0I/rl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738745080; x=1770281080;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TDI1x3pPPXADltJ6RYlbixxnTojq86IDBEnZD6rWzk4=;
  b=GBM0I/rlqvdFSYAuS1WCBxgVlKJZsTfR1wLW3/E59myapsr01p+oyt+h
   3+t4dw8RNLJBH5glvHbnHK8R43jU7Zsw2ZKZ/a52KPWcdiE2NR9UewpoX
   vofA5LS6pNxs2WjIPmF0kTyAkJVrQ3BaVdzwjDZZ3ZtrscpJKhrvaVIcG
   b7+9Au2vbrsSB/AHKQMu4uIEJBm3WMtu9SaxOkKVWxl2IvxQ2dQc3LkLL
   IO0/eJ+UmkJ7vgR7jYxpIR250YnF6Lr3cJDJnK4fylMepoeUOXpWqx5OG
   MBILb1vwxocRxuIvHzxPU2FcwmSKRBKbNRvWo9Q+pa55jQqKTmtSDws2C
   Q==;
X-CSE-ConnectionGUID: YAgS2tQUS8aciXjmMUxcmw==
X-CSE-MsgGUID: pXVqIrbNQCuF2GsFDMmwlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50291164"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="50291164"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 00:44:39 -0800
X-CSE-ConnectionGUID: p2+Imi2eRdyiwjOQsJsGLQ==
X-CSE-MsgGUID: XrWhEZReRxuR6iSdF5Wd6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="115809554"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.255])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 00:44:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 5 Feb 2025 10:44:31 +0200 (EET)
To: Paul Menzel <pmenzel@molgen.mpg.de>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    linux-pm@vger.kernel.org, regressions@lists.linux.dev, 
    Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
Subject: Re: Linux warns `rtsx_pci 0000:3b:00.0: PM: dpm_run_callback():
 pci_pm_resume returns -110`
In-Reply-To: <d7246feb-4f3f-4d0c-bb64-89566b170671@molgen.mpg.de>
Message-ID: <027efc9e-bc70-49af-7d48-fb474533993d@linux.intel.com>
References: <d7246feb-4f3f-4d0c-bb64-89566b170671@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Feb 2025, Paul Menzel wrote:

> #regzbot introduced: b46c89c08f41..aa22f4da2a46
> 
> Dear Linux folks,
> 
> 
> On the Intel Kaby Lake laptop Dell XPS 13 9360, at least Linux
> 6.13.0-07632-gaa22f4da2a46 logs the new warnings:
> 
>     rtsx_pci 0000:3b:00.0: Unable to change power state from D0 to D3hot,
> device inaccessible
>     rtsx_pci 0000:3b:00.0: PM: dpm_run_callback(): pci_pm_resume returns -110
>     rtsx_pci 0000:3b:00.0: PM: failed to resume async: error -110
> 
> These were not present up to including Linux 6.13.0-07078-gb46c89c08f41.
> 
> It looks like the first warning is not always logged:
> 
>     $ sudo dmesg | grep rtsx
>     [    8.612537] rtsx_pci 0000:3b:00.0: enabling device (0000 -> 0002)
>     [ 2010.081170] rtsx_pci 0000:3b:00.0: Unable to change power state from D0
> to D3hot, device inaccessible
>     [ 2010.236503] rtsx_pci 0000:3b:00.0: PM: dpm_run_callback():
> pci_pm_resume returns -110
>     [ 2010.236525] rtsx_pci 0000:3b:00.0: PM: failed to resume async: error
> -110
>     [ 4115.541202] rtsx_pci 0000:3b:00.0: PM: dpm_run_callback():
> pci_pm_resume returns -110
>     [ 4115.541216] rtsx_pci 0000:3b:00.0: PM: failed to resume async: error
> -110
> 
> Logs from Linux 6.14-rc1 are attached. Bisection is only possible after next
> Sunday.

Please try if this fix helps:

https://lore.kernel.org/linux-pci/20250131152913.2507-1-ilpo.jarvinen@linux.intel.com/

-- 
 i.


