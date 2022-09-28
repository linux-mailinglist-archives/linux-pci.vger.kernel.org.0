Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16C45EDB26
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 13:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiI1LHT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 07:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbiI1LG4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 07:06:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCACEB109;
        Wed, 28 Sep 2022 04:04:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d42so19899337lfv.0;
        Wed, 28 Sep 2022 04:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=CLhAIIvy9Y2ruJAf9+yREPotjEO2NIAIDlqLdK6fCj8=;
        b=S4MsPIJVPO+68AA+mS05lXRQC4HVgjwJ18Vc/QUIEVxLoxPcUeof2CnaBJzMoDIYk8
         M+0qyGNpb9Ao1b8c/uPDjbouH/PWRh0M7CyODt4MMq+D6p1t9Bib4bOlYt75fthcpF9H
         PQptnubFI1DM8bmWsNON6U6pvQZHrzaZp54LJ8FxuXuOH0GuNjIfHruOlbixT0kcXJrx
         xUjTxARLE521qTa/R7nKswBdwb+OIFaEB6tEUKOzcGHf/wmA1RsUacAM0+lX1Ha7QATb
         IIF3HH+/f7NPdtnTcowx7IEbxm55j5n29Ohz485aiWwO/zm5RPs8Cv5m6EJBPxpbi2L8
         H7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CLhAIIvy9Y2ruJAf9+yREPotjEO2NIAIDlqLdK6fCj8=;
        b=diRIN2jT8976cwaIu4xSGMf+QsxWKknnG+dvq9jr5mVwUBywocnqaKMmjZpac9l791
         ViwXMNlBxl8T5k/7BwvUm+QPMRga6qJByhwHFtGWiioMvMT0U8PUbf5JlEopSXfWBDh+
         Q5hdFKLIjcM70MiPGkNaLAJqzc6bDYFVTbOTT+UDyMFavgJ50crsv0inbLd+ghD6E8St
         3YBOKauV/aiK/pSWUdoxQqRDq8V6wIGLp7jQEqF/JJ6rrBHbFD70Hv/5ftjrT/xMJosz
         Xqr9Ln5DjuGI9Fwz7eqwIoMCkIF2TDFQJIyVNDn9jrZ/atJpCq5H4MD2VTmRZAYJGRaa
         AE4w==
X-Gm-Message-State: ACrzQf35S8Ph1IobQvFBG2AgPGza8bnzs0lndPB/JlGPP4DwxT0mDha7
        FQdBwWGdsHjVAUa634XTgMg=
X-Google-Smtp-Source: AMsMyM468iUduFFvtvCoOKe8j5rLxxlMzuyn20KnDLob97Sp2PgkxoG9AeKGHuYJJU8EdjFEAHHOOg==
X-Received: by 2002:ac2:4e09:0:b0:499:1e3a:54ab with SMTP id e9-20020ac24e09000000b004991e3a54abmr12665761lfr.170.1664363038738;
        Wed, 28 Sep 2022 04:03:58 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id v6-20020a197406000000b00499d70c0310sm446966lfe.3.2022.09.28.04.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 04:03:58 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:03:55 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Zhuo Chen <chenzhuo.1@bytedance.com>
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 3/9] NTB: Remove pci_aer_clear_nonfatal_status() call
Message-ID: <20220928110355.emf2nucmdmpb3vbu@mobilestation>
References: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
 <20220928105946.12469-4-chenzhuo.1@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928105946.12469-4-chenzhuo.1@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 28, 2022 at 06:59:40PM +0800, Zhuo Chen wrote:
> There is no need to clear error status during init code, so remove it.

Why do you think there isn't? Justify in more details.

-Sergey

> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 0ed6f809ff2e..fed03217289d 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2657,8 +2657,6 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>  	ret = pci_enable_pcie_error_reporting(pdev);
>  	if (ret != 0)
>  		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
> -	else /* Cleanup nonfatal error status before getting to init */
> -		pci_aer_clear_nonfatal_status(pdev);
>  
>  	/* First enable the PCI device */
>  	ret = pcim_enable_device(pdev);
> -- 
> 2.30.1 (Apple Git-130)
> 
