Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBB6729FB5
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242125AbjFIQKm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 12:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242116AbjFIQKk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 12:10:40 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574EA35BC
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 09:10:36 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b038064d97so7822075ad.0
        for <linux-pci@vger.kernel.org>; Fri, 09 Jun 2023 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686327036; x=1688919036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sFUAFP5ptKF9i1DX/sdXd+RC2UZtcoQAkwMutNG+aSc=;
        b=TE8HaICBN/0Ax7Okr7xnZeVgpaM0mni9irF6vSYt7KtO7JKzU6aguLbz7IwHMgihTj
         xqv8rI81jumHhIBfN78ajHTDkA9+yoYXlSWz1DbLdC9RVGLmiqg8gKCQEiAUkBYfHMpA
         7hn7uqLRZyzNpxD+ua3VzVTTNDZq5fRExdysAmR7AUynaXbjMa25O33t5jelW1Q90+Am
         ShHLt8kPhtMqOspeKSgnVFd0nHm+jMUxKooYYuyObH9fJ7C7bxD/np6vn6nBIibQD1uh
         KEOxriTaMCx/nZhig9tm2eV3HpiM+IFBpi9/9u9RdF773RSWnn5cpVVJniMAq6eTjOU6
         cPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327036; x=1688919036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFUAFP5ptKF9i1DX/sdXd+RC2UZtcoQAkwMutNG+aSc=;
        b=SMbFE1SDwO8j7mmzUoZO7aPOLCOBwRSYcoPCwG76bXr8SENOta8/vqveyDb08nQF0v
         bmpTlyA5Uhi1gvh64Gv5cD/VEQ27l8/9giFvTaSJnQi2NNlGdyjkI+8CKN6GJADRgfU/
         Ow4NzZmCE3e0RPW/1OTBMEBb5Is5JLcABjex3RO3kfspnYRgNSGr7LlypweWNWM+4BwW
         M5QE6m7UMlXgsfeJDx1IKW3WnbLQGJX5TtijFRClbFXCeCiGfpyVdRKsGDXNYXa790+d
         uhFGPmlP1jpsfs6YH0zDGREtQ8SSBpnkC9ivp1RgdlLz83VIBN/Ynh2B5n8X0rDpZ0WD
         +MCQ==
X-Gm-Message-State: AC+VfDxT9oxvF0JEDCB04z8nBvcYNQvd9ii5lYXoeBIbNMv4vovKNlHe
        7p8OQrrM1Espy7/4JghsnXyAK6azDu0CwjaCTg==
X-Google-Smtp-Source: ACHHUZ6nGqlsmw10WFMwRr0+VqM/PpRECoAhWjX1RfecCN76SnaBVOc8xmTt0Td+nbYpd9/Fh2zfnw==
X-Received: by 2002:a17:902:db12:b0:1b1:99c9:8ce5 with SMTP id m18-20020a170902db1200b001b199c98ce5mr6111685plx.16.1686327035563;
        Fri, 09 Jun 2023 09:10:35 -0700 (PDT)
Received: from thinkpad ([117.202.185.129])
        by smtp.gmail.com with ESMTPSA id r17-20020a170902c61100b001ac84f5559csm3472967plr.126.2023.06.09.09.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:10:34 -0700 (PDT)
Date:   Fri, 9 Jun 2023 21:40:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     tjoseph@cadence.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, nadeem@cadence.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com,
        nm@ti.com
Subject: Re: [PATCH v3] PCI: cadence: Fix Gen2 Link Retraining process
Message-ID: <20230609161029.GG6847@thinkpad>
References: <20230607091427.852473-1-s-vadapalli@ti.com>
 <20230608154206.GI5672@thinkpad>
 <67865af6-7ea4-63e3-6c35-4cd038f36af3@ti.com>
 <20230609055737.GA6847@thinkpad>
 <a63fc8b0-581b-897f-cac6-cb0a0e82c63e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a63fc8b0-581b-897f-cac6-cb0a0e82c63e@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 09, 2023 at 11:59:09AM +0530, Siddharth Vadapalli wrote:
