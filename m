Return-Path: <linux-pci+bounces-28104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C95ABD889
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 14:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A443BFB85
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 12:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010501A3177;
	Tue, 20 May 2025 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYTdicC7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185D233DB;
	Tue, 20 May 2025 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747745587; cv=none; b=bSuLjRzIuzCUPoU4ziSNHZqcQhZnTAS+TSET6dps3voPbQgl1FkHtL9LVGcBobz86XuDvcG0E8xaQcbxI3MlAs2TjBIBFYLRh4/Pn8r38hAFom5n7yCQtkCrWMEt5mt08YLFkhEWl+Us84rTbNxgMzQANRV6NZoa1jZxy3wM6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747745587; c=relaxed/simple;
	bh=3r22ZEQOOjXB0+9ybc9vgmjtZTSGn+/NcTHMqsIKPck=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cl6XuTDNjqW5BEe+jv9Slo19WdOic43Qbj4uBckNI+iBRiMOnwSsM/kSUZQtO8KXtZLhhseWnIO6oItF7oNj+V4t3ddOSgxmYLGo1pMuwa+kAqmTIr+yysnEHFMfnmf62t/nliYYLj9gmaBCN7E6UsKPxCcPOSd0a6bPdJ2wTcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYTdicC7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747745586; x=1779281586;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3r22ZEQOOjXB0+9ybc9vgmjtZTSGn+/NcTHMqsIKPck=;
  b=IYTdicC71KKE5AfU1+v/uB+5NtaLXbw9cPpX8VCbRXAawqq/rOlnz1QR
   wVsJEG+PNb9UZvWXgJ72YJCTn9Cqz7HPskN5XOb4mX0e+6+CBps3SjlIE
   ekzwORC0fCX1yrJ2IaZqqrj863ttBQJFLCxf8RPOkOc4+tG2aNZAL/26X
   VjNNBFcvaEo1P0bol3zODOzcKu5ONuq6zKmcf6KaVvXbsVnevzNsF6a80
   t6Fn57opKUEK36FJRAN71DRQX1qh0oxiH5WIG8RzBc/8zsdQCJ5qBlmUS
   n/giZwQOT1AUJxUsIPekeNqv1yKZLrN0oQJdwiI5WDTqE0HS0htXUWn/J
   Q==;
X-CSE-ConnectionGUID: XjHTPXm2REKeifPF/Tjglw==
X-CSE-MsgGUID: Yb+cOiu/SjedzW0kw+jXTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="48931399"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="48931399"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 05:53:05 -0700
X-CSE-ConnectionGUID: edvBxWzKShKWC7SdmcY47Q==
X-CSE-MsgGUID: 1pB0PcqnT0qZ2dxEmn4NPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144540965"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 05:52:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 15:52:56 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Shuai Xue <xueshuai@linux.alibaba.com>, rostedt@goodmis.org, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
    helgaas@kernel.org, bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de, 
    mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com, 
    naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com, 
    mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
In-Reply-To: <aCxxA-4HEnZ-O2W0@wunner.de>
Message-ID: <9b46a12b-90e2-c1ba-9394-5caa23a5cad7@linux.intel.com>
References: <20250512013839.45960-1-xueshuai@linux.alibaba.com> <87b1f8c6-bd72-b1a8-40a6-bbf552552806@linux.intel.com> <650cd4e4-561b-4d50-9cf2-c601518c9b9f@linux.alibaba.com> <31693574-e8bc-9a56-bad0-6a22280c4b6b@linux.intel.com> <aCxdFm_BpgOTFFUv@wunner.de>
 <aCxxA-4HEnZ-O2W0@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 20 May 2025, Lukas Wunner wrote:

> On Tue, May 20, 2025 at 12:44:38PM +0200, Lukas Wunner wrote:
> > Link speed changes and device plug/unplug events are orthogonal,
> > I don't think they should be mixed together in the same event.
> > 
> > A link speed event can be signaled simultaneously to a plug event
> > and then user space can decide in which type of event it's
> > interested in.
> > 
> > That also avoids the awkwardness of having N/A values for the
> > link speed on unplug.
> 
> After thinking about this some more:
> 
> A link speed event could contain a "reason" field
> which indicates why the link speed changed,
> e.g. "hotplug", "autonomous", "thermal", "retrain", etc.
> 
> In other words, instead of mixing the infomation for hotplug
> and link speed events together in one event, a separate link
> speed event could point to hotplug as one possible reason for
> the new speed.

It will be somewhat challenging to link LBMS into what caused it, 
especially in cases where there is more than one LBMS following a single 
Link Retraining.

Do you have opinion on should the event be only recorded from LBMS/LABS 
if the speed changed from the previous value? The speed should probably 
also be reported also for the first time (initial enumeration, hotplugging 
a new board).

-- 
 i.


