Return-Path: <linux-pci+bounces-31170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE48CAEF97B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 14:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8D44E0C53
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 12:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20382741CF;
	Tue,  1 Jul 2025 12:59:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F112515199A;
	Tue,  1 Jul 2025 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374742; cv=none; b=KCeeXJTUENWFmbICa5O5uHYg6uL/ghvsBopThePPcGnssuDG7ZMv+Yk89C5FOUUNjRXXywQZ+i1MzpUNxRWtQnpCGS41LSQbfg7TVjy6+m4xg1g3t6+cn9PbS2sa6bq7kcUK45BwdTZ+U37Ova/6GsV6/IZzRq9FYiI0kgyirzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374742; c=relaxed/simple;
	bh=lhmN5pCn0NAigU26xzVSelUpTaIfuc6BOhdrCn4l+gE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYMgQZ3cypcOIvvc45SduZzArImKtggb9osi4LpbyXp9+1uIEQGmqg2BIKEsnn2w3ehNakVGIwNI7xkJSz0CzwM3H6MpW4vccIWcsnY1KG4GCxi3LoeuVWs2iB02GwOVrHVtZAjgTjLMBRwE0QGhBMSyj+CRlu9xr3qxET7f7uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWjkM1yBrz6M4rV;
	Tue,  1 Jul 2025 20:58:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 611131402F5;
	Tue,  1 Jul 2025 20:58:57 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Jul
 2025 14:58:56 +0200
Date: Tue, 1 Jul 2025 13:58:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave
 Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
	<bp@alien8.de>, <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
Subject: Re: [PATCH 2/3 v4] ACPI: extlog: Trace CPER PCI Express Error
 Section
Message-ID: <20250701135855.00004406@huawei.com>
In-Reply-To: <20250623145453.1046660-3-fabio.m.de.francesco@linux.intel.com>
References: <20250623145453.1046660-1-fabio.m.de.francesco@linux.intel.com>
	<20250623145453.1046660-3-fabio.m.de.francesco@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 23 Jun 2025 16:54:19 +0200
"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:

> I/O Machine Check Architecture events may signal failing PCIe components
> or links. The AER event contains details on what was happening on the wire
> when the error was signaled.
> 
> Trace the CPER PCIe Error section (UEFI v2.10, Appendix N.2.7) reported
> by the I/O MCA.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

