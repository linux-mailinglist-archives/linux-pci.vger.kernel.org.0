Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD577B3F91
	for <lists+linux-pci@lfdr.de>; Sat, 30 Sep 2023 11:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjI3JC5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Sep 2023 05:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjI3JC4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Sep 2023 05:02:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C01B1
        for <linux-pci@vger.kernel.org>; Sat, 30 Sep 2023 02:02:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ae75ece209so1867752666b.3
        for <linux-pci@vger.kernel.org>; Sat, 30 Sep 2023 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696064572; x=1696669372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q0hizBBm4A8wjMZ1piqiDjr9gInhzk36CKnQSjY0ZpQ=;
        b=MqgondFe0Uu0H3HEYZgqefdjdyxZdyTjT8y55ZkDMsPO7kMFgwLJFQf7jFHPA4wdFh
         X5pfb2tqwIXV0KH4PgZtqU/nohpYPdztpZAuRxFcccPjqGWff0DtXISQB90S3uJb6yKJ
         HGHXSeLFtNQkXNl1aUFzrCWXS6yQUKLnnutEQ+p5m29WHGggzxM4lVN5yR8awvE/N8aY
         RNRTMdN+RuAWSP4GuiSYKUywLhpiPQaoaEt2YZJTL9FtHDCDmakBNzVE3WcibXF5n4Td
         +zAAn7DmmJr1ggvmOqY1fcW15B8skqc85IUp/I74rechxAgdBaS40C5lg/+6t9C+brtW
         NyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696064572; x=1696669372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0hizBBm4A8wjMZ1piqiDjr9gInhzk36CKnQSjY0ZpQ=;
        b=U/2B05TR07XDcew8kOHNxv4nABD35Au0r/K50K+S4fgo4RYuDnWPNrY10hWZWEYyy5
         8wgLowY/uZn7mJvtv269TPKFqyw55qXYjC33ec0X7zbaR22JBSZe0bo2gHcVaygHW765
         pByydWEg1vdiotDYvKDMOclOn8OWjSb6xVXj7PJg+3QdKMmbx72HIE7YvgDCzI+kUJo4
         zb/z7uJ73DLueZvmBy33Jz465kijr4RwsVZWHC+dIMC+dLcyHULpjv9kjdEx3qGcAg8U
         ZpVyOKeiatytrtgiD//8QZ+KbcqrpEBwo5ZXOWj2w/KeNcrJQYvFqHKvNnZV8cjpYEMc
         ZYGQ==
X-Gm-Message-State: AOJu0YzZwRhLfRzM9lNK8LZTr8rfYQChUkhq+IZqk2xx/dM8/bLr5dX9
        4aCHxp7hwEvnPwAmwWW96ilS
X-Google-Smtp-Source: AGHT+IHr952WuR/z5EU6Gyhdfd/SNEYlnNbdjLVbmblbMVw53N3v3z8rJmOSwHR0BANmLPzAn2RjbA==
X-Received: by 2002:a17:907:985b:b0:9ae:6a08:6f53 with SMTP id jj27-20020a170907985b00b009ae6a086f53mr5637893ejc.63.1696064572153;
        Sat, 30 Sep 2023 02:02:52 -0700 (PDT)
Received: from thinkpad ([88.128.88.98])
        by smtp.gmail.com with ESMTPSA id bv13-20020a170906b1cd00b00993a37aebc5sm13708153ejb.50.2023.09.30.02.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 02:02:51 -0700 (PDT)
Date:   Sat, 30 Sep 2023 11:02:49 +0200
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 0/5] Add RC-to-EP doorbell with platform MSI controller
Message-ID: <20230930090249.GB3564@thinkpad>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <ZQtmpL2vCMgR+Upu@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQtmpL2vCMgR+Upu@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 20, 2023 at 05:39:48PM -0400, Frank Li wrote:
> On Mon, Sep 11, 2023 at 06:09:15PM -0400, Frank Li wrote:
> > ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> > │            │   │                                   │   │                │
> > │            │   │ PCI Endpoint                      │   │ PCI Host       │
> > │            │   │                                   │   │                │
> > │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> > │            │   │                                   │   │                │
> > │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> > │ Controller │   │   update doorbell register address│   │                │
> > │            │   │   for BAR                         │   │                │
> > │            │   │                                   │   │ 3. Write BAR<n>│
> > │            │◄──┼───────────────────────────────────┼───┤                │
> > │            │   │                                   │   │                │
> > │            ├──►│ 4.Irq Handle                      │   │                │
> > │            │   │                                   │   │                │
> > │            │   │                                   │   │                │
> > └────────────┘   └───────────────────────────────────┘   └────────────────┘
> 
> @mani:
> 	Do you have chance to review this patch again?

I was on vacation for past few weeks. Will take a look in the coming week.

- Mani

> 
> Frank
> 
> > 
> > This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/
> > 
> > Original patch only target to vntb driver. But actually it is common
> > method.
> > 
> > This patches add new API to pci-epf-core, so any EP driver can use it.
> > 
> > The key point is comments from Thomas Gleixner, who suggest use new
> > PCI/IMS. But arm platform change still not be merged yet.
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-arm
> > 
> > So I still use existed method implement RC to EP doorbell.
> > 
> > If Thomas Gleixner want to continue work on devmsi-v2-arm, I can help test
> > and update this patch.
> > 
> > Change from v1 to v2
> > - Add missed patch for endpont/pci-epf-test.c
> > - Move alloc and free to epc driver from epf.
> > - Provide general help function for EPC driver to alloc platform msi irq.
> > - Fixed manivannan's comments.
> > 
> > Frank Li (5):
> >   PCI: endpoint: Add RC-to-EP doorbell support using platform MSI
> >     controller
> >   PCI: dwc: add doorbell support by use MSI controller
> >   PCI: endpoint: pci-epf-test: add doorbell test
> >   misc: pci_endpoint_test: Add doorbell test case
> >   tools: PCI: Add 'B' option for test doorbell
> > 
> >  drivers/misc/pci_endpoint_test.c              |  48 +++++
> >  .../pci/controller/dwc/pcie-designware-ep.c   |   2 +
> >  drivers/pci/endpoint/functions/pci-epf-test.c |  59 +++++-
> >  drivers/pci/endpoint/pci-epc-core.c           | 192 ++++++++++++++++++
> >  drivers/pci/endpoint/pci-epf-core.c           |  44 ++++
> >  include/linux/pci-epc.h                       |   6 +
> >  include/linux/pci-epf.h                       |   7 +
> >  include/uapi/linux/pcitest.h                  |   1 +
> >  tools/pci/pcitest.c                           |  16 +-
> >  9 files changed, 373 insertions(+), 2 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
