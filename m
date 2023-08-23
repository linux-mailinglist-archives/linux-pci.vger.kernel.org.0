Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628EE78506F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 08:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjHWGMv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 02:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjHWGMv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 02:12:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082A4E58
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 23:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9258B639B6
        for <linux-pci@vger.kernel.org>; Wed, 23 Aug 2023 06:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02322C433C7;
        Wed, 23 Aug 2023 06:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692771158;
        bh=8IhOTkMUvOP1Gag5k/x8c9VQDwafZOi7f4gwssCfTMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IepcbjrKdde4qoeCXqAuZ+WqHQwdjc6bzyj0AoiBnc+/ye7wozXw9GXRfyDfl2EyK
         /kZG1vg4OIxE84T1uSUKlRvlQHtbGXYafh5/cd+6+N2pxv5HDkYpPIQcxeA9whId6D
         C8CLWFfYIJ9VnJfPtx6n8eeF1FrLs3Z5OgXNMMfHBF4eXZb2aHQ7ESvYogGu2Z3+NG
         x6QfpsqfjoXnKR2E8EgZ78FAe2b1GlZJse90zvX/RY1ZzZ6p01SI+JuiN1j/8umL0U
         Dsq5idEQ/oYgrg2bqQcrGU8P+fCCYjiHDWSZdRKVfRg0RIHBfMXK6SiSb6mWIRx03m
         tyQVxfE4PstCA==
Date:   Wed, 23 Aug 2023 11:42:25 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH -next] PCI: endpoint: Use helper function IS_ERR_OR_NULL()
Message-ID: <20230823061225.GB3737@thinkpad>
References: <20230817070932.341667-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230817070932.341667-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 17, 2023 at 03:09:31PM +0800, Ruan Jinjie wrote:
> Use IS_ERR_OR_NULL() instead of open-coding it
> to simplify the code.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/endpoint/pci-epc-core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 5a4a8b0be626..fe421d46a8a4 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -38,7 +38,7 @@ static int devm_pci_epc_match(struct device *dev, void *res, void *match_data)
>   */
>  void pci_epc_put(struct pci_epc *epc)
>  {
> -	if (!epc || IS_ERR(epc))
> +	if (IS_ERR_OR_NULL(epc))
>  		return;
>  
>  	module_put(epc->ops->owner);
> @@ -660,7 +660,7 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
>  	struct list_head *list;
>  	u32 func_no = 0;
>  
> -	if (!epc || IS_ERR(epc) || !epf)
> +	if (IS_ERR_OR_NULL(epc) || !epf)
>  		return;
>  
>  	if (type == PRIMARY_INTERFACE) {
> @@ -691,7 +691,7 @@ void pci_epc_linkup(struct pci_epc *epc)
>  {
>  	struct pci_epf *epf;
>  
> -	if (!epc || IS_ERR(epc))
> +	if (IS_ERR_OR_NULL(epc))
>  		return;
>  
>  	mutex_lock(&epc->list_lock);
> @@ -717,7 +717,7 @@ void pci_epc_linkdown(struct pci_epc *epc)
>  {
>  	struct pci_epf *epf;
>  
> -	if (!epc || IS_ERR(epc))
> +	if (IS_ERR_OR_NULL(epc))
>  		return;
>  
>  	mutex_lock(&epc->list_lock);
> @@ -743,7 +743,7 @@ void pci_epc_init_notify(struct pci_epc *epc)
>  {
>  	struct pci_epf *epf;
>  
> -	if (!epc || IS_ERR(epc))
> +	if (IS_ERR_OR_NULL(epc))
>  		return;
>  
>  	mutex_lock(&epc->list_lock);
> @@ -769,7 +769,7 @@ void pci_epc_bme_notify(struct pci_epc *epc)
>  {
>  	struct pci_epf *epf;
>  
> -	if (!epc || IS_ERR(epc))
> +	if (IS_ERR_OR_NULL(epc))
>  		return;
>  
>  	mutex_lock(&epc->list_lock);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
