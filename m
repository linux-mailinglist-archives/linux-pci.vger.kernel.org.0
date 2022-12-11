Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590906494CF
	for <lists+linux-pci@lfdr.de>; Sun, 11 Dec 2022 16:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiLKP24 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Dec 2022 10:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLKP2z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Dec 2022 10:28:55 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CE410F7;
        Sun, 11 Dec 2022 07:28:54 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id v11so308103ljk.12;
        Sun, 11 Dec 2022 07:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kmJQ3JX0cNEDcibAVe7dwqeACzxUsNklsuHAlAAT2AY=;
        b=YPN6UipKS+mCxGrq1OPDGEAuFbMF9H7dWVi1shmS/sdsmgmFgpmPDEakvtLgyUfVgP
         6y+Z7sFOqZaClN04RxLVe/Yro2nLQSBlhJ26bEhW4ji77w9VPcQqNlTFr4UDxtP9e4/4
         lG61PHk3jYNX+VU2UsaewdUyHZX7O3u9ZrLXIz6TyrXbpB/kC25ubKNVTcDazVLPHkG6
         hvHtAlXKOALb58Y3/5A66iwcAD1jL1T+JLcWVn3bMrQPGb/suyP5ix6oEd27tKwlpEkz
         ll1FtdeX9r1Gqf8D9prfEpEqxtZu9U0XJPVhHcjroxqMvykgiKK6kkOWW5XDjVHfhphh
         i2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmJQ3JX0cNEDcibAVe7dwqeACzxUsNklsuHAlAAT2AY=;
        b=EWklhZ/19zbMRTK0g62oE5nidnGtOAcsjs9y1c3qovcScc8CWORcrTTck2C/u8U3Hj
         GRAwPY+BPDTrX0vDj9OfUhPEWkAZLgRjh8Jhc4nWna6Nq3AZ1cHtkLP7Gi7AfyBLVunS
         TaZOznKu5NjeSpsHt99ZfEvzHb9m4JtBPDSIFZZ3taAab4m7lhDQIAax9+DBO1dKq2on
         hxgzEyOQs7NYTn+VG5d3EExNU6n93FGSL5gBFMgy0O/tH+GXpHGI9vTPjPLDGd+ENnN+
         hVdib+l2jCX+BKJbo6T/5mLYwnlS+MqcJPmgF4wJC91EM9U5jQylGj9qe/2VJVxWL/Kd
         Xtcg==
X-Gm-Message-State: ANoB5pnb3NhhKRr6K5DeN30e3Mht8qLAchzGHMF0CaT8up5L23zob7aq
        QdpiVhiNFB5iUQHhMCRl6KU=
X-Google-Smtp-Source: AA0mqf4ec29PpXJgYvIXxoes0t+4hDpqBAloIHb1c2Zsw986jbFrb0kGPangD4gQLbS4VlDC9BKNNQ==
X-Received: by 2002:a05:651c:233:b0:279:f59a:4888 with SMTP id z19-20020a05651c023300b00279f59a4888mr3308367ljn.37.1670772532814;
        Sun, 11 Dec 2022 07:28:52 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id u4-20020a05651c140400b00279ceee1678sm934297lje.73.2022.12.11.07.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 07:28:52 -0800 (PST)
Date:   Sun, 11 Dec 2022 18:28:49 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <frank.li@nxp.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "Sergey.Semin@baikalelectronics.ru" 
        <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [EXT] RE: [PATCH v7 5/9] PCI: dwc: Avoid reading a register to
 detect whether eDMA exists
Message-ID: <20221211152849.y2dcxpc2teervlcl@mobilestation>
References: <20221127235532.u7q7oou36wymkpyf@mobilestation>
 <TYBPR01MB5341932B42719E026AA16D40D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221128115908.awhznkkrelk7h3nm@mobilestation>
 <TYBPR01MB534107A3C2B521BA0D67B4A7D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221128161114.deacldwbckfnn6ft@mobilestation>
 <TYBPR01MB5341FA664D5F1FCA07294F96D8129@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <TYBPR01MB53413E1BE13CCA65307770FDD81D9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221208140111.7phlnsxktxzsc55f@mobilestation>
 <TYBPR01MB5341B4EB94F1B829F0E0431CD81C9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <HE1PR0401MB23319A9F4AF7630A82249D65881C9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0401MB23319A9F4AF7630A82249D65881C9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank

On Fri, Dec 09, 2022 at 03:52:42PM +0000, Frank Li wrote:
> Hi Serge,
> 
> > From: Serge Semin, Sent: Thursday, December 8, 2022 11:01 PM
> >
> > Cc += Frank Li
> >
> > @Frank could you have a look at the thread and check the content of
> > the CSRs dbi+0x8f8 and dbi+0x978 on available to you DW PCIe +EDMA
> > devices?
> 

> [    2.598038] imx6q-pcie 5f010000.pcie_ep: imx_add_pcie_ep: +0x8f8 = 3438302a, +0x978 = 00010001

Thanks for the reply. So it's 4.80a with the legacy viewport-based
access. Alas it isn't what we need in this thread. We'll need
@Mani's respond in order to decide how to fix the auto-detection
procedure.

-Serge(y)

> 
> Frank Li
> 
> 
