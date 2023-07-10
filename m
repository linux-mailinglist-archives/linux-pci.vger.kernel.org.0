Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B639E74DBE4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jul 2023 19:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjGJRGO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 13:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGJRGN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 13:06:13 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31FABB;
        Mon, 10 Jul 2023 10:06:12 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-666e916b880so2073127b3a.2;
        Mon, 10 Jul 2023 10:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689008772; x=1691600772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Iw8KZUJTj1cchn5BEOBZt1C0ElzOm95lZTUa+kZmbA=;
        b=VC5EqQTukL0uD4xZ36UESsvdbKfe+1QzNdpxM+IeQAgg6iv8+4MWUU1M/ZoQ+8vJ4c
         oOzPExXlb/vN+g6TfE11fuNqYNMSRtKwU7T5xyWsB4AlB36+KTxJTbmE+AlFffhSOkxm
         xFbfnjlPYqDaIKRbthO1Re/hAdXgou0zY4K/lTwBtXbD5B0al2bG1UWhJzngf6v6nnVK
         gol0oOcNRRVhGvYC0OPYDXA+wJkDQz23EREuBF+9ajZh88gg/OkTMCrKLSFGSoTGQSnd
         xaVLP6DJO96O3jBuZXropNaUMFUPkMsLjuS1S1M5Onk5qKNZV+cNMeKmUrfTi0ebB8GW
         TXzA==
X-Gm-Message-State: ABy/qLaLJbaPL7tv9Xneg+b3lmLSRKyPFFHBRQKLFChZZsnoO3uxhFxV
        tL8nsoCLBneeWIunENdz3GM=
X-Google-Smtp-Source: APBJJlE4EzggNERv/+HFTohbu2uCg6hgjiYuw8vzlGn9/PAgZ9dvSgFsznTsOjig7ZpQMjOmBpVNsg==
X-Received: by 2002:a05:6a20:1449:b0:123:828f:68c with SMTP id a9-20020a056a20144900b00123828f068cmr12620273pzi.50.1689008771822;
        Mon, 10 Jul 2023 10:06:11 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id s62-20020a637741000000b0055c178a8df1sm5739093pgc.94.2023.07.10.10.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 10:06:10 -0700 (PDT)
Date:   Tue, 11 Jul 2023 02:06:08 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Ajay Agarwal <ajayagarwal@google.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH] Revert "PCI: dwc: Wait for link up only if link is
 started"
Message-ID: <20230710170608.GA346178@rocinante>
References: <20230706082610.26584-1-johan+linaro@kernel.org>
 <20230706125811.GD4808@thinkpad>
 <ZKgJfG5Mi-e77LQT@hovoldconsulting.com>
 <ZKwwAin4FcCETGq/@google.com>
 <ZKw03xjH5VdL/JHD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKw03xjH5VdL/JHD@google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> > > > > Finally, note that the intel-gw driver is the only driver currently not
> > > > > providing a start_link callback and instead starts the link in its
> > > > > host_init callback, and which may avoid an additional one-second timeout
> > > > > during probe by making the link-up wait conditional. If anyone cares,
> > > > > that can be done in a follow-up patch with a proper motivation.
> > > 
> > > > The offending commit is bogus since it makes the intel-gw _special_ w.r.t
> > > > waiting for the link up. Most of the drivers call dw_pcie_host_init() during the
> > > > probe time and they all have to wait for 1 sec if the slot is empty.
> >
> > Mani, can you please explain how my commit made the intel-gw driver
> > special? The intel driver actually fails the dw_pcie_host_init if the
> > link does not come up. That was my motivation behind adding the fail
> > logic in the core driver as well.
> > > 
> > > Just to clarify, the intel-gw driver starts the link and waits for link
> > > up in its host_init() callback, which is called during probe. That wait
> > > could possibly just be dropped in favour of the one in
> > > dw_pcie_host_init() and/or the driver could be reworked to implement
> > > start_link().
> > > 
> > > Either way, the call in dw_pcie_host_init() will only add an additional
> > > 1 second delay in cases where the link did *not* come up.
> > > 
> > > > As Johan noted, intel-gw should make use of the async probe to avoid the boot
> > > > delay instead of adding a special case.
> > > 
> > > Indeed.

The whole conversation above about the intel-gw driver: would something
need to be addressed here?  Or can I pick the suggested fix?

> > My apologies for adding this regression in some of the SOCs.
> > May I suggest to keep my patch and make the following change instead?
> > This shall keep the existing behavior as is, and save the boot time
> > for drivers that do not define the start_link()?
[...]

> I just realized that Fabio pushed exactly the same patch as I suggested
> here:
> https://lore.kernel.org/all/20230704122635.1362156-1-festevam@gmail.com/.
> I think it is better we take it instead of reverting my commit.

Will do.  I will also make sure that we have correct attributions in place.

	Krzysztof
