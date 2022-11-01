Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA0C614C2C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 15:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiKAODr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 10:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiKAODp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 10:03:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C6820D
        for <linux-pci@vger.kernel.org>; Tue,  1 Nov 2022 07:03:43 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 17so9291717pfv.4
        for <linux-pci@vger.kernel.org>; Tue, 01 Nov 2022 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=25r7x71BJUlLmcpTtBOvRX5e+DPvRIUazgMCBLedLV4=;
        b=EHwHs/eoA11NfprJ9r1RMuqVDVLi0ivOmk0YkDR3SUc3U9iRkiJGI94psFRKl236UT
         vQxQS3jZob54t5+AdBe16s2vlW9OeUY1WMPnEdaACC8JnhyXclYxM2A2a/2wa0/CPmz5
         lt6WXqPUP+dIao3FBfzp5JvqE/lOgpdSKteL0ivNn0fc2pLZbMUwH5JdL2Jh/LudZRg7
         MD+9RhtwiRQDC3Sxwdo8Qzy3xGH4eZUR5RzV0tcGzrdzzWUmuOKx8c4GQnHY6dTAmS8x
         FpAUQSsHtyh3AjSKYABvn4UeuchTHjiowBuSJ9De/iAXtM0Py4ma9Vqzt7PLTM8j8cWD
         iU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25r7x71BJUlLmcpTtBOvRX5e+DPvRIUazgMCBLedLV4=;
        b=Wy44s2NLgQqH3iTCEmOzORyT6+29lVX5cTcm3eATVASaEB58ix7YGB5aaaRV/EJ+fX
         /qJaWXhtHw/wiB11cwQpxW69wz2Au+9gN2DlfkDLXjUh8VY6OMOWA1HiBYe1scWeADIY
         /XRASwnnXr7OTGkXknuREL3Xz0KJV6MqUjD0F4b26JSIEOStVkfvNeICuKYkp911qDqD
         +1Eyrn00gU45JfqE/ceU4OJaKahkARLG0AZ438z4jEWlJvAbA3XUCKFIDDEfl54RroAE
         ycK8BEh01+J21DkCAWTbTGZ88suMIMmkebkMmLceE/ZF0DEAG4jSU0B4D59dWz9a5hXC
         Sj4w==
X-Gm-Message-State: ACrzQf1ILLZOhHq6s5lgkOuPm25rMLyGU3NvQhv+UF+J2WasnUs/iTXE
        vkpok0qp2SwbII7oVYj/gyoI
X-Google-Smtp-Source: AMsMyM7Wa/jVKlqcT3G0BD15kt2pJPA8yGLcpyUm+ILPa0nW4abZp6r43DQwzw3XDd68Ihms2ZnLFg==
X-Received: by 2002:a05:6a00:1d06:b0:56b:ec38:27e9 with SMTP id a6-20020a056a001d0600b0056bec3827e9mr19659995pfx.71.1667311422902;
        Tue, 01 Nov 2022 07:03:42 -0700 (PDT)
Received: from thinkpad ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090a020700b002132f3e71c6sm6058590pjc.52.2022.11.01.07.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 07:03:41 -0700 (PDT)
Date:   Tue, 1 Nov 2022 19:33:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     kishon@ti.com, gregkh@linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mie@igel.co.jp, kw@linux.com
Subject: Re: [PATCH v2 0/5] pci_endpoint_test: Fix the return value of IOCTLs
Message-ID: <20221101140334.GP54667@thinkpad>
References: <20220824123010.51763-1-manivannan.sadhasivam@linaro.org>
 <Yxs7JlQ8jzNNwvdi@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yxs7JlQ8jzNNwvdi@lpieralisi>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 09, 2022 at 03:09:58PM +0200, Lorenzo Pieralisi wrote:
> On Wed, Aug 24, 2022 at 06:00:05PM +0530, Manivannan Sadhasivam wrote:
> > During the review of a patch for pci_endpoint_test driver [1], Greg spotted
> > the wrong usage of the return value of IOCTLs in the driver. This series
> > fixes that by returning 0 for success and negative error code for failure.
> > Relevant change is also made to the userspace tool and the Documentation.
> > 
> > Along with those, there are couple more patches fixing other small issues
> > I noted.
> > 
> > NOTE: I have just compile tested this series. So it'd be good if someone
> > can test it on the PCI endpoint setup.
> > 
> > Thanks,
> > Mani
> > 
> > [1] https://lore.kernel.org/all/20220816100617.90720-1-mie@igel.co.jp/
> > 
> > Changes in v2:
> > 
> > * Fixed the error numbers in pci_endpoint_test
> > * Added Fixes tag and CCed stable list for relevant patches. The patches
> >   should get backported until 5.10 kernel only. Since for the LTS kernels
> >   before that, the pci_endpoint_test driver was not supporting all commands.
> > 
> > Manivannan Sadhasivam (5):
> >   misc: pci_endpoint_test: Fix the return value of IOCTL
> >   tools: PCI: Fix parsing the return value of IOCTLs
> >   Documentation: PCI: endpoint: Use the correct return value of
> >     pcitest.sh
> >   misc: pci_endpoint_test: Remove unnecessary WARN_ON
> >   tools: PCI: Fix memory leak
> > 
> >  Documentation/PCI/endpoint/pci-test-howto.rst | 152 ++++++++--------
> >  drivers/misc/pci_endpoint_test.c              | 167 ++++++++----------
> >  tools/pci/pcitest.c                           |  48 ++---
> >  3 files changed, 179 insertions(+), 188 deletions(-)
> 
> May I ask where are we with this thread ? I have noticed some key
> comments from Greg that need addressing so I'd expect a new version.
> 

Sorry for the late response. Yes, there will be a new version.

Thanks,
Mani

> Thanks,
> Lorenzo

-- 
மணிவண்ணன் சதாசிவம்
