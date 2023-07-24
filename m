Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DC375EB16
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 08:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGXGBF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 02:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGXGBE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 02:01:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21082CF
        for <linux-pci@vger.kernel.org>; Sun, 23 Jul 2023 23:01:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD2EA60F1A
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 06:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F25EC433C7;
        Mon, 24 Jul 2023 06:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690178463;
        bh=xPOPBZxzA6FHJCo1a1O93Uf6tJQPki7boyd0hP6RSPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nx/HmI1OcLGix8FIZM+sATRKuOChQxRb0NIJ+BCu4TKy7trDevStZifAbwuEZXm+8
         +CiUl6/MSvTkP0JD0Spl5HdhkcNERVq9CHrI3cv1grXfi3fQgasWjfZjpWDpyAgYty
         WYEyr9PzVnqH7TgNpCt1bRMm5dQPtM2afDo6EYFNKP1imh7vtb1UroVBwtFpuqkJJA
         piNa2mOrAVAyUK4ME3CBAOadnjCSZbS/7Wi1KY+niBq8sMdGB9QjrHbls9FYw6g7Hj
         Gu9p8mtoIAjtkb80SLfFbz9jRiLLSUOcnJ5+waRc5IL1HvRaRAhLJmdwhBJmp/cfCE
         QS8O2IwG5/1KA==
Date:   Mon, 24 Jul 2023 11:30:49 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org,
        mhi@lists.linux.dev, ntb@lists.linux.dev
Subject: Re: [PATCH 1/5] PCI: endpoint: Make pci_epf_ops in pci_epf_driver
 const
Message-ID: <20230724060049.GC2370@thinkpad>
References: <20230722230848.589428-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230722230848.589428-1-lars@metafoo.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 22, 2023 at 04:08:44PM -0700, Lars-Peter Clausen wrote:
> The pci_epf_ops struct contains a set of callbacks that are used by the
> pci_epf_driver. The ops struct is never modified by the epf core itself.
> 
> Marking the ops pointer const allows epf drivers to declare their
> pci_epf_ops struct to be const. This allows the struct to be placed in the
> read-only section. Which for example brings some security benefits as the
> callbacks can not be overwritten.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  include/linux/pci-epf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 3f44b6aec477..34be3f1da46c 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -98,7 +98,7 @@ struct pci_epf_driver {
>  	void	(*remove)(struct pci_epf *epf);
>  
>  	struct device_driver	driver;
> -	struct pci_epf_ops	*ops;
> +	const struct pci_epf_ops *ops;
>  	struct module		*owner;
>  	struct list_head	epf_group;
>  	const struct pci_epf_device_id	*id_table;
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
