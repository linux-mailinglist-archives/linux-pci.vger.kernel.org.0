Return-Path: <linux-pci+bounces-11368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31339494EE
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 17:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4D62869AB
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D755139FF3;
	Tue,  6 Aug 2024 15:56:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F51E18D63D
	for <linux-pci@vger.kernel.org>; Tue,  6 Aug 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959778; cv=none; b=Jdy5BibD5rrgymDMIFhreWnDc5TB6voCJDQHKOo+znX03MrIRdAPhghLqSsZxNbph/mMvkEZ5RZxgYpYQQoYtGNuWaSwdA4tBCJVB2h7AUCUd57sVeLT0HjTdcBVexkJmWI8nWwyATNJhZbA2fbLcVG1RJ5eeyLGyI2quj143aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959778; c=relaxed/simple;
	bh=ipO6LCC+0lX5NBVUGpfeO7z9r1n3Rg6JiUqrmv3yBKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UB3kBrAuNvrlPqCQEV3W3XIUoakrBNpgknPU6fNrXl80qdMce09iNZdtKyv7c6PplW/Z2Fji3Iru9cmXxU9iAphwCtWC2KiTiSGlON2hkyBqYGFQ3IYOQF10ZPFYR3gcm3klA+uHD/KAnATcrv4Mwoh8ywa8rOWmL9sPyrTW5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B134FEC;
	Tue,  6 Aug 2024 08:56:42 -0700 (PDT)
Received: from [10.1.32.65] (unknown [10.1.32.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA7703F766;
	Tue,  6 Aug 2024 08:56:14 -0700 (PDT)
Message-ID: <fbf120ac-acba-4a9f-a857-190a35f9bdf7@arm.com>
Date: Tue, 6 Aug 2024 16:56:08 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: does dtb not support pci acs enable?
To: Bjorn Helgaas <helgaas@kernel.org>, steven <steven_ygui@163.com>
Cc: linux-pci@vger.kernel.org, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Vidya Sagar <vidyas@nvidia.com>,
 Pavan Kondeti <quic_pkondeti@quicinc.com>
References: <20240802000042.GA129381@bhelgaas>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240802000042.GA129381@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-02 1:00 am, Bjorn Helgaas wrote:
> On Thu, Aug 01, 2024 at 06:43:59PM -0500, Bjorn Helgaas wrote:
>> [+cc ARM, IOMMU folks; I don't know the answer, but maybe they do]

Same story as before, it *is* nominally supported (per the linked 
thread), but DT-based IOMMU probing is still subtly broken so often ends 
up doing things too late to be effective. It can also go wrong the worse 
way round, wherein you may sometimes end up with multiple groups when 
you *don't* have ACS isolation between them, depending on the exact 
driver probe order.

Thanks,
Robin.

> 
> [+cc Vidya, Pavan, also see this recent thread:
> https://lore.kernel.org/r/PH8PR12MB667446D4A4CAD6E0A2F488B5B83F2@PH8PR12MB6674.namprd12.prod.outlook.com]
> 
>> On Fri, Jul 19, 2024 at 11:01:11PM +0800, steven wrote:
>>> Hello,
>>>
>>> I am a new person in PCI, I am trying to do something for iommu
>>> group on arm64 platform, I found if I boot the linux (5.10 kernel)
>>> kernel using UEFI + ACPI, it will work correctly. But if I boot it
>>> using UEFI + DTB, the iommu group not work, only one group present.
>>>
>>> I read the code, found that pci_acs_enable is set to 1 during
>>> acpi_init, but I can not find any code for dtb booting, so it will
>>> return "disable_acs_redir " during call pci_enable_acs.
>>>
>>> static void pci_enable_acs(struct pci_dev *dev)
>>> {
>>>      if (!pci_acs_enable)
>>>          goto disable_acs_redir;
>>>
>>>      if (!pci_dev_specific_enable_acs(dev))
>>>          goto disable_acs_redir;
>>>
>>>      pci_std_enable_acs(dev);
>>>
>>>
>>>
>>>
>>> SO, is it not support in dtb?
>>>

