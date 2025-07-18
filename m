Return-Path: <linux-pci+bounces-32480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FDEB099CC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 04:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9385568430
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 02:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941A51A9B53;
	Fri, 18 Jul 2025 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOnS9at+"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF423597A
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805909; cv=none; b=fVgTkQtu0FufFYzVPK02I8ykuGaBDdO/ANp9hQB2wAgnp8JwUvWbhMPsaZjfifaJxuUwRBsIuIuia4S0CrJoYXfen9dzpl6AlKvjXOXhiE5t/W0OUGJT8mQkCxe3cjbzwW2o3uxOEKmBkj31njGx/p9RdLJGePA7TtmkrIngBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805909; c=relaxed/simple;
	bh=GKHMgIQjLp7KXkce3TSNrNDc4cs1kxoWV9ktElkfly4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1cAgSECgZzCqi4BwiyWSuw32AQRkpL3o7N4ofC9ZNldHb3YCh/262E/PwgHx05J1V2PqGTmKQ1ZeEkVtQhM3EuLYPWDk1UjtmYmM+LWapfpWkhQ27qLBeu2xPeMYapl0g09TVOsPC6TpQOCxsJVfAJw4xXHNKJcIAF45G+aQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOnS9at+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752805906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaZLU4GKhmRux2+I10jXp65n20V7jWRI51gsD8E69t4=;
	b=hOnS9at+bKb4Ui5jNLSiOMMqQlkayEmC54wgM4qE6uU6cBoH/AHief1DqYWf5v0RC0ZT6o
	IFjfKRy+WEXQwDaDJpSAtfXgOUo9G/K+VBKNQP9slX5ey/zJoQvep2d9zP4ImXVbM2vhf8
	my3SKCa+xKAdqGm9tAvWQNhJ73zvYRA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-RmptAFkQMlmGOSyLpSx2lA-1; Thu, 17 Jul 2025 22:31:45 -0400
X-MC-Unique: RmptAFkQMlmGOSyLpSx2lA-1
X-Mimecast-MFC-AGG-ID: RmptAFkQMlmGOSyLpSx2lA_1752805905
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e095227f5dso252777585a.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 19:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752805905; x=1753410705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaZLU4GKhmRux2+I10jXp65n20V7jWRI51gsD8E69t4=;
        b=o/Ser71yNPYsn9Faji+fslo9mV8d1yqY9nU4SIV7eEfcyKe1uGsSvc82RGH2D1vpeB
         dSaqKvt9rMQWf/JWruYhpaXeZQ4LDiJs9AnMAIUhKxdUHP/DGpnFgHGFeFcDftvTIqB1
         cEk1SD053b7HjFq7UI3vmEQ87USH7n66YKVPaaLXlrt8rxWaVh5ey5ZRAiRltZXDJBTW
         uZj4INL8cVqy1wbPlgkou3rYDv4+XJER2ss0tIALdk/o+sOlsb7iwE180QdgEw4lA+0M
         joK8rG3n7+l2EU7mSudYla+53iHTYcx2gmZjvpQiXVG8cjilf+dcZ33P1tKbq2oXPHVu
         voIA==
X-Forwarded-Encrypted: i=1; AJvYcCXHOQShwStQ/gwPZzZ7CfzHfTbJ+QWlQQvaU4J+iHa5NgKr4tSlRlpn2i+MbU0R0k7MqpXnkQwuPNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypNeUGaZqnYMdt5GEOnh2MHQ114CZJawqw+tPnpqX4bK+4f2YH
	cwdISLenPvCq5pTZDNhVpBkFR5HEAtYlT2TfLywkONK2KMvZWlF34VCB3yZEQL4jt4p8DUpWSGq
	QT2arqk0zLQhALd4hGgjGQHl10tuxpJNAGHuMssVMD+IdaUYCC0MEBkoPTm+Jqg==
X-Gm-Gg: ASbGncv+ynPyWRgRk0Jk1H4FNdEgRbyVSHEFXdA0kpfrqV3O6akGrofVKtq0V1IKfVo
	1LSqhCpDDJ50AcJzVhmnrp2QppLDC5cBYTESL1xfiMXf0c3GAt9i6vFc/PwjoSsWcu5/A1IuUkP
	LaMg9JeeAM8V3eXJgS8HnAWn6YWxCIV6sxZmwQhcSUG34aFO0D1kI7fmdw8cuqJhMdI0+bnaGPJ
	NH/OLOYBI0BzvVDMykqeDcaAMvmHMN+KNHt+HKVKCyZWpnjfGHVPuvj1z3j+FdQoDOdTUiaJvQt
	37HRhGLWKrt7PKx5WY/2Vm3+Mr2/4lU0xMLqWFkd
