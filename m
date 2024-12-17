Return-Path: <linux-pci+bounces-18572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8AC9F4037
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 02:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B37E16A12B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 01:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A695182488;
	Tue, 17 Dec 2024 01:50:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C706EB7C
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734400212; cv=none; b=MiOimnvBKBgRY7Q0nnilbF2+FNmVeM8o3tkejbGekzbSIgJLJcrn8xFDSXy8HkFYSYi1IAwgdsnQEMx2i4U3eJRKz/44WoOC5F9K+GDHOJRoSeaudHHzPCCqYzlN5EU7iXhcvqPVbbqLsQv7aJyHPFqZQb6wh/rzc1N45gHb1To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734400212; c=relaxed/simple;
	bh=ljKmAB0VT2J1XoUx9siQ779m5CZ8tdsK068WTcuBiOY=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=Wybtl+9oRdaGHNJDzSnB/UiQj5ms84fplJkNhlWu9JPDnzlY1OxXDFXzz57ralhnuTOWCpJj0JdqITpiVpo7AGrnTL33NWnEuPpQh0uovXb93bObIN6cRrGt4YJp/x7lMWzu7Y0ea5br6fmClGR17Kf5JTqXIIInXsDyAmwVOeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YC09k2wWhz1JFcQ;
	Tue, 17 Dec 2024 09:49:46 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 8930C1A0171;
	Tue, 17 Dec 2024 09:50:07 +0800 (CST)
Received: from [10.67.111.53] (10.67.111.53) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Dec
 2024 09:50:06 +0800
Message-ID: <30cde67b-7add-49c1-b45f-bc8a9204862b@huawei.com>
Date: Tue, 17 Dec 2024 09:50:06 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <zhangkunbo@huawei.com>
CC: <bhelgaas@google.com>, <bp@alien8.de>, <chris.zjh@huawei.com>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <liaochang1@huawei.com>,
	<linux-pci@vger.kernel.org>, <mingo@redhat.com>, <tglx@linutronix.de>,
	<x86@kernel.org>
References: <20241126015457.3463645-1-zhangkunbo@huawei.com>
Subject: Re: [PATCH v2] x86: fix missing declaration of x86_apple_machine
From: zhangkunbo <zhangkunbo@huawei.com>
In-Reply-To: <20241126015457.3463645-1-zhangkunbo@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh100007.china.huawei.com (7.202.181.92)

ping gently.


