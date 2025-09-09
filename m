Return-Path: <linux-pci+bounces-35720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D44B4A10E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 07:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525DB163A4E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 05:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412FD2E8E11;
	Tue,  9 Sep 2025 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5m0jrqU"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9823C4FA
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 05:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394078; cv=none; b=gEWsKP2Gz8ayrBXdS3I9rNeKDtNBwdPtDyfTp3Q71/ggHtfl18bMQof7Y2hP3DlZ+26PctDb+FVxt2dUTVwPUkSoQe2jPUK7IY5BDsM4sEInygY0NcsAt62oEAj2o3lq7Q+Ly3NSYdM9tWDysMaVHeE8rEkip/RFmWmNCCm7Zps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394078; c=relaxed/simple;
	bh=MyQD77cAjsx3koLkQL4dZ/lIFxkKOLlM485XRyjXANQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8DfqxI/ytuY/MUU7uwZndwwfonL+mzsGlb2NK/YbQV/C5oM63MPvdnd3+Vjx++dG0o3I9uuj6xwZnxLsizEJk4usQvPf7jO/043cqTY+PTcxJCeqd/SD5D+c/HfzDMy17VpzMSf65qFqpHseAlZuCBuwExwN3/pEF5TO8pcUMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5m0jrqU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757394075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmM7ymHL/oEefvbkHXDJF00eQsWO67ZJ3ZKRSeokg8I=;
	b=a5m0jrqUL4kREIzvi6JJ8vRb11/vyPfedJrgBjglB8RsgtvHjty42Li5El4ZxZbuDJCAh5
	FNkddiv6540CUjbncu7xoBFRS+W/Kxs1/ScSEEq10QgSolekSs4IhcoLThysTsN7Zzh9Xo
	jGIp2/NElkd8xWs3QScedGsmwVGrnKU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-BZbWYEBsMzy7IQK-HWcLyQ-1; Tue, 09 Sep 2025 01:01:14 -0400
X-MC-Unique: BZbWYEBsMzy7IQK-HWcLyQ-1
X-Mimecast-MFC-AGG-ID: BZbWYEBsMzy7IQK-HWcLyQ_1757394073
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-71fe8dd89c6so122725506d6.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Sep 2025 22:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757394073; x=1757998873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmM7ymHL/oEefvbkHXDJF00eQsWO67ZJ3ZKRSeokg8I=;
        b=MDO5SGEqDRBAU3u3JoVUXDiKFosl56xSjX7knAjxOO7WvpnC4ZhL0kxfAHv32yBYlT
         jQva5dL702n3N8Cql420un37qyiRugfbWIEcter7z/86upcxPZSFTS25d6QiC/fP052q
         1XBU1mTMTGGwDecXv/8XoN+AA8wGgvud4UwtT+Yi/y9NKfzljABESJ6oIXpcJbdrw1jM
         BTlbqIIyCixbNXaS5JyNN1F995oP0yDlmurSGE1bflesVF4brtK/DZCBpim7NjU5/8Ss
         OZzjeyzbBl5XP6APOsc3i38HqCFQ/ZJUZtGHIvUmEPRAqbWR36X2K8vtvvQLG1Fq9miV
         K48A==
X-Forwarded-Encrypted: i=1; AJvYcCUuwzrsDe0W+zlMgwM91sC9o435xNMEgJzSyPFQTL36laynXqkFoE2egQAV3JCN61nz/Pn98KCdIrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUc5tlml8iCMGU9mxhUCUbLlF/U2cXZG2uB8g9uwj7mJY2WP76
	OEmdFHmYcVeUphzdci2pcYrDRVd6aVxC644ygsuhqAmgP6MYZA+SLP12XOuQRp7zayUFEm8JRsE
	fHDv3FBL4EE8jDwlW8yr1JP8/yzY2++IjNkkQQqKnl71evFLF11YpswqbyarSuw==
X-Gm-Gg: ASbGnct43voYAmwGOEM3/7nJzbdPoihxvDIDOf0TV1yUxOTOlStse9w0UDlQTPYODra
	hMYAhgEbedcc4mskQOUrA3IfiNC/xG4Id2OXPWidEgbxZT4s7Ef67o/GZ/Ax7OVYjEH1bWzdeiv
	KNhtdx72O8p0TAnGvc3/uB/vJ796jG3fvtWSNa2EVNmYx1nFc4F0j7JRCA8XvAFuSqum0HHT0Jb
	TNIMLZNCX9HGpnzavuDrW39Z0QTcLAU1sxxJwqqtKyBgaG6Lk6hycQG7/hHfwLLJqxDS2+eYhzU
	buyru36379tw6XnOPrYsT5GG3j4ldI6cB01J7VnW
X-Received: by 2002:a05:6214:202e:b0:731:736a:bcd6 with SMTP id 6a1803df08f44-739492cd6a4mr90308166d6.65.1757394073592;
        Mon, 08 Sep 2025 22:01:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6LxTQIHgJ7KqLHWn9G0D2H5GjVpooVfL9ooFPQZ8Rx2Wu55/VAB6FIJdzOrsfvnjVbX7qXg==
X-Received: by 2002:a05:6214:202e:b0:731:736a:bcd6 with SMTP id 6a1803df08f44-739492cd6a4mr90307796d6.65.1757394073070;
        Mon, 08 Sep 2025 22:01:13 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-725dda254d4sm118146646d6.8.2025.09.08.22.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 22:01:12 -0700 (PDT)
Message-ID: <17c3072e-0c9e-48da-b236-2fefe8ebc823@redhat.com>
Date: Tue, 9 Sep 2025 01:01:11 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] PCI: Add the ACS Enhanced Capability definitions
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <8-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <8-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/25 2:06 PM, Jason Gunthorpe wrote:
> This brings the definitions up to PCI Express revision 5.0:
> 
>   * ACS I/O Request Blocking Enable
>   * ACS DSP Memory Target Access Control
>   * ACS USP Memory Target Access Control
>   * ACS Unclaimed Request Redirect
> 
> Support for this entire grouping is advertised by the ACS Enhanced
> Capability bit.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   include/uapi/linux/pci_regs.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 6095e7d7d4cc48..54621e6e83572e 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1005,8 +1005,16 @@
>   #define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
>   #define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
>   #define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
> +#define  PCI_ACS_ENHANCED	0x0080  /* IORB, DSP_MT_xx, USP_MT_XX. Capability only */
> +#define  PCI_ACS_EGRESS_CTL_SZ	GENMASK(15, 8) /* Egress Control Vector Size */
>   #define PCI_ACS_EGRESS_BITS	0x05	/* ACS Egress Control Vector Size */
>   #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
> +#define  PCI_ACS_IORB		0x0080  /* I/O Request Blocking */
> +#define  PCI_ACS_DSP_MT_RB	0x0100  /* DSP Memory Target Access Control Request Blocking */
> +#define  PCI_ACS_DSP_MT_RR	0x0200  /* DSP Memory Target Access Control Request Redirect */
> +#define  PCI_ACS_USP_MT_RB	0x0400  /* USP Memory Target Access Control Request Blocking */
> +#define  PCI_ACS_USP_MT_RR	0x0800  /* USP Memory Target Access Control Request Redirect */
> +#define  PCI_ACS_UNCLAIMED_RR	0x1000  /* Unclaimed Request Redirect Control */
>   #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */
>   
>   /*

Reviewed-by: Donald Dutile <ddutile@redhat.com>


