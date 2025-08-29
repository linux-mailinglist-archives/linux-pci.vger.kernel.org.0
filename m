Return-Path: <linux-pci+bounces-35094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B58B3B61F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 10:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F5E1B25C26
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 08:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF87B2857C2;
	Fri, 29 Aug 2025 08:39:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98D28032D;
	Fri, 29 Aug 2025 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756456755; cv=none; b=noLLQ88aLYrht9QQ4frlXammmHMqX6DClvWIoG72QiFdgu5pLhEihQX+s5va2x6q+zEMvrovQCZ2hWjvt0lImTDMa1h8zqECF07jGPu6UfIAt/IfC7d0tJ9eJjwirqahLD8TG52+Go/Jl9NK41BugRy+qsQ/7+PRmc4QIyN7tFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756456755; c=relaxed/simple;
	bh=XygJeSm7/yiITjrZVGFCN878KwwVhVDRGf6FQ5qqJDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sm3bX49ZMzXt49wMa7cXW1K/m3YGRUpeORzySIjbSXkHItydzfOaOOJ43/ZRh+EDSxhF5RQOlHleE+/8qnyyV6Jibj3XsWVSJo8aQZY42COuzJ08WC/wNO9KSccTR96zggT03rahA6C3QY8eS2KZ6zUAITHXpKzTJV0AXnLme60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C46FD2C01826;
	Fri, 29 Aug 2025 10:39:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 812563FB86E; Fri, 29 Aug 2025 10:39:05 +0200 (CEST)
Date: Fri, 29 Aug 2025 10:39:05 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com,
	shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 06/23] CXL/AER: Introduce rch_aer.c into AER driver
 for handling CXL RCH errors
Message-ID: <aLFnKbWtacLUsjAi@wunner.de>
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-7-terry.bowman@amd.com>
 <9e01d94c-7990-4599-9eee-ac0f337d6e2d@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e01d94c-7990-4599-9eee-ac0f337d6e2d@intel.com>

On Thu, Aug 28, 2025 at 01:53:35PM -0700, Dave Jiang wrote:
> On 8/26/25 6:35 PM, Terry Bowman wrote:
> >  drivers/cxl/Kconfig        |   9 +++-
> >  drivers/cxl/core/ras.c     |   3 ++
> >  drivers/pci/pci.h          |  20 +++++++
> >  drivers/pci/pcie/Makefile  |   1 +
> >  drivers/pci/pcie/aer.c     | 108 +++----------------------------------
> >  drivers/pci/pcie/rch_aer.c |  99 ++++++++++++++++++++++++++++++++++
> 
> I wonder if this should be cxl_rch_aer.c to be clear that it's cxl
> related code.

I'd prefer an "aer_" prefix at the beginning of filenames,
but maybe that's just me...

Thanks,

Lukas

