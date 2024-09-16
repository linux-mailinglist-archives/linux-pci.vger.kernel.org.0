Return-Path: <linux-pci+bounces-13230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E35A4979E2A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 11:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F7AB21C7D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 09:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A1013DDDD;
	Mon, 16 Sep 2024 09:16:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2994C12F5B1;
	Mon, 16 Sep 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478165; cv=none; b=G23rQkqSkIGHGySqgeb82SFP4HYrmcXMJVW+fgdWDwo2ZYzPbs9i3MSNSjRB69uYuNCve7/s91fv4oVSs+Nchqs62rIGqly+76iLI2qg1LtBlgIynAVqQZI6ggcuDI+UICrMnIDgrkeLHa63ChuntyL9Y722SPUk8YqvqjhhCpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478165; c=relaxed/simple;
	bh=jtdwfYadaYYw0XauKl0wZWfekoNSA9U3l0za1HkbZJw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWhhsuv4752GOGIR0ubBYLCMaLhPfsdkn532q/N5yVpuYicWBERsp/7kv5oi+YODzGNqbuE18pVDxKRS3NSzoEZxOUnML9AgxPxePjFl+48/bVhi4IWTGWU8UNFdRIxuUxBsxewGvckUE2nxJfgPKpjDCexuLllm6HioY4h8wAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6fQz3psDz6K5X3;
	Mon, 16 Sep 2024 17:15:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 24E56140158;
	Mon, 16 Sep 2024 17:15:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Sep
 2024 11:15:58 +0200
Date: Mon, 16 Sep 2024 10:15:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Gregory Price <gourry@gourry.net>, <linux-pci@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bhelgaas@google.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH] pci/doe: add a 1 second retry window to pci_doe
Message-ID: <20240916101557.00007b3a@Huawei.com>
In-Reply-To: <66e51febbab99_ae212949d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240913183241.17320-1-gourry@gourry.net>
	<66e51febbab99_ae212949d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Sep 2024 22:32:28 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> [ add linux-pci and Lukas ]
> 
> Gregory Price wrote:
> > Depending on the device, sometimes firmware clears the busy flag
> > later than expected.  This can cause the device to appear busy when
> > calling multiple commands in quick sucession. Add a 1 second retry
> > window to all doe commands that end with -EBUSY.  
> 
> I would have expected this to be handled as part of finishing off
> pci_doe_recv_resp() not retrying on a new submission.
> 
> It also occurs to me that instead of warning "another entity is sending conflicting
> requests" message, the doe core should just ensure that it is the only
> agent using the mailbox. Something like hold the PCI config lock over
> DOE transactions. Then it will remove ambiguity of "conflicting agent"
> vs "device is slow to clear BUSY".
> 

I believe we put that dance in to not fail too horribly
if a firmware was messing with the DOE behind our backs rather than
another OS level actor was messing with it.

We wouldn't expect firmware to be using a DOE that Linux wants, but
the problem is the discovery protocol which the firmware might run
to find the DOE it does want to use.

My memory might be wrong though as this was a while back.

Jonathan

