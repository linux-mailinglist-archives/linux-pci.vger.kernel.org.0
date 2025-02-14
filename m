Return-Path: <linux-pci+bounces-21404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E2BA35399
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23C0F7A3C11
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 01:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CA96FC5;
	Fri, 14 Feb 2025 01:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="oPTNf2fp"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C2A3C17;
	Fri, 14 Feb 2025 01:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495953; cv=none; b=oZp49IGjRcM/fUeSGLB/DyUaGOFD0BW8pfl3OAcmBAkRr4/gBCX9qwTPIJQ3mCUB2z0ebXak3/ut2GBebNSs9VsQiRTv13hgMQ/rACW+nJzKj2s6iYq+oShnPy8ObJH2sJ8upRz3eTe+ZzpM2fdWezaewm41NoNz5lLmo8opNA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495953; c=relaxed/simple;
	bh=SYkpNCSTx2UkzzNin27ENo32K8px7iZPUMTcOSgJv9Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=Sf8CJsuAYi7PYiS/lDlfsoksMNLrUwPPYEXGQxZNzHJCZUR7s03wAR1i2GFzpNgRSaFsQaDcxfOd5jdFAu2Fi7UI5YTGlidHjl28rrIjoJa796bl7ukQhx7MtcALwoyJMgS1sW4wNGb9SjsDZHIOmWlcTykms7dK09B2UrXE4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=oPTNf2fp; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=g/ISVN0B6Jcdp0mrAl53NLh4YuAQL/kTyUuo7E9AozE=; b=oPTNf2fpGCo/Gvs+lWcIEg3qTf
	+R1cZI1iw31/VqIxMf8WfToLae9kl/EYCYhRH9v5Strm7h50UqmeJTOQZCEkzJx5xhjJu2ts2JiN4
	XMVzVPq6K1XOCx8A/mNA4f1rDECORqy89XvA3+Rl350uFs48mmiPfoDd4bCkG6SG+n9C4NR7otBsb
	Yy2nQkYMdSijSv5jZuRswT3VvFL1m0Sr4/xn9y+P/h0NaS2/OpHkZkDm6rIO+InKcq3cT/RTKyDrp
	VcmYzOHbBlMfYjMXeUeczV//8OnXNfjG3eCpxecPgOz8ZXYq/72Un3sfQDPSK1PuZCaAKhhiH2uMw
	Bjj8VqBg==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1tijtx-00EUQt-08;
	Thu, 13 Feb 2025 17:49:50 -0700
Message-ID: <ca475db2-87e5-4879-9951-68ccf9cf408e@deltatee.com>
Date: Thu, 13 Feb 2025 17:49:44 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
 kurt.schwemmer@microsemi.com
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 linux-pci@vger.kernel.org, ntb@lists.linux.dev
References: <20250213225319.1965-1-Maciej.Grochowski@sony.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20250213225319.1965-1-Maciej.Grochowski@sony.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: Maciej.Grochowski@sony.com, kurt.schwemmer@microsemi.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org, ntb@lists.linux.dev
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 0/3] ntb_hw_switchtec enable 256 LUTs
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-02-13 15:53, Maciej Grochowski wrote:
> Microchip NTB devices support up to 512 LUTs shared across all NT
> partitions. This short patch series increases MAX_MWS to 256 and also
> address issues when the number of mw is equal to 0 or MAX_MWS
> 
> Maciej Grochowski (3):
>   ntb: ntb_hw_switchtec: Fix shift-out-of-bounds for 0 mw lut
>   ntb: ntb_hw_switchtec: Fix array-index-out-of-bounds access
>   ntb: ntb_hw_switchtec: Increase MAX_MWS limit to 256
> 
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 

All these patches look good to me. Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

