Return-Path: <linux-pci+bounces-40269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AFAC329CA
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482F53A2D77
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3F833890E;
	Tue,  4 Nov 2025 18:18:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A432EBDFA;
	Tue,  4 Nov 2025 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280319; cv=none; b=BFSPrb6Crvc/nd0B6Fe9jDtgNCIeVO3pNMsZoY6ngdu6g8ZKCKv9zAzTW3eB0utWVDQMOuDR6WB2jEuLT2XoeAMhcChrjke/qIF/3pNK0nYv9jpY4pWeJx8Ds8psPywSBo+tEaX1SLBCqNjQFMQfr+bX2Bd+fh6Qg0ynvviL7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280319; c=relaxed/simple;
	bh=Tekw6vacs3bE1GdYDd0Cq+7ajhwsgCoA5JD7K/sgy5M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNlk5KACL8hhg8rbDHiCrDMb7j+/gQeiUYNRawW9sgR10L/ApctnVQMFfjMUUWOYNvGZ1AdP3BQthbx9/vJ6flNq7E5jiPucsBSrOaC/pX6TpuCpNh+vI4Dw0VmEL6u188YzY9ksSau+iyZP2+Rtaf0nadz+8I31VbnrbFVgraU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1Gsg3QmBzJ46C2;
	Wed,  5 Nov 2025 02:18:15 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B26E14033F;
	Wed,  5 Nov 2025 02:18:35 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 18:18:34 +0000
Date: Tue, 4 Nov 2025 18:18:33 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [RESEND v13 18/25] cxl: Change CXL handlers to use guard()
 instead of scoped_guard()
Message-ID: <20251104181833.00000e08@huawei.com>
In-Reply-To: <20251104170305.4163840-19-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
	<20251104170305.4163840-19-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 4 Nov 2025 11:02:58 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> The CXL protocol error handlers use scoped_guard() to guarantee access to
> the underlying CXL memory device. Improve readability and reduce complexity
> by changing the current scoped_guard() to be guard().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Nice
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


