Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2789728F91
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 07:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbjFIF6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 01:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbjFIF5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 01:57:50 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950033580
        for <linux-pci@vger.kernel.org>; Thu,  8 Jun 2023 22:57:44 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33e4e59da95so6426725ab.2
        for <linux-pci@vger.kernel.org>; Thu, 08 Jun 2023 22:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686290263; x=1688882263;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=++2Zj1omCLLppu446gvNENuVYrBxM0BkVm2pcONPHCw=;
        b=mJEksCrESHsJiex1or4mBAdTqS8mtSQXqx32WSM0EtiLydQdkeHaajbo2P1enf/Cdn
         edR1ScgCRG7tUAhcANwXFfbPbctS63b2XcPB+5i5urD4A0q6IVqEnEoJOdYZv0+LIz8w
         FVwJVbvpzk70BJ3yRMy08Y6qNeOIaIcohuVUfi5Yq8YcEJSowC0nOXR7jkGxEsrijIjQ
         o2tCkl6kM9/vKV3KhABhJPzBLgtFcJCRATEBUkBsirD0Mdj1pPsKywUwKtzNZneAhKaP
         +8jcAybypAjdMf81gHzS0yfIgS0zCw5TlKomlFBCGXy5lqY1jDgbwNXRHBostzpaTkQe
         0jSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686290263; x=1688882263;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++2Zj1omCLLppu446gvNENuVYrBxM0BkVm2pcONPHCw=;
        b=I1GEF+Gy9YE/oHeHb+H6ubKZczp46Ub06gP/pHS3KPG+F+r7o5GoNzHppgK48oUWXl
         9G5LKtSP4s5qwbrMQDhnD16ri4vq81AMGKvTIb1/+swJTd98KANGwlKEomjz1wictMUm
         bOmRq30cdBpkAzrtMjI/AVBZ79DOoec2f+F/bhGz8qQhEOIe+Xez9xTFbpNOsikE7EW7
         bKVoMzUVwXsaAK49j1VfQaW0jT8T1JQj1cfPFZLYSac3aujOW6XrPjbJ2ZdbvRceRakT
         3VkyCGwEGv9wUkEkZTA8JE1FUhGMruId55mOyRaYCvcPaCBz2KinUevgWlJaknygPPTG
         DVgA==
X-Gm-Message-State: AC+VfDzKHply7dznMff9VkYYNOjvqVAB4loSwddWr2MlERHEOofk9Y4r
        z7r8j/c2IWzHiNNUGgCRhxSd
X-Google-Smtp-Source: ACHHUZ6GJJrdYE1QiP/Ozdl2rWOQLC5T3Eor5qKvghiCVz8mJ5Y0d+6D5hPCUlbt+nEN01EpI+suhg==
X-Received: by 2002:a92:cbd2:0:b0:338:18f1:db72 with SMTP id s18-20020a92cbd2000000b0033818f1db72mr696567ilq.29.1686290263599;
        Thu, 08 Jun 2023 22:57:43 -0700 (PDT)
Received: from thinkpad ([117.202.186.138])
        by smtp.gmail.com with ESMTPSA id e15-20020aa7824f000000b0063b96574b8bsm1888925pfn.220.2023.06.08.22.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 22:57:43 -0700 (PDT)
Date:   Fri, 9 Jun 2023 11:27:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     tjoseph@cadence.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, nadeem@cadence.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com,
        nm@ti.com
Subject: Re: [PATCH v3] PCI: cadence: Fix Gen2 Link Retraining process
Message-ID: <20230609055737.GA6847@thinkpad>
References: <20230607091427.852473-1-s-vadapalli@ti.com>
 <20230608154206.GI5672@thinkpad>
 <67865af6-7ea4-63e3-6c35-4cd038f36af3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67865af6-7ea4-63e3-6c35-4cd038f36af3@ti.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 09, 2023 at 09:46:20AM +0530, Siddharth Vadapalli wrote:
