Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BE072852A
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjFHQgk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 12:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbjFHQgi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 12:36:38 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0952119
        for <linux-pci@vger.kernel.org>; Thu,  8 Jun 2023 09:36:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b24eba184bso4592435ad.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Jun 2023 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686242140; x=1688834140;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/aL6Mm02RP068H18Hmx+R64BHyyt5ervIsVqvJjdt9Q=;
        b=JdAw6Mq860YRQRBQswOEjzf4ISFKIXDDTQ9l5+MNDNoF1EZ0S1jAnlfVQnp3wSTKLf
         kIrgXpITkuDawG2u8CMycorgDxUFVpWL5x1rcK5SeXYILykhJu1cXysOOYEBWsf1+54K
         32y2qYyO5wU2TOJDEUoYhqc8bbZJM5oNqSKnGWCnfcxnHH8u/7B6Lo1a36cGs7EA/G5B
         3OkmjlYhcoeo4hKxgvF2KxE7/KIW/UK3Zmbd6bpnWLGT6nnhkm2JrYf3WTfykpUuO6Em
         Vyn0hKWWcGz0IA4xb7O2uCHk7PWP//aDpb9qwosyCGupjN0eqeIhjN3y6D7jQR6D7iwe
         JtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242140; x=1688834140;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/aL6Mm02RP068H18Hmx+R64BHyyt5ervIsVqvJjdt9Q=;
        b=AmNIYcywR3eehpSsA/aHtAyDBb47jKMgL8sW5c+0g8EWE8J9w7XJLWKYQ6Nvfqf+s0
         EbC0cciNCYkTVoWhFebCtjzDllC9j2e2zU+Ei/+u7kgf3xsg1ZJX+Y+D8UQZnW6/ZBlP
         4gBxmTe0MoCNCyi2kleQ1cUSBG3fQ6tT9TXT4xU1eGMuEPp6XgROQadzqoo0JsvyW3bR
         nHOzdbMRxUc1/kzH6uWnzeLYF5RG3Vvn18vK5uFcl4hh4rgyWU4/HIqYtilyVoG4qDkE
         3lRBEnlCEItr9YSewgM5q4Q1nyIMkp6blMwzhx1m+DXHo2m9zALDZBN3lL1JwpAi2XsT
         rEFg==
X-Gm-Message-State: AC+VfDzSiQN/77V+mHN9xQ1RT00GpU8m4atOHkCAazVA8/Rh4IR3JHba
        lqtio/FHwC3PpIgt6pL3JQuO
X-Google-Smtp-Source: ACHHUZ41Md8JiH2gX2B8B2vO1CwrgtpmT9DH0nhknBHBFZk41hPsvipEwYYD0QPAAbP64J2nbjYOZQ==
X-Received: by 2002:a17:902:e54b:b0:1a9:9ace:3e74 with SMTP id n11-20020a170902e54b00b001a99ace3e74mr5073873plf.65.1686242140125;
        Thu, 08 Jun 2023 09:35:40 -0700 (PDT)
Received: from thinkpad ([117.202.186.138])
        by smtp.gmail.com with ESMTPSA id z11-20020a1709027e8b00b001b0295de9acsm1656054pla.179.2023.06.08.09.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:35:39 -0700 (PDT)
Date:   Thu, 8 Jun 2023 22:05:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dlemoal@kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH v6 8/9] PCI: endpoint: Add PCI Endpoint function driver
 for MHI bus
Message-ID: <20230608163529.GD8632@thinkpad>
References: <20230607204923.GA1174664@bhelgaas>
 <20230607211941.GA1176583@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607211941.GA1176583@bhelgaas>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 07, 2023 at 04:19:41PM -0500, Bjorn Helgaas wrote:
> [+cc Yang Li, sorry I didn't notice your patch earlier:
> https://lore.kernel.org/r/20230607093514.104012-1-yang.lee@linux.alibaba.com]
> 
> I think we can squash this into the original commit since it hasn't
> gone upstream yet.  Also note that removing the dev_err() apparently
> makes "dev" unused, so we'd have to remove that as well, based on this
> report [2].
> 
> [2] https://lore.kernel.org/r/202306080418.i64hTj5T-lkp@intel.com
> 
> On Wed, Jun 07, 2023 at 03:49:25PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 02, 2023 at 05:17:55PM +0530, Manivannan Sadhasivam wrote:
> > > Add PCI Endpoint driver for the Qualcomm MHI (Modem Host Interface) bus.
> > > The driver implements the MHI function over PCI in the endpoint device
> > > such as SDX55 modem. The MHI endpoint function driver acts as a
> > > controller driver for the MHI Endpoint stack and carries out all PCI
> > > related activities like mapping the host memory using iATU, triggering
> > > MSIs etc...
> > > ...
> > 
> > > +static int pci_epf_mhi_bind(struct pci_epf *epf)
> > > +{
> > > ...
> > 
> > > +	ret = platform_get_irq_byname(pdev, "doorbell");
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "Failed to get Doorbell IRQ\n");
> > 
> > This dev_err() causes this new warning from the 0-day robot [1]:
> > 
> >   drivers/pci/endpoint/functions/pci-epf-mhi.c:362:2-9: line 362 is redundant because platform_get_irq() already prints an error
> > 
> > Maybe we could drop it?
> > 

Right. I think Lorenzo can handle both while squashing.

- Mani

> > Bjorn
> > 
> > [1] https://lore.kernel.org/all/20230607163937.ZTc-D%25lkp@intel.com/

-- 
மணிவண்ணன் சதாசிவம்
