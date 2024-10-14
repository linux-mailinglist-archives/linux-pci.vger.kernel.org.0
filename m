Return-Path: <linux-pci+bounces-14435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDD899C553
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 11:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6F528AE4E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A931E3A1BA;
	Mon, 14 Oct 2024 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYw2BJcV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5D28E3F
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897129; cv=none; b=Kd5Ja5UGINMhEwq9aGUQrAAz4tKyh7REijF9vz71hGvc1xCqXrwXpoF4SI4NuSX2FA9GxfmoSKdM+/X7xBIgy63VUiMjOdS9ZuRVXj+uUN8HXUTL7/1podznbTIQfexlGwoSy9JobZcLjz16TiQHlwHrRu6fhlStbsRNH9BL1CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897129; c=relaxed/simple;
	bh=opZczmtnmAC46lzsiMq5o6DHbppnV5C1bXWNocZ2GT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOIcSs3n5cc90WAj/6bRwOmpLF7cQXEyyDVtcOooIoV+dDK/H3S+PP+rJuGmQQb8egl5WlbdFpQTeuLBC1CeAr4fxKuo5K2h0fI/gQXNRf1pSGqKXeDR6n0ZuEfm4ugeW1UFI7SECkQ0xoYBJJb4Dthi4gmzJ2QGCUNOmOd/sIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYw2BJcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46244C4CEC3;
	Mon, 14 Oct 2024 09:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728897129;
	bh=opZczmtnmAC46lzsiMq5o6DHbppnV5C1bXWNocZ2GT4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cYw2BJcV5MYv0VOc4XtiMyTpD06KJORp1C0uGNyEpo495rD3VwUtSfZ7mQ/sASKfL
	 7qtgJQLT4BkTHush3lmtKhq29iKTQ+9lyVH671GG3g9Jwtp23a+Ftebo7K/ufD/LiN
	 uJeyPBiyLZUq1XBd6dYDwy5AjtcdVcfPI7B3zuolf46xx6Qt5EU3Ja9+fT1SoEvZyb
	 0KA3WJT7mzus2QBolm2mdY+rQXWObVzPNj+VoeeRwnybWURjc5pZBE0pFRlJTTb4wh
	 SfSoEg+t9RD3swROV2Ih3OjS9WTDkbOqTta2KZv9x9pMib1JrasbG9dCvZnV6FhfpF
	 gbMhSp3tUDe2Q==
Message-ID: <afabc1b5-e1c8-4b45-ba9a-57e0481d6d87@kernel.org>
Date: Mon, 14 Oct 2024 18:12:06 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] nvmef: Introduce the NVME_OPT_HIDDEN_NS option
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241011121951.90019-1-dlemoal@kernel.org>
 <20241011121951.90019-4-dlemoal@kernel.org> <20241014084258.GB23780@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241014084258.GB23780@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/24 17:42, Christoph Hellwig wrote:
> On Fri, Oct 11, 2024 at 09:19:49PM +0900, Damien Le Moal wrote:
>> Introduce the NVME fabrics option NVME_OPT_HIDDEN_NS to allow a host
>> controller to be created without any user visible or internally usable
>> namespace devices. That is, if set, this option will result in the
>> controller having no character device and no block device for any of its
>> namespaces.
>>
>> This option should be used only when the nvme controller will be
>> managed using passthrough commands using the controller character
>> device, either by the user or by another device driver.
> 
> That doesn't make any sense whatsover.  Why would you create a
> passthrough controller to support PCIe?

PCIe is handled by the PCI endpoint driver and that driver only passes the nvme
commands it gets to the local fabrics controller that is being used (which can
be a loopback or tcp or whatever nvmf supports).


-- 
Damien Le Moal
Western Digital Research

