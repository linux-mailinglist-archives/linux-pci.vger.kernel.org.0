Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C38D54BB73
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 22:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbiFNUQm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 16:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352180AbiFNUQX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 16:16:23 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1459F4E3BF;
        Tue, 14 Jun 2022 13:14:12 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l18so10960160lje.13;
        Tue, 14 Jun 2022 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DbgTeZvKMZMkY2xBEwLn16RCp1UraZZjgWIgM7gcxt4=;
        b=YpTXdOu04Da4bwX2u1aw6QWfROLDiCc/wAhdO4Irw19oQUV3cMVWMyMzeTALrzrIDr
         ItY22qgrrWwNqIYGFrvai1emx8Qa60T90/ti35dYXFQM1mrAmY9Gp2OEFWe0Yu/u/E/V
         FWwQL872OG6n7SjeX7aAT6GrRnQsSGmYO02+zou7EKuHGS6KzqSorGlt8l3zyaAzDwbx
         fc0r6US8E4gqZWR9Gfs5qKf8ixDOjqwO2xbG6vVVVHAZChReaZ9sbaUdEVsmMFBawbbZ
         zzeaICxiolClh/Tm7CEbfyCUNsWQ/w2CXR0qnpSHoUBMFhleNBLAXrkElqleRunX+R5m
         HrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DbgTeZvKMZMkY2xBEwLn16RCp1UraZZjgWIgM7gcxt4=;
        b=xI/s+z9RgNvdbCfFh3ONzoYLhl8Hu3Odm52EHmTv/cOoVMLeoFNM/XtfhLSR2zJFd4
         8KRwkDTplss8jcR8m3YAOlhknbmB82UswyNssOxgCwT3fhR37zFFjZPdr5Ph2Yd6GeDu
         kgTZsoIjDoXtcULGbqJi+iNr4ihergpiI2c5uGD7TZbupb1SZTk2P6ujbid6WMo8dy1w
         AZybGYeipfsJ6Nhk4RYUv4/A/XhrLPPI5KhXG3rugTFwxl8M+03GPImMv9LGYKy0zm8A
         X1nK3Ighc1JQW8FDY5aBfbdoIOAKFcpZElRZ4BlMAWADRWMBGb3BPPfOm41qhBWHE1VV
         5NqQ==
X-Gm-Message-State: AJIora8aiyYyLorRGVru6SFjhGPmMeOBNndGmgYNtVCOnNrnthJmDQnd
        iM8L/ScGnFJFjOKUD73QhF4=
X-Google-Smtp-Source: AGRyM1vDFpPpioirOpV5lQxK+3AXGHnhFvea+VKCIscwedqxPoieVDlvdcRJsnCaHfgkxr2sdSdhtQ==
X-Received: by 2002:a2e:8805:0:b0:255:6e73:9a67 with SMTP id x5-20020a2e8805000000b002556e739a67mr3510918ljh.426.1655237650240;
        Tue, 14 Jun 2022 13:14:10 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id l18-20020a2e9092000000b002558b05c5f9sm1421196ljg.105.2022.06.14.13.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 13:14:09 -0700 (PDT)
Date:   Tue, 14 Jun 2022 23:14:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/18] PCI: dwc: Discard IP-core version checking on
 unrolled iATU detection
Message-ID: <20220614201407.exci2xtdcd742kjk@mobilestation>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-10-Sergey.Semin@baikalelectronics.ru>
 <20220613202047.GE4188875-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613202047.GE4188875-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 13, 2022 at 02:20:47PM -0600, Rob Herring wrote:
> On Fri, Jun 10, 2022 at 11:25:25AM +0300, Serge Semin wrote:
> > It's pretty much pointless. Even though unrolled version of the internal
> > ATU has been indeed available since DWC PCIe v4.80a IP-core, there is no
> > guarantee it was enabled during the IP-core configuration (Synopsys
> > suggests to contact the Solvnet support for guidance of how to do that for
> > the newer IP-cores). So the only reliable way to find out the unrolled
> > iATU feature availability is indeed to check the iATU viewport register
> > content. In accordance with the reference manual [1] if the register
> > doesn't exist (unrolled iATU is enabled) it's content is fixed with
> > 0xff-s, otherwise it will contain some zeros. So we can freely drop the
> > IP-core version checking in this matter then and use the
> > dw_pcie_iatu_unroll_enabled() method only to detect whether iATU/eDMA
> > space is unrolled.
> 

> Are you sure that pre v4.80a, it is safe to read the register address? 

v4.60a ref manual says that the register exists in case if
(!CX_PL_REG_DISABLE && CX_INTERNAL_ATU_ENABLE)
and no word regarding all 1s. Most likely it shall have all zeros by
default and if there is no iATU available.

> Seems unlikely that the all 1s guarantee would be valid before the 
> feature ever existed. 

Right, all 1s is the marker of the unrolled iATU mapping, which has
been available since v4.80a. So before that version we were never
supposed to meet all 1s in that registers.

> 
> 
> > [1] DesignWare Cores, PCI Express Controller, Register Desciptions,
> > v.4.90a, December 2016, p.855
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> Assuming this works,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks.

-Sergey

