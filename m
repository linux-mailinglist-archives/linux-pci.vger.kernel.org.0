Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AE77A0F43
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 22:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjINUss (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 16:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjINUss (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 16:48:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44AF2697;
        Thu, 14 Sep 2023 13:48:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-501cba1ec0aso2437435e87.2;
        Thu, 14 Sep 2023 13:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694724522; x=1695329322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=45ptA9Ev0Q7vvV6dGzDO73E6C/RcgoUUw8K6bYHgVzc=;
        b=Zcw3FeQ3Ci2luEb41EljhtRCPMo/uWQrjxwLmeZMNaH45hMY1Dz9unim4mytNDlBzC
         +j+p4utsau6k0cuh4swKV2oF6arDzYS5cYaEwcK92Kg2Zgb9yxCbcfCZlNdsScElZdLx
         znNxnvo3JJ3SIYe4MvzM/C7TTHEGqhCucD4Ifz8b4PT7zS4fuAS8Cwfy1mMJGTnG/6P2
         XS6+tTo5JqSdPH+Xk/V+KgvBqJqWkFGd5SI6Bbgt5LbrfZZE6NgImrnv5v/cIhD80jSs
         J8jvqQmGBfD3YtGxi5bkfIfpEHssnDi21WSy2qmE1KTbOpNlrPS1mSif0lsjwPSSQBFs
         8Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694724522; x=1695329322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45ptA9Ev0Q7vvV6dGzDO73E6C/RcgoUUw8K6bYHgVzc=;
        b=EPCYGx48dGGuQuzBMGD0I1yfDTU0psu/zj1KBigDRpS2RvYNkQb+/G9rMK0pG1WFsx
         kU6fayL97D+RNVxoOwXu05OcWzHQ368mdheT6WbNDNI78Bg/O17YcRsmyIewtVvGE7mq
         SuW1y+7RN+GsEu+AnUwuxVOuBx9UozZ3rVTorPzF4FNVYFwu3ueG/HpXzWxyHANioSHk
         e5qZ44tcUv+u3HHzZedhd6MvFd3yhFyl1K1qCODEwmcFnF2AQWh1EIwkQG9wB1WHc5Vf
         gFynirlN1nrXog2NheaVdfd/CcmeVGB6Ctup5EqeddIUgZ+lIAYe+h38/0b4TE+SQx7w
         yFjg==
X-Gm-Message-State: AOJu0YwTx+8S8Ajz3SVznCVFbS3u6JlY//LK03F8VzIHOc+10Yg82x6x
        nmVdQbMlCd6VopNhMFFzwz8=
X-Google-Smtp-Source: AGHT+IFCsr2E7SKoFrH6KHmPB6GF5TiLZHBUe7C3gLRFdJnc5FamwTHlf5hXyEti1JblE5Ery9W6Xg==
X-Received: by 2002:ac2:5f57:0:b0:502:9fce:b6db with SMTP id 23-20020ac25f57000000b005029fceb6dbmr5066923lfz.1.1694724521662;
        Thu, 14 Sep 2023 13:48:41 -0700 (PDT)
Received: from mobilestation ([95.79.219.206])
        by smtp.gmail.com with ESMTPSA id t10-20020ac2548a000000b004ff9ab6463fsm400992lfk.87.2023.09.14.13.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 13:48:41 -0700 (PDT)
Date:   Thu, 14 Sep 2023 23:48:39 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v20 07/19] PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW
 handling
Message-ID: <notuqnugfnmu7ep7rvnerix7hvgqt5b4wdrirjjgggjsxfc7lz@pismsfnlenu4>
References: <20230825093219.2685912-8-yoshihiro.shimoda.uh@renesas.com>
 <20230914160058.GA32113@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914160058.GA32113@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 14, 2023 at 11:00:58AM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 25, 2023 at 06:32:07PM +0900, Yoshihiro Shimoda wrote:
> > Update dw_pcie_link_set_max_link_width() to set PCI_EXP_LNKCAP_MLW.
> > In accordance with the DW PCIe RC/EP HW manuals [1,2,3,...] aside with
> > the PORT_LINK_CTRL_OFF.LINK_CAPABLE and GEN2_CTRL_OFF.NUM_OF_LANES[8:0]
> > field there is another one which needs to be updated. It's
> > LINK_CAPABILITIES_REG.PCIE_CAP_MAX_LINK_WIDTH. If it isn't done at
> > the very least the maximum link-width capability CSR won't expose
> > the actual maximum capability.
> > 
> > [1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> >     Version 4.60a, March 2015, p.1032
> > [2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> >     Version 4.70a, March 2016, p.1065
> > [3] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> >     Version 4.90a, March 2016, p.1057
> > ...
> > [X] DesignWare Cores PCI Express Controller Databook - DWC PCIe Endpoint,
> >       Version 5.40a, March 2019, p.1396
> > [X+1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> >       Version 5.40a, March 2019, p.1266
> 

> Is there value in keeping all four of these Root Port citations?  I
> assume that if you have the most recent one (X+1), it completely
> obsoletes the older ones, so you should never have to look at the
> older ones?

In general the procedure may differ from one device version to
another. Though it doesn't concern DW PCIe IP-cores. So by citing all
these manuals I implied that all DW PCIe controllers expect the same
link-width initialization procedure. Keeping that in mind I guess the
text could be indeed simplified by keeping only two citations (note
[X] and [X+1] refer to the Root Port and End-point HW databooks of the
same IP-core version) and noting in the text that the procedure is
common for the older DW PCIe controllers too.

In anyway I wouldn't say that new IP-core databooks obsolete the
old one since the driver supports all old and new controllers. So
before introducing a generic procedure we need to make sure that it
will work for all the known to be supported devices. From that
perspective citing all the available databooks gets to make sense.

-Serge(y)

> 
> Bjorn
