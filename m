Return-Path: <linux-pci+bounces-39573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4DEC16B72
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 21:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56B23ACACC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 20:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51498350D58;
	Tue, 28 Oct 2025 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WSY+NiP9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7E34FF70
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681719; cv=none; b=mGqi6pPQbcbsJZhx1yK2Iz/RiuPZ4PBF/r7bphVbyGiKrz8pzfpmeBMxxeiM61qrCIgeFNaMVAMVe9CpdfoM7aCYTa2s/cK0rx+Vp00zXBUqZGs9M6Fvbvt2gR1ns71ZaM6+z6lPPLJsakNzC0dU33aATwaUnzlnfiBY5eBH73Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681719; c=relaxed/simple;
	bh=vy/2BFyxrURtJGpqMFUVBMusirEky6Bfx+SPD0xfX6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5Y0FIlKDbTMcCKW0miRmgoRsE//YxZraus2bkXQkgsiuzVr66EwP2gsMEk8XjHoMXOAT88eUfKkkumAh4Egx+wtuP7RAB4p5eluVa4arj3LnJrsA5hwFsCJS9JxKH4hkyDtYFVdy52Ra8kz6enkMvjMk94WsIKYCwg3/FFJ6S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WSY+NiP9; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-5db1e29edbcso3616200137.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 13:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681716; x=1762286516;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wwzCwoll9urQFzaJ2w/bQYJFP3bpkFcySIlakUGODA=;
        b=lWNX7JApeJQbYLcGQRiWrmj5LarczLXUzOGLddvMb7KCDWgb6ER+V+ju6+GdfH7Gsq
         mCdxqLebjNRY0v/Peu0yM0xyDt4f2AlMDmUkKn494iYok54NnekL5JyjtUJGJFtgJjk2
         nuA7JPj34N39Oo724LuDFKiAi9Wep6MxfYKri0xIQoW1kiilI2UNs+UBjDf4CmUDWEAS
         eP2nOMUEdl+TEmYopZaUlMw47kR9+OZAIHy97HDV3k25bePXAHjxSkblyR1bsJPXq+7M
         jGSJYtPTqDeTaerx1R6L07YB9AN7sqN1wdcIU75xZgyoWwkxHfXLHxgu3d9HBG8+DJPk
         zUCw==
X-Gm-Message-State: AOJu0Yw97icauCZNMSGgI/F+t86iN4xLpayMqUzHA5LZkytz2sakiqVO
	4S8saUA1RDev/hEFexFgJi9iE4wGUVddMRUvZOukNr6FhWPoMnGYoLoMjzyW676AdK3yr9kzwlS
	l0ORUKQp19z2ZszH/GpQPjeCD8NdLCiTFGKxzgWJVHT2vfla8LsyHDqt203F2FBcKSX92OlWJcx
	CKWP+dbPztyFSerpFa6/I4GuwP0nb97is+k4JdVl4m9K4U113yZ59Znny/xHY9x0DWFgGvr9Qrn
	XMt/LH0Um+COjEl
X-Gm-Gg: ASbGnctCv0Hx3m5vjhvSR4p6Jf4bws721wB8O/4q5J/nf9a3Dn+1MsC6uEWcefdnzLb
	fGWzRg8dERBosSWK99glPnO0F0TzxNWPkeUX9FJkI5F6Ev0FUpqORvlGkmstT5lXUgqlL0I5xrr
	AcXqZVGNTVU4EsN75hMNMmfifld+Bhqf3shhe2qsyGmJ6Nu3MiGA/VaaLxPbNI8D0UPSEaE3JBZ
	JOJ11lcVgUhf2jgPjBewoXcRTF+sO34irBrAOyBWuBzn6QrRrZrFK2GAq1ZhjvnTjupf53G7Dpj
	VcsN3jgK7mAwPywe62kChmB7k++k3j0/riTU7aEm5XbLZFWG6pt2trXaDSmg4KjYA9S0Qwj6WSf
	jJIGUEv6hnvw2vammDiJl8IYI1sHFpkLNAhBx/f+KIGq26DRpwX8QAljqNpQVYV94MWzh2yaLQk
	mN+EBpiYCsGJ1Qw3u4E1hvJwTKV+cwVc7fCz0ggg==
X-Google-Smtp-Source: AGHT+IGHwUYggXn//B78T+yUFpXArkB6EFVTOmgv4lk9JfsyMszHyFPUitrppbbMZMKuGl78pQqvMekNDyAM
X-Received: by 2002:a05:6102:80a0:b0:5db:2f62:c15 with SMTP id ada2fe7eead31-5db9069da0fmr104777137.41.1761681716067;
        Tue, 28 Oct 2025 13:01:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-934c3fb35f3sm285496241.3.2025.10.28.13.01.55
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2025 13:01:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6cdfcb112bso12383619a12.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 13:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761681715; x=1762286515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7wwzCwoll9urQFzaJ2w/bQYJFP3bpkFcySIlakUGODA=;
        b=WSY+NiP9PW6lr5AXn8ubguWK2/Z/zSykoKKYWvWgtpo0fjGIPuTPqmuNRVh+1KB53u
         BWqvhmPn4ylWP1mb0F0U/uPSVPxLURdyzr4Q0oKL+W172xS2H5FIEthK9e9JH+pnpgis
         +O1pGF3cMNChXcuR/6B+iegsAcFhGhAzdzUKQ=
