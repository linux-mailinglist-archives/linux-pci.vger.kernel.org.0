Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFA27227F0
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 15:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjFENzg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 09:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjFENzf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 09:55:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE8DE5
        for <linux-pci@vger.kernel.org>; Mon,  5 Jun 2023 06:55:33 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6549df4321aso2181020b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Jun 2023 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685973333; x=1688565333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JxwDQhCAuPGIb3iHcVUC4+fUCXLvKFtEBk4rG+JbNsE=;
        b=pnkJLWSOGbzo1NvVO/8XOxioEO7TsaL5uds5covOj8vyRYu8Gz35EjX5v+BTx86tLE
         3sI12/6C1e8jLWUR18wRea0ZREohGMNgpWqWeRzatJVsg4Y/5kJAcEn+d+kWjPYVJMUk
         IYN5lgjTLEChlQDU6s6ZweGIzGkYytSDQCiKtJR8KijFK+oSELp1uZDf+1mRIU+VTjqM
         Du2uEtHkc0PCwE1RFRtzckxjwBt3tI7vUkTa7j0PFyqa0OBOeTOFALDemwbYFWU01qIv
         Ao0em5bYtCHktzJ3ZJCZQDN9HnAWBTOIYVyA8e4fj3lKp8JGJXAqSzz6jQijhf3GNA5O
         SbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685973333; x=1688565333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxwDQhCAuPGIb3iHcVUC4+fUCXLvKFtEBk4rG+JbNsE=;
        b=XMDKtpzUPrhwp3S3DMIxncuk5paPrmZerf4qQP8A36ewCAMKxy4PxtyD9cvSmseRxH
         lmqtogQtMefxnWn4JmmHUIWyRyE0JRM6kkBILdCV2qFjyi9izXx4yTWmaeCjQGvnWs5F
         xxcEgAI3kDi3eHycMDKHhf7N/ADIe6AQT7u6dNmcPKUsQyv48qyPOGROAKXwpuXQeifx
         Mv/8pkPYlMDrTPmKJ0ULjSkDJzW8/soe567I8S3aaebp1SkSivalcN+czwVSruGAPDgl
         7qtXPgPtBTfgaVh+r2UcXY9jeYuE4as5vLLUAWTsTkZ0o1pWhi6DoY1sVfaDY02A2VUn
         Lqwg==
X-Gm-Message-State: AC+VfDwliY/Oudh7ijyZkx4+M9DX+3DQslnSBr2AGSNf363qBVVl0NZw
        at4FY+77+96p2dSQLL+FrA3L
X-Google-Smtp-Source: ACHHUZ5hQGlm/xEWO3otl7disCK8xOa/jNYnGs3o8HN+8Dm8ow4rqjkcVwoK25Qverdcell0Q7E6FQ==
X-Received: by 2002:a05:6a00:1501:b0:65a:6870:3acb with SMTP id q1-20020a056a00150100b0065a68703acbmr4472586pfu.31.1685973332897;
        Mon, 05 Jun 2023 06:55:32 -0700 (PDT)
Received: from thinkpad ([120.138.12.115])
        by smtp.gmail.com with ESMTPSA id d18-20020aa78152000000b00640e64aa9b7sm5417015pfn.10.2023.06.05.06.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 06:55:32 -0700 (PDT)
Date:   Mon, 5 Jun 2023 19:25:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>, kw@linux.com,
        kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 2/9] PCI: endpoint: Pass EPF device ID to the probe
 function
Message-ID: <20230605135528.GF5536@thinkpad>
References: <20230602114756.36586-1-manivannan.sadhasivam@linaro.org>
 <20230602114756.36586-3-manivannan.sadhasivam@linaro.org>
 <fdf5ea08-f3a1-3c9f-66a3-1cfa3743dae2@kernel.org>
 <ZH3eUQaIvWAQLI9A@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZH3eUQaIvWAQLI9A@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 05, 2023 at 03:08:33PM +0200, Lorenzo Pieralisi wrote:
> On Fri, Jun 02, 2023 at 09:13:25PM +0900, Damien Le Moal wrote:
> > On 6/2/23 20:47, Manivannan Sadhasivam wrote:
> > > Currently, the EPF probe function doesn't get the device ID argument needed
> > > to correctly identify the device table ID of the EPF device.
> > > 
> > > When multiple entries are added to the "struct pci_epf_device_id" table,
> > > the probe function needs to identify the correct one. This is achieved by
> > > modifying the pci_epf_match_id() function to return the match ID pointer
> > > and passing it to the driver's probe function.
> > > 
> > > pci_epf_device_match() function can return bool based on the return value
> > > of pci_epf_match_id().
> > > 
> > > Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > [...]
> > 
> > >  static int pci_epf_device_match(struct device *dev, struct device_driver *drv)
> > > @@ -510,8 +510,12 @@ static int pci_epf_device_match(struct device *dev, struct device_driver *drv)
> > >  	struct pci_epf *epf = to_pci_epf(dev);
> > >  	struct pci_epf_driver *driver = to_pci_epf_driver(drv);
> > >  
> > > -	if (driver->id_table)
> > > -		return pci_epf_match_id(driver->id_table, epf);
> > > +	if (driver->id_table) {
> > > +		if (pci_epf_match_id(driver->id_table, epf))
> > > +			return true;
> > > +		else
> > > +			return false;
> > 
> > You prefer keeping this pattern ?
> > 
> > return pci_epf_match_id(driver->id_table, epf) != NULL;
> > 
> > is no much nicer !
> 
> s/no/so
> 
> Yes it is, I can change it myself to spare Mani few cycles.
> 

Please do!

- Mani

> Lorenzo
> 
> > 
> > Anyway:
> > 
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > 
> > -- 
> > Damien Le Moal
> > Western Digital Research
> > 

-- 
மணிவண்ணன் சதாசிவம்
