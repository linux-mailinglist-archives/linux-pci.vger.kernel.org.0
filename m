Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6018463CC33
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 01:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiK3AH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 19:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiK3AH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 19:07:28 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03057044E;
        Tue, 29 Nov 2022 16:07:26 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id d3so19156525ljl.1;
        Tue, 29 Nov 2022 16:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVsAs2Za73d6UJPfTz0MZvUiul0X6sklp6MH+CmRL3k=;
        b=EL47aYSQjawJcsLLj/QAQ8+YXvjf23CGJROzwdIE7wtldJvsKi46kOiNH8Nl+U7j0h
         ObfsQI3tr5WATq7qgHwTyBxwj7PrSiOaR02VxnCwSgrUpzSkC3nu+3xCtxPmOe0Nphk6
         Mn9IyRHFXOE8Ibc+ru3BYcGdiccptw+GhjdbJx9Nr45UIjV7V7pAW9dD9cgK+8JlAmIe
         1XAbJmKZngaT2SEmNzkp0ukKd97UYj4fGz5Q3r+pQqBsu60DmrdKKxYPM6hSNMi7mqWx
         KbpVERYTp6984IPccQ7mkqg137Bd/28MVaBxB+ZHzbSgINt2Hk07QNRFTFESs4Df6tHR
         UutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVsAs2Za73d6UJPfTz0MZvUiul0X6sklp6MH+CmRL3k=;
        b=FCIaIG3ZGXPK3sb2qT3dtlYa1ubtWPYEQsggbmz+pXH4u/41BAflY21hSjsi/kbO81
         66au/cNN13Rr9wvE6f2/tSdyQWOIqwXzkJubEkiK71OInZrkJDzpbnNnaXH+XDr42gfi
         QpeOb4iXJwOqUL5/u2oZHTNAQD+kn0UpOM39FowTgOwC3qUjv+3GeLVlvADzpX67yenn
         F0FTGgPUauGkF0OO6Oh31/73LTC5Lpf6nzj4jNezQL+uT7KcZFzFgefL5Y00mNyvWpJG
         XYSnJ7IVvsBwIYaSLwRNTnDdmTAKiv7cXRcmRuIqX4msPZ5DR3wI45HSlcIvyRGrDZ1V
         YSig==
X-Gm-Message-State: ANoB5pll4BWNSefYxLzddvceyKtRw3ZIIetnNr4HUSzViekq8j4B5Y7b
        FgHIU1BfOaZyRWbplXJpKw8=
X-Google-Smtp-Source: AA0mqf5dURaix8FQhVVoV1kopruBMKkRVWorfEJEfcfyVRXaS6vpE74eyht6je/iu8eJ0ZOiJU6fPw==
X-Received: by 2002:a2e:be08:0:b0:277:857:87ab with SMTP id z8-20020a2ebe08000000b00277085787abmr12402330ljq.442.1669766845080;
        Tue, 29 Nov 2022 16:07:25 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0026fc8855c20sm1706704ljc.19.2022.11.29.16.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 16:07:24 -0800 (PST)
Date:   Wed, 30 Nov 2022 03:07:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 17/20] PCI: dwc: Introduce generic resources getter
Message-ID: <20221130000722.xfh3q22mo2huhipk@mobilestation>
References: <20221127011005.cjzcd6slb6ezy7ix@mobilestation>
 <20221129183543.GA729294@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129183543.GA729294@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 29, 2022 at 12:35:43PM -0600, Bjorn Helgaas wrote:
> On Sun, Nov 27, 2022 at 04:10:05AM +0300, Serge Semin wrote:
> > On Wed, Nov 23, 2022 at 01:44:36PM -0600, Bjorn Helgaas wrote:
> > > On Sun, Nov 13, 2022 at 10:12:58PM +0300, Serge Semin wrote:
> 
> > > Thanks for these new generic interfaces in the DWC core!  And thanks
> > > for the changes in this patch to take advantage of them in the
> > > pcie-designware drivers.
> > > 
> > > Do you plan similar changes to other drivers to take advantage of
> > > these DWC-generic data and interfaces?  If you add generic things to
> > > the DWC core but only take advantage of them in your driver, I don't
> > > think they are really usefully generic.
> > 
> > Could you be more specific what generic things you are referring to? I
> > am asking because the only part of the changes which is used in my
> > low-level driver only is introduced in another patch of this series.
> 
> I asked because three of your patches mention "generic" things, but I
> didn't see any changes to drivers except pcie-designware:
> 

>   PCI: dwc: Introduce generic platform clocks and reset

This patch introduces a method to request a generic platform clocks
and resets by their names. As I already said these names are defined
by the DT-bindings, which are platform-specific. That's why the most
of the currently available drivers can't be converted to using it.
Instead the new drivers are supposed to be encouraged to use the
generic names (in accordance with the generic DW PCIe DT-schema) and
the resources request interface (based on the generic DT-bindings) if
it suits their design.

Anyway I honestly tried to come up with an even more generic
interface, which could be used by all the low-level drivers. But due
to too much variations of the resource names and their sometimes too
complex utilization in the drivers any solution looked too complex.
After all of thoughts I decided to keep things simpler.

>   PCI: dwc: Introduce generic resources getter

This patch defines a generic resource getter for the DW PCIe host and
end-point drivers. That's why it's called generic. 

>   PCI: dwc: Introduce generic controller capabilities interface

This patch introduces an interface to set the device-specific
capabilities. Since these capabilities can be marked as available by
both the core driver (at least two of them already defined within this
patchset) and low-level platform drivers the interface is called
as generic.

> 
> I hoped that we would be able to use these to remove some code from
> existing drivers, but if they only improve maintainability of future
> drivers, that's useful, too.

Removing some code is possible for instance from the pcie-visconti.c
driver by using the new generic clocks and resets request interface.
I've scheduled to create a small patchset which would do that after
the rest of my patches pass the review process.

-Serge(y)

> 
> Bjorn
