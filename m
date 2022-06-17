Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D654154F833
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 15:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381356AbiFQNMD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 09:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiFQNMC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 09:12:02 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF904C79E;
        Fri, 17 Jun 2022 06:12:01 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b7so4688301ljr.6;
        Fri, 17 Jun 2022 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=791oGUkmZnfRuTNKHAERlu6WE3+Htir8Ec5AhgIO5jI=;
        b=Uq+N89keIW7OooF6H5l3twHzNknWg0rsgasWOSA+KIlAJAQBiNSuEzipg091uypJqV
         4yUyQb3hr6i0zmYHcEDXqAd04/9DeCvxySQ4bHcNVCETQWIqJ64ycHD5Bomd4teVLSXN
         T81Kv5I6+IWDAXPKS0zq6iBZ6P9x4x4QQnjGL2iv4KulnkPq0jgd0X3YGKCBc8sjfTN/
         iPdQUWc9w+EczuY6ZdSRzuTZ/imwECG1Ivr++6XSjbMyjBgx3U08tFXN9fKmIH7NXZdZ
         OtHvbvxmjgN0znPR5SlytNFht3zzy5r/OOokoqMlL7YCJQ8+fgf0eOsGtjduTVzO/F47
         1B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=791oGUkmZnfRuTNKHAERlu6WE3+Htir8Ec5AhgIO5jI=;
        b=pO8mPB9VXoEBPKwt4T4/3aWgeeBOG3D5ON85DKRo+jT1yyYGafXNZgaEigrnqnTVAk
         VEIwp8BN5HHgNM65XkeZjToGR8b7aOh4DxEX8PIzgEgcK6GJGvqQfyiB1B+MtQWJKh6L
         m+HK7VYzdf8NUdWgw4tt2V4ig+08657zc9GS9feZ86NK+xgdwydp9CKTRTHjAEcOc7mX
         ftXjDKaEwlpONqQuklDKK2xCcO1Kb+pufbbnbV7n6Em/Ng3nS8srUUR/Xrh+sfj1Gvm6
         JV9wPMnKiW7694juQEuiONg9Rj9yhH8df1XjMT+eFAKM2+hn2QmuqA4bYeRKGyBPRhcj
         A19A==
X-Gm-Message-State: AJIora8XqsyLEXBTI+sMQ3Xl4y04U0TYJV2FPBlIidFRMs3guZSTPd1K
        55e0XtcWgz16TNE2MSSKQEw=
X-Google-Smtp-Source: AGRyM1tTQ5Z4cmbsU8I+ncb7XGq/AEhisxWPA1C/k8qU1cIG5ASIW+LDwgLVDzfPfoOwTwzRajdvAQ==
X-Received: by 2002:a2e:96c9:0:b0:258:ac98:5304 with SMTP id d9-20020a2e96c9000000b00258ac985304mr5149376ljj.382.1655471520033;
        Fri, 17 Jun 2022 06:12:00 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id c13-20020a056512074d00b0047255d21104sm636227lfs.51.2022.06.17.06.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 06:11:59 -0700 (PDT)
Date:   Fri, 17 Jun 2022 16:11:57 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/18] PCI: dwc: Various fixes and cleanups
Message-ID: <20220617131157.wpxncriprazptnze@mobilestation>
References: <20220617104143.yj2mlnj4twoxoeld@mobilestation>
 <20220617112922.GA1176883@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617112922.GA1176883@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 17, 2022 at 06:29:22AM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 17, 2022 at 01:41:43PM +0300, Serge Semin wrote:
> > On Thu, Jun 16, 2022 at 03:03:16PM -0500, Bjorn Helgaas wrote:
> > > On Fri, Jun 10, 2022 at 11:25:16AM +0300, Serge Semin wrote:
> > > > This patchset is a first one in the series created in the framework of
> > > > my Baikal-T1 PCIe/eDMA-related work:
> > > > ...
> 
> > > This doesn't apply cleanly on v5.19-rc1 (my "main" branch).  v5.19-rc1
> > > was tagged June 5, but apparently v4 was rebased to v5.18 and posted
> > > June 10?  That's just a non-starter because many of these files were
> > > changed during the merge window between v5.18 and v5.19-rc1.
> > 
> > Ok. I'll rebase it on top of v5.19-rcX on the next cycle.
> 

> I merge things on topic branches based on -rc1, so there's no benefit
> to rebasing to anything past that (at least for me).  Normally it
> doesn't matter because very little will change between -rc1 and -rcX.

Ok. rc1 it is then.

-Sergey

> 
> > > I'll be looking for an ack from Jingoo and/or Gustavo, maintainers of
> > > pcie-designware.c and related files.
> > 
> > Alas this will be very unluckily to happen. They have been inactive
> > for more than four months on this and the rest of the patchsets
> > (that's how long the patchsets have been hanging out on review).
> > The last commit authored by Gustavo was the commit ce31ff786ddf
> > ("PCI: dwc: Fix 'cast truncates bits from constant value'") posted
> > in Sep 22, 2020 and no review activity afterwards. Jingoo' last
> > ack was in Jun 25, 2019. So two and three years of silence accordingly
> > doesn't give any hope on the sooner reaction from them.
> 
> Ok, thanks for the update.  I hadn't noticed that.
> 
> Bjorn
