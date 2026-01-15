Return-Path: <linux-pci+bounces-44958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F1BD25231
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0546630B0968
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 14:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8C835505B;
	Thu, 15 Jan 2026 14:57:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A709354AEB;
	Thu, 15 Jan 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489023; cv=none; b=lpkVodZ5AYPD8ORgAFfQE0oolROFV2JFqCvKsoRTq30rrvhDUio/DK/wukg7D42KuBv2Cc3285PxzagCbJLDucBuqfn+hfStblPkK3wogTb5bmOmqOBnAp8UotcFyPZriTC1X3453VUgrjuvI6xVpobXLu0zJaRnBO8XcceedsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489023; c=relaxed/simple;
	bh=HhGNilRYIAdT8jacWXYqmrlVjzDY67htIE6hnT337O4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h376OlgzkJjOo8f5PLlSUSGbYjRe2UciCexqjUhDPvCl8t3lw/Xpgbk1Lo1jFJ9Dn8xmoqEeE/b45ZmUKB+t2l+4Qo8PgSjBwgV/pK3+SEL4mcQC95w2ddakdveCQqU4u0GVnNfEWg/z6Vo63uhN8fm3KUvwTwdyp1d5WNn8tO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsQzh2ZRgzHnGfT;
	Thu, 15 Jan 2026 22:56:32 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E06740086;
	Thu, 15 Jan 2026 22:56:54 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 14:56:53 +0000
Date: Thu, 15 Jan 2026 14:56:52 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 20/34] cxl/port: Move dport operations to a driver
 event
Message-ID: <20260115145652.00002355@huawei.com>
In-Reply-To: <20260114182055.46029-21-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-21-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 12:20:41 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> In preparation for adding more register setup to the cxl_port_add_dport()
> path (for RAS register mapping), move the dport creation event to a driver
> callback. This achieves 2 things it puts driver operations logically where
> they belong, in a driver, and it obviates the gymnastics of
> DECLARE_TESTABLE() which just makes a mess of grepping for CXL symbols.
> 
> In other words, a driver callback is less of an ongoing maintenance burden
> than this DECLARE_TESTABLE arrangement that does not scale and diminishes
> the grep-ability of the codebase.
> 
> cxl_port_add_dport() moves mostly unmodified from drivers/cxl/core/port.c.
> The only deliberate change is that it now assumes that the device_lock is
> held on entry and the driver is attached (just like cxl_port_probe()).
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>
Subject to carrying fixes from earlier review forwards in the code movement,
this looks fine to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

