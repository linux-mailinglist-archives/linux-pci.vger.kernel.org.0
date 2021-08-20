Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F353F3649
	for <lists+linux-pci@lfdr.de>; Sat, 21 Aug 2021 00:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhHTWMh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 18:12:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231511AbhHTWMh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 18:12:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89D3F61184;
        Fri, 20 Aug 2021 22:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629497518;
        bh=HyNEEVCd9o7mWaLSVvoy4swYAPMRE2PXQmUBHU6S68M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RufoxdMHaGxZpQ0WxtWc5xXS8c3rB1DQKj+IC4Ck3jwWfCMQpXbxFz19pk3Dxam9L
         lKT4937n0VGw2EhSMwGmZhol6Mt0EqykSpaRtzNH2wq3J0LoepJLKx6qoEpvG2LqMW
         WYBBjEzi7fZN0SZw1ylcN3vhpNmhK4Mdnw9+sK3ghNQ96OK2h6QMfZWnHBWSB1Fpjj
         s6mNNuwJUeV1Qmw8b88m340FMu/tWjgvVVeA1GwIOpIvhJIP2BsTER/RXbkjqT8vBA
         5IvOD2s/ERMz6YNY/E+qopU3ERMUKGXdeenWgEOPRuokA+0ribv1XFKJkng+wrtiqJ
         1WbgjxkPd3p+g==
Date:   Fri, 20 Aug 2021 17:11:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Optimize pci_resource_len() to reduce the
 binary size of kernel
Message-ID: <20210820221157.GA3365579@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713072236.3043-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 13, 2021 at 03:22:36PM +0800, Zhen Lei wrote:
> pci_resource_end() can be 0 only when pci_resource_start() is 0.
> Otherwise, it is definitely an error. In this case, pci_resource_len()
> should be regarded as 0. Therefore, determining whether
> pci_resource_start() and pci_resource_end() are both 0 can be reduced to
> determining only whether pci_resource_end() is 0.
> 
> Although only one condition judgment is reduced, the macro function
> pci_resource_len() is widely referenced in the kernel. I used defconfig to
> compile the latest kernel on X86, and its binary code size was reduced by
> about 3KB.
> 
> Before:
>  [ 2] .rela.text        RELA             0000000000000000  093bfcb0
>       0000000001a67168  0000000000000018   I      68     1     8
> 
> After:
>  [ 2] .rela.text        RELA             0000000000000000  093bfcb0
>       0000000001a66598  0000000000000018   I      68     1     8
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Applied to pci/resource for v5.15, thanks!

> ---
>  include/linux/pci.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 540b377ca8f6..23ef1a15eb5d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1881,9 +1881,7 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma);
>  #define pci_resource_end(dev, bar)	((dev)->resource[(bar)].end)
>  #define pci_resource_flags(dev, bar)	((dev)->resource[(bar)].flags)
>  #define pci_resource_len(dev,bar) \
> -	((pci_resource_start((dev), (bar)) == 0 &&	\
> -	  pci_resource_end((dev), (bar)) ==		\
> -	  pci_resource_start((dev), (bar))) ? 0 :	\
> +	((pci_resource_end((dev), (bar)) == 0) ? 0 :	\
>  							\
>  	 (pci_resource_end((dev), (bar)) -		\
>  	  pci_resource_start((dev), (bar)) + 1))
> -- 
> 2.25.1
> 
