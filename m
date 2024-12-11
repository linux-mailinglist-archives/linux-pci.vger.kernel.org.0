Return-Path: <linux-pci+bounces-18081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241BE9EC179
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 02:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABAF1697B5
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 01:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE4239FF3;
	Wed, 11 Dec 2024 01:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lCjAqtM/"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B5179BD;
	Wed, 11 Dec 2024 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880259; cv=none; b=E3YhTYFx83WHpa63H8JjDFpqGVqLo8vhPXZmsPNcXhGUnwMHHpKy9qu+BTlSv9oa6mjAkJx2glMCRd24wxp3SAPE/AbGEfFG1hQOthsFXdvFNvj9LGJ3NeuGsV8xtEv/hobUmwPe42xbXpBRzWLvttz5LYsKmk2GObqJyUB89NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880259; c=relaxed/simple;
	bh=roMrJ4xY7RhyaKy22kBbzezoTLoOe175jEiPV0n1qww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kht/LKMOaNrHqPA955iQPLa8S8Z7O/WZ837PkgnbPOcSHlhq1nY1ETNxZLMpyHjjoKtzT/yuv5tKRtIuIx3vEMVc9m528Ffagx1z9UeMix2NSkO7IL0oM7scQzIPhtkahFD5Iohh1y3bsMJXzCsoFjEyLuT5RG+3j5D2mv/tCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lCjAqtM/; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733880252; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QLiF3+1wxeQNn+Qj/FRUqScT1++3cQ1MFzbwCBVRb9c=;
	b=lCjAqtM/oA0qdEtrZ0+sUcfBXUGzcwst45vqa2LcQAkj/gduluZDrQE1oOzeQB9vTSB2EIPmVdLrblmAGhM/YL2OV7no1TQKNnqS5GQ1uBVEDv0Eno1bkjJCFyKanrt3V0/+uwcaYLuwsSjd1vmnVhIJAveHTNTJ3F8kZLeiGx8=
Received: from 30.166.1.177(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WLGFXUW_1733880251 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 09:24:11 +0800
Message-ID: <f8786f53-eff0-4fd7-9c4d-c5733f648c6e@linux.alibaba.com>
Date: Wed, 11 Dec 2024 09:24:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/dwc_pcie: Qualify RAS DES VSEC Capability by Vendor,
 Revision
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20241210145335.GA3239578@bhelgaas>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241210145335.GA3239578@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/10 22:53, Bjorn Helgaas 写道:
> On Tue, Dec 10, 2024 at 08:04:17PM +0800, Shuai Xue wrote:
>> 在 2024/12/10 06:29, Bjorn Helgaas 写道:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> PCI Vendor-Specific (VSEC) Capabilities are defined by each vendor.
>>> Devices from different vendors may advertise a VSEC Capability with the DWC
>>> RAS DES functionality, but the vendors may assign different VSEC IDs.
>>>
>>> Search for the DWC RAS DES Capability using the VSEC ID and VSEC Rev
>>> chosen by the vendor.
> 
>>> -	for (vid = dwc_pcie_vendor_ids; vid->vendor_id; vid++) {
>>> +	for (vid = dwc_pcie_pmu_vsec_ids; vid->vendor_id; vid++) {
>>
>> How about checking the pdev->vendor with vid->vendor_id before
>> search the vesc cap?
>>
>> +		if (pdev->vendor != vid->vendor_id)
>> +			continue;
> 
> Every user of VSEC needs to specify the (Vendor ID, VSEC ID) and
> verify that the Vendor ID matches the device Vendor ID, so
> pci_find_vsec_capability() does this check internally, so I don't
> think we need to do it here.


I see. LGTM. Also, I quickly tested it on Yitian 710 and it works as expected.

Reviewed-and-tested-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.

Best Regards,
Shuai

