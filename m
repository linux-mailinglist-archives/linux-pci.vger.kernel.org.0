Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C584BB9E7
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 14:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiBRNOP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Feb 2022 08:14:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiBRNOO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Feb 2022 08:14:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495621BE077;
        Fri, 18 Feb 2022 05:13:57 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bg10so15001790ejb.4;
        Fri, 18 Feb 2022 05:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2rr4tmi7/d0PvHdO4onYfUR4YvrcRNFtlu5Wyv5itrM=;
        b=FhW+J6S+lwhp+0e20MHUdBowUwSmmRoeYeeoPK1VwSrUJvNbrC1Zos5gbbgENd1X9o
         Tcki/9zZB8RCQ9Als6J6AbgSC2C6kNhaV0J/bSJiWQWWnaFyVKCUGZtVHnyz/4+DIrwQ
         swR7w1YANDn2Va9KxvpMvtAtxQzanTQc2OoY4aZY+8lfonQOqdUSVx+pPigIkmuLEghc
         Nw2lB5dxBAD1mcIxYmzer+VbKIywXaxaxi4HVHbD3Wp4HpYwWFXrm9zFXKpv214zNdSy
         lVpVvGCPWUmhRyh8Um8o4AEc0V8ECv8PlM1YvUEEA7pOIa3r4nq2m/paNhFBKrlMgkPQ
         fwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2rr4tmi7/d0PvHdO4onYfUR4YvrcRNFtlu5Wyv5itrM=;
        b=3xxsYhoOhh5MJAFaWohsk3J7ZCS5sj13p1XrwyZJrW+nWe8wXhrLbz1Jtla/kMEL33
         ODh7xELoVPlZMjOfT1r1RfVC+7qgMu9QEYIbvICrwZQU1k+Exl5rC0cOhhlivC8GgpwA
         TqC7I5tKcNU1BJMm/64nXH1rZJ9gRbBLz215zXbBToRvH6BvpEuOk88UJgxcYGtpNdBC
         X9gEnRbXSgFvyStTCGGIFmX92bSRBPUARKUyQVbqxh5TOHYT/x5IOi52RN6BaWAKwWwf
         bm8oXqkppg51mEIJ75INRZdXmoTbLcOLlzX8svOy8MVPIBegrUxR1YnHWndcbl0zRyoh
         +f9Q==
X-Gm-Message-State: AOAM530NEDpuEbsdwhqlqdQUo5MsAmzJaqNPoS/B8jeKfqSZuRNfopcv
        fEXanQaZG6NwMSGdRvO+3I/WZh9Jyoe84VmAaqk=
X-Google-Smtp-Source: ABdhPJxl+IQGTmAKoqkdMrngrr13yLSAsVP8hfHBAXMPVfVWdOd5SK0ailB8rMVVElRPkUqg5y2xJl0LMkEaVPIeuzI=
X-Received: by 2002:a17:906:ae97:b0:6cf:73fe:8515 with SMTP id
 md23-20020a170906ae9700b006cf73fe8515mr6366008ejb.462.1645190035697; Fri, 18
 Feb 2022 05:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20220131220518.GA515079@bhelgaas> <bac4cc7e-f81e-82e6-9b60-e5e3199637d7@ti.com>
In-Reply-To: <bac4cc7e-f81e-82e6-9b60-e5e3199637d7@ti.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 18 Feb 2022 14:13:44 +0100
Message-ID: <CAH9NwWcChBLEwLrzUEcvh7EXtjaEBe5rZo0gHNnzXnaV9p5QGA@mail.gmail.com>
Subject: Re: [PATCH] PCI: cadence: respond to received PTM Requests
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Am Fr., 18. Feb. 2022 um 11:56 Uhr schrieb Kishon Vijay Abraham I
<kishon@ti.com>:
>
> Hi Bjorn,
>
> On 01/02/22 3:35 am, Bjorn Helgaas wrote:
> > Update subject line to match previous conventions ("git log --oneline
> > drivers/pci/controller/cadence/pcie-cadence-host.c" to see).
> >
> > On Mon, Jan 31, 2022 at 01:08:27PM +0100, Christian Gmeiner wrote:
> >> This enables the Controller [RP] to automatically respond
> >> with Response/ResponseD messages.
> >
> > Update to imperative mood, e.g., "Enable Controller to ...":
> >
> >   https://chris.beams.io/posts/git-commit/
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst?id=v5.16#n134
> >
> >> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> >> ---
> >>  drivers/pci/controller/cadence/pcie-cadence-host.c | 10 ++++++++++
> >>  drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++++
> >>  2 files changed, 14 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> index fb96d37a135c..940c7dd701d6 100644
> >> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> @@ -123,6 +123,14 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
> >>      return ret;
> >>  }
> >>
> >> +static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
> >> +{
> >> +    u32 val;
> >> +
> >> +    val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> >> +    cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
> >
> > I assume this is some device-specific enable bit that is effectively
> > ANDed with PCI_PTM_CTRL_ENABLE in the Precision Time Measurement
> > Capability?
>
> That's correct. This bit enables Controller [RP] to respond to the received PTM
> Requests.
>

With that information is it okay for you that I send a V2 of this
patch with an improved commit message or do
you see any other problems that I need to take into account?

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
