Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C3A42A811
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 17:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhJLPUK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 11:20:10 -0400
Received: from office.oderland.com ([91.201.60.5]:54686 "EHLO
        office.oderland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbhJLPUJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Oct 2021 11:20:09 -0400
Received: from [193.180.18.161] (port=38880 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <josef@oderland.se>)
        id 1maJXZ-005qGI-W8; Tue, 12 Oct 2021 17:18:06 +0200
Message-ID: <29bb9284-668a-8ccf-7727-1e1f0857a0ed@oderland.se>
Date:   Tue, 12 Oct 2021 17:17:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101
 Thunderbird/93.0
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION
 (MCP79)
Content-Language: en-US
From:   Josef Johansson <josef@oderland.se>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, maz@kernel.org,
        linux-pci@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
 <b023adf9-e21c-59ac-de49-57915c8cede8@oderland.se>
 <c9218eb4-9fc1-28f4-d053-895bab0473d4@oderland.se>
 <ef163327-f965-09f8-4396-2c1c4e689a6d@oderland.se>
 <CAKf6xpvGyCKVHsvauP54=0j10fxis4XiiqBNWH+1cpkbtt_QJw@mail.gmail.com>
 <fdfb6267-e467-4785-b4a0-00859f6dc161@oderland.se>
In-Reply-To: <fdfb6267-e467-4785-b4a0-00859f6dc161@oderland.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - office.oderland.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oderland.se
X-Get-Message-Sender-Via: office.oderland.com: authenticated_id: josjoh@oderland.se
X-Authenticated-Sender: office.oderland.com: josjoh@oderland.se
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/12/21 15:33, Josef Johansson wrote:
> On 10/12/21 15:07, Jason Andryuk wrote:
>> On Tue, Oct 12, 2021 at 2:09 AM Josef Johansson <josef@oderland.se> wrote:
>>> On 10/11/21 21:34, Josef Johansson wrote:
>>>> On 10/11/21 20:47, Josef Johansson wrote:
>>>>> More can be read over at freedesktop:
>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/1715
>> Hi, Josef,
>>
>> If you compare
>> commit fcacdfbef5a1633211ebfac1b669a7739f5b553e "PCI/MSI: Provide a
>> new set of mask and unmask functions"
>> and
>> commit 446a98b19fd6da97a1fb148abb1766ad89c9b767 "PCI/MSI: Use new
>> mask/unmask functions" some of the replacement functions in 446198b1
>> no longer exit early for the pci_msi_ignore_mask flag.
>>
>> Josef, I'd recommend you try adding pci_msi_ignore_mask checks to the
>> new functions in fcacdfbef5a to see if that helps.
>>
>> There was already a pci_msi_ignore_mask fixup in commit
>> 1a519dc7a73c977547d8b5108d98c6e769c89f4b "PCI/MSI: Skip masking MSI-X
>> on Xen PV" though the kernel was crashing in that case.
>>
>> Regards,
>> Jason
> Hi Jason,
>
> Makes sense. I am compiling now, will try it as soon as it's done.
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 0099a00af361..620928fd0065 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -148,6 +148,9 @@ static noinline void pci_msi_update_mask(struct
> msi_desc *desc, u32 clear, u32 s
>      raw_spinlock_t *lock = &desc->dev->msi_lock;
>      unsigned long flags;
>  
> +    if (pci_msi_ignore_mask)
> +        return;
> +
>      raw_spin_lock_irqsave(lock, flags);
>      desc->msi_mask &= ~clear;
>      desc->msi_mask |= set;
> @@ -179,6 +182,9 @@ static inline void __iomem
> *pci_msix_desc_addr(struct msi_desc *desc)
>   */
>  static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
>  {
> +    if (pci_msi_ignore_mask)
> +        return;
> +
>      void __iomem *desc_addr = pci_msix_desc_addr(desc);
>  
>      writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
> @@ -186,6 +192,9 @@ static void pci_msix_write_vector_ctrl(struct
> msi_desc *desc, u32 ctrl)
>  
>  static inline void pci_msix_mask(struct msi_desc *desc)
>  {
> +    if (pci_msi_ignore_mask)
> +        return;
> +
>      desc->msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
>      pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
>      /* Flush write to device */
> @@ -194,6 +203,9 @@ static inline void pci_msix_mask(struct msi_desc *desc)
>  
>  static inline void pci_msix_unmask(struct msi_desc *desc)
>  {
> +    if (pci_msi_ignore_mask)
> +        return;
> +
>      desc->msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
>      pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
>  }
>
I love open source. It just works. Was my patch correct btw?

Thanks Jason!

Regards

- Josef