X-Received: by 2002:a17:902:f681:b0:265:89c:251b with SMTP id d9443c01a7336-294dee98e93mr4778815ad.29.1761681714401;
        Tue, 28 Oct 2025 13:01:54 -0700 (PDT)
X-Received: by 2002:a17:902:f681:b0:265:89c:251b with SMTP id d9443c01a7336-294dee98e93mr4778465ad.29.1761681713837;
        Tue, 28 Oct 2025 13:01:53 -0700 (PDT)
Received: from [10.28.17.173] ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d30030sm124568435ad.65.2025.10.28.13.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 13:01:53 -0700 (PDT)
Message-ID: <5ca0b4a2-ec3a-4fa5-a691-7e3bab88890a@broadcom.com>
Date: Tue, 28 Oct 2025 16:01:50 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: brcmstb: Fix use of incorrect constant
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251022224553.GA1271981@bhelgaas>
Content-Language: en-US
From: James Quinlan <james.quinlan@broadcom.com>
Autocrypt: addr=james.quinlan@broadcom.com; keydata=
 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
In-Reply-To: <20251022224553.GA1271981@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/22/25 18:45, Bjorn Helgaas wrote:
> On Fri, Oct 03, 2025 at 01:04:36PM -0400, Jim Quinlan wrote:
>> The driver was using the PCIE_LINK_STATE_L1 constant as a field mask for
>> setting the private PCI_EXP_LNKCAP register, but this constant is
>> Linux-created and has nothing to do with the PCIe spec.  Serendipitously,
>> the value of this constant was correct for its usage until after 6.1, when
>> its value changed from BIT(1) to BIT(2);
>> ...
>>   #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
>>   #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK	0x1f0
>> -#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
> This all tangential questions for possible future changes, not
> anything for *this* patch.
>
> We have these in include/uapi/linux/pci_regs.h:
>
>    #define PCI_EXP_LNKCAP          0x0c    /* Link Capabilities */
>    #define  PCI_EXP_LNKCAP_MLW     0x000003f0 /* Maximum Link Width */
>    #define  PCI_EXP_LNKCAP_ASPMS   0x00000c00 /* ASPM Support */
>    #define  PCI_EXP_LNKCAP_ASPM_L0S 0x00000400 /* ASPM L0s Support */
>
> Since you're using PCI_EXP_LNKCAP_ASPM_L0S below for writes to
> PCIE_RC_CFG_PRIV1_LINK_CAPABILITY, I assume
> PCIE_RC_CFG_PRIV1_LINK_CAPABILITY is another name for PCI_EXP_LNKCAP?
yes and no, see below.
>
> If so, it looks like we should also use PCI_EXP_LNKCAP_MLW instead of
> PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK (although the
> value is different for some reason; maybe 0x1f0 just reflects the
> limits of brcmstb).
>
> It would be nice to have a #define for the base of the PCIe
> Capability so we could use that plus PCI_EXP_LNKCAP instead of
> PCIE_RC_CFG_PRIV1_LINK_CAPABILITY.

Hi Bjorn,

I believe this has come up before.  Our "priv" registers should be exact 
mirrors of standard PCI config space registers to allow us to set RO 
fields.  Unfortunately, sometimes the "priv" fields do not exactly match 
the standard version.

As you have noticed, our field for MAX_LINK_WIDTH_MASK is 0x1f0 instead 
of 0x3f0.  The reason for this is not necessarily a BRCM limitation; our 
priv register has a CPM field mask of 0x200 (!) instead of where you 
would expect: 0x40000.  Further, everything in this priv register is 
different from its counterpart from bit 18 and higher.

> But you did something like that already for PCI_EXP_LNKCTL2 using
> BRCM_PCIE_CAP_REGS (0x00ac), which means LNKCTL2 and LNKCAP must be
> at:
>
>    LNKCTL2: 0x00dc (0x00ac + 0x30)
>    LNKCAP:  0x04dc (0x04d0 + 0x0c)
>
> which doesn't look at all like they would both be in the actual PCIe
> Capability format.
>
>>   #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
>>   #define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK	0xf8

Just like the fields of our "priv" registers may be non-standard, so may 
be the addresses of our "priv" registers.  The first few registers are 
in the same order as EXP_CAP, but then the rest are not, so using 
standard offsets does not work.

I don't know why HW did these things.  I can add a comment to the code 
like "priv register addresses and fields may not correspond to standard 
PCI registers".

Regards,

Jim Quinlan

Broadcom STB/CM

>  From its usage to "un-advertise L1 substates",
> PCIE_RC_CFG_PRIV1_ROOT_CAP looks like it might be related to
> PCI_L1SS_CAP, but 0xf8 doesn't really match up to
> PCI_L1SS_CAP_L1_PM_SS (0x10)
>
> If this is really related to PCI_L1SS_CAP, can we use the names from
> pci_regs.h somehow?
>>   	/* Don't advertise L0s capability if 'aspm-no-l0s' */
>> -	aspm_support = PCIE_LINK_STATE_L1;
>> -	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
>> -		aspm_support |= PCIE_LINK_STATE_L0S;
>>   	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
>> -	u32p_replace_bits(&tmp, aspm_support,
>> -		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
>> +	if (of_property_read_bool(pcie->np, "aspm-no-l0s"))
>> +		tmp &= ~PCI_EXP_LNKCAP_ASPM_L0S;
>>   	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
>>   
>>   	/* 'tmp' still holds the contents of PRIV1_LINK_CAPABILITY */



