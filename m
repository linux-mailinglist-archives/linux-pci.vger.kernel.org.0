Return-Path: <linux-pci+bounces-24355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15122A6BC6F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 15:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393DE7A999F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDA01DB12C;
	Fri, 21 Mar 2025 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DjNLnSnR"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99FB1D63E1;
	Fri, 21 Mar 2025 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565552; cv=none; b=Y4ebVs/lNXFWOCTbonbL3kuhsTo4N06l0rG7HMX3MaXSOARggzTTk9G0EHYwV9RtXGI6BFIPfqjAxtaeXqbKO8nptO9Qz8N71AEKivzeJSGuUyvO5I1RiejsTHX0marbESPDXDltlXualhkZVNgXg2knCVPzElyKtvpwb0cfYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565552; c=relaxed/simple;
	bh=c/YDzsiM+GDCifgu1m4Ci5vYTdih1/CrpsRgbzWPihA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPD//8yEDXlQpGc22gT04iJoDgZge+vijyY8/UC4BljB4Z0meycloHvZu/Rvim+S0sIij8HHYP++Q+7UIGqvwweUzK+L1nuoPzIN02EyzVgGoFvm15TqruKJRuiueV4yH2YkdzjXc4dDHt0WRMeRb2VQOLZniMbBNAFbqh1Y/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DjNLnSnR; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=SiaPKDoE/YTcT89KFnIvHEyzNIcPjSlYbVVHxQMqPOs=;
	b=DjNLnSnRU4ZCX+N6UdhAyMgBGDZJ6XxErIN+YERbAQZZNN+gQ190RS0XNpx172
	XnBKE2JUMliGzvO1XSYnSlN/e3Lc/su2Bw5x9IpPDE04Ezfxt2vlpldM88eqzW/s
	+B2A1Gw57hoeHazyORP6hVlRydY40w9d5ln9nq3XQwC7E=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3P22DcN1nnlvTAw--.63994S2;
	Fri, 21 Mar 2025 21:58:27 +0800 (CST)
Message-ID: <17b4e704-8c71-4863-aa3c-85a591f53390@163.com>
Date: Fri, 21 Mar 2025 21:58:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 2/4] PCI: dwc: Replace dw_pcie_find_capability() and
 dw_pcie_find_ext_capability()
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250321101710.371480-1-18255117159@163.com>
 <20250321101710.371480-3-18255117159@163.com>
 <20250321130516.7pkvfl5ls7fzgtdf@thinkpad>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250321130516.7pkvfl5ls7fzgtdf@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3P22DcN1nnlvTAw--.63994S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUriSdDUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx8Xo2fdalqulgAAsC



On 2025/3/21 21:05, Manivannan Sadhasivam wrote:
> On Fri, Mar 21, 2025 at 06:17:08PM +0800, Hans Zhang wrote:
>> Replace duplicate logic code. Use a common interface and provide callback
>> functions.
>>
> 
> I'd reword the subject and description as:
> 
> ```
> PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
> 
> Since the PCI core is now exposing generic APIs for the host bridges to
> search for the PCIe capabilities, make use of them in the DWC driver.
> ```

Hi Mani,

Thank you very much for your advice. Will change.

Best regards,
Hans

> Patch LGTM!
> 
> - Mani
> 


