Return-Path: <linux-pci+bounces-15211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 712B19AEBC9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 18:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A4EB20DA9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 16:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AD21F5836;
	Thu, 24 Oct 2024 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="VZN70DSE"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737221CBA17
	for <linux-pci@vger.kernel.org>; Thu, 24 Oct 2024 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786893; cv=none; b=BGXJKXu5a1FYLPgEEWeE0tOvcsYP4+WgBqj5MTnXlIGSPS0cY81jUFeGTcKxDZ4nyBO/5FhoMmNjjU+uc4gKSYPtE1KiiQk+9/g8ZCG6SxjGEMKZEt7uSYTOzd1Pc6GFeCjVIMQs6QaKSwEjfg3QlO/6xewLBtAt/vOT4uZoJDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786893; c=relaxed/simple;
	bh=jDrqNELMr4hJN1aNtpR6XIChV3cdGXU6NdzMsUfUu2Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=jtFs4XqGcgpao2gLftvOEzL420rEdVQMcXIsHHzUBUu0KstrhVWKQZQup6A++i77qIrT5iwZ1gnd1EBBvqHA5TEBfdD5Ef6zs+BiU74DDwuSafiilwTt6xayptKYDoofHuGJ5dJ87kZRBE55Fq/df2V1p3uw4PTpG+1urGGCuOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=VZN70DSE; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=jDrqNELMr4hJN1aNtpR6XIChV3cdGXU6NdzMsUfUu2Q=; b=VZN70DSEHTNVPzL+RGGTX59N7u
	QP4SQI+9x/ruSZAa/+2N4QB0MjvGWc1r/15twm78XTUiSYkbNBAk1dIUbsV4tADi75JwD18oDlhLO
	N7AHpuDs3tzHWRknPrua4P5B8dIszCAF2cWBGzu1oUYSZZqqJCrJok7qUmzyQwGxoVSN1/oBvTZ/+
	dGuAhXS/xjavYldjg1wkmFUQ+JYPdkN/KlHt2YFupcHxKTZk12iqwZO3aW8IsV2QY1SNDqLe8389m
	qC9Aqf/4h6XH73D45XjvKFxJzRu2j/se9tEqu00LWYUKJWjWHLSguWoUrdlvMiIiFyEBEsjBhi+bO
	dC0ZTsLA==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1t40aO-00H4d1-2k;
	Thu, 24 Oct 2024 10:21:21 -0600
Message-ID: <2e8eec04-c73c-410d-a844-716a68c6dac2@deltatee.com>
Date: Thu, 24 Oct 2024 10:21:17 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20241022151616.GA879071@bhelgaas>
 <26d7baf8-cfdc-4118-b423-5935128cc47f@deltatee.com>
 <IA0PR11MB718513F3D07518E9CCF3D498F84E2@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <IA0PR11MB718513F3D07518E9CCF3D498F84E2@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: vivek.kasireddy@intel.com, helgaas@kernel.org, dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, bhelgaas@google.com, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 1/5] PCI/P2PDMA: Don't enforce ACS check for functions
 of same device
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2024-10-23 23:50, Kasireddy, Vivek wrote:
>> I'd echo many of Bjorn's concerns. In addition, I think the name of the
>> pci_devs_are_p2pdma_compatible() isn't quite right. Specifically this is
>> dealing with PCI functions within a single device that are known to
>> allow P2P traffic. So I think the name should probably reflect that.
> Would pci_devfns_support_p2pdma() be a more appropriate name?

That sounds better to me, thanks.

Logan

