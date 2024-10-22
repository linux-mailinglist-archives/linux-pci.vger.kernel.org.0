Return-Path: <linux-pci+bounces-15046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFDC9AB849
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721A41F21A48
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6871547ED;
	Tue, 22 Oct 2024 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Lyf9eK+Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69C6153565
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 21:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631722; cv=none; b=iMPSAJes7iZEOpJn+71ns4D4OJqd7ZASi0Q5Dix9MQeduedriHYRic/zUwnP1+jgeLaimRYtR1n1yrIWD5IjhDfxVm+IGP4Bt9XPcujLhQYD2KnoyrRTAtGaQQItHvByQySSX4oL+jDOaQwpdPpVZzzfZrA08g1Q9ExTLPVQIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631722; c=relaxed/simple;
	bh=6ixhY8gclUoC042Y+ke43z8Kloya6uBAUcIDPmq4PzA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=rY179hQZNmibWl7R1FRvXq3aoBwkAilrcek9n0QmSQfCmwLIONg9/L9QOht2e+KHIh1BZkVzueXy1FSC3BuHvB+FFQrSLEJnRreCTSBgXhzviwTSBCPWhZRNKgSnpUjUmmNPhsoHs5bWtS9IGKtMCOsfubaf59LVNVuIn29wlvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=Lyf9eK+Y; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=TgerkKHU+W70hpEqn7HGkgopsgSDErck10sEePVgCrE=; b=Lyf9eK+YAptXwpU2UBsLWPfxIS
	OomHFA+kiegXoBLOLFcQAoinNu3dT3+zXqs6YATgrGGTnCz+V6IWBv5mDp6VvVBtxBlPOofGeqKjY
	UTJPvq1N83wdXkMBTkYBxQGDykN7USFbP1cuOfDsOFYoL7tf4KvLjV1fPCT9LVQGyZYZXnTzj7Pg4
	m6j46hyNl+Vtea6WmJ7pmaQgbwrzEbBtksswquyMxvdebtWZOK6meZI3mTR5mwW2zHSDtqhnCfX1K
	9SM4g7cn7zuhC0D2uaMiokjpmLylY/HjVptH1lJImVLv+LzkW8tY1ryXBfmevNV3O7nBiN0HMmPNK
	G9yUPYkQ==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1t3MDc-00FYLI-18;
	Tue, 22 Oct 2024 15:15:09 -0600
Message-ID: <26d7baf8-cfdc-4118-b423-5935128cc47f@deltatee.com>
Date: Tue, 22 Oct 2024 15:15:05 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bjorn Helgaas <helgaas@kernel.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20241022151616.GA879071@bhelgaas>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20241022151616.GA879071@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: helgaas@kernel.org, vivek.kasireddy@intel.com, dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, bhelgaas@google.com, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 1/5] PCI/P2PDMA: Don't enforce ACS check for functions
 of same device
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2024-10-22 09:16, Bjorn Helgaas wrote:
> On Sun, Oct 20, 2024 at 10:21:29PM -0700, Vivek Kasireddy wrote:
>> Functions of the same PCI device (such as a PF and a VF) share the
>> same bus and have a common root port and typically, the PF provisions
>> resources for the VF. Therefore, they can be considered compatible
>> as far as P2P access is considered.
>>
>> Currently, although the distance (2) is correctly calculated for
>> functions of the same device, an ACS check failure prevents P2P DMA
>> access between them. Therefore, introduce a small function named
>> pci_devs_are_p2pdma_compatible() to determine if the provider and
>> client belong to the same device and facilitate P2P DMA between
>> them by not enforcing the ACS check.
>>
>> v2:
>> - Relax the enforcment of ACS check only for Intel GPU functions
>>   as they are P2PDMA compatible given the way the PF provisions
>>   the resources among multiple VFs.
> 
> I don't want version history in the commit log.  If the content is
> useful, just incorporate it here directly (without the version info),
> and put the version-to-version changelog below the "---".
> 
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Logan Gunthorpe <logang@deltatee.com>
>> Cc: <linux-pci@vger.kernel.org>
>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>> ---
>>  drivers/pci/p2pdma.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 4f47a13cb500..a230e661f939 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -535,6 +535,17 @@ static unsigned long map_types_idx(struct pci_dev *client)
>>  	return (pci_domain_nr(client->bus) << 16) | pci_dev_id(client);
>>  }
>>  
>> +static bool pci_devs_are_p2pdma_compatible(struct pci_dev *provider,
>> +					   struct pci_dev *client)
>> +{
>> +	if (provider->vendor == PCI_VENDOR_ID_INTEL) {
>> +		if (pci_is_vga(provider) && pci_is_vga(client))
>> +			return pci_physfn(provider) == pci_physfn(client);
>> +	}

I'd echo many of Bjorn's concerns. In addition, I think the name of the
pci_devs_are_p2pdma_compatible() isn't quite right. Specifically this is
dealing with PCI functions within a single device that are known to
allow P2P traffic. So I think the name should probably reflect that.

Thanks,

Logan

