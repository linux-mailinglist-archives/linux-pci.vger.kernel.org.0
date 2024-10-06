Return-Path: <linux-pci+bounces-13898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74920992213
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 00:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A429E1C20A33
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2024 22:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFD416F910;
	Sun,  6 Oct 2024 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIkXpfrV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5416D4E6
	for <linux-pci@vger.kernel.org>; Sun,  6 Oct 2024 22:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728252911; cv=none; b=pLbPhHkld9jN3D7rrt6zSNONos8YwMvlmA6adTD//3nnGya1lyBUpywYqT83SE9CoAcfSgITP57o5T/w6xl+bDi7g7aYek0tK8n+XQV9RpiNfNjjX6859lITel0pJKz4yQZxKafbCOblS12h9vSXvNqO9Jo6R95Op2om++UTutw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728252911; c=relaxed/simple;
	bh=+uAETJuxmy9BpTpr1zeCxOxMXGpYl1Mwi/p8CcLdcNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPqJwBeawn5gw4AhZug6H0TgtEjCbCsH+vo8dJKDx6wo9+BOtZvHGLlFc8n4qxgr77rXa/a23dV7HanLQwcBvk2sClS67bQoEiM42HPmr2raazRAK8v0m+U3jGH8fVjaQC1/KEXYI/7wAxKGk6Zy0NRkoDVItOkTmq7TVp/c4ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIkXpfrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDA0C4CEC5;
	Sun,  6 Oct 2024 22:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728252910;
	bh=+uAETJuxmy9BpTpr1zeCxOxMXGpYl1Mwi/p8CcLdcNE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oIkXpfrVcb/BZI7hLIo4fhGDwgANQfywcT02U8pUaNv5WfbUNW9Cptz/+OSMHAI7G
	 TsA8H4nxljNntKCOnzi5DkWDoZ6UWjSnWB8iosnNP4NF5jPPVJ0lFxnMp5pPq/g4fp
	 FNJASz8nuE/2yINb3fULUfo6GNm1nd28iJXQ6XqGhDZ5r+IKTGWG3RYIQf2W4F54Mr
	 BWUXbW6Vqj6cK9I7lMJn+u1tQryaF08O2uxwX3lTetANwgXtipXKScU6Hgt0PVal0u
	 W4uX28Dbyx8a+3OrMladNsy+1/DKMJlQDiU/imI6uBcRlDD06oOH7KggCrlANNe79X
	 a9Ac1/SaRZqsg==
Message-ID: <2899bd11-4a8f-4328-9ece-94b8227093f2@kernel.org>
Date: Mon, 7 Oct 2024 07:15:06 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] PCI: endpoint: test: Use pci_epc_mem_map/unmap()
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>
References: <20241004050742.140664-1-dlemoal@kernel.org>
 <20241004050742.140664-7-dlemoal@kernel.org> <Zv_bdtrQFSDulOkA@ryzen.lan>
 <a3c93ede-adc8-4f4d-9da1-da8241ddeffc@kernel.org>
 <ZwJ49NkwhKpeuwKa@ryzen.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZwJ49NkwhKpeuwKa@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/24 20:48, Niklas Cassel wrote:
> On Fri, Oct 04, 2024 at 10:47:01PM +0900, Damien Le Moal wrote:
>> On 10/4/24 21:11, Niklas Cassel wrote:
> 
> (snip)
> 
>>> I think that you need to also include the patch that implements map_align()
>>> for rk3399 in this series (without any other rk3399 patches), such that the
>>> API actually makes sense.
>>
>> This is coming in a followup series. Note that the Cadence controller also look
>> suspiciously similar to the rk3399, so it may need the same treatment.
> 
> I strongly think that you should continue to include patch:
> "PCI: rockchip-ep: Implement the map_align endpoint controller operation"
> (that was part of your V2) in this series.

I would rather not because this patch needs a prep patch that fixes the
currently broken rockchip_pcie_prog_ep_ob_atu() function. So I will post this
patch as part of a series for the rk3399 today.



-- 
Damien Le Moal
Western Digital Research

