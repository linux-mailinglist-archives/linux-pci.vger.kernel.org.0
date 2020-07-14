Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AD021F629
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 17:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgGNP2V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 11:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgGNP2V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 11:28:21 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C4F221EF;
        Tue, 14 Jul 2020 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594740500;
        bh=0qquT16fbcjpcUrLJKMrlKrFGQbbIFMbuB4UG5jOkoQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=s1oowI9A4zRjsuRhByPYU2IrrGnkDzB0e+M9tL3W4uY4Rz+xdKSfXXT4Ue6GjN2qv
         k3EdVfrMqa/6dnaH9VVyFBbnQlhp00QqYfN6yPhYsbyjQnA/oiP9zs3o9bygbRQqsm
         +6CcnZaGf485FQr8AgvdkPuTOpEYayWlrnj6c85k=
Date:   Tue, 14 Jul 2020 10:28:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     alex.williamson@redhat.com, herbert@gondor.apana.org.au,
        cohuck@redhat.com, nhorman@redhat.com, vdronov@redhat.com,
        bhelgaas@google.com, mark.a.chambers@intel.com,
        gordon.mcfadden@intel.com, ahsan.atta@intel.com,
        qat-linux@intel.com, kvm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] PCI: Add Intel QuickAssist device IDs
Message-ID: <20200714152818.GA395763@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714063610.849858-2-giovanni.cabiddu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 14, 2020 at 07:36:06AM +0100, Giovanni Cabiddu wrote:
> Add device IDs for the following Intel QuickAssist devices: DH895XCC,
> C3XXX and C62X.
> 
> The defines in this patch are going to be referenced in two independent
> drivers, qat and vfio-pci.
> 
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci_ids.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 0ad57693f392..f3166b1425ca 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2659,6 +2659,8 @@
>  #define PCI_DEVICE_ID_INTEL_80332_1	0x0332
>  #define PCI_DEVICE_ID_INTEL_80333_0	0x0370
>  #define PCI_DEVICE_ID_INTEL_80333_1	0x0372
> +#define PCI_DEVICE_ID_INTEL_QAT_DH895XCC	0x0435
> +#define PCI_DEVICE_ID_INTEL_QAT_DH895XCC_VF	0x0443
>  #define PCI_DEVICE_ID_INTEL_82375	0x0482
>  #define PCI_DEVICE_ID_INTEL_82424	0x0483
>  #define PCI_DEVICE_ID_INTEL_82378	0x0484
> @@ -2708,6 +2710,8 @@
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI     0x1577
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE  0x1578
>  #define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
> +#define PCI_DEVICE_ID_INTEL_QAT_C3XXX	0x19e2
> +#define PCI_DEVICE_ID_INTEL_QAT_C3XXX_VF	0x19e3
>  #define PCI_DEVICE_ID_INTEL_82840_HB	0x1a21
>  #define PCI_DEVICE_ID_INTEL_82845_HB	0x1a30
>  #define PCI_DEVICE_ID_INTEL_IOAT	0x1a38
> @@ -2924,6 +2928,8 @@
>  #define PCI_DEVICE_ID_INTEL_IOAT_JSF7	0x3717
>  #define PCI_DEVICE_ID_INTEL_IOAT_JSF8	0x3718
>  #define PCI_DEVICE_ID_INTEL_IOAT_JSF9	0x3719
> +#define PCI_DEVICE_ID_INTEL_QAT_C62X	0x37c8
> +#define PCI_DEVICE_ID_INTEL_QAT_C62X_VF	0x37c9
>  #define PCI_DEVICE_ID_INTEL_ICH10_0	0x3a14
>  #define PCI_DEVICE_ID_INTEL_ICH10_1	0x3a16
>  #define PCI_DEVICE_ID_INTEL_ICH10_2	0x3a18
> -- 
> 2.26.2
> 
