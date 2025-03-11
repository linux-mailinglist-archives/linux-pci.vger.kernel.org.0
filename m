Return-Path: <linux-pci+bounces-23417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CECA5BE38
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 11:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C61A3A7105
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7115D2505AC;
	Tue, 11 Mar 2025 10:51:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5FB2222CA
	for <linux-pci@vger.kernel.org>; Tue, 11 Mar 2025 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690290; cv=none; b=N82eOUwasgCT57AEtrfybma7LpEz8eZPaozIHyMf/QrZU5FHafNrGan4hsmRW3vWsdWPJttnJKkkTdFl/iNfzvFACrg4hIllsCY5t0d9vC1kNnJgiBtFzQzy1+F6ZWTDRBiGu1yj9aiUt9u/2/cBaijEMJ7STi99snXVBO3yrnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690290; c=relaxed/simple;
	bh=8gBmuF02AyP2VSLO8tV8drSilNu4K2BlY9BFFhnDKgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCo3q7KGiCDFJZYgM3IIjAc9sAyFqqzJnkt9rq+Nv8hZAFKaXGDK5kWBF5MPrQpy6iNwmVnIGXhutQa/2/iMvbiGOfvRE2gSKpyQAFSJySWlqQLrokuz/xp1dY+ewerUiLFR7WNYTonXOXj3k18KxCSHPOkqLbBmTHHpvUp/jzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69CD1152B;
	Tue, 11 Mar 2025 03:51:38 -0700 (PDT)
Received: from [10.57.40.127] (unknown [10.57.40.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A953A3F673;
	Tue, 11 Mar 2025 03:51:25 -0700 (PDT)
Message-ID: <032cd284-1b0e-4d52-94d8-e37fc9a759fc@arm.com>
Date: Tue, 11 Mar 2025 10:51:24 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] PCI/IDE: Add IDE establishment helpers
Content-Language: en-GB
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, gregkh@linuxfoundation.org,
 linux-pci@vger.kernel.org
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107250147.1288555.16948528371146013276.stgit@dwillia2-xfh.jf.intel.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <174107250147.1288555.16948528371146013276.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dan

On 04/03/2025 07:15, Dan Williams wrote:
> There are two components to establishing an encrypted link, provisioning
> the stream in Partner Port config-space, and programming the keys into
> the link layer via IDE_KM (IDE Key Management). This new library,
> drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
> driver, is saved for later.
> 
> With the platform TSM implementations of SEV-TIO and TDX Connect in mind
> this library abstracts small differences in those implementations. For
> example, TDX Connect handles Root Port register setup while SEV-TIO
> expects System Software to update the Root Port registers. This is the
> rationale for fine-grained 'setup' + 'enable' verbs.
> 
> The other design detail for TSM-coordinated IDE establishment is that
> the TSM may manage allocation of Stream IDs, this is why the Stream ID
> value is passed in to pci_ide_stream_setup().
> 
> The flow is:
> 
> pci_ide_stream_alloc()
>    Allocate a Selective IDE Stream Register Block in each Partner Port
>    (Endpoint + Root Port), and reserve a host bridge / platform stream
>    slot. Gather Partner Port specific stream settings like Requester ID.
> pci_ide_stream_register()
>    Publish the stream in sysfs after allocating a Stream ID. In the TSM
>    case the TSM allocates the Stream ID for the Partner Port pair.
> pci_ide_stream_setup()
>    Program the stream settings to a Partner Port. Caller is responsible
>    for optionally calling this for the Root Port as well if the TSM
>    implementation requires it.
> pci_ide_stream_enable()
>    Run the stream after IDE_KM.
> 
> In support of system administrators auditing where platform, Root Port,
> and Endpoint IDE stream resources are being spent, the allocated stream
> is reflected as a symlink from the host bridge to the endpoint with the
> name:
> 
>      stream%d.%d.%d:%s
> 
> Where the tuple of integers reflects the allocated platform, Root Port,
> and Endpoint stream index (Selective IDE Stream Register Block) values,
> and the %s is the endpoint device name.
> 
> Thanks to Wu Hao for a draft implementation of this infrastructure.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   .../ABI/testing/sysfs-devices-pci-host-bridge      |   32 ++
>   drivers/pci/ide.c                                  |  352 ++++++++++++++++++++

...

> +
> +static struct pci_ide_partner *to_settings(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	if (!pci_is_pcie(pdev)) {
> +		pci_warn_once(pdev, "not a PCIe device\n");
> +		return NULL;
> +	}
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		if (pdev != ide->pdev) {
> +			pci_warn_once(pdev, "setup expected Endpoint: %s\n", pci_name(ide->pdev));
> +			return NULL;
> +		}
> +		return &ide->partner[PCI_IDE_EP];
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +		struct pci_dev *rp = pcie_find_root_port(ide->pdev);

My (relatively old) compiler complains about this:

drivers/pci/ide.c: In function ‘to_settings’:
drivers/pci/ide.c:322:3: error: a label can only be part of a statement 
and a declaration is not a statement
   322 |   struct pci_dev *rp = pcie_find_root_port(ide->pdev);
       |   ^~~~~~

$ gcc -v
...
Target: aarch64-none-linux-gnu
...
gcc version 10.3.1 20210621 (GNU Toolchain for the A-profile 
Architecture 10.3-2021.07 (arm-10.29))

Works fine on a later version of the GCC (version 12.2)

The following hunk fixes the build for me.

diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 0c72985e6a65..f6f4cb71307d 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -318,15 +318,16 @@ static struct pci_ide_partner *to_settings(struct 
pci_dev *pdev, struct pci_ide
                         return NULL;
                 }
                 return &ide->partner[PCI_IDE_EP];
-       case PCI_EXP_TYPE_ROOT_PORT:
+       case PCI_EXP_TYPE_ROOT_PORT: {
                 struct pci_dev *rp = pcie_find_root_port(ide->pdev);

-               if (pdev != pcie_find_root_port(ide->pdev)) {
+               if (pdev != rp) {
                         pci_warn_once(pdev, "setup expected Root Port: 
%s\n",
                                       pci_name(rp));
                         return NULL;
                 }
                 return &ide->partner[PCI_IDE_RP];
+       }


Suzuki