> Hello Mani,
> 
> Thank you for reviewing this patch.
> 
> On 08/06/23 21:12, Manivannan Sadhasivam wrote:
> > On Wed, Jun 07, 2023 at 02:44:27PM +0530, Siddharth Vadapalli wrote:
> >> The Link Retraining process is initiated to account for the Gen2 defect in
> >> the Cadence PCIe controller in J721E SoC. The errata corresponding to this
> >> is i2085, documented at:
> >> https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
> >>
> >> The existing workaround implemented for the errata waits for the Data Link
> >> initialization to complete and assumes that the link retraining process
> >> at the Physical Layer has completed. However, it is possible that the
> >> Physical Layer training might be ongoing as indicated by the
> >> PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.
> >>
> >> Fix the existing workaround, to ensure that the Physical Layer training
> >> has also completed, in addition to the Data Link initialization.
> >>
> > 
> > cdns_pcie_host_wait_for_link() function is called even for the non-quirky cases
> > as well, so does this patch. But if your patch is only targeting the link
> > retraining case, you should move the logic to cdns_pcie_retrain().
> 
> In the v2 version of this patch at:
> https://lore.kernel.org/r/20230315070800.1615527-1-s-vadapalli@ti.com/
> I had implemented it as suggested above by you. However, based on the discussion
> with Bjorn at:
> https://lore.kernel.org/r/20230509182416.GA1259841@bhelgaas/
> it was agreed upon that waiting for two things in succession doesn't seem to be
> the best way to implement it. Therefore, the cdns_pcie_host_training_complete()
> function in the v2 patch is merged into the cdns_pcie_host_wait_for_link()
> function in this patch.
> 

I think Bjorn's point was to make the wait_for_link() behavior same across
drivers. While I agree with that, I'd like to know whether adding this wait for
all cases (not just during link retraining quirk) adds up any latency or not.

Can you measure that?

> > 
> > 
> >> Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
> >> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> >> ---
> >>
> >> Hello,
> >>
> >> This patch is based on linux-next tagged next-20230606.
> >>
> >> v2:
> >> https://lore.kernel.org/r/20230315070800.1615527-1-s-vadapalli@ti.com/
> >> Changes since v2:
> >> - Merge the cdns_pcie_host_training_complete() function with the
> >>   cdns_pcie_host_wait_for_link() function, as suggested by Bjorn
> >>   for the v2 patch.
> >> - Add dev_err() to notify when Link Training fails, since this is a
> >>   fatal error and proceeding from this point will almost always crash
> >>   the kernel.
> >>
> >> v1:
> >> https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com/
> >> Changes since v1:
> >> - Collect Reviewed-by tag from Vignesh Raghavendra.
> >> - Rebase on next-20230315.
> >>
> >> Regards,
> >> Siddharth.
> >>
> >>  .../controller/cadence/pcie-cadence-host.c    | 20 +++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> index 940c7dd701d6..70a5f581ff4f 100644
> >> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> @@ -12,6 +12,8 @@
> >>  
> >>  #include "pcie-cadence.h"
> >>  
> >> +#define LINK_RETRAIN_TIMEOUT HZ
> >> +
> >>  static u64 bar_max_size[] = {
> >>  	[RP_BAR0] = _ULL(128 * SZ_2G),
> >>  	[RP_BAR1] = SZ_2G,
> >> @@ -80,8 +82,26 @@ static struct pci_ops cdns_pcie_host_ops = {
> >>  static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
> >>  {
> >>  	struct device *dev = pcie->dev;
> >> +	unsigned long end_jiffies;
> >> +	u16 link_status;
> >>  	int retries;
> >>  
> >> +	/* Wait for link training to complete */
> >> +	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
> >> +	do {
> >> +		link_status = cdns_pcie_rp_readw(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKSTA);
> >> +		if (!(link_status & PCI_EXP_LNKSTA_LT))
> >> +			break;
> >> +		usleep_range(0, 1000);
> >> +	} while (time_before(jiffies, end_jiffies));
> >> +
> >> +	if (!(link_status & PCI_EXP_LNKSTA_LT)) {
> >> +		dev_info(dev, "Link training complete\n");
> > 
> > This info is not needed.
> 
> Sure. I will drop it in the v4 patch.
> 
> > 
> >> +	} else {
> >> +		dev_err(dev, "Fatal! Link training incomplete\n");
> > 
> > This could be, "Link retraining incomplete".
> 
> I added the word "Fatal" since Linux is almost always guaranteed to crash if the
> link training doesn't complete before the PCI subsystem attempts to enumerate
> the EP devices. Therefore, adding the word "Fatal" will help the users identify
> what the cause of the crash is, which would otherwise be overlooked, unless the
> critical nature of this error is conveyed to the user.
> 

Ok.

- Mani

> > 
> > - Mani
> > 
> >> +		return -ETIMEDOUT;
> >> +	}
> >> +
> >>  	/* Check if the link is up or not */
> >>  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> >>  		if (cdns_pcie_link_up(pcie)) {
> >> -- 
> >> 2.25.1
> >>
> > 
> 
> -- 
> Regards,
> Siddharth.

-- 
மணிவண்ணன் சதாசிவம்
