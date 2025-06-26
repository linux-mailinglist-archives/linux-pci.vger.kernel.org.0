Return-Path: <linux-pci+bounces-30778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEF0AEA1DE
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 17:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0234A2D67
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10F62EBDE9;
	Thu, 26 Jun 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DcFilojf"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDA62EB5B2;
	Thu, 26 Jun 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949521; cv=none; b=rXwa+D/vvXk0QSR+/r3BSwT+skCX6PzarvealhWwXvU73pcLo+7mM/1XkJ4GgapB19RC3MZp/h6Oq0qdQiI8ELnC++I/J4fYAyGe+yRK5QnirDGfufI3/Es4INB4hm0NNDSGiQOs4cLm+JSX/ytvAeS7OycQ8U8u6MxVTw9MYJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949521; c=relaxed/simple;
	bh=ESYTevXc/oepA5McDn6MnktgxmqOjOapOIogKMzUnIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1+KSpAEtZb3y0V5wUxcexW9Ugtoc+dwIDwOhOVUWbaiSJepl4jPIV6TxnylgwNqjRxGizjmF45nP7Do1FprDsBpw9YBBlM+/NOLjSw7uXPsXfTEUdg9FakvRh8xf/mxHtOjeWIC7wc6n6OSNVAB5+Vqq3d2ykRWRCN861Etslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DcFilojf; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=3xpPx2kOCad2hpMzOvAwCwU2e5kTTO83LTiQgpExVbg=;
	b=DcFilojfZDnOzsgdWezISQW+YDKOWn5VH6YdYQe/IngdfGqnywABuZkIahAW9G
	ZfhXzysK1+3YUvLdYBcB+aBolkdlxBIYUcetJi/xjGzyTfc1KZg8plmXySyaQxQp
	omi3884oiADPhZBd1UVCBBIMgv38MoSaJOtIbjIMZ118c=
Received: from [IPV6:240e:b8f:919b:3100:5951:e2f3:d3e5:8d13] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3H2Z1Xl1ovuUDAw--.19485S2;
	Thu, 26 Jun 2025 22:51:34 +0800 (CST)
Message-ID: <a2f02857-34b9-4abd-8315-9279f31f6e91@163.com>
Date: Thu, 26 Jun 2025 22:51:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] PCI: dwc: Refactor register access with
 dw_pcie_clear_and_set_dword helper
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250618152112.1010147-1-18255117159@163.com>
 <yw5ex3su7gjepctaqwkz3u5orcau55hibb2oozdlc2bkdopd3i@ftd34glarexm>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <yw5ex3su7gjepctaqwkz3u5orcau55hibb2oozdlc2bkdopd3i@ftd34glarexm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3H2Z1Xl1ovuUDAw--.19485S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4DGrWrXF4DKF1xWFy7Awb_yoW8Gw4xpF
	WUWayYkayUJa92va4xXa1xX34F93s5JwsxGF95J348XFsIyFn2vFyFqry5GasrWrWUtF12
	qr42qrWkuw1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UaJPiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgR4o2hdWexmjAAAsP



On 2025/6/26 05:00, Manivannan Sadhasivam wrote:
> On Wed, Jun 18, 2025 at 11:20:59PM +0800, Hans Zhang wrote:
>> Register bit manipulation in DesignWare PCIe controllers currently
>> uses repetitive read-modify-write sequences across multiple drivers.
>> This pattern leads to code duplication and increases maintenance
>> complexity as each driver implements similar logic with minor variations.
>>
>> This series introduces dw_pcie_clear_and_set_dword() to centralize atomic
>> register modification. The helper performs read-clear-set-write operations
>> in a single function, replacing open-coded implementations. Subsequent
>> patches refactor individual drivers to use this helper, eliminating
>> redundant code and ensuring consistent bit handling.
>>
>> The change reduces overall code size by ~350 lines while improving
>> maintainability. Each controller driver is updated in a separate
>> patch to preserve bisectability and simplify review.
>>
> 
> Thanks for the cleanup! I spotted a typo in patch 13/13. Apart from that, I only
> have one comment. You are initializing the temp variable like 'val' to 0 and
> then ORing it with some fields. Here the initialization part is not necessary.
> You could just write the first field directly instead of ORing with a 0
> initialized variable.
> 
> Rest LGTM!

Dear Mani,

Thank you very much for your reply and reminder.

Will fix.

Best regards,
Hans

> 
> - Mani
> 


