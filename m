Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A9E6BB6DE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 16:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjCOPC5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 11:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjCOPCf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 11:02:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592F861A90
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 08:01:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF60B61DC3
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 15:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BA8C433EF;
        Wed, 15 Mar 2023 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678892501;
        bh=aHtu9maYyyIHr/XoVlixWl3bm/KLMNKI7Af0m0Ap+IA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9td6Wp55OTxxyAfn8wn3vx/WRccnuGlVdQthFEf/Va+wOp5Ia8OVEU70r+hSbhRZ
         hD2mg8L22O33ubruROC8W3dE/OaL196mLsFYTU2FbNk3LDgmQxcwK2U1I6c74hV81n
         UF5YnfMZaoAMCNcA+teb45KdIhiDnEMMfTH5pRfo4laovgpE1N3KoaiyA8rBlLu7KK
         rBOpCc/dnwAkpoDVBLZhcqaWb/l50sUSu/MOuy0zkgXIEAvDkkfAEL5hv3SOUJyIa0
         cxWS2mwJbGyo2p0fyEnkaanuTr5KxzsSdcOmhuFlXib+i1Th9YAQaZ0JnWQN3/4PHJ
         BObtrdteoI26Q==
Date:   Wed, 15 Mar 2023 20:31:28 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 02/16] PCI: endpoint: Move pci_epf_type_add_cfs() code
Message-ID: <20230315150128.GD98488@thinkpad>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
 <20230308090313.1653-3-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308090313.1653-3-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 08, 2023 at 06:02:59PM +0900, Damien Le Moal wrote:
> pci_epf_type_add_cfs() is called only from pci_ep_cfs_add_type_group()
> in drivers/pci/endpoint/pci-ep-cfs.c, so there is no need to export this
> function and we can move its code from pci-epf-core.c to pci-ep-cfs.c
> as a static function.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/pci/endpoint/pci-ep-cfs.c   | 20 ++++++++++++++++++
>  drivers/pci/endpoint/pci-epf-core.c | 32 -----------------------------
>  include/linux/pci-epf.h             |  2 --
>  3 files changed, 20 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index b16fc6093c20..3a05e9b5a4e9 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -509,6 +509,26 @@ static const struct config_item_type pci_epf_type = {
>  	.ct_owner	= THIS_MODULE,
>  };
>  
> +static struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
> +						 struct config_group *group)
> +{
> +	struct config_group *epf_type_group;
> +
> +	if (!epf->driver) {
> +		dev_err(&epf->dev, "epf device not bound to driver\n");
> +		return NULL;
> +	}
> +
> +	if (!epf->driver->ops->add_cfs)
> +		return NULL;
> +
> +	mutex_lock(&epf->lock);
> +	epf_type_group = epf->driver->ops->add_cfs(epf, group);
> +	mutex_unlock(&epf->lock);
> +
> +	return epf_type_group;
> +}
> +
>  static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
>  {
>  	struct config_group *group;
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 2036e38be093..355a6f56fcea 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -20,38 +20,6 @@ static DEFINE_MUTEX(pci_epf_mutex);
>  static struct bus_type pci_epf_bus_type;
>  static const struct device_type pci_epf_type;
>  
> -/**
> - * pci_epf_type_add_cfs() - Help function drivers to expose function specific
> - *                          attributes in configfs
> - * @epf: the EPF device that has to be configured using configfs
> - * @group: the parent configfs group (corresponding to entries in
> - *         pci_epf_device_id)
> - *
> - * Invoke to expose function specific attributes in configfs. If the function
> - * driver does not have anything to expose (attributes configured by user),
> - * return NULL.
> - */
> -struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
> -					  struct config_group *group)
> -{
> -	struct config_group *epf_type_group;
> -
> -	if (!epf->driver) {
> -		dev_err(&epf->dev, "epf device not bound to driver\n");
> -		return NULL;
> -	}
> -
> -	if (!epf->driver->ops->add_cfs)
> -		return NULL;
> -
> -	mutex_lock(&epf->lock);
> -	epf_type_group = epf->driver->ops->add_cfs(epf, group);
> -	mutex_unlock(&epf->lock);
> -
> -	return epf_type_group;
> -}
> -EXPORT_SYMBOL_GPL(pci_epf_type_add_cfs);
> -
>  /**
>   * pci_epf_unbind() - Notify the function driver that the binding between the
>   *		      EPF device and EPC device has been lost
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index a215dc8ce693..b8441db2fa52 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -214,8 +214,6 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>  			enum pci_epc_interface_type type);
>  int pci_epf_bind(struct pci_epf *epf);
>  void pci_epf_unbind(struct pci_epf *epf);
> -struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
> -					  struct config_group *group);
>  int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
>  void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
>  #endif /* __LINUX_PCI_EPF_H */
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
