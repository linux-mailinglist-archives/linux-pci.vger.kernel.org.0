Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62691F700E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 00:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgFKW2o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 18:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgFKW2n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 18:28:43 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F192073E;
        Thu, 11 Jun 2020 22:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591914523;
        bh=qR+bb79kjv7rHg2TTLK0j38Wr0FMOchsruCVsDSyxxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GIWqaL9EURHp17sluSLu4VOr74g4BY6p8lo+Pu1ZAxnq7lE115PfSE8pWWfXJyNpY
         RnsvJTg6JsI6vADpH9+ncqZgQQfE5k5NGKgZ7WlNRDuFercn2UAQPSPkKlTuZoOwy8
         /ApEk/uRHJjjYYS/CVuH8n4A2P1C+kxa+auS5S1I=
Date:   Thu, 11 Jun 2020 17:28:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     refactormyself@gmail.com
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH 8/8] PCI: Align return value of pcie capability accessors
 with other accessors
Message-ID: <20200611222841.GA1615548@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609153950.8346-9-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 09, 2020 at 05:39:50PM +0200, refactormyself@gmail.com wrote:
> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> 
> The pcie capability accessors can return 0, -EINVAL, or any PCIBIOS_ error
> code. PCIBIOS_ error codes have positive values. The pci accessor on the
> other hand can only return 0 or any PCIBIOS_ error code.This inconsistency
> among these accessor makes it harder for callers to check for errors.

s/pcie/PCIe/ (also below)
s/pci/PCI/
s/code.This/code. This/

> Return PCIBIOS_BAD_REGISTER_NUMBER instead of -EINVAL in all pcie
> capability accessors.
> 
> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> ---
>  drivers/pci/access.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 79c4a2ef269a..cbb3804903a0 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>  
>  	*val = 0;
>  	if (pos & 1)
> -		return -EINVAL;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
>  	if (pcie_capability_reg_implemented(dev, pos)) {
>  		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
> @@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
>  
>  	*val = 0;
>  	if (pos & 3)
> -		return -EINVAL;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
>  	if (pcie_capability_reg_implemented(dev, pos)) {
>  		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
> @@ -469,7 +469,7 @@ EXPORT_SYMBOL(pcie_capability_read_dword);
>  int pcie_capability_write_word(struct pci_dev *dev, int pos, u16 val)
>  {
>  	if (pos & 1)
> -		return -EINVAL;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
>  	if (!pcie_capability_reg_implemented(dev, pos))
>  		return 0;
> @@ -481,7 +481,7 @@ EXPORT_SYMBOL(pcie_capability_write_word);
>  int pcie_capability_write_dword(struct pci_dev *dev, int pos, u32 val)
>  {
>  	if (pos & 3)
> -		return -EINVAL;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
>  	if (!pcie_capability_reg_implemented(dev, pos))
>  		return 0;
> -- 
> 2.18.2
> 
