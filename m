Return-Path: <linux-pci+bounces-11694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E7D9533E5
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 16:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C35CB22D57
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821D31AC8BB;
	Thu, 15 Aug 2024 14:20:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B8762D2
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731623; cv=none; b=ZpKNmwSJ7zuiwnuwjOaq6Lvk141XfNTzzCivZcGe8mp02PoEkfSW/kuJtszTdHQakE33i95dS7nExAwnY4+Z99svULUH/79jzLmIKHRSxJPutnCG+cNX45IFUZ3ayoCK9qfNt1mkzNQVqzmiJFA0/0mfxtgSW9BXcOZpvyWiqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731623; c=relaxed/simple;
	bh=EIavVgddvytM+LhdrrIA/10ouzQDKAUOARda1jOpktU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hABSN3ar/5a4XEfES/pJVwbM8206dRsjD2CnynqkwgPjHTTHItYyCOJWjQ8fjP1YWv4xLQV65h/RBcI+ZCNyO+7jfgUOYDiFOXNxiPrazZ6R6oDjJOLQBZNHxNNh92Ip50HBzac1K/YRQVnOSlmw58TRTds7HV3387Qzn5gjgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wl6d675fpz6FGYq;
	Thu, 15 Aug 2024 22:16:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 772B3140680;
	Thu, 15 Aug 2024 22:20:18 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 15:20:18 +0100
Date: Thu, 15 Aug 2024 15:20:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Keith Busch <kbusch@meta.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>,
	<mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RFC 3/8] pci: move the walk bus lock to where its needed
Message-ID: <20240815152016.000041cb@Huawei.com>
In-Reply-To: <20240722151936.1452299-4-kbusch@meta.com>
References: <20240722151936.1452299-1-kbusch@meta.com>
	<20240722151936.1452299-4-kbusch@meta.com>
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

On Mon, 22 Jul 2024 08:19:31 -0700
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> Simplify the common function by removing an unnecessary parameter that
> can be more easily handled in the only caller that wants it.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Good cleanup irrespective of anything else in this series.
I guess there is some history behind this one.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


