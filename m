Return-Path: <linux-pci+bounces-28415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845BCAC4305
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 18:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D17F3AAE41
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 16:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0550225A34;
	Mon, 26 May 2025 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PxK97WVN"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9281171C9
	for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748276975; cv=none; b=M89alzTjUv/Q2uiMK7ipqmo+82le/o2lRoJNxPqK/3D0Fw/UIL60BtzqT0ofwiCVkvRvd4gHhNOhAXzKMuvSKIPUlYE2q4LloyUO3avN9Uh6nQEKCSD/K371YmPW1Waehk+GazX03wa61arhjmoKWYpfKqt3WvT/GjIzn8u1OkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748276975; c=relaxed/simple;
	bh=+JXwCb8vZrhr5i9ZpBJP32LcB2dvemBmVKARYu70jo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqgGyAONyOusKjEJWY5CNFL/OZTYAYkPCQmubXHSMbLqNPVgvJYg5vBRntRzUlhM4jPqSek1h+AniWXbyILfi8Qfm6lg7y4BIJObfjM8ike0jZz/mdTZR2+/BkhdtwgbtTpVWS7kuD4lOuSnsZ1KJPPas+t6rTO+muhbF2KwHUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PxK97WVN; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=nPrRdEGbHVjLs0oHcrB0XorXcJKgI3QJIBJ0cRoKuWI=;
	b=PxK97WVNV/2F7zSPxbWZWdnRG7dTBdsTbpItML3KQJ3Y/z/zKmOM1DPkOfH4Ub
	mGK2WkRto4tYRkdZ+DJBGn1TDXOU4hIAHab67GK4P121In153pe2USS2VvdT39hG
	u8V6JEUknqVBCXvKYvBAHUPNd/pHNt5BrORglGNzB4E04=
Received: from [192.168.71.94] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wB3bjveljRoYrzXEA--.45533S2;
	Tue, 27 May 2025 00:29:19 +0800 (CST)
Message-ID: <39743267-6a2c-4a5a-9581-05b03e25477f@163.com>
Date: Tue, 27 May 2025 00:29:18 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: EXPORT dw_pcie_allocate_domains
To: Samiksha Garg <samikshagarg@google.com>, jingoohan1@gmail.com,
 manivannan.sadhasivam@linaro.org
Cc: ajayagarwal@google.com, maurora@google.com, linux-pci@vger.kernel.org,
 manugautam@google.com
References: <20250526104241.1676625-1-samikshagarg@google.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250526104241.1676625-1-samikshagarg@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wB3bjveljRoYrzXEA--.45533S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU1WlkDUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhtZo2g0liwRNgAAsa



On 2025/5/26 18:42, Samiksha Garg wrote:
> Hi Mani,
> Thanks for your response. I can see that pci-keystone driver already calls this function.
> Does it not mean that there is already an upstream user?
> 

Hello,

pci-keystone is build-in.

Best regards,
Hans


