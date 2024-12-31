Return-Path: <linux-pci+bounces-19105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B84599FEC37
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 02:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB7F1882DAB
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 01:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C972AF07;
	Tue, 31 Dec 2024 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YGdA5NcZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A9DFC0B;
	Tue, 31 Dec 2024 01:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735610112; cv=none; b=scmoQPhvHyAxKG7czqU72kqH52WSuWjCLwB8Lahv7qpIHYZ1P5fnOdyP7IcvlSCSAgpQ/ARYX3MuONcSba8RU/NDohM19wSiJk0sjBqnszgZkCVjUHQC68AJfpKjpYO3RkcwEtMXMllGWckLkftDIi1TsmMuuxnH49X2L72BT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735610112; c=relaxed/simple;
	bh=l+H08OsQvn+XZwFD7n2L0jFKwX9rOV3+7pEMLoPSWOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maxYSPtr/iC2cOLfX44bKiHQ0xQvwSYbsKpm2l6LJO+7oiT3HE3dIxTVyy6T9ah0yw0SGGfoONTI/1SVhBjOA/anrw+yHR4i8cQ5dzlJcu5Y1QZUNCsXbLN3o8H1Uc4zUxq2Cl+GmtlmjhAs7yhaGK17ApHfjln1YKBGaq2IdM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YGdA5NcZ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=uEnQbV0P884ixat1JkZCqTqdO+9bk0pJ3MKbHReYOss=;
	b=YGdA5NcZJErUvtOSbOusTvZXnwYKB3ak6hL3vkOiBbttBBbatmArsr5LNftV0h
	AYWkw+1YshVQg0Hh84Jnc2Tcigt+e7qeuyMK5Oid5ZLKehXncESsIvbDzhPKha/R
	aonfXKp5T5k/Y/59lHSOj7GyL6JgJhVc/Ksp4uMoZ2fjo=
Received: from [192.168.174.52] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDXwtrJTnNnB2JrCw--.65089S2;
	Tue, 31 Dec 2024 09:54:19 +0800 (CST)
Message-ID: <4777d3a2-92dd-483b-8563-1f84736b0b41@163.com>
Date: Tue, 31 Dec 2024 09:54:17 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] misc: pci_endpoint_test: Fix return resource_size_t from
 pci_resource_len
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, kishon@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com,
 Niklas Cassel <cassel@kernel.org>
References: <20241221141009.27317-1-18255117159@163.com>
 <20241230175249.lx32nb2adsm54qh3@thinkpad>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20241230175249.lx32nb2adsm54qh3@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXwtrJTnNnB2JrCw--.65089S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVpVbUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxHFo2dyttiLBwADsY



On 2024/12/31 01:52, Manivannan Sadhasivam wrote:

> Subject should be improved:
> 
> misc: pci_endpoint_test: Fix overflow of bar_size

Thanks a lot, Mani.

Regards
Hans


