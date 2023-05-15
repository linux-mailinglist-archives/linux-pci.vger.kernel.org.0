Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9074E7025F6
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 09:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbjEOHVL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 03:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjEOHVK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 03:21:10 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E01A0
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 00:21:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-530638a60e1so4964236a12.2
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 00:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684135269; x=1686727269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SX8XuKwYQaOqwiC7NaJGIm8hp/FtYtCRalgCqWfcmno=;
        b=y18lffyjuZgg3zwiU6CGqXgPuMz9NyeB62QXc8yKfOJQQOBogA3slYJ9aEd73MnRdD
         xJf6+7b3W4YOlOXuxRxtQwvnNIZkjttiyW4jQFyOYmTAkAbH+0w7H6siI61p2v/vzixa
         qEBElGFFQRnHdizp1nxAWq10bct1KJtSR6Dqp6PUMYyc93lDQzoz/7UrfQK/1orYGhMa
         RRB5lyJ9vd7TsMHmmXHWEtaEUQflNX9lEX/DWOJ0ins+L/drocgHLWoZAorC4ndPpU38
         4Jss0wgOeyrmo2PRXo8j6V0FHb+wgPqpEVr+CxzHK6/dYGOyUkPeZsQdvLJY9KKru4Ic
         CJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684135269; x=1686727269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SX8XuKwYQaOqwiC7NaJGIm8hp/FtYtCRalgCqWfcmno=;
        b=GQ3YsmqzwiW8fDS8dLkRq15ng4/v+Bg99lkFR7k5ozU87svYRKD4JiDMNgIhdvoZ57
         moffZ4ypfW6SLm8w2MA8adviFLEgxZFCRiJSlwkCsgrQICNS9GYgXtseU+KB2CvlXRe0
         MD8eopezQv0qHmQi+wmkGYrtHJVi5TgPNeV3jlnuUW62CBYBk9nmeMYxzJAnc3g6CkPY
         gnE7BKFcNEzLZBMYhcwBSj0Ks0WkHkOvAxAH815gQMaK57NH/CeMh8KwG5KJpcf+fFY/
         nSyn3TkWnmW0/rNgVt/fM/svCifz+VTrlHq/gxr213fQLf3/w3itMfPq3QZVb9dyh8j1
         geEA==
X-Gm-Message-State: AC+VfDwyglen+2dy3Y4mFM8Ne1NINdan9eZuPba1cKp6UNmRQUqEQl+6
        53fASr285dAGfJiWRIoQuB6U
X-Google-Smtp-Source: ACHHUZ4eCkCW8NSrGriyT2SKPGlAdYPWf8ewG/IQgSF7NfLTwMsQILDVHkrrGPdH4Sdt4Q9g9L7bEg==
X-Received: by 2002:a05:6a20:7f8a:b0:ff:8911:c695 with SMTP id d10-20020a056a207f8a00b000ff8911c695mr38146780pzj.43.1684135269105;
        Mon, 15 May 2023 00:21:09 -0700 (PDT)
Received: from thinkpad ([103.28.246.73])
        by smtp.gmail.com with ESMTPSA id s10-20020aa78d4a000000b0062e0010c6c1sm11093971pfe.164.2023.05.15.00.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 00:21:08 -0700 (PDT)
Date:   Mon, 15 May 2023 12:51:05 +0530
From:   Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH 2/2] PCI: endpoint: Add kdoc description of
 pci_epf_type_add_cfs()
Message-ID: <20230515072105.GB30758@thinkpad>
References: <20230515051500.574127-1-dlemoal@kernel.org>
 <20230515051500.574127-3-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515051500.574127-3-dlemoal@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 15, 2023 at 02:15:00PM +0900, Damien Le Moal wrote:
> Restore an improve the kdoc function description for
> pci_epf_type_add_cfs() that was removed with commit
> 893f14fed7d3 ("PCI: endpoint: Move pci_epf_type_add_cfs() code").
> 
> Fixes: 893f14fed7d3 ("PCI: endpoint: Move pci_epf_type_add_cfs() code")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index d8a6abe2c31c..15e17a661875 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -509,6 +509,24 @@ static const struct config_item_type pci_epf_type = {
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
> + * Return: NULL if the function driver

Spurious?

- Mani

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
