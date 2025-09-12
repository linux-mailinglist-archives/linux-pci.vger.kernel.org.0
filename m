Return-Path: <linux-pci+bounces-36035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4E0B5522C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 16:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5EA3188A5AA
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC0D30E82A;
	Fri, 12 Sep 2025 14:47:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE9E3009F8;
	Fri, 12 Sep 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688432; cv=none; b=h5TvlQwbt/LhNUZK6nSMk9ey+c/95wylK2p8R6EZWH3qu/lt/qQX3nf+ftp1oBBKAc/40rKqBALGna2ujcff4rhplCYG+qnMVvU93ku0JC4U8cWmqfaOglR32G2qlezycpQNXSq1OdI7cppGqHGjPRAYtJPS4o57U6nsg9T5chA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688432; c=relaxed/simple;
	bh=41mg2V0FR0dYOB8eW9CPIIvUuAh540ORGz5m0rTTn3A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+octUewomxzSip/H8Z4MMzF/Y5dzRddjp7Qou7CrQt+V8DM+juu5JISt6I+Swsv4SrouqJTaUDERpgn8W93FyBchFLfL8u+XXbJL/SV3pCQQ0decpXEiFtqoj1Ro5FSsOAYhUCZnbmBHk6OkT9X7FGCDkU61c3R+Uppq8vW6kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNcdQ53mtz6M55j;
	Fri, 12 Sep 2025 22:44:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A84414038F;
	Fri, 12 Sep 2025 22:47:08 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 16:47:07 +0200
Date: Fri, 12 Sep 2025 15:47:06 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 02/16] cxl/regs: Add CXL Isolation capability mapping
Message-ID: <20250912154706.00002b71@huawei.com>
In-Reply-To: <20250730214718.10679-3-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
	<20250730214718.10679-3-Benjamin.Cheatham@amd.com>
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

On Wed, 30 Jul 2025 16:47:04 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add necessary information to map the CXL Timeout & Isolation Capability
> (CXL 3.2 8.2.4.24). This will be used in later commits by the CXL core
> and PCIe portdrv driver to set up and manage the capability.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

