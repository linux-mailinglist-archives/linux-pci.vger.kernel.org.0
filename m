Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FC51BB3E4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 04:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgD1CTF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 22:19:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40060 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbgD1CTE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 22:19:04 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 76E57BEF60CBAFF6AC79;
        Tue, 28 Apr 2020 10:19:02 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 10:19:00 +0800
Subject: Re: [PATCH v4] pci: Make return value of pcie_capability_read*()
 consistent
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Saheed Bolarinwa <refactormyself@gmail.com>
References: <20200427181304.GA214573@google.com>
CC:     <bjorn@helgaas.com>, <skhan@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-mips@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <4cc16e59-d346-5523-5072-eebe77d06a08@hisilicon.com>
Date:   Tue, 28 Apr 2020 10:19:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200427181304.GA214573@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/4/28 2:13, Bjorn Helgaas wrote:
>
> I'm starting to think we're approaching this backwards.  I searched
> for PCIBIOS_FUNC_NOT_SUPPORTED, PCIBIOS_BAD_VENDOR_ID, and the other
> error values.  Almost every use is a *return* in a config accessor.
> There are very, very few *tests* for these values.

If we have certain reasons to reserve PCI_BIOS* error to identify PCI errors
in PCI drivers, maybe redefine the PCI_BIOS* to generic error codes can solve
the issues, and no need to call pcibios_err_to_errno() to do the conversion.
Few changes may be made to current codes. One possible patch may
look like below. Otherwise, maybe convert all PCI_BIOS* errors to generic error
codes is a better idea.

Not sure it's the best way or not. Just FYI.


diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cd..843987c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -675,14 +675,18 @@ static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev) { return false;
 
 /* Error values that may be returned by PCI functions */
 #define PCIBIOS_SUCCESSFUL		0x00
-#define PCIBIOS_FUNC_NOT_SUPPORTED	0x81
-#define PCIBIOS_BAD_VENDOR_ID		0x83
-#define PCIBIOS_DEVICE_NOT_FOUND	0x86
-#define PCIBIOS_BAD_REGISTER_NUMBER	0x87
-#define PCIBIOS_SET_FAILED		0x88
-#define PCIBIOS_BUFFER_TOO_SMALL	0x89
-
-/* Translate above to generic errno for passing back through non-PCI code */
+#define PCIBIOS_FUNC_NOT_SUPPORTED	-ENOENT
+#define PCIBIOS_BAD_VENDOR_ID		-ENOTTY
+#define PCIBIOS_DEVICE_NOT_FOUND	-ENODEV
+#define PCIBIOS_BAD_REGISTER_NUMBER	-EFAULT
+#define PCIBIOS_SET_FAILED		-EIO
+#define PCIBIOS_BUFFER_TOO_SMALL	-ENOSPC
+
+/**
+ * Translate above to generic errno for passing back through non-PCI code
+ *
+ * Deprecated. Use the PCIBIOS_* directly without a translation.
+ */
 static inline int pcibios_err_to_errno(int err)
 {
 	if (err <= PCIBIOS_SUCCESSFUL)
@@ -690,17 +694,12 @@ static inline int pcibios_err_to_errno(int err)
 
 	switch (err) {
 	case PCIBIOS_FUNC_NOT_SUPPORTED:
-		return -ENOENT;
 	case PCIBIOS_BAD_VENDOR_ID:
-		return -ENOTTY;
 	case PCIBIOS_DEVICE_NOT_FOUND:
-		return -ENODEV;
 	case PCIBIOS_BAD_REGISTER_NUMBER:
-		return -EFAULT;
 	case PCIBIOS_SET_FAILED:
-		return -EIO;
 	case PCIBIOS_BUFFER_TOO_SMALL:
-		return -ENOSPC;
+		return err;
 	}
 
 	return -ERANGE;


>
> For example, the only tests for PCIBIOS_FUNC_NOT_SUPPORTED are in
> xen_pcibios_err_to_errno() and pcibios_err_to_errno(), i.e., we're
> just converting that value to -ENOENT or the Xen-specific thing.
>
> So I think the best approach might be to remove the PCIBIOS_* error
> values completely and replace them with the corresponding values from
> pcibios_err_to_errno().  For example, a part of the patch would look
> like this:
>
> diff --git a/arch/mips/pci/ops-emma2rh.c b/arch/mips/pci/ops-emma2rh.c
> index 65f47344536c..d4d9c902c147 100644
> --- a/arch/mips/pci/ops-emma2rh.c
> +++ b/arch/mips/pci/ops-emma2rh.c
> @@ -100,7 +100,7 @@ static int pci_config_read(struct pci_bus *bus, unsigned int devfn, int where,
>  		break;
>  	default:
>  		emma2rh_out32(EMMA2RH_PCI_IWIN0_CTR, backup_win0);
> -		return PCIBIOS_FUNC_NOT_SUPPORTED;
> +		return -ENOENT;
>  	}
>  
>  	emma2rh_out32(EMMA2RH_PCI_IWIN0_CTR, backup_win0);
> @@ -149,7 +149,7 @@ static int pci_config_write(struct pci_bus *bus, unsigned int devfn, int where,
>  		break;
>  	default:
>  		emma2rh_out32(EMMA2RH_PCI_IWIN0_CTR, backup_win0);
> -		return PCIBIOS_FUNC_NOT_SUPPORTED;
> +		return -ENOENT;
>  	}
>  	*(volatile u32 *)(base + (PCI_FUNC(devfn) << 8) +
>  			  (where & 0xfffffffc)) = data;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 83ce1cdf5676..f95637a8d391 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -675,7 +675,6 @@ static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev) { return false;
>  
>  /* Error values that may be returned by PCI functions */
>  #define PCIBIOS_SUCCESSFUL		0x00
> -#define PCIBIOS_FUNC_NOT_SUPPORTED	0x81
>  #define PCIBIOS_BAD_VENDOR_ID		0x83
>  #define PCIBIOS_DEVICE_NOT_FOUND	0x86
>  #define PCIBIOS_BAD_REGISTER_NUMBER	0x87
> @@ -689,8 +688,6 @@ static inline int pcibios_err_to_errno(int err)
>  		return err; /* Assume already errno */
>  
>  	switch (err) {
> -	case PCIBIOS_FUNC_NOT_SUPPORTED:
> -		return -ENOENT;
>  	case PCIBIOS_BAD_VENDOR_ID:
>  		return -ENOTTY;
>  	case PCIBIOS_DEVICE_NOT_FOUND:
> .
>