> 
> 
> On 09/06/23 11:27, Manivannan Sadhasivam wrote:
> > On Fri, Jun 09, 2023 at 09:46:20AM +0530, Siddharth Vadapalli wrote:
> >> Hello Mani,
> >>
> >> Thank you for reviewing this patch.
> >>
> >> On 08/06/23 21:12, Manivannan Sadhasivam wrote:
> >>> On Wed, Jun 07, 2023 at 02:44:27PM +0530, Siddharth Vadapalli wrote:
> >>>> The Link Retraining process is initiated to account for the Gen2 defect in
> >>>> the Cadence PCIe controller in J721E SoC. The errata corresponding to this
> >>>> is i2085, documented at:
> >>>> https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
> >>>>
> >>>> The existing workaround implemented for the errata waits for the Data Link
> >>>> initialization to complete and assumes that the link retraining process
> >>>> at the Physical Layer has completed. However, it is possible that the
> >>>> Physical Layer training might be ongoing as indicated by the
> >>>> PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.
> >>>>
> >>>> Fix the existing workaround, to ensure that the Physical Layer training
> >>>> has also completed, in addition to the Data Link initialization.
> >>>>
> >>>
> >>> cdns_pcie_host_wait_for_link() function is called even for the non-quirky cases
> >>> as well, so does this patch. But if your patch is only targeting the link
> >>> retraining case, you should move the logic to cdns_pcie_retrain().
> >>
> >> In the v2 version of this patch at:
> >> https://lore.kernel.org/r/20230315070800.1615527-1-s-vadapalli@ti.com/
> >> I had implemented it as suggested above by you. However, based on the discussion
> >> with Bjorn at:
> >> https://lore.kernel.org/r/20230509182416.GA1259841@bhelgaas/
> >> it was agreed upon that waiting for two things in succession doesn't seem to be
> >> the best way to implement it. Therefore, the cdns_pcie_host_training_complete()
> >> function in the v2 patch is merged into the cdns_pcie_host_wait_for_link()
> >> function in this patch.
> >>
> > 
> > I think Bjorn's point was to make the wait_for_link() behavior same across
> > drivers. While I agree with that, I'd like to know whether adding this wait for
> > all cases (not just during link retraining quirk) adds up any latency or not.
> > 
> > Can you measure that?
> 
> For J7200 SoC which doesn't have the link retraining quirk set, I added prints
> before and after the exact section of newly added code with this patch. The
> output with timestamps for the case where no EP is connected to the board is:
> [    1.350061] j721e-pcie 2910000.pcie: <1> Before link training check
> [    1.356324] j721e-pcie 2910000.pcie: Link training complete
> [    1.361883] j721e-pcie 2910000.pcie: <1> After link training check
> indicating a latency of about 12 milliseconds.
> 
> On the other hand, with an EP device connected, the output is:
> [    1.349822] j721e-pcie 2910000.pcie: <1> Before link training check
> [    1.356083] j721e-pcie 2910000.pcie: Link training complete
> [    1.361641] j721e-pcie 2910000.pcie: <1> After link training check
> again indicating a latency of about 12 milliseconds.
> 
> For the J721e SoC which has the quirk, without an EP device connected, the
> output is:
> [    2.668926] j721e-pcie 2910000.pcie: <1> Before link training check
> [    2.675178] j721e-pcie 2910000.pcie: Link training complete
> [    2.680734] j721e-pcie 2910000.pcie: <1> After link training check
> with the latency again being about 12 milliseconds.
> 
> Now, with the EP device connected to the board with J721e SoC, the output for
> the training phase is:
> [    2.685335] j721e-pcie 2910000.pcie: <1> Before link training check
> [    2.691592] j721e-pcie 2910000.pcie: Link training complete
> [    2.697150] j721e-pcie 2910000.pcie: <1> After link training check
> and for the retraining phase is:
> [    2.807581] j721e-pcie 2910000.pcie: <1> Before link training check
> [    2.831578] j721e-pcie 2910000.pcie: LINK DOWN!
> [    2.831905] j721e-pcie 2910000.pcie: Link training complete
> [    2.841653] j721e-pcie 2910000.pcie: <1> After link training check
> During the training phase, the latency again is about 12 milliseconds, while
> during the retraining phase, the latency is about 34 milliseconds.
> 
> Note, the above latency is measured for the Non-RT Linux kernel, with the
> assumption that the latency will be lower for the RT Linux kernel.
> 
> I suppose this indicates a latency of about 12 milliseconds for the PCIe
> controllers without the Gen2 Link Retraining quirk, while for the PCIe
> controller with the Gen2 Link Retraining quirk, it is a net latency of 12+34
> milliseconds = 46 milliseconds for the training and retraining phases.
> 

