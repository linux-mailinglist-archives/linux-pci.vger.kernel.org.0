Return-Path: <linux-pci+bounces-36856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25630B9A139
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 15:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F9A3BD89F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 13:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F36D2DFF33;
	Wed, 24 Sep 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOCZ9S3v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C66A2DC773;
	Wed, 24 Sep 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721365; cv=none; b=ZW50Kakoas+AUtBPXVp6Y8VtsvDAAPrsY4ShGvXZFIHvuGGqfAjtVuRr0Y1u6l8SmNZVkJMXknEi+SIKgxFlX8c7RbdaTnQ9PK9pvU4XMXuNqUHOcWrMy8s3nTjPmqNXP5IyMxDTMPz6ERkieAM1oFByZkLRn6RaRFT6UQu4gso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721365; c=relaxed/simple;
	bh=aU7Kj8q3T+N/ckXraKVvG5QL1OzZvkmuPh+eYeaDr54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BRATYij96fDUAootFVnybLqbkG1fyOgrxMIYu8IKU5wg7Bj9Jv+UkG54MxCozJ+X3LXJjb8B4smzyKwwvnzBt69JjiFnEYgT0UcJWv02M5zzV9cRtbMgtUV4O6qWOxUK9K7f/QB8cuwd2h3mb4G+ISBlixikqSgxoT2nqC5BEQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOCZ9S3v; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758721363; x=1790257363;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aU7Kj8q3T+N/ckXraKVvG5QL1OzZvkmuPh+eYeaDr54=;
  b=mOCZ9S3vL0DUL8VA3gNLXypsRNjmc0kvfFL7kyzTbw9x+XhIHNvrjRBD
   +F6ip5vRvThT28s7BRJ89FxXMjzejYXZdugXvdbz3KZf0XZW0YMzimXAc
   fGUDCIvLQBV6DkOqpby10qt8nFMDh+N1UI6NVkOQSvaPofHfIEzO1Fe+j
   cqPdBItJH9neYd2MMvqpiGgPSn0rUc/gKtZZpo4bNGm52s46MhwrSWGIH
   Rqh7Z9Z6fMR1bR2//GxxmIdkvZ6lzdCfxzvexLBC36m8gJXkPxklt/TfW
   /S3WI3RVbLK9yCQdDT6NM9uNe9yNfbQz2ANzlXrvEJHCvqyZHkoYZaVRc
   w==;
X-CSE-ConnectionGUID: +xIzV2TvSCmUrkzhFHJZhg==
X-CSE-MsgGUID: zt3xZiqAS1G7IgQAHoqzAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="64854827"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="64854827"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 06:42:42 -0700
X-CSE-ConnectionGUID: 0CdW5AbFTfCwamvE7IM0qg==
X-CSE-MsgGUID: +cpdcj8pS/2WgeDisYwZ5Q==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.210])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 06:42:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/2] PCI: Fix bogus resource overlaps
Date: Wed, 24 Sep 2025 16:42:26 +0300
Message-Id: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

I noticed a few bogus resource overlaps in logs which occurred for PNP
resource addresses that collided with large zero-based resources
(typically IOV resources). It turns out, the problem boils down to not
marking resources properly with IORESOURCE_UNSET when BAR is read into
the struct resource.

I've long wanted to mark resource not within their window with
IORESOURCE_UNSET as done in patch 2, however, my first attempt to do it
failed because the bridge window resources were not yet available. I
assumed the bridge window change would require more extensive changes
and postponed it, but it turns there were no big complications from it
(at least so far).

But things may be more complicated than I know so if you think there's
a good reason why the filling of bridge resources is delayed to the
second read, please speak up!

There are extra notes in both patches under --- line, please check
them as well.

This series does not removed the second read of the bridge resources,
it's probably unnecessary work now but confirming that requires more
testing and code reading than I currently have time for so just sending
the obvious fix series out (and adding a TODO entry for myself for
later).

Ilpo Järvinen (2):
  PCI: Setup bridge resources earlier
  PCI: Resources outside their window must set IORESOURCE_UNSET

 drivers/pci/probe.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.39.5


