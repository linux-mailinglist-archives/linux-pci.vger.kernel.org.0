Return-Path: <linux-pci+bounces-35817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0924EB51B0D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 17:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AC6171D3F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12D126C3AE;
	Wed, 10 Sep 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ipFymVzJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0108259CBC
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516873; cv=none; b=dwQO3peMiFvNonDaGs5tsgmdzOceoqWw92w3Ll1VqMm7rnONmeav+znmQJ5s+GjIw/Z3C1uvO0INHMXDZO2BXL1zBXnPj81WEZsdEmb1f/I4cobgbn53RaFyDh8PSb6FDv0yikBP5PL1KXQRu0XeLSCG690lkdC/3MDipIZpXDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516873; c=relaxed/simple;
	bh=y8m0jBS7QF7mSBtjPTJejL0GU8BqumBmxws5w8K4d4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK2kjq0/akZjNUXWYSkFIOt2fweHLx5dscVEKsJmjTR9NhNkTdYNe+oPc8WmtE1fvRQoDAX7D+oicv/cE1HQssxlIlTeYdWA1iZTHo8Btl+92SrPR9EQxbSqiRNcQg6mDOBR9aH0TfXWRo6CCui9YaXNRBFQk80NwGItiVaAhRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ipFymVzJ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-721504645aaso54629886d6.2
        for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1757516871; x=1758121671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNdY3PgAZdaOe7FmnSpRTxifjOSbXP7fn6IEcFySgc0=;
        b=ipFymVzJsbb4kNskatPk1haPjllc0CtQTO6Q2vE1M0fomeDiY3jPgSYK5JnrgmxOVH
         bpn+imRs4dO1+yopf2Zt43nXDvarl017ns0DF8hUxQWXp1h1HTQermFcpbgMz1gPO1Vh
         Hh9q+9hRJyMC3J+uMOsaZk1eHiDnfrFZFf22pvLBLUZKlfJUKKM8VI89MUS3pcNV3I4P
         Yjx/sY7thJyi/a5H7YwO/jT39O70ik/PG+BKmq4ZxmPc2XqAucAsOAbRO/IdoDYAbvYI
         0ee6Z19dh8rXGDysh3ALPC2ZeZ4egBQzCvl29CJIUub8tE5TA4qVIytygULUfyr+XtrD
         0Efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757516871; x=1758121671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNdY3PgAZdaOe7FmnSpRTxifjOSbXP7fn6IEcFySgc0=;
        b=cEL3RH4pEWesmW7iZ+cssRDLNcj00vDaN8X40JjsgvqFIdRJmcV86VUkvNVicA2cz/
         9eWA1bmSP10u1TiLDqO3Pudwl8itGwTUpo6I/CdvjWOkN0xUqJ9NQw+2jATvH95LP/He
         N5Vih8/0WmgbSnMrI0ctOmxet6OyR9/HrP4EcNhKqL5kjGuh1hChliIEhTTEfVcoRSNW
         KNJmvCDb8Sk5tHWzJ6+IxINJbYUaZYfXtReKQlA0kgXk+vt5hefa/C0wB4f10H+J1Ihe
         mra/4ImetZyxc70Uq4C8v4ka4wLKUlC/S7WkuTFL1F/FsrQTa3slRBL1XVqnMUTtPrWS
         ZM9g==
X-Forwarded-Encrypted: i=1; AJvYcCVawU9hmOzx41o0ArkSlQjz5jnB7SFy+HBZCw0/h03PC9WXrqto8J5LmSNKS2ElVaj2uXL5yD0JEiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdadmnfUhqmpm1Wxyf86fm4WWYP6eLLcIL1+4Rf7aUdhl6u9GO
	H3eArUGme/EqyLSgxoKdZFxpTFyt+ofocY/GzsUI4hIHhxefZ1V60L3laqCnwp18bT8=
X-Gm-Gg: ASbGncuSIOUnVumAO3q8ffb7jIiqUdeMzQ72MLpkT7cIB8/DXAvUjzCT6z9cQc5E0dM
	6OmuXtKUKUr9VkUAV9yH2/Y+aB7waS3ev9eFX71g0JE1iWBMJq5sJE/LC5G0P/Pqjj210yJYavu
	OmM4QFelyozL6mPa2TzINC7J41zGe2RHH5KdTenr0RA3FkCqMGoEnJZ4xkRVfzy3Uquyh9vQhZs
	/6rypRqhvPKKgue3fdUPwAVW9P/CNgOe1cHcm7eAFZfJVIB6ynupYL0c9TwCPWKJgGesiEu4QXH
	BoHXunvOu3vG556oIPGkFvuBmMDECPJIqaMAB4RDbvbJiZD77IMK+SrGjgrD5+e0LAciTwmoPsW
	Zd06hNnwBfcPm92uqQwk=
X-Google-Smtp-Source: AGHT+IH+BJW22LupObBGk6NPwobuFYb41PxuJvvB4HPRo4i7+jxyExborwUK24gXOQ4lS4LmrCtzlw==
X-Received: by 2002:a05:6214:2386:b0:71b:6414:fd06 with SMTP id 6a1803df08f44-739256bd5bdmr177377526d6.27.1757516852901;
        Wed, 10 Sep 2025 08:07:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::3:1704])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-75856b44ac5sm23806886d6.2.2025.09.10.08.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:07:31 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:07:28 -0400
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 23/23] CXL/PCI: Disable CXL protocol error interrupts
 during CXL Port cleanup
Message-ID: <aMGUMACDTT5a2-XA@gourry-fedora-PF4VCD3F>
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-24-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827013539.903682-24-terry.bowman@amd.com>

Hi Terry,

On Tue, Aug 26, 2025 at 08:35:38PM -0500, Terry Bowman wrote:
> Introduce cxl_mask_proto_interrupts() to call pci_aer_mask_internal_errors().
> Add calls to cxl_mask_proto_interrupts() within CXL Port teardown for CXL
> Root Ports, CXL Downstream Switch Ports, CXL Upstream Switch Ports, and CXL
> Endpoints. Follow the same "bottom-up" approach used during CXL Port
> teardown.
> 
...
> @@ -1471,6 +1475,8 @@ static void cxl_detach_ep(void *data)
>  {
>  	struct cxl_memdev *cxlmd = data;
>  
> +	cxl_mask_proto_interrupts(cxlmd->cxlds->dev);
> +
>  	for (int i = cxlmd->depth - 1; i >= 1; i--) {
>  		struct cxl_port *port, *parent_port;
>  		struct detach_ctx ctx = {

While testing v10 of this patch set, we found ourselves with a deadlock
on boot with the following stack in the hung task:

[  252.784440]  <TASK>
[  252.789090]  schedule+0x5d6/0x1670
[  252.796629]  ? schedule_preempt_disabled+0xa/0x10
[  252.807061]  schedule_preempt_disabled+0xa/0x10
[  252.817108]  __mutex_lock+0x245/0x7b0
[  252.825229]  cxl_mask_proto_interrupts+0x23/0x50
[  252.835470]  cxl_detach_ep+0x25/0x2e0

This occurs on a system which fails to probe ports fully due to the
duplicate id error resolved by the Delayed HB patch set.  

But it's concerning that there's a deadlock condition without that
patch set. Can you help try to eyeball this?  I'm trying to get more
debug info, but testing system availability is limited.

~Gregory


