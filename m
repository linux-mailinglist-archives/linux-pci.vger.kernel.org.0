Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876B24BAFEE
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 04:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiBRDDa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 22:03:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiBRDD3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 22:03:29 -0500
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF36517E4;
        Thu, 17 Feb 2022 19:03:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1645153384; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=AAghYhEtBuBsRRdPfhEY3ptEqfEg5WwmhPJfSE9wSYj1bvAH2Ne/pZyKmsX96BKWF4tcSQeUWdCkgEqJdcu5cj1xF6iNeibKBSqYPMU2PUvN2LrhiHZXv/7QPFWJUc9nFw04MnLzzC9eWfdw2QUa3vkZQ/7HDb8N+XfL3iJPeQg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1645153384; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=XPO+pb8A7LXLQdzcNexkeaONrrOTy72Y4nFvtXzmfo0=; 
        b=Q92LCoA059lb6HSvjVCpvJ5ZpeIja6qMXW9G4ekuUZKEG6gTpacbAxHiV4OqtA9yoK/Ac1/UTDGDvmfpz0HpR9XnKTsmE6kkPqCQF+MXz8O2TUi3eU8rZgtVyZUpXS4NB8SgKx0KvwrAaDKW5NaJBtH3Rxe93EX944nf5SCb42o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1645153384;
        s=zm2020; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=XPO+pb8A7LXLQdzcNexkeaONrrOTy72Y4nFvtXzmfo0=;
        b=JWzbJDkJXNCNKsKlCI36Ah2KTLPeRF7bdF/fL2Ui+s2+5CQC9RR9GRfBEUHCcga0
        qYG97mxszUGj8X+qDMsLZOYOKYxbfwBl7d86yeb9WScVhvAF0et/rEy0kPLsvujl84p
        scDVXdkH6VaQbFGo8NxwU4onpJyAHaM8ai2rLA0A=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1645153382557407.6073312228908; Thu, 17 Feb 2022 19:03:02 -0800 (PST)
Received: from  [203.218.243.128] by mail.zoho.com
        with HTTP;Thu, 17 Feb 2022 19:03:02 -0800 (PST)
Date:   Fri, 18 Feb 2022 11:03:02 +0800
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "xkernelwang" <xkernel.wang@foxmail.com>
Cc:     "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <17f0ac8707d.e967ff2c113435.3595297833916391134@zohomail.com>
In-Reply-To: <tencent_CA4766945C568E210AA2701525957F041007@qq.com>
References: <tencent_CA4766945C568E210AA2701525957F041007@qq.com>
Subject: Re: [EXT] [PATCH] PCI: endpoint: functions/pci-epf-test: fix a
 potential memory leak
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Xiaoke,
This is duplicate  to https://lore.kernel.org/lkml/17ed816b6f3.d4fb44fb69745.1048447841721382920@zohomail.com/T/

Regards,
Li

 ---- On Fri, 18 Feb 2022 00:31:24 +0800  <xkernel.wang@foxmail.com> wrote ----
 > From: Xiaoke Wang <xkernel.wang@foxmail.com>
 > 
 > In pci_epf_test_write(), there is an error path does not properly
 > release 'buf' which is allocated by kzalloc(). It is better to release
 > it by changing the target label of goto statement.
 > 
 > Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
 > ---
 >  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 >  1 file changed, 1 insertion(+), 1 deletion(-)
 > 
 > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
 > index 90d84d3..41227dd 100644
 > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
 > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
 > @@ -441,7 +441,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 >          if (!epf_test->dma_supported) {
 >              dev_err(dev, "Cannot transfer data using DMA\n");
 >              ret = -EINVAL;
 > -            goto err_map_addr;
 > +            goto err_dma_map;
 >          }
 >  
 >          src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
 > -- 
 > 
 > ######################################################################
 > This EXTERNAL email has been scanned by Proofpoint Email Protect service.
 > 
