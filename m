Return-Path: <linux-pci+bounces-40449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0977BC392C8
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 06:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2FD3B732E
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 05:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAA22D6E64;
	Thu,  6 Nov 2025 05:34:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out198-15.us.a.mail.aliyun.com (out198-15.us.a.mail.aliyun.com [47.90.198.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7682D6E72
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762407286; cv=none; b=JLHsTK7U7nyUciMIp+mO5vqY55hS713uB6Q8nzkDKBdl7XsDR+/JJMnNX8QGDFrFcSJHktQ1wwrEBUXWHbpAlGVjLpZIThWz5iImkaClXBlQ64iEH+MQvL3DNuS2EYL5jhDxU2RgpNmDnnT4UM9kCW/2ddF0dSuecICQjNs9ck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762407286; c=relaxed/simple;
	bh=MeCLtyN0zUoNeMhTur5GBFBIZd3070h+UzIOSK5c9Og=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:Cc:From:
	 In-Reply-To:Content-Type; b=UnzwrehQx7cpjjbXdldkYCvqVI9FiwtOKz+C+YWWfGmNnw/Xy0miIPikKodCkRsIyNa2Uv+3NXWgOigx/X857UWmguJaDEQgHBRvGSu0wVNhz8VxaQ0kQO3a1ji/6aJIfXPkX5IW9IZcZDfvOEQjCRxgVjVyqq/wf8bUY6oyzKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com; spf=pass smtp.mailfrom=allwinnertech.com; arc=none smtp.client-ip=47.90.198.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allwinnertech.com
Received: from 192.168.208.43(mailfrom:michael@allwinnertech.com fp:SMTPD_---.fG0XyBz_1762406952 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 06 Nov 2025 13:29:13 +0800
Message-ID: <610ad0fd-cc5a-f19d-77de-c565449f1c5e@allwinnertech.com>
Date: Thu, 6 Nov 2025 13:29:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Fwd: PCIe msi bitmap issue by split nr_irqs for 1 by 1
Content-Language: en-US
References: <89809140-413e-9b31-6a2a-99be98628e62@allwinnertech.com>
To: lpieralisi@kernel.org, kw@linux.com, mani@kernel.org, robh@kernel.org,
 bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, maz@kernel.org
From: Michael Wu <michael@allwinnertech.com>
In-Reply-To: <89809140-413e-9b31-6a2a-99be98628e62@allwinnertech.com>
X-Forwarded-Message-Id: <89809140-413e-9b31-6a2a-99be98628e62@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dear linux-pci team,

I got some msi-irq bitmap issue when using PCIe NVMe SSD during 
resume/suspend.

First, we know now all the controller driver using "order_base_2()" to 
find the bitmap in alloc/free.

Then in my case, SSD request for 9 msi-irqs, and 16 bits is occupy in 
bitmap[31:16].
Eg. msi_bitmap from 00000001 to ffff0001.

When in suspend, msi-irqs will be free one by one, but not 9 in one 
time. This will cause bitmap cannot fully clear which was requested, 
bit[24:16] will be free, but bit[31:25] was residue.
Eg. msi_bitmap from ffff0001 to fffe0001(1st) to fffc0001(2nd) to ... to 
fe000001(9th)

And I found that this "split" operation was push in below commit:
4615fbc3788d ("genirq/irqdomain: Don't try to free an interrupt that has 
no mapping")

After i revert it, everything goes normal.

So at last, is there any solution to fix it?

-- 
Regards,
Michael Wu

