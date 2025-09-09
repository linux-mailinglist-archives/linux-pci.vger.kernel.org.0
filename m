Return-Path: <linux-pci+bounces-35766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20EAB506A0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 21:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D713444BC8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 19:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50DE30506E;
	Tue,  9 Sep 2025 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux5OsOQf"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B923148CA
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447752; cv=none; b=CQMmTS8of4ycytkcqJ8+iA0x3GLjjpTnICiaxM8O0+ZtS6Sh+PpbyvRG5DjO/7nHT2ubh2/nDwytttW1R+QECTJLYiKIaq7XUeuSkISV1FS5GcjRgfeVK2EgBkxPZsGyKhOK53DoEmlKYrtPB3XSGdo5TWUIh2FPc+BdELyrYrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447752; c=relaxed/simple;
	bh=UBTwN9epOeHMQdtzqaWFx5uzJ4dIDcreN1C53Qvt8jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAeJbLERj8q94K2pf+q3zMxb0IVnmtF6Qkg03q3A2v/tueBtzyDD/pw/nvZI54TUa6emRSAlKYYfVko/2x2CH/fSvgajZNK6y94uzRlYn6DQd4HXSVptKVexvCcq+2tHH4ZkUMcAfkGmGsqxQz8unRvw5gkbOmw5Q8N6VlL2M8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ux5OsOQf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757447750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwEaYTkppqVE2bssVNAxlDikzdrxi/t7gGAUHOOn71I=;
	b=Ux5OsOQf3PKHRiVmu/5qhgSfC7Wy0a8ijCVmrXaWLmHsD66m7ZTnSr5O1lM9wsc0ZVQLSR
	JOQxOswqQr63+o+k0R3R9VmcJNrb73jZyNH9fCuEzkJ355QNW4eRt973mc58BM8tURHcvg
	n8BD7KsivgE97iVJWb5opZm+Qufxb7s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-obp2urFbOIuRw8Un6DJegQ-1; Tue, 09 Sep 2025 15:55:47 -0400
X-MC-Unique: obp2urFbOIuRw8Un6DJegQ-1
X-Mimecast-MFC-AGG-ID: obp2urFbOIuRw8Un6DJegQ_1757447746
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8063443ef8cso2410332385a.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Sep 2025 12:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757447746; x=1758052546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwEaYTkppqVE2bssVNAxlDikzdrxi/t7gGAUHOOn71I=;
        b=M0bIv6ii42EUcccN3t7Uwxa96XWpsEjQdGNKaed5QYEqyDRelOKxiXauVPHabw9PDJ
         cAFLuk1+snnnGiuydK2rJO+63VD34KHL8L6uDfGNXo0JCQMUfuEllHkGS1eG/Z6NmB9Q
         r3sEvPTzkJIe93BOvYwSDoNxPqbJVp73A12wrn5Vb/XNDOuodkWQtp+4shSADniK5V6Z
         AthD+0cLE7FvNpjCmcxhAnpgp9XNrB3EvXCTwE/1zhmYufhvFDFrbuGeOm915UhVk0sl
         trRqrbWzUh2tvuW46OjcKqQmTJGvZeCsluUluwqS/sWuJdUhzqvB9CVR14H7bGULEEiL
         kIzg==
X-Forwarded-Encrypted: i=1; AJvYcCWOg3uA4jVuZ9txvqaUzZv7zu1r9Ndf64jq6pCh9/Y6l7L4qqgMuwgtk+Jxk90SFQS9vhAKmkD5esI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpmefyvjcbphVrpvcWX1pkiOLRSinOv5R++dy3SdaMtKBXgIG
	AIRY4jpajIdIX67Pz9UTAjIibh0f80PWVPcCutTb14cavozL45KK7JKQZRPkPUDT8zIbFOFLGrs
	XcFBU6ntPL6x/sF2RVGp5GAD/wQoScBZuhb9rO7aa/1yhpDFro2HRSYWAC0Ctbw==
X-Gm-Gg: ASbGncvw/t+PTXdZDhB/PrQRkTB4fGDZP6cn+ieev63Xvj+cigLKpCYCL/g+PKqEjG2
	m1nh7+yNXEJG893X3tzfQUnS5I+4hZ27E1prO0O3UR2w6rzEao6soFMgBEfbpLkPuP2UmZmsGT8
	88b2me2s5SfL8NngfMfiT9fkioOq2ujqrGPBlYRJP91e0ypaBfwCMdk2YKdZ5q++MJLm9aBTnn4
	Z4hOv1HbEAmjtTLSxpA87TGZyDF7hzDB93RZiGVtP8WO+dUMYfOfWb9/fO/426AdaajoHoaKNdb
	JcIVQz6iU/nl6GmutZXL8DdNU5Lov3RAMaeNgXQC
X-Received: by 2002:a05:620a:2695:b0:813:ccb9:509f with SMTP id af79cd13be357-813ccb9510emr1236086185a.5.1757447746528;
        Tue, 09 Sep 2025 12:55:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaAcXU8kXFobnNvUqNWSUsQz0woT7+jL6jE0MUCrwRybPYjUTXel6RI/GHw+5Xzip867Mnsw==
X-Received: by 2002:a05:620a:2695:b0:813:ccb9:509f with SMTP id af79cd13be357-813ccb9510emr1236082685a.5.1757447746092;
        Tue, 09 Sep 2025 12:55:46 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-73a16bb3ff5sm74385076d6.1.2025.09.09.12.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 12:55:45 -0700 (PDT)
Message-ID: <25676d12-57f0-4f54-8554-a6d77d2c6631@redhat.com>
Date: Tue, 9 Sep 2025 15:55:43 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] iommu: Compute iommu_groups properly for PCIe
 MFDs
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <6-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
 <d0a5052e-fbbc-4bb7-b1cd-f3f72c7085d3@redhat.com>
 <20250909133128.GK789684@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250909133128.GK789684@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/9/25 9:31 AM, Jason Gunthorpe wrote:
> On Tue, Sep 09, 2025 at 12:57:59AM -0400, Donald Dutile wrote:
> 
>> ... and why was the above code done in patch 3 and then undone here to
>> use the reachable() support in patch 5 below, when patch 5 could be moved before
>> patch 3, and we just get to this final implementation, dropping (some of) patch 3?
> 
> If you use that order then the switch stuff has to be done and redone :(
> 
> I put it in this order because the switch change seems lower risk to
> me. Fewer people have switches in their system. While the MFD change
> on top is higher risk, even my simple consumer test systems hit
> troubles with it.
> 
In 'my world' I see -lots- of switches in servers.
I don't disagree on the MFD being a higher risk, and more common across all systems.

> Jason
> 

poe-tay-toe, poh-tah-toh... It gets to the end point needed.
Thanks for reasoning...

Reviewed-by: Donald Dutile <ddutile@redhat.com>