Thanks for the detailed measurement. So the latency of 12ms for non-quirky
devices seems fine to me, unless someone really cares about optimizing boot
time.

- Mani

> > 
> >>>
> >>>
> >>>> Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
> >>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >>>> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> >>>> ---
> >>>>
> >>>> Hello,
> >>>>
> >>>> This patch is based on linux-next tagged next-20230606.
> >>>>
> >>>> v2:
> >>>> https://lore.kernel.org/r/20230315070800.1615527-1-s-vadapalli@ti.com/
> >>>> Changes since v2:
> >>>> - Merge the cdns_pcie_host_training_complete() function with the
> >>>>   cdns_pcie_host_wait_for_link() function, as suggested by Bjorn
> >>>>   for the v2 patch.
> >>>> - Add dev_err() to notify when Link Training fails, since this is a
> >>>>   fatal error and proceeding from this point will almost always crash
> >>>>   the kernel.
> >>>>
> >>>> v1:
> >>>> https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com/
> >>>> Changes since v1:
> >>>> - Collect Reviewed-by tag from Vignesh Raghavendra.
> >>>> - Rebase on next-20230315.
> >>>>
> >>>> Regards,
> >>>> Siddharth.
> >>>>
> >>>>  .../controller/cadence/pcie-cadence-host.c    | 20 +++++++++++++++++++
> >>>>  1 file changed, 20 insertions(+)
> >>>>
> >>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >>>> index 940c7dd701d6..70a5f581ff4f 100644
> >>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> >>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >>>> @@ -12,6 +12,8 @@
> >>>>  
> >>>>  #include "pcie-cadence.h"
> >>>>  
> >>>> +#define LINK_RETRAIN_TIMEOUT HZ
> >>>> +
> >>>>  static u64 bar_max_size[] = {
> >>>>  	[RP_BAR0] = _ULL(128 * SZ_2G),
> >>>>  	[RP_BAR1] = SZ_2G,
> >>>> @@ -80,8 +82,26 @@ static struct pci_ops cdns_pcie_host_ops = {
> >>>>  static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
> >>>>  {
> >>>>  	struct device *dev = pcie->dev;
> >>>> +	unsigned long end_jiffies;
> >>>> +	u16 link_status;
> >>>>  	int retries;
> >>>>  
> >>>> +	/* Wait for link training to complete */
> >>>> +	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
> >>>> +	do {
> >>>> +		link_status = cdns_pcie_rp_readw(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKSTA);
> >>>> +		if (!(link_status & PCI_EXP_LNKSTA_LT))
> >>>> +			break;
> >>>> +		usleep_range(0, 1000);
> >>>> +	} while (time_before(jiffies, end_jiffies));
> >>>> +
> >>>> +	if (!(link_status & PCI_EXP_LNKSTA_LT)) {
> >>>> +		dev_info(dev, "Link training complete\n");
> >>>
> >>> This info is not needed.
> >>
> >> Sure. I will drop it in the v4 patch.
> >>
> >>>
> >>>> +	} else {
> >>>> +		dev_err(dev, "Fatal! Link training incomplete\n");
> >>>
> >>> This could be, "Link retraining incomplete".
> >>
> >> I added the word "Fatal" since Linux is almost always guaranteed to crash if the
> >> link training doesn't complete before the PCI subsystem attempts to enumerate
> >> the EP devices. Therefore, adding the word "Fatal" will help the users identify
> >> what the cause of the crash is, which would otherwise be overlooked, unless the
> >> critical nature of this error is conveyed to the user.
> >>
> > 
> > Ok.
> > 
> > - Mani
> > 
> >>>
> >>> - Mani
> >>>
> >>>> +		return -ETIMEDOUT;
> >>>> +	}
> >>>> +
> >>>>  	/* Check if the link is up or not */
> >>>>  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> >>>>  		if (cdns_pcie_link_up(pcie)) {
> >>>> -- 
> >>>> 2.25.1
> >>>>
> >>>
> >>
> >> -- 
> >> Regards,
> >> Siddharth.
> > 
> 
> -- 
> Regards,
> Siddharth.

-- 
மணிவண்ணன் சதாசிவம்
