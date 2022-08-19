Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EFB599E27
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 17:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349697AbiHSPZK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 11:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349711AbiHSPZJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 11:25:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC0B883D2;
        Fri, 19 Aug 2022 08:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E6FADCE2689;
        Fri, 19 Aug 2022 15:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0D8C433C1;
        Fri, 19 Aug 2022 15:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660922705;
        bh=YG9oaqVO7xrgsjGFwRl7uekmuu7kg3be4zVrVLl6lM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MF8QlLnHbmI4k23WS+w2bqoka6EBG+AQl3aBf+k4HEeSWTa/CxuTTNTbQOMYsLlXC
         g5LiDZs0WltKbVhekIIH6dfYmfqjd3K8y2nJy5a0rRot4zevXq/rnD5G7WtZ/CWzW3
         kBqMHWi5vdJu8MCtoj507y3f+HaWZRlS/yhU79qo=
Date:   Fri, 19 Aug 2022 17:25:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kishon@ti.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mie@igel.co.jp, kw@linux.com
Subject: Re: [PATCH 2/5] misc: pci_endpoint_test: Fix the return value of
 IOCTL
Message-ID: <Yv+rTZ1u7HXmS5Qk@kroah.com>
References: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
 <20220819145018.35732-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819145018.35732-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 19, 2022 at 08:20:15PM +0530, Manivannan Sadhasivam wrote:
> IOCTLs are supposed to return 0 for success and negative error codes for
> failure. Currently, this driver is returning 0 for failure and 1 for
> success, that's not correct. Hence, fix it!
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 163 ++++++++++++++-----------------
>  1 file changed, 76 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index db0458039d7d..bbf903c5a5bd 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -174,13 +174,12 @@ static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
>  	test->irq_type = IRQ_TYPE_UNDEFINED;
>  }
>  
> -static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
> +static int pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
>  						int type)
>  {
> -	int irq = -1;
> +	int irq = -EINVAL;
>  	struct pci_dev *pdev = test->pdev;
>  	struct device *dev = &pdev->dev;
> -	bool res = true;
>  
>  	switch (type) {
>  	case IRQ_TYPE_LEGACY:
> @@ -202,15 +201,16 @@ static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
>  		dev_err(dev, "Invalid IRQ type selected\n");
>  	}
>  
> +	test->irq_type = type;
> +
>  	if (irq < 0) {
> -		irq = 0;
> -		res = false;
> +		test->num_irqs = 0;
> +		return irq;

Why are you setting the type if there is an error?


>  	}
>  
> -	test->irq_type = type;
>  	test->num_irqs = irq;
>  
> -	return res;
> +	return 0;
>  }
>  
>  static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
> @@ -225,7 +225,7 @@ static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
>  	test->num_irqs = 0;
>  }
>  
> -static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
> +static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>  {
>  	int i;
>  	int err;
> @@ -240,7 +240,7 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>  			goto fail;
>  	}
>  
> -	return true;
> +	return 0;
>  
>  fail:
>  	switch (irq_type) {
> @@ -260,10 +260,10 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>  		break;
>  	}
>  
> -	return false;
> +	return err;
>  }
>  
> -static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> +static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
>  	int j;
> @@ -272,7 +272,7 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  	struct pci_dev *pdev = test->pdev;
>  
>  	if (!test->bar[barno])
> -		return false;
> +		return -ENOMEM;

How is this no memory?

Shouldn't this not even get here if the allocation failed?

>  
>  	size = pci_resource_len(pdev, barno);
>  
> @@ -285,13 +285,13 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  	for (j = 0; j < size; j += 4) {
>  		val = pci_endpoint_test_bar_readl(test, barno, j);
>  		if (val != 0xA0A0A0A0)
> -			return false;
> +			return -EINVAL;

Is this really an invalid value sent to the ioctl?


>  	}
>  
> -	return true;
> +	return 0;
>  }
>  
> -static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
> +static int pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
>  {
>  	u32 val;
>  
> @@ -303,12 +303,12 @@ static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
>  	val = wait_for_completion_timeout(&test->irq_raised,
>  					  msecs_to_jiffies(1000));
>  	if (!val)
> -		return false;
> +		return -ETIMEDOUT;
>  
> -	return true;
> +	return 0;
>  }
>  
> -static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
> +static int pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
>  				       u16 msi_num, bool msix)
>  {
>  	u32 val;
> @@ -324,19 +324,18 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
>  	val = wait_for_completion_timeout(&test->irq_raised,
>  					  msecs_to_jiffies(1000));
>  	if (!val)
> -		return false;
> +		return -ETIMEDOUT;
>  
> -	if (pci_irq_vector(pdev, msi_num - 1) == test->last_irq)
> -		return true;
> +	if (pci_irq_vector(pdev, msi_num - 1) != test->last_irq)
> +		return -EINVAL;

Again, is this an invalid value passed to the ioctl?

Same for other places you are doing something and then returning this
error value, are you sure that is correct?

-EINVAL should be "the values you sent me was incorrect", not "something
bad happened based on what you gave me".

thanks,

greg k-h
