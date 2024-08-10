Return-Path: <linux-pci+bounces-11573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B1994DE84
	for <lists+linux-pci@lfdr.de>; Sat, 10 Aug 2024 22:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1511F21787
	for <lists+linux-pci@lfdr.de>; Sat, 10 Aug 2024 20:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7948613D240;
	Sat, 10 Aug 2024 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ofTvF0Uj"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B281311A3;
	Sat, 10 Aug 2024 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320735; cv=none; b=ZkzF6dbbBlAvcA4Q1+fPlTrKeJ1YZtbf0kcZB5CIbeve2oEE1mgU6O4sADDfiUaLv/Mum8anSJt7H9epyjB2FNNTVLIKTS3d1PjyVsUF8VHSBDJVd7BRc07vO55CoX935U55stfjcvGmhsOJd+UpN4kZ5+LT5R+HBDN27y2AClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320735; c=relaxed/simple;
	bh=8nDF/iz5aI2tyDazPSqvemagDFebCFJ/eE/3I5c6RVM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=WLPi5gdqSD+Q073+f3X1mE06cezjMFbA5uThRQDWrR9XWtkNE+bGMva1CHvVNoWhRWp14g+q8olBRJaHdA5hGQYlXbZvCQA8Mlxe8vN2LOVM0VNcwi1n9i5tsHSwCyJi3NlwbRaDmpgr87Bc4cRrtAdeHenIC0QTRhxzRZY1k8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=ofTvF0Uj; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=ISPzHx6KFFacCRjr4AJjMnt3nYsKRyqSpF96QPp0ok0=; b=ofTvF0UjC8O5ND2bvlX8OvOqKN
	h+x2gensuwgqySRmmVyUFeWakU+qtTd3qCJaHTdGMbA0BsqznFrO847VUzFKuwsSOMghG52LTp/dA
	YuDUTc11bND9fOOrTW8RtuUjN3o9OwfjOzVUGU23YCWNWzVzVDB1tXfC2ce8WeXX7RDwdlgbPs9Gv
	9lyKUjmmlGwcz5Vcu9q1imuAYBjzyfwrM8BvIrblJHFA0uYzSdqvlH8w4pChgPM3xdmytQiHKAmOe
	s0HH0zefXP7w87Wj1oWceQYojdFQG6s+wmdUNyC+nC5r3jZMUy6sS6cjJUQBdj77+3vJHxJN41TWE
	Ovyt0toQ==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1scrq0-00BGwV-1P;
	Sat, 10 Aug 2024 13:33:17 -0600
Message-ID: <7d74ee82-a529-4f1e-b46c-fcc59e8edda2@deltatee.com>
Date: Sat, 10 Aug 2024 13:33:14 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bjorn Helgaas <helgaas@kernel.org>,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
 linux-kernel@vger.kernel.org, sumanesh.samanta@broadcom.com,
 sathya.prakash@broadcom.com
References: <20240621204737.GA1374564@bhelgaas>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20240621204737.GA1374564@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: helgaas@kernel.org, shivasharan.srikanteshwara@broadcom.com, linux-pci@vger.kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org, sumanesh.samanta@broadcom.com, sathya.prakash@broadcom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 2/2] pci/p2pdma: Modify p2p_dma_distance to detect virtual
 P2P links
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Hi,

On 2024-06-21 14:47, Bjorn Helgaas wrote:
> [+cc Logan]
> 
> On Wed, Jun 12, 2024 at 04:27:36AM -0700, Shivasharan S wrote:
>> Update the p2p_dma_distance() to determine virtual inter-switch P2P links
>> existing between two switches and use this to calculate the DMA distance
>> between two devices.
>>

I've reviewed this and the previous patch to the best of my current
ability and I haven't seen anything major to object to. The changes to
the P2P code specifically look good (once Bjorn's comments are addressed).

Please copy me on future postings and I'll do another pass with a
Reviewed-By tag.

Thanks,

Logan

