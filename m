Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432B760FA63
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 16:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiJ0O1u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiJ0O1q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 10:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9A0189820;
        Thu, 27 Oct 2022 07:27:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2271062348;
        Thu, 27 Oct 2022 14:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDB7C433C1;
        Thu, 27 Oct 2022 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666880864;
        bh=aFZT0WPmTqqNdeUqfKIIY9QIG68gQ4cqxwvWkM2ByAg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=g9OR87wD2iSPyJ+bzLFnr0uPzL8I+VYfddGCty81VJ2yfuJBF3K+YQBR0TH5sZTOv
         7cWn72XsChsOLA0X4Eqr3wHJIeLfV3aJGSBRHqECTy7f1k93Q5AXQ04d2EFaf3XDDn
         +53Oh3RsP4BzV3+ScfsWQx7TU8DJKu1ann4ZX923X0UnL1aT7kvsPPbZn52uW0aJc+
         /vLAZft09cWM6UM6Fn4kWmioTU0CqLUl565ljlvwIkYEJkvAylqQ1tjKh1YYTiOCeL
         /m1gfBYUGaQmrpcy3ZYBBPQPvbicC9D31UBP6wCdcKr1QpiZ0cdexGexZHw8VluAnH
         rmUDaTWtxK2kA==
Date:   Thu, 27 Oct 2022 09:27:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add vendor ID for Quectel and Cinterion
Message-ID: <20221027142742.GA826519@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027115123.5326-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 27, 2022 at 07:51:23PM +0800, Slark Xiao wrote:
> In MHI driver, there are some companies product still
> do not have their own PCI vendor macro. So we add it
> here to make the code neat. Ref ID could be found in
> link https://pcisig.com/membership/member-companies.

Rewrap to fill 75 columns.

Post along with the patch that uses the definitions.

> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  include/linux/pci_ids.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index b362d90eb9b0..e3bfea06b90e 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -172,6 +172,10 @@
>  #define PCI_DEVICE_ID_BERKOM_A4T		0xffa4
>  #define PCI_DEVICE_ID_BERKOM_SCITEL_QUADRO	0xffa8
>  
> +#define PCI_VENDOR_ID_CINTERION		0x1269

The URL above says 0x1269 belongs to Thales.  Maybe add a comment to
that effect, similar to the one for PCI_VENDOR_ID_CB.

> +#define PCI_VENDOR_ID_QUECTEL		0x1eac

Both new definitions look like they're dropped in a random location.
Please move them so the vendor IDs in the file remain sorted by
numeric value.

>  #define PCI_VENDOR_ID_COMPAQ		0x0e11
>  #define PCI_DEVICE_ID_COMPAQ_TOKENRING	0x0508
>  #define PCI_DEVICE_ID_COMPAQ_TACHYON	0xa0fc
> -- 
> 2.34.1
> 
