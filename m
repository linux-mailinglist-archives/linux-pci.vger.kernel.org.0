Return-Path: <linux-pci+bounces-9998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4CF92BD4A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 16:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A62928BED6
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 14:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F6C19B5B1;
	Tue,  9 Jul 2024 14:43:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089361684AE;
	Tue,  9 Jul 2024 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536227; cv=none; b=LtagQp0AOkwCwKgIRK3xO2qIb4z7upACuoRE9Nj05nk7YSIvZW606dj9oeH/noAuK+By/7Kt7nAEIQlaCNA0kyMNgnHh8HmITXflAb1WBpxWNh7rNYjKSdQYTmAEPTw+rgZRDQrJIfmDXf+V4z5q9J8jLfRfVaWoCdIDxX7PkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536227; c=relaxed/simple;
	bh=Q4gomzJZEK3pCgfpImtcuC3mWhWXMlklkAv65B90irk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGAmwfqDKdri6CFepygtIVERQRpXbC4ZPLYTu2XbMGBGpWBgAUolRZGDu6F7lekWUiG9WvvkUnegpFer2fkWw64WnxGLUEyQ7CgkzjGqAumGue96TJ773QhhisF+V9bV4tp6vbdqz7azgFndFGw4EhmcYfbkrMVAiDKmLyg0R5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WJNwg4t9Sz6K8bw;
	Tue,  9 Jul 2024 22:41:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C999140D27;
	Tue,  9 Jul 2024 22:43:42 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 9 Jul
 2024 15:43:28 +0100
Date: Tue, 9 Jul 2024 15:43:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
CC: Xiaowei Song <songxiaowei@hisilicon.com>, Binghui Wang
	<wangbinghui@hisilicon.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: kirin: use dev_err_probe() in probe error
 paths
Message-ID: <20240709154328.000042e0@Huawei.com>
In-Reply-To: <20240707-pcie-kirin-dev_err_probe-v2-1-2fa94951d84d@gmail.com>
References: <20240707-pcie-kirin-dev_err_probe-v2-0-2fa94951d84d@gmail.com>
	<20240707-pcie-kirin-dev_err_probe-v2-1-2fa94951d84d@gmail.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 07 Jul 2024 15:54:01 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> dev_err_probe() is used in some probe error paths, yet the
> "dev_err() + return" pattern is used in some others.
> 
> Use dev_err_probe() in all error paths with that construction.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


