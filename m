Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ABF794056
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 17:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbjIFP1S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 11:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjIFP1R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 11:27:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD988172E
        for <linux-pci@vger.kernel.org>; Wed,  6 Sep 2023 08:27:13 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c0d0bf18d7so23655915ad.0
        for <linux-pci@vger.kernel.org>; Wed, 06 Sep 2023 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694014033; x=1694618833; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/zC3sGldpjzeO9CMTZXERQUoaHDgQlu9tqCa3BrGgAE=;
        b=ZTBwdQ+WF35PHzUSDLhLhN3NBH3Vd/FMyx/RQ919NWpeYm5JmPBiVdJ55MpOpApon4
         kYQzR9P1JjswUF6RKp0DyG8N84y1Yy52aCxsgPH/cXan4yQZ7Dx9t5KdJaKr6U+N1mlW
         uQauYp88I6jedPTXOEejxe6oS204Vj9rzr3SSqAJjsRxYDNLOJxXXK2hx1u1mU0IYJG/
         PXa10A6iye4Y/64Z5HbrZqPbYUW0uI48+GV//DO4po9bXgvVAWTcyv7GnETkT9JQp20N
         t5bRfV2GRyDsg5Q6SkPVNIrXNGJAMFWuJm5iEd11imVp8XaNVimOrhMj3e/DJ8KOo0Aa
         64yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694014033; x=1694618833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zC3sGldpjzeO9CMTZXERQUoaHDgQlu9tqCa3BrGgAE=;
        b=Lt6BYYQWpTfbxqJ8zSUGXlWQ5+iTcCcnANfVnVOyDEQnuYCQ/MVhlsDUYyKKIo4rD/
         We2rhohA8yVkErlsspa/jOZN97tDU67nVJUOLjiZMnHdrBfeWEBqpDjumqjbSoBc1hg3
         CTAZAK6Y2zNeI3tMbefVByHngGz10F+a6QnECa4VS5JIm7js0KCpKdmKveAx0O5wbI/p
         gh8tXcg7SQ4ZuP6AH9Nvn4AiIs5PultfvhxyuqctgINMEXbfXkaftpHxoc8iXQsnvt9F
         tTWmKGlvwAyK4ZFhHMkQk8X6sNbB9gT/K32zwYiOSmIQBC9HX/xyGTiBlqk7PHh+GlZr
         vm7Q==
X-Gm-Message-State: AOJu0YwNGvNyH9Lc29VxVEb910UWWGhnatedlj8b3NkTk52XIyM7bQI1
        7Uk/dhIH7sQPUaj+y27Va2S5
X-Google-Smtp-Source: AGHT+IG3+CorsfPvIhXCthxDyrsclXr1JANLccL0UeFE1jZA2vIkElTgbVbw6jVva0tUGoKzfeesBA==
X-Received: by 2002:a17:903:4296:b0:1bd:ca21:c85 with SMTP id ju22-20020a170903429600b001bdca210c85mr12134409plb.69.1694014033186;
        Wed, 06 Sep 2023 08:27:13 -0700 (PDT)
Received: from thinkpad ([120.138.12.139])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902ee5300b001bb99ea5d02sm11265261plo.4.2023.09.06.08.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:27:12 -0700 (PDT)
Date:   Wed, 6 Sep 2023 20:57:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     tglx@linutronix.de, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Message-ID: <20230906152704.GD5930@thinkpad>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <20230426203436.1277307-2-Frank.Li@nxp.com>
 <20230902045214.GA2913@thinkpad>
 <20230902045328.GB2913@thinkpad>
 <ZPf/EkffMC51iLQ/@lizhi-Precision-Tower-5810>
 <20230906122605.GB5930@thinkpad>
 <ZPiNwQg3rDQMRA/6@lizhi-Precision-Tower-5810>
 <20230906145227.GC5930@thinkpad>
 <ZPiT/LJGpNbCRDZk@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPiT/LJGpNbCRDZk@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 06, 2023 at 11:00:12AM -0400, Frank Li wrote:
> On Wed, Sep 06, 2023 at 08:22:27PM +0530, Manivannan Sadhasivam wrote:
> > > > 
> > > > Can't you assign it in the EPF driver itself? I do not want any OF reference in
> > > > the EPF core since it has no OF support.
> > > 
> > > If that, Each EPF driver need do duplicate work. 
> > > 
> > 
> > Yes, and that's how it should be. EPF core has no job in supplying the of_node.
> > It is the responsibility of the EPF drivers as they depend on OF for platform
> > support.
> 
> EPF driver still not depend on OF. such pci-epf-test, which was probed by
> configfs.
> 

Hmm, yeah. Then it should be part of the EPC driver.

Sorry for the confusion.

- Mani

> Frank 
> 
> > 
> > - Mani
> > 
> > > IMS will support per-device MSI domain, then we can implement customized
> > > MSI irq allocated. But so far, it is simplest solution, we can update it
> > > after IMS implementation at kernel. Only one place need be changed.
> > > 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
