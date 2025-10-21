Return-Path: <linux-pci+bounces-38832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3362FBF4418
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 03:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB55618A64FD
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 01:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4075115687D;
	Tue, 21 Oct 2025 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="drVf/uj0"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8D19CC28;
	Tue, 21 Oct 2025 01:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761010394; cv=none; b=k8y5EcdrWtdtjQymrw5ScOpf7VdMbR1+OzrAwKEdCAZ+qqYgRYEshAfskxhvUg9fEeMh7c0o4ra1aWb+OMbQFrMk5baqX9dVifx8DIXWlNeO4UDW8xy6cO2XDV4YOrlBWh17/olsYZYUsMwHW9DRiUTTIpvDKMkNcUS/7cElPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761010394; c=relaxed/simple;
	bh=6asv7xMuZrfQYT2oIWUFj5ZLN3INXRMwIzpjeKTKlR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWviCmxj4UrolXT0HEEsaoWHklf1C15iCs3vK8387JQO9xnXTzSdoX9yeJhISPErQ9pIE1WPDFiJennkCrF1DJn08bxwswukwa88iLXKR5zFjVNv1WejtHrgjR8w68VRyIkH416beKLRToIaBivoMxSN7YOwaEGx6hR+SFA6SUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=drVf/uj0; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761010387; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JftLKudts6AlugdH0e5sXukUNjaz5n6bWnIRDr7FQDU=;
	b=drVf/uj0YKHPxLGVSh7ktTEThbNY/E0Vt7Ba/38X5CK+51I+WSW8hhmzJFI/UYXUnlfQB/QbIyxj3b1RNwaDATw6Nyb9PUrmSdPBEmiQyv1tvZAitEPUEkwusdgCyf9BpjTDRweB0PmlTj3EUfjtdgjpKqKZyrj5wpJkcTerszg=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wqgxi9._1761010386 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Oct 2025 09:33:07 +0800
Message-ID: <cd36a39b-fc63-4c4b-aa67-215656b86990@linux.alibaba.com>
Date: Tue, 21 Oct 2025 09:33:02 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] PCI/AER: Clear both AER fatal and non-fatal status
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com, tianruidong@linux.alibaba.com, lukas@wunner.de
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-6-xueshuai@linux.alibaba.com>
 <8cfebb7f-e557-493f-9458-f770fd459d06@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <8cfebb7f-e557-493f-9458-f770fd459d06@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/21 02:44, Kuppuswamy Sathyanarayanan 写道:
> 
> On 10/14/25 19:41, Shuai Xue wrote:
>> The DPC driver clears AER fatal status for the port that reported the
>> error, but not for the downstream device that deteced the error.  The
>> current recovery code only clears non-fatal AER status, leaving fatal
>> status bits set in the error device.
>>
>> Use pci_aer_raw_clear_status() to clear both fatal and non-fatal error
>> status in the error device, ensuring all AER status bits are properly
>> cleared after recovery.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
> 
> I think it needs to go to stable tree. Any Fixes: commit ?

Got it. I will add a Fixes tag and cc stable.

Thanks.
Shuai

