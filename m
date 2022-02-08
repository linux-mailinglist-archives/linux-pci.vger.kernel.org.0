Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D044AD1C4
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 07:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbiBHGsF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 01:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbiBHGsF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 01:48:05 -0500
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266D7C0401F5;
        Mon,  7 Feb 2022 22:48:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1644302876; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Mz5nes1S9Bv7uWg7mSdSkoWdqOUwx1ai6CPGy/4ZaRCeK/so4I5iIctzdQhCKtG/ItC82VgSQY1gm3W7XO0pBlnJS6EENrejw8S1jwffSvmnF64PeEfWEJ2/31yqUaxsBo5OmHbYeVOXXl08TSWnPYTQtL7rHDzEByRe9GR8WqU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1644302876; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=9rkLAN/8k6qz/+MCyKkO/cuBmp6HwOLZxvM3wynyJt8=; 
        b=b8idG1FPq+aVw4jPrnJ0JeQPt3nrFc3C0Lz7VT9tQcMFq8Dbn+SD+WHI9J8W5CZE539xnjcJq5vnhEWNsEiy+vpi9oVM8dlbBWwXsW06pfbzOVB35oS+d7Cszlu9LVDSnPw7VRkMtgNzyl2gnKTBjng+nxP4xm+YME2OCDTvfAU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1644302876;
        s=zm2020; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=9rkLAN/8k6qz/+MCyKkO/cuBmp6HwOLZxvM3wynyJt8=;
        b=jmm5HoQ8dH4kGzfEOCCZz0VFiJml/KwoXdh5nV1+P342P3NkjkjhQMpbB7MOs4u1
        Vs4I9hAW0AF3rAy+HBgTD+Ipb+8++kkddaP/UPnwRzXey3Wg1/UnG7yKYFl2XUpgM7v
        rVJNRYUK6cFuFyFQp/dY8WnuZ2GUmSeCh+cMJ3Mc=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1644302874384547.2045927238538; Mon, 7 Feb 2022 22:47:54 -0800 (PST)
Received: from  [45.80.185.140] by mail.zoho.com
        with HTTP;Mon, 7 Feb 2022 22:47:54 -0800 (PST)
Date:   Tue, 08 Feb 2022 01:47:54 -0500
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17ed816b6f3.d4fb44fb69745.1048447841721382920@zohomail.com>
In-Reply-To: <17e7b9b9ee6.c6d9c6a02564.4545388417402742326@zohomail.com>
References: <17e7b9b9ee6.c6d9c6a02564.4545388417402742326@zohomail.com>
Subject: Re: [PATCH] PCI: endpoint fix misused goto label
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

ping

 ---- On Fri, 21 Jan 2022 02:48:23 -0500 Li Chen <lchen.firstlove@zohomail.com> wrote ----
 > From: Li Chen <lchen@ambarella.com>
 > 
 > If we goto err_map_addr here, buf allocated
 > via kmalloc won't get freeed, then memoryleak.
 > 
 > Signed-off-by: Li Chen <lchen@ambarella.com>
 > ---
 >  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 >  1 file changed, 1 insertion(+), 1 deletion(-)
 > 
 > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
 > index 96489cfdf58db..60303223976a1 100644
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
 > 2.34.1
 > 
 > 
 > 
