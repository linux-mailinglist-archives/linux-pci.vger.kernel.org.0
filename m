Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6885859ADC6
	for <lists+linux-pci@lfdr.de>; Sat, 20 Aug 2022 14:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346036AbiHTMBZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Aug 2022 08:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242181AbiHTMBY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Aug 2022 08:01:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D2EA3478
        for <linux-pci@vger.kernel.org>; Sat, 20 Aug 2022 05:01:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s206so5650116pgs.3
        for <linux-pci@vger.kernel.org>; Sat, 20 Aug 2022 05:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=lDEkY/yeMPXbQUNcvN1NJWGfIdYQRwGMibZPIx8rNuw=;
        b=PQbYi3anFSf+45hPdBCKJK8rMdAyTHn3vksXRezHdYXy4Ju6EhM33xwKuqR/Bw+yif
         1I7Bx+XheCGL01YnU9FIzj8XRqH/kVTDaWknGLTkAUu3ojmTqYJg1KV+oh+LUbOby79D
         9JJbeALKZ5aMAAbmmCPTMDWU3sZHor4SIRC4itru1T8WjBwKmE3WGMFDtNxRCXzBEl9p
         BGbohuFK78kogdV9PNMCgcV1S1iNELVaIzvcTV8VFppSZBbVzxb5I9UvlpHXcuDMXIKH
         igVtmtfNKTJltVmSkNNpKwpYBGZcdptysIaJYfvQ34rViJ4QXpUiV7qRpdAyqkCuDT6n
         yXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=lDEkY/yeMPXbQUNcvN1NJWGfIdYQRwGMibZPIx8rNuw=;
        b=MVBteiOh9/qMP0eF56i92gcwcchwBDnrWc5GNLXw51nHvstLUS04la8D1fDqgRqJAT
         fOcCu6K8BeMsCkai3teTsTTCJS+qk0Hsn3sGwb+SaXZB/C4pXDGUc0x+KfS1BwmXc8uJ
         5rC6/t/zGR+ByQQCkDcU5XSRc91+/rlPZAQHOBqrLWUrfwkndUpQ30OkCg6uwNCcUVTO
         r1psHFC2ALxliEpOoHWzeHGh4L+CZXPjx6ujX/wA/phaA/076B5Cf0k7MiG8zcqVVB/0
         a5sTdVsaVVkfhxuCjsjWgkmsA4zn3ge8ZQ2R0jttjD00WOvd/rGApCQMNMzMASCT5c7m
         Ba4w==
X-Gm-Message-State: ACgBeo0LtCYz6dN49Y0fCuVk0Eium3dCn8SQz7AryO0/FsFUiHZgTz8k
        xOV7oxGuQ03H9JIdT+Y0/oxsO5NYZTtK
X-Google-Smtp-Source: AA6agR7W75/oj+IheQfbyZ1gnRavn2Zy8YNefMFAJ7psKM8Kj/rmfwB0yx38hsZSgs04M5GS/z839Q==
X-Received: by 2002:a05:6a00:a81:b0:530:2967:dc48 with SMTP id b1-20020a056a000a8100b005302967dc48mr12275238pfl.38.1660996883517;
        Sat, 20 Aug 2022 05:01:23 -0700 (PDT)
Received: from thinkpad ([220.158.158.232])
        by smtp.gmail.com with ESMTPSA id 2-20020a630c42000000b004129741dd9dsm4251913pgm.51.2022.08.20.05.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 05:01:22 -0700 (PDT)
Date:   Sat, 20 Aug 2022 17:31:16 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kishon@ti.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mie@igel.co.jp, kw@linux.com
Subject: Re: [PATCH 2/5] misc: pci_endpoint_test: Fix the return value of
 IOCTL
Message-ID: <20220820120116.GC3151@thinkpad>
References: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
 <20220819145018.35732-3-manivannan.sadhasivam@linaro.org>
 <Yv+rTZ1u7HXmS5Qk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yv+rTZ1u7HXmS5Qk@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 19, 2022 at 05:25:01PM +0200, Greg KH wrote:
