Return-Path: <linux-pci+bounces-15160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031F99ADAA4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 05:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE475280D51
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 03:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78C1474CC;
	Thu, 24 Oct 2024 03:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hTEli1vQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A01EB3D
	for <linux-pci@vger.kernel.org>; Thu, 24 Oct 2024 03:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741361; cv=none; b=AYUiVwf++bO90ZfkO5BniEUvL5VKjCq4pVrTUquLttjmI2mdsWHWrhVXFyk/1eCwpoR0rQ40ARs3/iVPIVdO0OcbUX23qt8ef9jNvgfNAgPbYFsqEEEFFmRbFQx8JtaJOLEM+z7jruMt0Jsci/cJwhEVPyt06WUPxNp18fVQVcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741361; c=relaxed/simple;
	bh=5E+vmuY/XFKSj68y2Huqrww82Ag1t6Sz7egdfNBbSd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JK1/b88VMtSsKBitFUXyDPah3yi+Off20QtbFur5HsFaTObu9dZTscN599CcoyEKQMrsDN1xBLnGHZH7RPtf1gjgHBrf2/hWQKy/L+qKQCF+iV3p/VZhZRwEUMNrINOZxoXzi5RxEpvYTmBECxQ8rCntBY/00cvP4Bo9WQyByKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hTEli1vQ; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729741355; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gquinrMR6yQnQ8hqiK8kRExAOqM5ZgNQZ+JugqpI9V8=;
	b=hTEli1vQa4vD/HqPSzl2Wfzlt7WcCi0X/BzEZmpB5e4OUm0vaM8SDkDA/p5kzxZkvD1BMxX3oKg59SAaC5kXMQdCRzdLcbcvGlhoSHgtEO3eX7C3IfX4pEoVBsYjIP1Qn8Ll5OW/dhNp2FcmJRlL6A7nLLR56LdqWaaBYaEgQU4=
Received: from 30.178.82.24(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHnbmLW_1729741353 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 11:42:35 +0800
Message-ID: <ac47e477-bb06-414f-9766-a3688c098beb@linux.alibaba.com>
Date: Thu, 24 Oct 2024 11:42:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] PCI: optimize proc sequential file read
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>
References: <20241022154443.GA880326@bhelgaas>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241022154443.GA880326@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/10/22 23:44, Bjorn Helgaas 写道:
> [+cc Greg]
>
> On Fri, Oct 18, 2024 at 01:47:28PM +0800, Guixin Liu wrote:
>> PCI driver will traverse pci device list in pci_seq_start in every
>> sequential file reading, use xarry to store all pci devices to
>> accelerate finding the start.
>>   /* iterator */
>>   static void *pci_seq_start(struct seq_file *m, loff_t *pos)
>>   {
>> -	struct pci_dev *dev = NULL;
>> +	struct pci_dev *dev;
>>   	loff_t n = *pos;
>>   
>> -	for_each_pci_dev(dev) {
>> -		if (!n--)
>> -			break;
>> -	}
> Maybe another approach would be to use pci_get_device() directly
> instead of for_each_pci_dev().
>
> pci_get_device() takes a "from" starting point, so instead of keeping
> track of the index "n", you could keep track of the current pci_dev.

You mean let struct seq_file to keep the pci_dev? Well, we also need keep

the pci_dev which held by seq_file in klist_devices, because finding 
next rely on

it, this make things complicated.

In addition, in pci_seq_start(), the pos may not increased one by one, so

we dont know how many times we should skip to find the pci_dev which number

is *pos.

Best Regards,

Guixin Liu


