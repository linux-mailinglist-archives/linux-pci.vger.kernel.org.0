Return-Path: <linux-pci+bounces-10192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 384E592F331
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 02:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE871F2302D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 00:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26641FB4;
	Fri, 12 Jul 2024 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbpzlSAy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A9B1FAA;
	Fri, 12 Jul 2024 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720745405; cv=none; b=iLxARLvmEpuTV5+QE8R7ZbTICi9uMeTUAJV2v2jqFlWmwY1cLxwDLB1OKW3KHH+8UQ9Chk5vfLMv0/5vtuqAbGOq5FPY0MQnhI+P4/uScY1c2ZYQzluNctMPtEnbc1W/D0OBsSKtnkrJ1Ak2QApdP8oBc3dAt4jjbbibOaInETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720745405; c=relaxed/simple;
	bh=AKWe8Qn+JgzF6EdSjkIYwomkBKCf8Qjz/jTgKFuw+A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqDE8V/2O4K7Kk+f/LdrfdES0bbYe/2BYwaoFCPyF/NDy81hqDFePDqzWIICuSfBe01rjwEM57dVhIbCzkWJMIIOkn4aeEowo501tmVO+taUpeVRI5UmXkyx0FbwLgew7st2JdCN9eBR5E1RZkXtxcva78zHK2WdmDDGuHArigM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbpzlSAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B95C116B1;
	Fri, 12 Jul 2024 00:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720745405;
	bh=AKWe8Qn+JgzF6EdSjkIYwomkBKCf8Qjz/jTgKFuw+A4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HbpzlSAyX8ew9mMjrJxUSRnedThOaZaG/esRSUjytCAr8KcAr2xKAlwZwz75GCDci
	 LHUIOvcxTWYEIDYDP4/iUvN5Ni/7dF7mkibK9bM0g6UpIFjuqeaHgkXkBFJ1WDrBy1
	 2RS7dNvs7j7ZauC/S6qCn3g2fpSycqr5gUiaMoY4bGvgsHIRQH8yodaWjLHUnifJcH
	 I2DXnIs7hQshTRrZTzh7xV6TVLgVjmMtYzp8257v/AoV/wPK9NN1HhByB5PKGj4Ofa
	 gsjWQBKeHPbEKRuWpOSpEDGXR9QMUUv9UFCiBbGyMzThpXhirN0U8XBKEOE0BOgGPT
	 cl57zrxFnJKog==
Message-ID: <75b8e594-01e8-4b5c-aa31-810845f894da@kernel.org>
Date: Fri, 12 Jul 2024 09:50:00 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
To: Dan Williams <dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxarm@huawei.com,
 David Box <david.e.box@intel.com>, "Li, Ming" <ming4.li@intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Alexey Kardashevskiy
 <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>,
 Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>,
 Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>,
 Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/12/24 02:50, Dan Williams wrote:
> Lukas Wunner wrote:
>> On Tue, Jul 09, 2024 at 04:31:30PM -0700, Dan Williams wrote:
>>> Non-authenticated operation is the status quo. CMA is a building block
>>> to other security features.
>>
>> That's not quite correct:  Products exist which support CMA but neither
>> IDE nor TDISP.  CMA is not just a building block for IDE or TDISP,
>> but is useful on its own merits.
> 
> Agree it is useful. The use case of signed device inventory at a CSP,
> that I understand storage vendors are interested, does not demand
> aggressive forced authentication of all PCI devices in early init. As far
> as I understand the non PCI-CMA consumers of lib/spdm/ are going to be
> drivers possibly built as modules.

Yes, and they already are: SCSI/ATA and NVMe command transport for SPDM is being
defined (SPDM-over-storage using the SECURITY IN/OUT for SCSI and SECURITY
SEND/RECV commands for NVMe). Authentication of such storage device will require
the device driver to be loaded first and the device to be scanned and probed to
discover this feature. So SPDM authentication in this case would not even happen
early in the device initialization process as we will need the device to already
be functional to issue the security commands.

For PCIe/DOE devices (which could be PCIe NVMe devices not using
SPDM-over-storage), I do not see why we cannot also do the authentication from
the device driver context. As you suggested, pci_enable_device() context could
be the right place to do that, if the device driver opts-in (and that can be
driven by distro config).

This would result in all calls to lib/spdm authentication for all devices to
happen at the same timing, i.e. device driver initialization, whenever that
happens (at boot with kernel built-in or modules loaded later).

This approach would also likely facilitate handling re-authentication on resume
since that also involves the device driver, at least for the SPDM-over-storage
case (e.g. OPAL device locking/unlocking for SCSI already has code to be
suspend/resume aware).

-- 
Damien Le Moal
Western Digital Research


