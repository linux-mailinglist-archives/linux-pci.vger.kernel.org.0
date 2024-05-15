Return-Path: <linux-pci+bounces-7512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E016C8C6AA5
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 18:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4BD1C218C4
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BF55660;
	Wed, 15 May 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YYsZjvsO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01D182D2
	for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790732; cv=none; b=VooTdXpw5PCvDr/9433Ljdh8vhh6OakEaxw5865nsjlt3x6tt1VSIOVFwiH6xtgW8lW1u5Eo0XW8OtuHC23YXsfhi09Gs4Hjj4NHUlECIgpVQO2DHDhzXzbGbuSJ6/D0EYxEqgRnaawQhgB6GMSKaqCJzkJkcxYetLSYf0Wk9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790732; c=relaxed/simple;
	bh=nui8g1oHbr2oB2DKqSyORL0IlshxXxbeuaYFRJIE1A4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LbmAxRjNT+GHgj24MoMbkuBWYGa7KR8pIyueN3wbN1QsS6oFCM0YSgPHHuYyRpBADdTrQ0hp+u+OuyHgBD/ZwdlVNpDL78cBfJb3B5EaSN5DSv56LkbS3SzNLi5R7vQyLRWB1eSeWQiXEt8w0Vlc0/fH07TKboKR0cN+64WuERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYsZjvsO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715790732; x=1747326732;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=nui8g1oHbr2oB2DKqSyORL0IlshxXxbeuaYFRJIE1A4=;
  b=YYsZjvsOAO6eKctke4WKgJDlRy0DVI1vJllDnZzkwY0d3ISv/2ifCaZ7
   +eG4I2bVGOFPmjKX6k/LdZtTtgkFzRY3oVDgBiYDZXD7N9IAJ8e6G705v
   5S2c26hUAD1REcBRY2sx7UE5Ag4WXCNtyc/gg4iN/B4B7XAoJ+vbwNuxa
   KZ/fggr+DI524cigZID0FuvXfYlfDHMc5nQntBgvhzCx9n3spbC0yz3T1
   arAwKle097n6JBP5tKpPJ8N6jHhV7fgzlfr6c9d8AJ3Q5NAeqy3IBJZEa
   Z6V6XNq/NfSpQTe0aPK93QnnzA8In/cQA/Ind5x7/XWSvjATSCUzAGEEg
   w==;
X-CSE-ConnectionGUID: WBLiyW6nSzysOEODaUnDHQ==
X-CSE-MsgGUID: dzYLHP3RTj+oUiXjpUD9PQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="29343785"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="29343785"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 09:32:10 -0700
X-CSE-ConnectionGUID: Ioa1riIsT/qlPchH8XaUXA==
X-CSE-MsgGUID: QDgzYScqRheigPyL62Ko0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="68572648"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.141])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 09:32:07 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: intel-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/8] drm/i915/pciids: PCI ID macro cleanups
In-Reply-To: <20240515154505.GA2123614@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240515154505.GA2123614@bhelgaas>
Date: Wed, 15 May 2024 19:32:03 +0300
Message-ID: <87zfsravek.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 15 May 2024, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Sorry, I had ignored this because I didn't think it affected any PCI
> stuff.  This is fine with me:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks, pushed to drm-intel-next.

> But since you asked :), I'll gripe again about the fact that this
> intel_early_ids[] list needs continual maintenance, which is not the
> way things are supposed to work.  Long thread about it here:
>
> https://lore.kernel.org/linux-pci/20201104120506.172447-1-tejaskumarx.surendrakumar.upadhyay@intel.com/t/#u

Right. I was under the impression we'd cease doing this for new
platforms, and see if we can get away with it. For example, we don't
have Meteorlake or Lunarlake there. Fingers crossed. But we probably
don't want to touch the old stuff.

Except now that I'm doing some non-functional refactoring to be able to
better reuse the macros for something else. There's a bit more coming,
please bear with me. :) I just tend to err on the side of getting the
acks than pushing away.

BR,
Jani.


-- 
Jani Nikula, Intel

