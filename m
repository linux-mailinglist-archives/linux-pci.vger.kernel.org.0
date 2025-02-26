Return-Path: <linux-pci+bounces-22398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C333A4527B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 02:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D0F177180
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 01:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD2117B506;
	Wed, 26 Feb 2025 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fzlaxSrG"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C1CEBE;
	Wed, 26 Feb 2025 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535011; cv=none; b=Sneyts+m7fm4Gzq5oXLiXOHp+3V6TuU0Fp2dC6Cm0b0Tm9coOPMceUbOrWgUQf8cUxvb7VHDHxe/OYmWKiaaVDml9xI2UQ4bADb/z0yVZ35w5v7nctsq6DdTff+HQJUcvP9qUVFa/ZC0i06ftE4knH+RFG+euk4ISrZjgbN51ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535011; c=relaxed/simple;
	bh=khsGAjmguSesc1UDHJD16EP2lGM7e5GTL1ZwuD7wpXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9wzg3Gf73/YQpedI27TniQDmSAMgrLPFODTvmLf1lu6BW3qn3oZ2w+7TUTEUKlTOsSh35AIljxIvvBTlADLwyWkXPWVVtJv0U8jmACuu41Yd4pJ2AkvuUGrq1FhNYBE9q3Mf69XDk6cBvPFhfvB6EunmoxyKB5dkVxUw4oERwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fzlaxSrG; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=GerhdZtK456QL3AJuJ2m1hlKNpTWmVQbj+hrnztgqKU=;
	b=fzlaxSrG0tJSuiRT/wizX5esaGjZx2Oc8lIMcPKMiE+AWJyzd9xZ22dbK0eDtz
	ZDXe6LboE7I6vgKo24+mYA+Iu3ZPVOjrsq89bwO6H8zDBM85Oi4vHO1TBMOB47hv
	wnYn3UTJyF0fvHs3x7lOMOBVrxsHUiFIhoBvEj3TEm+Bo=
Received: from [192.168.34.52] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAHhC+odL5nuzNDOA--.496S2;
	Wed, 26 Feb 2025 09:55:54 +0800 (CST)
Message-ID: <e25e5d68-7fb7-4157-825c-eb973f7e1321@163.com>
Date: Wed, 26 Feb 2025 09:55:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PCI: dwc-debugfs: Couple of fixes
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com
Cc: robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, shradha.t@samsung.com, cassel@kernel.org
References: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250225171239.19574-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAHhC+odL5nuzNDOA--.496S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur1DXr4fGF43CrW5Zw1fWFg_yoWxKFbEkF
	95trW8CFyUuFW29a9ayr1kJFZIya1fX3WSga43trnrWry5JrZ8Gr4ruw17XFy5ur97A3Z3
	Gr90qrWrJ3429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRCzuJUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDwQAo2e+bv28yAAAsW

Hi Mani,

Can you submit after this patch? Otherwise, will my patch conflict?

https://patchwork.kernel.org/project/linux-pci/patch/20250223141848.231232-1-18255117159@163.com/

Best regards
Hans

On 2025/2/26 01:12, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series has a couple of fixes for the recently merged debugfs patches.
> This series is rebased on top of pci/controller/dwc branch.
> 
> - Mani
> 
> Manivannan Sadhasivam (2):
>    PCI: dwc-debugfs: Perform deinit only when the debugfs is initialized
>    PCI: dwc-debugfs: Return -EOPNOTSUPP if an event counter is not
>      supported
> 
>   .../controller/dwc/pcie-designware-debugfs.c   | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)


