Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF3434CB3
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 15:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhJTNy0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 09:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhJTNyZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Oct 2021 09:54:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B7BA60EE3;
        Wed, 20 Oct 2021 13:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634737931;
        bh=SBDigKEN5g+FIb/oTr8InqTwNX3E4a1MT8ec1sBFvlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebOZ/YM1U8AKCU7bkBMRow9hfGEg/T5qtZOnzqYL2X4cYzQc3YBPMtGv7baBuoDor
         IxdawKe6lJCZFRLJV495dwO5XDDiZjfhHWiRG5x2rR3e5gOrIkJ8CIhOCSoU22mQl7
         Fr07REsSQa4GqxQ09hAeA9DWeapw6ZfUUWv4jlRloaBaEgkcDf+cJSe2Txk6G+ZbUI
         IZfHGOVEzVKM0eAME2f2N9Ti6yAYtg5TbrDs1Q2C7bD+PYHsTqgDfrisgQtBg2Efx5
         isY6pjXd7AVvCUYGh1lDcuVsz4IE5lwT4ZMo5SsCXB8DZpq0E0RjVDbZV2d83aKRcW
         qj3vJk/Y+E23Q==
Received: by pali.im (Postfix)
        id E204C883; Wed, 20 Oct 2021 15:52:08 +0200 (CEST)
Date:   Wed, 20 Oct 2021 15:52:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 02/24] PCI: Set error response in config access
 defines when ops->read() fails
Message-ID: <20211020135208.zgm2gvhqd7ukb57m@pali>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
 <b913b4966938b7cad8c049dc34093e6c4b2fae68.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b913b4966938b7cad8c049dc34093e6c4b2fae68.1634306198.git.naveennaidu479@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 15 October 2021 19:58:17 Naveen Naidu wrote:
> Make PCI_OP_READ and PCI_USER_READ_CONFIG set the data value with error
> response (~0), when the PCI device read by a host controller fails.
> 
> This ensures that the controller drivers no longer need to fabricate
> (~0) value when they detect error. It also  gurantees that the error
> response (~0) is always set when the controller drivers fails to read a
> config register from a device.
> 
> This makes error response fabrication consistent and helps in removal of
> a lot of repeated code.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/access.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 46935695cfb9..b3b2006ed1d2 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -42,7 +42,10 @@ int noinline pci_bus_read_config_##size \
>  	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
>  	pci_lock_config(flags);						\
>  	res = bus->ops->read(bus, devfn, pos, len, &data);		\
> -	*value = (type)data;						\
> +	if (res)									\
> +		SET_PCI_ERROR_RESPONSE(value);			\
> +	else										\
> +		*value = (type)data;						\

Hello! Just one small comment. It looks like that in this patch is
broken alignment of backslashes on the end of lines. Prior this patch
backslashes on all lines were at the same column. With this patch they
are not.

>  	pci_unlock_config(flags);					\
>  	return res;							\
>  }
> @@ -228,7 +231,10 @@ int pci_user_read_config_##size						\
>  	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
>  					pos, sizeof(type), &data);	\
>  	raw_spin_unlock_irq(&pci_lock);				\
> -	*val = (type)data;						\
> +	if (ret)								\
> +		SET_PCI_ERROR_RESPONSE(val);			\
> +	else									\
> +		*val = (type)data;						\
>  	return pcibios_err_to_errno(ret);				\
>  }									\
>  EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
> -- 
> 2.25.1
> 
