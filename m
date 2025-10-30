Return-Path: <linux-pci+bounces-39799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB616C1FB1C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 12:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606733B5B9D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37098238175;
	Thu, 30 Oct 2025 11:02:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03212135AD
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822178; cv=none; b=VdD9lvUIvZHl7YoIOKviIWnn7Xb+WCb729DGWOBvKXdo/oUsJo4XEw/PlsGDbm4kI7MJC+W+P5FdfBq2cxOKP6EEVxoitq1GmUot21cFRAUtJ6CQtF1+PCtleZXD/7lpI72uunPo6L+oaeB+A87b+JTvQvZtcy+WwF3Pf7Xkc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822178; c=relaxed/simple;
	bh=PsSn0f/tjL8awL22xEhCimuKuSJy4vRFfPgE/UyuJJU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDqZ2078hoQIJEBlj/ObKv7+c0FLtiLCGRcp5oKZeU9Y4BaqBr6/9civKTt4UuAFjhBRQtUKhr7mzeAW+KlGk6THQULExPN12Wm0zUx7w/PosTB4wEJ9IZA9S4HSaDypDkBTELGJmkvZfBtRpTSQJ+I1e66f46cbWK4DHWNGEYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cy1PX4JGCz6K6Ct;
	Thu, 30 Oct 2025 19:01:04 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id BA0121402F9;
	Thu, 30 Oct 2025 19:02:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 11:02:53 +0000
Date: Thu, 30 Oct 2025 11:02:51 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Dave Jiang <dave.jiang@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH 11/27] acpi: Add KEYP Key Configuration Unit parsing
Message-ID: <20251030110251.00002b03@huawei.com>
In-Reply-To: <20250919142237.418648-12-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
	<20250919142237.418648-12-dan.j.williams@intel.com>
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

On Fri, 19 Sep 2025 07:22:20 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Dave Jiang <dave.jiang@intel.com>
> 
> Parse the KEYP Key Configuration Units (KCU), to decide the max IDE
> streams supported for each host bridge.
> 
> The KEYP table points to a number of KCU structures that each associates
> with a list of root ports (RP) via segment, bus, and devfn. Sanity check
> the KEYP table, ensure all RPs listed for each KCU are included in one
> host bridge. Then extact the max IDE streams supported to
> pci_host_bridge via pci_ide_init_nr_streams().
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> [djbw: todo: find a better place for this than common host-bridge init]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Generally all this ACPI code looks fine (up to the TODOs Dan has called out)
One trivial thing below

> diff --git a/drivers/acpi/x86/keyp.c b/drivers/acpi/x86/keyp.c
> new file mode 100644
> index 000000000000..99680f1edff7
> --- /dev/null
> +++ b/drivers/acpi/x86/keyp.c

> +static bool keyp_info_match(struct acpi_keyp_rp_info *rp,
> +			    struct keyp_hb_info *hb)
> +{
> +	if (rp->segment != hb->segment)
> +		return false;
> +
> +	if (rp->bus >= hb->bus_start && rp->bus <= hb->bus_end)
> +		return true;
If you are going to not use the simple pattern for matching that
would have this inverted so we only match if we pass all checks
might as well do
	return rp->bus >= hb->bus_start && rp->bus <= hb->bus_end;


> +
> +	return false;
> +}

