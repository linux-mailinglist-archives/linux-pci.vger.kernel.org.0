Return-Path: <linux-pci+bounces-11942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67089959A44
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 13:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997B11C21C89
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B69B1C6F7F;
	Wed, 21 Aug 2024 11:01:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DD81C6F63
	for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238115; cv=none; b=qHhyAlLI/coLvYm0LDnJJstfVfOOKxEEQF03e/gLUYLZM3CkXuSz8Ja6e6l4QDLB8csobvuYEVigUpzCgF2Z11kWImTQG2Ll5Gu+bVAfardzXiPIv8faHtR3+4DoCq6InzDRz3F2EZfvbzE6JSoHYc6q0bl4bmYMDTR2oBKYYIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238115; c=relaxed/simple;
	bh=Ma02xXJuqORflxWd6kQLwrvFLuCLNkSf6PIZiIehUdE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TK5VYtr33PJmMhjx9YYBVq9QWv6/2pYdXqeb/VEHWGVztePeX4UZYJsIVhITql8of3VXs5IP3WHm5e1ag45Ddy5JsZPWZHA+LdFoMW8a579WqC9R2UVHGsU7Mq98wTZmNB/A4f/110c+S5aX+wX53GfPhQTq0Ke1GS3FExFjMuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wpjwv37RYz687hk;
	Wed, 21 Aug 2024 18:58:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E0CBC140A36;
	Wed, 21 Aug 2024 19:01:45 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 12:01:45 +0100
Date: Wed, 21 Aug 2024 12:01:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Keith Busch <kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, <linux-pci@vger.kernel.org>,
	<bhelgaas@google.com>, <lukas@wunner.de>, <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH RFC 1/8] pci: make pci_stop_dev concurrent safe
Message-ID: <20240821120144.000035b3@Huawei.com>
In-Reply-To: <ZsSv_KuFfLiwBxZW@kbusch-mbp>
References: <20240722151936.1452299-1-kbusch@meta.com>
	<20240722151936.1452299-2-kbusch@meta.com>
	<20240815151717.00007e7c@Huawei.com>
	<ZsSv_KuFfLiwBxZW@kbusch-mbp>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 20 Aug 2024 09:02:20 -0600
Keith Busch <kbusch@kernel.org> wrote:

> On Thu, Aug 15, 2024 at 03:17:17PM +0100, Jonathan Cameron wrote:
> > On Mon, 22 Jul 2024 08:19:29 -0700
> > Keith Busch <kbusch@meta.com> wrote:
> >   
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > Use the atomic ADDED flag to safely ensure concurrent callers can't
> > > attempt to stop the device multiple times.  
> > 
> > Maybe mention what concurrent paths exist where this might happen.  
> 
> I think everyone calling this is holding the pci_rescan_remove_lock, so
> it shouldn't be possible today. This series aims to remove that lock
> though, so this is more of a prep patch for that. But also, the flag is
> already an atomic type, so using those properties makes sense on its own
> too.

Ok. Perhaps mention that it's cleanup / a prep patch rather than a fix.
The current text scared me a bit ;)

Jonathan



