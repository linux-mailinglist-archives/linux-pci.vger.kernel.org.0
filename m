Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879D859FD40
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 16:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiHXO2b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 10:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbiHXO2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 10:28:30 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BE857242
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 07:28:29 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s206so15188079pgs.3
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=VHZ1ksjQl5AvM5dtHsHT/yZDe5KV60+BqIyJVV5J5uo=;
        b=RM+nfmA9Bgeo4UxgaKhY2YaTFa7Uo1Xz7+8bvcx9KoPOgLoHj/kVqUxK88VBH6dVK8
         ZrkROkaJlF736UWfTVb11bI1hRCtpEnjp/hCgxnM2OC7va6xnttCh6APsILSN2whjOWj
         CNd0wtoY9ZnEGxAVI+LeqkXnauvxYTaJbNqc62L1Vkzuw6+m9FMikDy6n4cWE7zHcpA4
         Sh3oR0GArh+agB+sQr7Nr4Q43C9ZN5bxBkywRgPUs596aLCfC1lydvv+P5CR3Z2nGWXq
         FbklLVd96uhSUf3vYgMOx5uTxnOXQwszSRDfEalzBIdl8JNcljsLswKMMqd4ddfBnmME
         Pa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=VHZ1ksjQl5AvM5dtHsHT/yZDe5KV60+BqIyJVV5J5uo=;
        b=I8/7TbeV+9A8S4OUaJPBfhzQb184ipMjpH7CFbUu7rtaLSI7vYc9sJOhWXDD+UDqht
         86HQuYHU0J4fl0EzKeyg69gxdDJ1F8l6iolKKB2bz0xluIZXju8LJWmsrNSw2+93VeDL
         MWaF+GRf1vE26biMq2sd/KGC+OoJLAo4/Eclf/5TdJ/Qcm677xyV9YMNs8YQta0H7g63
         Giv1TcGlJzbjZ1ifJZoHDdZIvJXsb44J2HF+6rDkyejqEnJPkNufFgfud/OjjJkznCNr
         DD6VyUiZK/TQ2yq88ukHMXSZVRcBAGamKddkgODdThvm7DDPI4K+1fM9L6Jwez0HrooQ
         cVUg==
X-Gm-Message-State: ACgBeo0M2lga3H9u0y632uubkBJMlA4B7SyNyVZsLQUWAa7CpUCH/6UT
        rreZdykVxSC7zXf0slS+CLFd
X-Google-Smtp-Source: AA6agR6m+4Z7m/Wrb514SKsSQkNiUA0fZM99UcPSJFiJC0RcpdGS8unmI17fFFdsHDvHHi2O4TZ5fg==
X-Received: by 2002:aa7:88c3:0:b0:536:f035:ede0 with SMTP id k3-20020aa788c3000000b00536f035ede0mr8850989pff.74.1661351308433;
        Wed, 24 Aug 2022 07:28:28 -0700 (PDT)
Received: from thinkpad ([117.207.24.28])
        by smtp.gmail.com with ESMTPSA id n3-20020aa79843000000b005368341381fsm7305569pfq.106.2022.08.24.07.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 07:28:28 -0700 (PDT)
Date:   Wed, 24 Aug 2022 19:58:21 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kishon@ti.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mie@igel.co.jp, kw@linux.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 2/5] tools: PCI: Fix parsing the return value of IOCTLs
Message-ID: <20220824142821.GC4767@thinkpad>
References: <20220824123010.51763-1-manivannan.sadhasivam@linaro.org>
 <20220824123010.51763-3-manivannan.sadhasivam@linaro.org>
 <YwYdFt6sc7lZGRcg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YwYdFt6sc7lZGRcg@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 24, 2022 at 02:44:06PM +0200, Greg KH wrote:
> On Wed, Aug 24, 2022 at 06:00:07PM +0530, Manivannan Sadhasivam wrote:
> > "pci_endpoint_test" driver now returns 0 for success and negative error
> > code for failure. So adapt to the change by reporting FAILURE if the
> > return value is < 0, and SUCCESS otherwise.
> > 
> > Cc: stable@vger.kernel.org #5.10
> > Fixes: 3f2ed8134834 ("tools: PCI: Add a userspace tool to test PCI endpoint")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  tools/pci/pcitest.c | 41 +++++++++++++++++++++--------------------
> >  1 file changed, 21 insertions(+), 20 deletions(-)
> > 
> > diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> > index 441b54234635..a4e5b17cc3b5 100644
> > --- a/tools/pci/pcitest.c
> > +++ b/tools/pci/pcitest.c
> > @@ -18,7 +18,6 @@
> >  
> >  #define BILLION 1E9
> >  
> > -static char *result[] = { "NOT OKAY", "OKAY" };
> >  static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
> >  
> >  struct pci_test {
> > @@ -54,9 +53,9 @@ static int run_test(struct pci_test *test)
> >  		ret = ioctl(fd, PCITEST_BAR, test->barnum);
> >  		fprintf(stdout, "BAR%d:\t\t", test->barnum);
> >  		if (ret < 0)
> > -			fprintf(stdout, "TEST FAILED\n");
> > +			fprintf(stdout, "FAILED\n");
> >  		else
> > -			fprintf(stdout, "%s\n", result[ret]);
> > +			fprintf(stdout, "SUCCESS\n");
> 
> Is this following the kernel TAP output rules?  If not, why not?  If so,

It is not following the TAP rules currently as I was not aware of it. Now that
you pointed out, I'll try to adapt to it.

Thanks,
Mani

> say that you are fixing that issue up in the changelog text.
> 
> thanks,
> 
> greg k-h

-- 
மணிவண்ணன் சதாசிவம்
