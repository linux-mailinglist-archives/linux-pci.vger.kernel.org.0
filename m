Return-Path: <linux-pci+bounces-44960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDDED253BC
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA0643001013
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083633AEF3D;
	Thu, 15 Jan 2026 15:17:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D593AE6F3;
	Thu, 15 Jan 2026 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490240; cv=none; b=XvLW2yMmBnANhP53XB6yE7a6g/4bNAhbQkK42pKO1O2GCKl43H8MVgcNObAmmJ8lPegUWOamI4Ih/VzVKrt/RRygzsFxsOvKnWb17ocJff6Rz1BZ9cTQat6wak+uD2y/Y9au8wp9R8x3zX2nL1mfqCuGlllvuUaFdMwxkuMnfZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490240; c=relaxed/simple;
	bh=ZZ13uVnNnrGG9NKYlxXnWn1oC9kV+DTdHDEO8g2fKIo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAHsi0NbECV1vh72xtDCsFgxv8Wh7/o4hv9/GqvTdv2UNAXBgNYNQaXw4GqKwAq5yp5GMJN7xfuTEsbC0lJmfKpODmlkoSHjvpMuEY2w+HNu1qRhvUjNz5mXNzUf4BLsAqlD+zUZHXInVv4zWKqQ177aTGs/nemZlnRlkbDxZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsRR43yvWzJ46dL;
	Thu, 15 Jan 2026 23:16:48 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 04C654056A;
	Thu, 15 Jan 2026 23:17:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 15:17:04 +0000
Date: Thu, 15 Jan 2026 15:17:02 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 23/34] cxl: Map CXL Endpoint Port and CXL Switch
 Port RAS registers
Message-ID: <20260115151702.00005a51@huawei.com>
In-Reply-To: <20260114182055.46029-24-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-24-terry.bowman@amd.com>
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

On Wed, 14 Jan 2026 12:20:44 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> In preparation for CXL VH (Virtual Host) topology protocol error handling,
> add RAS capability registered mapping for all ports in a CXL VH topology.
> This includes the RAS capabilities of Switch Upstream Ports, Switch
> Downstream Ports, Host Bridge Ports ("upstream"), and Root Ports
> ("downstream")
> 
> Update cxl_port_add_dport() to map the upstream RAS capability on first
> 'dport' attach, and downstream RAS capability on each 'dport' attach.
> Arrange for dport mappings to be released at del_dport() time.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> [djbw: reword changelog, fix devm handling]
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
One comment inline on which level we handle failures in ras setup at but
that's already true so things aren't made worse by this.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

I'm not particularly keen on failing to pass errors up to
callers of devm_cxl_dport_ras_setup() which could then cleanly
ignore them with comments saying why. However, that predates this
anyway so a question for another day.