X-Received: by 2002:a05:620a:6007:b0:7d4:3bcc:85bf with SMTP id af79cd13be357-7e342a5eda7mr1167332685a.12.1752805904769;
        Thu, 17 Jul 2025 19:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ7WNmhYxeTKTnJvjyZYFdY4Uy7qNdAA+omyn3onwql37C/+HhiaajQ3N5wll13LWDMCOCqQ==
X-Received: by 2002:a05:620a:6007:b0:7d4:3bcc:85bf with SMTP id af79cd13be357-7e342a5eda7mr1167330085a.12.1752805904357;
        Thu, 17 Jul 2025 19:31:44 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c9155csm34859285a.95.2025.07.17.19.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 19:31:43 -0700 (PDT)
Message-ID: <2cb00715-bfa8-427a-a785-fa36667f91f9@redhat.com>
Date: Thu, 17 Jul 2025 22:31:42 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] iommu: Compute iommu_groups properly for PCIe
 switches
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <0-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
 <3-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
 <20250701132905.67d29191.alex.williamson@redhat.com>
 <20250702010407.GB1051729@nvidia.com>
 <c05104a1-7c8e-4ce9-bfa3-bcbc8c9e0ef5@redhat.com>
 <20250717202744.GA2250220@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250717202744.GA2250220@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/17/25 4:27 PM, Jason Gunthorpe wrote:
> On Thu, Jul 17, 2025 at 03:25:35PM -0400, Donald Dutile wrote:
>>> What does a multi-function root port with different ACS flags even
>>> mean and how should we treat it? I had in mind that the first root
>>> port is the TA and immediately goes the IOMMU.
>>>
>> I'm looking for clarification what you are asking...
>>
>> when you say 'multi-function root port', do you mean an RP that is a function
>> in a MFD in an RC ?  other?  A more explicit (complex?) example be given to
>> clarify?
> 
> A PCIE Root port with a downstream bus that is part of a MFD.
> 
> Maybe like this imaginary thing:
> 
> 00:1f.0 ISA bridge: Intel Corporation C236 Chipset LPC/eSPI Controller (rev 31)
> 00:1f.2 Memory controller: Intel Corporation 100 Series/C230 Series Chipset Family Power Management Controller (rev 31)
> 00:1f.3 Audio device: Intel Corporation 100 Series/C230 Series Chipset Family HD Audio Controller (rev 31)
> 00:1f.4 SMBus: Intel Corporation 100 Series/C230 Series Chipset Family SMBus (rev 31)
> 00:1f.5 PCI bridge: Intel Corporation 100 Series/C230 Series Chipset Family PCI Express Root Port #17 (rev f1)
> 
>> IMO, the rule of MFD in an RC applies here, and that means the per-function ACS rules
>> for an MFD apply -- well, that's how I read section 6.12 (PCIe 7.0.-1.0-PUB).
>> This may mean checking ACS P2P Egress Control.  Table 6-11 may help wrt Egress control bits & RPs & Fcns.
> 
> The spec says "I donno"
> 
>   Implementation of ACS in RCiEPs is permitted but not required. It is
>   explicitly permitted that, within a single Root Complex, some RCiEPs
>   implement ACS and some do not. It is strongly recommended that Root
>   Complex implementations ensure that all accesses originating from
>   RCiEPs (PFs, VFs, and SDIs) without ACS support are first subjected to
>   processing by the Translation Agent (TA) in the Root Complex before
> 
> "strongly recommended" is not "required".
> 
A bridge (00:1f.5) is not an EndPt(RCiEP). Thus the above doesn't apply to it.
[A PF, VF or SDI can be a RCiEP -- 00:1f.3, 00:1f.2 ]

>> If no (optional) ACS P2P Egress control, and no other ACS control, then I read/decode
>> the spec to mean no p2p btwn functions is possible, b/c if it is possible, by spec,
>> it must have an ACS cap to control it; ergo, no ACS cap, no p2p capability/routing.
> 
> Where did you see this? Linux has never worked this way, we have
> extensive ACS quirks specifically because we've assumed no ACS cap
> means P2P is possible and not controllable.
> 
e.g., Section 6.12.1.2 ACS Functions in SR-IOV, SIOV, and Multi-Function Devices
  ...
  ACS P2P Request Redirect: must be implemented by Functions that support peer-to-peer traffic with other Functions.
                            ^^^^

It's been noted/stated/admitted that MFDs have not followed the ACS rules, and thus the quirks may/are needed.

Linux default code should not be opposite of the spec, i.e., if no ACS, then P2P is possible, thus all fcns are part of an IOMMU group.
The spec states that ACS support must be provided if p2p traffic with other functions is supported.


> Jason
> 


