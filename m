Return-Path: <linux-pci+bounces-18494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB079F2E6E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 11:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BF5162A17
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 10:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4331E203D57;
	Mon, 16 Dec 2024 10:44:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1012620127A
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345879; cv=none; b=AiDeRxrUcYcIjcI8MTkx0EnPytPu0cFUiZe0UPQfRWLjreA5ad4mGuAb2EUsUR661vmG/mzNjFUtIyV2S2TDiqxl2ncfnAuNwOv+JvbojhBmob4daEUOFXkfanvUkvmnCtr5NoNjQ5HRwq7zJtZBY4RPRJv3dLSJxld0LZjNyBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345879; c=relaxed/simple;
	bh=Xm0rQlHKZUNK4AM1SFgpWRDPsXNT4szzZZpEg9C+wSg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmwDdEALuZ3DC0fzkndpQ8gqRSTL53TILHYzcHS8wJXa2FxMeLoMmVinrjF5nZMMugs0UCCz+Kk11zJOhOTVxY3OvDGYUCiDjHpPzfSNIVZVmsK3cacUt39mKlsKPzk287k6RAY2PfsbqTubcea18GZd4tYPhl1WZKDwI6PKKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YBc3w4pBzz6LDBF;
	Mon, 16 Dec 2024 18:43:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D5E2140CB1;
	Mon, 16 Dec 2024 18:44:26 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Dec
 2024 11:44:26 +0100
Date: Mon, 16 Dec 2024 10:44:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Karolina Stolarek <karolina.stolarek@oracle.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC 0/4] Rate limit PCIe Correctable Errors
Message-ID: <20241216104424.00000fab@huawei.com>
In-Reply-To: <cover.1734005191.git.karolina.stolarek@oracle.com>
References: <cover.1734005191.git.karolina.stolarek@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
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

On Thu, 12 Dec 2024 14:27:28 +0000
Karolina Stolarek <karolina.stolarek@oracle.com> wrote:

> TL;DR
> ====
> 
> We are getting multiple reports about excessive logging of Correctable
> Errors with no clear common root cause. As these errors are already
> corrected by hardware, it makes sense to limit them. Introduce
> a ratelimit state definition to pci_dev to control the number of
> messages reported by a Root Port within a specified time interval.
> The series adds other improvements in the area, as outlined in the
> Proposal section.

Hi Karolina,

Just to check, this doesn't affect tracepoints?   From a quick read
of the patches they look like they will still be triggered so monitoring
tools will see the correctable errors.  That's definitely the right
option even if we limit prints to the kernel log.

Assuming I read it right, change the series title to make it clear this
is just the prints to the kernel log that you are touching.

Thanks,

Jonathan

