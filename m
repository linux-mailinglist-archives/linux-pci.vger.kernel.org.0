Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3673C70618B
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 09:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjEQHpK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 03:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjEQHpI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 03:45:08 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855A6118
        for <linux-pci@vger.kernel.org>; Wed, 17 May 2023 00:45:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaef97652fso4355385ad.0
        for <linux-pci@vger.kernel.org>; Wed, 17 May 2023 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684309507; x=1686901507;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ddij+IgcohB+6avEyT6HE6OwNGw10qKKU1zhDBMIdCU=;
        b=jkaTUZt9Hs97I1MjdIphtWrYTCS6celIa+fvsyxEcGRYkIlZ7s54nclg4kyRmb371q
         kvxx8u6+mHZQBUb4taRXcquv2MNclgVbCDJhhHxUEerjDFKKAf9USgYGFEEU4709UZYT
         2mJtLhhGZY3uDbc91ETeqKCTKQPkQAZvv3KIvFLATApzUcsZEcu0aSLZRwRtZ+euhN8u
         03VHe7OKJZEV5TXXy6xQEyWt9xKbqVcTjTa/QstDHfPRl+rxRFtWrr4dPYLIik33gTQA
         aG4hzo5p+lyBPME+8s6vnbdhy+0cfiEMzwBMlL4uZX5QuE8pMDKDdD7yVP0TzWjBHk4N
         9d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684309507; x=1686901507;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ddij+IgcohB+6avEyT6HE6OwNGw10qKKU1zhDBMIdCU=;
        b=DYuEEQ32EkI+oukZOF+A6SRMzeJfPCdH6TJhkTGH9nfVgAbX0GOiTD15ry10VCD1aR
         haIS4VwJLUkKRabVgJz1+Ut4Yjf9l1sri3Z2ZMG89Hnv3SMjb95D6ipsUfWy8tP1iWMT
         dZkuDmoQYXQVbY6+ncsewpBSRV/jzgFZdc3WP2oUpSf7EMfxoAYB+3HscKbHCMp0fpLC
         27dEayS1kj8m1S0iF2VhfA7he7w8WBiS3lqi1rvfdNoOYKA+sU0ulfTTEJGN3GMKmeCA
         ntyKF67zruDIHajxsJ+tA+3KgPo4vRDLelFs9Y1blsHDFNvBI5Sheev1dWVrRyDMwybW
         11tg==
X-Gm-Message-State: AC+VfDwk/7F4NunpgJOD0bYBwiOjhUeiItqXSwJChAlCEri35ARux6K5
        xiX5Ivc5da+QmL3V0P9OF02a
X-Google-Smtp-Source: ACHHUZ7Pc+TZlRHUWTX9PYr3qJ+VJYdNJJmMTsMZkqfYNDlIGj+eCyDL38FMnMC/1h3DunGIn/7lew==
X-Received: by 2002:a17:902:ced0:b0:1ad:c736:209a with SMTP id d16-20020a170902ced000b001adc736209amr23245827plg.56.1684309506983;
        Wed, 17 May 2023 00:45:06 -0700 (PDT)
Received: from thinkpad ([117.207.26.28])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001a9a8983a15sm16832784plb.231.2023.05.17.00.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 00:45:06 -0700 (PDT)
Date:   Wed, 17 May 2023 13:15:00 +0530
From:   Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: endpoint: Add kdoc description of
 pci_epf_type_add_cfs()
Message-ID: <20230517074500.GK4868@thinkpad>
References: <20230515074348.595704-1-dlemoal@kernel.org>
 <20230515074348.595704-3-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515074348.595704-3-dlemoal@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 15, 2023 at 04:43:48PM +0900, Damien Le Moal wrote:
> Restore an improve the kdoc function description for
> pci_epf_type_add_cfs() that was removed with commit
> 893f14fed7d3 ("PCI: endpoint: Move pci_epf_type_add_cfs() code").
> 
> Fixes: 893f14fed7d3 ("PCI: endpoint: Move pci_epf_type_add_cfs() code")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index 0bf5be986e9b..be042c3f50b5 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -509,6 +509,22 @@ static const struct config_item_type pci_epf_type = {
>  	.ct_owner	= THIS_MODULE,
>  };
>  
> +/**
> + * pci_epf_type_add_cfs() - Help function drivers to expose function specific   
> + *                          attributes in configfs
> + * @epf: the EPF device that has to be configured using configfs
> + * @group: the parent configfs group (corresponding to entries in
> + *         pci_epf_device_id)
> + *
> + * Invoke to expose function specific attributes in configfs.
> + *
> + * Return: A pointer to a config_group structure or NULL if the function driver
> + * does not have anything to expose (attributes configured by user) or if the
> + * the function driver does not implement the add_cfs() method.
> + *
> + * Returns an error pointer if this function is called for an unbound EPF device
> + * or if the EPF driver add_cfs() method fails.
> + */
>  static struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
>  						 struct config_group *group)
>  {
> -- 
> 2.40.1
> 

-- 
மணிவண்ணன் சதாசிவம்