> On Fri, Aug 19, 2022 at 08:20:15PM +0530, Manivannan Sadhasivam wrote:
> > IOCTLs are supposed to return 0 for success and negative error codes for
> > failure. Currently, this driver is returning 0 for failure and 1 for
> > success, that's not correct. Hence, fix it!
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 163 ++++++++++++++-----------------
> >  1 file changed, 76 insertions(+), 87 deletions(-)
> > 
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index db0458039d7d..bbf903c5a5bd 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -174,13 +174,12 @@ static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
> >  	test->irq_type = IRQ_TYPE_UNDEFINED;
> >  }
> >  
> > -static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
> > +static int pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
> >  						int type)
> >  {
> > -	int irq = -1;
> > +	int irq = -EINVAL;
> >  	struct pci_dev *pdev = test->pdev;
> >  	struct device *dev = &pdev->dev;
> > -	bool res = true;
> >  
> >  	switch (type) {
> >  	case IRQ_TYPE_LEGACY:
> > @@ -202,15 +201,16 @@ static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
> >  		dev_err(dev, "Invalid IRQ type selected\n");
> >  	}
> >  
> > +	test->irq_type = type;
> > +
> >  	if (irq < 0) {
> > -		irq = 0;
> > -		res = false;
> > +		test->num_irqs = 0;
> > +		return irq;
> 
> Why are you setting the type if there is an error?
> 

This was the original behaviour, so I kept it as it is. If it needs to be
changed, then it should be done in a separate patch I believe.

> 
> >  	}
> >  
> > -	test->irq_type = type;
> >  	test->num_irqs = irq;
> >  
> > -	return res;
> > +	return 0;
> >  }
> >  
> >  static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
> > @@ -225,7 +225,7 @@ static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
> >  	test->num_irqs = 0;
> >  }
> >  
> > -static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
> > +static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
> >  {
> >  	int i;
> >  	int err;
> > @@ -240,7 +240,7 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
> >  			goto fail;
> >  	}
> >  
> > -	return true;
> > +	return 0;
> >  
> >  fail:
> >  	switch (irq_type) {
> > @@ -260,10 +260,10 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
> >  		break;
> >  	}
> >  
> > -	return false;
> > +	return err;
> >  }
> >  
> > -static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> > +static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
> >  				  enum pci_barno barno)
> >  {
> >  	int j;
> > @@ -272,7 +272,7 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> >  	struct pci_dev *pdev = test->pdev;
> >  
> >  	if (!test->bar[barno])
> > -		return false;
> > +		return -ENOMEM;
> 
> How is this no memory?
>

No bar means a failure in pci_ioremap_bar() during probe. And that implies a
failure while mapping the device's BAR in host memory. So -ENOMEM seems to be
the apt error no.
 
> Shouldn't this not even get here if the allocation failed?
> 

No, the driver tries to map PCI_STD_NUM_BARS which is 6 and if some of them are
not available except BAR_0 then it just logs an error and continues. So it is
not fatal.

> >  
> >  	size = pci_resource_len(pdev, barno);
> >  
> > @@ -285,13 +285,13 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> >  	for (j = 0; j < size; j += 4) {
> >  		val = pci_endpoint_test_bar_readl(test, barno, j);
> >  		if (val != 0xA0A0A0A0)
> > -			return false;
> > +			return -EINVAL;
> 
> Is this really an invalid value sent to the ioctl?
> 
> 
> >  	}
> >  
> > -	return true;
> > +	return 0;
> >  }
> >  
> > -static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
> > +static int pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
> >  {
> >  	u32 val;
> >  
> > @@ -303,12 +303,12 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
> >  	val = wait_for_completion_timeout(&test->irq_raised,
> >  					  msecs_to_jiffies(1000));
> >  	if (!val)
> > -		return false;
> > +		return -ETIMEDOUT;
> >  
> > -	return true;
> > +	return 0;
> >  }
> >  
> > -static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
> > +static int pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
> >  				       u16 msi_num, bool msix)
> >  {
> >  	u32 val;
> > @@ -324,19 +324,18 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
> >  	val = wait_for_completion_timeout(&test->irq_raised,
> >  					  msecs_to_jiffies(1000));
> >  	if (!val)
> > -		return false;
> > +		return -ETIMEDOUT;
> >  
> > -	if (pci_irq_vector(pdev, msi_num - 1) == test->last_irq)
> > -		return true;
> > +	if (pci_irq_vector(pdev, msi_num - 1) != test->last_irq)
> > +		return -EINVAL;
> 
> Again, is this an invalid value passed to the ioctl?
> 
> Same for other places you are doing something and then returning this
> error value, are you sure that is correct?
> 
> -EINVAL should be "the values you sent me was incorrect", not "something
> bad happened based on what you gave me".
> 

Okay. Will revisit all of them.

Thanks,
Mani

-- 
மணிவண்ணன் சதாசிவம்
