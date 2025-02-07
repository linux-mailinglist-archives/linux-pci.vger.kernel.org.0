Return-Path: <linux-pci+bounces-20854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46195A2B82E
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 02:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B091675BA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 01:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2239855887;
	Fri,  7 Feb 2025 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MGA7AvWr"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27321130A7D;
	Fri,  7 Feb 2025 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738892454; cv=none; b=JZupK1+DMuNg5j/gvxiWqyNv4Qm5xiNOlAXdmWPLA/DGx103yaSZcZROoYsXO8WXzrCaQHtIo/HAPiZc5vddqlHeIB/Bv4F91VXlQ947NyARQ7bJBAmU0386m5SzG8XelUTGcEjnUvPFDBJBlcioLh42Y9obMMW7ml25ZHCobJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738892454; c=relaxed/simple;
	bh=Lhzd8eug+wRFyWvz16M7FQ+34flE/6/zpUTu2a6cnLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r10I3sG7yDprif0d395bLgcj3IdL0CQIcPzMntJmu1MYxOlrjYg2BblG1kz4Wl7TWy/VrqQJVQXhsAdtnyZtJaiQ7dW+p+HYTney2ouKv1zeLwMOdzwsV20LTj/kIt4KMvYeBCC6mieRsG5ZfjjtjSxESuxlKak6/qlcBmQwadE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MGA7AvWr; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738892442; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Lhzd8eug+wRFyWvz16M7FQ+34flE/6/zpUTu2a6cnLg=;
	b=MGA7AvWr2TN+mJjpOjOqWeatdLFroBXcDyKWkBnfG7qjQFROyCrlXGEo43MB+dDCcxm2MjynRoiawQH8mHh1TaJyhgA3i4pl4uIgGBNMynI1gNTYdrPxzAtPo+P9jiVogvHnQzVgOADlXF9eRiiATOXhL62DxyBu7QDAQxCs+58=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WOxcGXe_1738892440 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Feb 2025 09:40:41 +0800
Date: Fri, 7 Feb 2025 09:40:39 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	rafael.j.wysocki@intel.com
Subject: Re: [1/2] PCI/portdrv: Add necessary delay for disabling hotplug
 events
Message-ID: <Z6Vkl7TXZmhceOFn@U-2FWC9VHC-2323.local>
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
 <b6f97a22-4b24-4ca1-b9e9-38a4b0e69f04@web.de>
 <Z6Qho7k_zj7NcA37@U-2FWC9VHC-2323.local>
 <01a579e0-4a5d-4cdf-9ac4-7e6212279bd0@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01a579e0-4a5d-4cdf-9ac4-7e6212279bd0@web.de>

On Thu, Feb 06, 2025 at 12:40:44PM +0100, Markus Elfring wrote:
> > Could you be more specific? I got the mail addresses from get_maintainers.pl.
> Would you like to take another look at information also according to Jonathan Cameron
> (for example in your patch recipient list)?

I see, thanks!

- Feng

> Regards,
> Markus

