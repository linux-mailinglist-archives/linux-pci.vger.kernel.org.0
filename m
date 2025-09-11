Return-Path: <linux-pci+bounces-35864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C738CB52801
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 07:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F848687946
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 05:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E001B4F0A;
	Thu, 11 Sep 2025 05:07:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE0168BD;
	Thu, 11 Sep 2025 05:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757567250; cv=none; b=Ez6CTLsGGvBnHcBYdpChtI0tnkGRG6HzUsB8h1XLUyUsSoJ/NY8JKQkDnUVFBhW07YhYyVSrql+SPKo8vv/1K8QlZCa1Cmg8J50CEhHGt7nwfBrV7dse7nA4K3aQEGJCoKizpIhHaeD4I6LjlMlvskQOtBPGuBatxUj0sa0rbdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757567250; c=relaxed/simple;
	bh=nVLyv8hldE1W+mNH4/SUEosoS1HWa82HK78i/z8dfiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWrU391Hknc8JIX+7hiEgfARB4kie1H2VnP4TEGjUXhQCDgD4sbb9DoCqIfdnO/ikoMezlQFLZgbPVO3DQKbc7ZY8nyGbPr5OCnyvWNX12NdYze3GXMcVHTbtpL2CMiHfkf+EHxk9rztSqaZEuLTFnvb2Y8j00BTWTeu2B8uItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 91A972C09E2C;
	Thu, 11 Sep 2025 07:07:23 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7556B25C481; Thu, 11 Sep 2025 07:07:23 +0200 (CEST)
Date: Thu, 11 Sep 2025 07:07:23 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 09/23] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
Message-ID: <aMJZC-AP11B9XRjC@wunner.de>
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-10-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827013539.903682-10-terry.bowman@amd.com>

On Tue, Aug 26, 2025 at 08:35:24PM -0500, Terry Bowman wrote:
> +++ b/drivers/pci/pci.h
> @@ -608,6 +608,7 @@ struct aer_err_info {
>  	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
>  	int error_dev_num;
>  	const char *level;		/* printk level */
> +	bool is_cxl;
>  
>  	unsigned int id:16;
>  

Commit 273024ded7b3 ("PCI: pcie, aer: flags to bits") made an effort
to reduce memory size of struct aer_err_info by converting flags and
small integers to bitfields.

So it seems the proper approach would be to take away 1 bit from
__pad1 or __pad2 and use that for the is_cxl flag.

I know bitfields are somewhat controversial, but it is what this
struct is using, so... :)

Thanks,

Lukas

