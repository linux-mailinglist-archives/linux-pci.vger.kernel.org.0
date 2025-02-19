Return-Path: <linux-pci+bounces-21781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1AAA3AF84
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 03:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD42418863DA
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 02:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63D513D891;
	Wed, 19 Feb 2025 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ubN6Iskt"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249CF35953;
	Wed, 19 Feb 2025 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931597; cv=none; b=dAv62xyBan0Xtq0X4dpFSYOTSGj8Z2P2e64N7QncGY2za/F+eudfFqviJeCMd5GsEKEf8wGGi0l8qpIieysx6VGU5GOCsU2em+wIFBnfv9mT0h9Fw3HNJvCZa6IN+elakufL3f+zbav0kx7D/q85D3DJDa1ShMdkPiEh9F/Ko3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931597; c=relaxed/simple;
	bh=XCO7aG0qdH8I+G0ipRw03stO6RiIv2I3oVc7k1eZLdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoJg+UkgTJ1j7ieOXulevVlNSEEzrEjs5+G2oputMo2DRccMlLXNV+iNZ2B4O0Lvbbw0FrCrsNn3MHWXzcL/f5QQAm29//jLf0nuMLpYRiBtQ+3qmFCgrFE1sQUqX+SVBWMMQCtBiAzOyycUGry6vTdvFxgWWEbE+znxujkwPfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ubN6Iskt; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739931590; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=kNmeRWaY/Gzx67QUsazLWRkGga4wXBt2+ae+XANxPFs=;
	b=ubN6IsktplmGv6rxvIF4EBaNeE10OWih16NkuhfArgiudBVGAXZF5weDmizf3shEdkE97nXjCktP7TtG8iobDaA98M10iuCn6SM3o0iPprd1CoxLi8SyqbJ4FzoYFOEJ0X0oJG/njjUtV692kdWwh2ujc0Ingy3DyidVNkOVC3o=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WPnQaEn_1739931588 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Feb 2025 10:19:49 +0800
Date: Wed, 19 Feb 2025 10:19:48 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/2] PCI/portdrv: Add necessary wait for disabling
 hotplug events
Message-ID: <Z7U_xNsQ04_tcTgB@U-2FWC9VHC-2323.local>
References: <20250218034859.40397-1-feng.tang@linux.alibaba.com>
 <a7ebd733-3fdd-4163-8fd4-9f70ee40c6be@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7ebd733-3fdd-4163-8fd4-9f70ee40c6be@web.de>

Hi Markus,

On Tue, Feb 18, 2025 at 10:00:33AM +0100, Markus Elfring wrote:
> > There was problem reported by firmware developers that they received
> > 2 pcie link control commands in very short intervals on an ARM server,
> > which doesn't comply with pcie spec, and broke their state machine and
> > work flow. According to PCIe 6.1 spec, section 6.7.3.2, software needs
> 
> Would you like to use key words in consistent ways also in such a change description?

Will do. thanks

> 
> > to wait at least 1 second for the command-complete event, before
> > resending the cmd or …
> 
>                 command?

Yes.

> …
> > ---
> > Changlog:
> >
> >   since v1:
> …
> 
> Are cover letters generally desirable for patch series?

The 2 patches solve different issue, and not logically relevant. But
I'll try in next version.

Thanks,
Feng

> Regards,
> Markus

