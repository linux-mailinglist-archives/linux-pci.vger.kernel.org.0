Return-Path: <linux-pci+bounces-41242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06649C5D4B7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 14:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B02584F322E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 13:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690DC248896;
	Fri, 14 Nov 2025 13:10:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62A19E7D1;
	Fri, 14 Nov 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125839; cv=none; b=WOeg+w/dwpZWgHACJ2To0e0+BawZQGuDCZFKpwpOsh8Cr58vjBM3L/dpKDXGUqXymywPHH7uQlECysKbPjKFLKOKzy5ZYWidQLpiVCuj4GYWOX7raWWXY/jsd/EeJQ14q4X7yTmSkZ233ygElvKhGtTHl+kE3c4yKDP8jEPSXDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125839; c=relaxed/simple;
	bh=MgBSQa2bumLnFgtNpezo4aCHcSFNSfKwMYPmdsVHaHE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ag6Z0CVhC0QXhQxsEtyISx4qVIxt0i0bc8z6HIkl/s0AeAu/SDrWvKWDmqbWhqOkL1+imE16j1QwM9ssSqz2Wl0+U+tN4RJt1bv44hiYg1kH89N3uQGpXgFN2jSE+r3Jg+leYz5LH/M4r4E48YH730CL8OsIZ3G+8mpbbwjPCgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d7HYZ6MCmzHnH87;
	Fri, 14 Nov 2025 21:10:10 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E17811400FD;
	Fri, 14 Nov 2025 21:10:33 +0800 (CST)
Received: from localhost (10.126.173.232) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 14 Nov
 2025 13:10:33 +0000
Date: Fri, 14 Nov 2025 13:10:31 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, LKML
	<linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, Frank
 Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, Dan Williams
	<dan.j.williams@intel.com>, Linux PCI <linux-pci@vger.kernel.org>, "Bjorn
 Helgaas" <helgaas@kernel.org>
Subject: Re: [PATCH v2 0/3] PM: runtime: Wrapper macros for usage counter
 guards
Message-ID: <20251114131031.00003b60@huawei.com>
In-Reply-To: <5959587.DvuYhMxLoT@rafael.j.wysocki>
References: <5959587.DvuYhMxLoT@rafael.j.wysocki>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 13 Nov 2025 20:24:57 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> Hi All,
> 
> This supersedes
> 
> https://lore.kernel.org/linux-pm/13883374.uLZWGnKmhe@rafael.j.wysocki/
> 
> as discussed here:
> 
> https://lore.kernel.org/linux-pm/5068916.31r3eYUQgx@rafael.j.wysocki/
> 
> It adds runtime PM wrapper macros around ACQUIRE() and ACQUIRE_ERR() involving
> the guards added recently (patch [1/3]) and then updates the code already
> using those guards (patches [2/3] and [3/3]) to make it look more
> straightforward.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
for whole series. 

