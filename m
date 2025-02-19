Return-Path: <linux-pci+bounces-21805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689F6A3BC7D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 12:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6515C3B7EFF
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 11:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325371DED44;
	Wed, 19 Feb 2025 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jARdlX5C"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B51DE89A;
	Wed, 19 Feb 2025 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963584; cv=none; b=RKgHnRjhdyl4tfRLA7df7uXKDI4aQtAigEA4URAcscsbnTKtDj5dGc7sdn3wsZHvfBzCD4OS2QJ5Ys7evDvcmVG3knkGkpcWfIo4VccUb8iggONyB96DyA6J1L10gek9hxs7dJrq3pal6E86VcFvBq7zA5JR1sRnQGH4pKM3ThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963584; c=relaxed/simple;
	bh=eq0bO5AiKScgWknT2M0jtFi8rEe2UnYq/oIVfB8MlEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJ5pH8vEr1yny1TXVWa7fqoJ7bxBTHRGwXPRqHQ4eOGDFr/7upQ2Zg60IIKY/PkxxPlJGdFp0CLL2VBc4SCfDbAchXSyiKd835jjyjZsKcQl+u8zp1C09ZGVxygM/RsOQVII3yZmKI8y5dlUX6aRIASrviO/IpRXoLjVe9eEl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jARdlX5C; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739963577; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=AOS3TxiSBim6IrLgI1TkSe7MBn0RikxAUdjypC+ZAt4=;
	b=jARdlX5Ck4DR2iBG2A3Eqs4jsTpvfE2Q8npxWBEzRNVuXC2y+/UEJRdAofhst8Usia9UgbRKoGT8aMb0d21xl4RCsB6lBbFjRFn7J9zrHopfHy55wAVfR23Vq4g8zrutXQ3mJG91o+UG/v/+dhLRu0c1eX3PAyFyuoG6W6cDYO0=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WPpAZdk_1739963576 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Feb 2025 19:12:56 +0800
Date: Wed, 19 Feb 2025 19:12:54 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>, rafael@kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI/portdrv: Add necessary wait for disabling
 hotplug events
Message-ID: <Z7W8tlhd-Yw3snk4@U-2FWC9VHC-2323.local>
References: <20250218034859.40397-1-feng.tang@linux.alibaba.com>
 <20250218223354.GA196886@bhelgaas>
 <Z7VHuOFxilan4LX_@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7VHuOFxilan4LX_@U-2FWC9VHC-2323.local>

On Wed, Feb 19, 2025 at 10:53:44AM +0800, Feng Tang wrote:
[...] 
> > 
> > And IIUC this will add a one second delay for ports that don't need
> > command completed events.  I don't think that's fair to those ports.
> 
> Good catch! So we should add a read of PCI_EXP_SLTCAP register and
> check if PCI_EXP_SLTCAP_HPC bit is set.

Maybe something like this?

	if (slot_cap & PCI_EXP_SLTCAP_HPC &&
	    !(slot_cap & PCI_EXP_SLTCAP_NCCS) &&
	    !pdev->broken_cmd_compl)
	    do_the_wait();

Thanks,
Feng



