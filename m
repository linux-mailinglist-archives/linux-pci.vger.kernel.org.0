Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE1A462E4B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 09:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbhK3IQb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 03:16:31 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:45571 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbhK3IQb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 03:16:31 -0500
Received: by mail-wr1-f48.google.com with SMTP id o13so42364902wrs.12;
        Tue, 30 Nov 2021 00:13:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gel94vrOrqonis20YmKQuXvzgvOACg1XjXXHouJkBiA=;
        b=OzdHZ09BEe28mhVuoMAUJHpNlBMVyqJoq8AYNMBJCMsD1/YMgPs8YuXKfTfvyIEgUP
         Z4bW3fLSG3frsTqyaaOSW47S5sffHINXu72a8GJwHEZk41cGosjveblyc4mOTINBcaJ1
         vQz7Djobt00tag+ds70qTbsHbboNFnMvOTaR1O8fOw5N1MnSGhV/QxkcOsenaJ0350Ik
         fUMZieQYq6xZ6iOYa5bNPFRzKJhRnjWL1BeVGsDSSdFZijKyBx+qdddibL1r4ljb9X3V
         r6kQvyf/fae2M731yaB5gCcsMPH+ih09eZh/PwSQofi8kTcyJl7oG20Nh/x255GOaC5m
         sveQ==
X-Gm-Message-State: AOAM531j/ElWGNnpwfSl8eUKJLItT5GTBbVVJGkLNC3jk4X7Oz+LMWjg
        AGrs3UUcxQ0wxMxcyf/TMIU=
X-Google-Smtp-Source: ABdhPJyL/JbxXASPutf+GBs+RCbYVQSx//xVo+ZwJEGwcCqVctDHz1R+CQdglRUU7aZE697NNJQ1jw==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr40983191wru.363.1638259991172;
        Tue, 30 Nov 2021 00:13:11 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id l2sm1685849wmq.42.2021.11.30.00.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 00:13:10 -0800 (PST)
Date:   Tue, 30 Nov 2021 09:13:09 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] PCI: qcom: Use __be16 for catching cpu_to_be16()
 return instead of u16
Message-ID: <YaXdFbrUAOMrDJ+s@rocinante>
References: <20211130064215.207393-1-manivannan.sadhasivam@linaro.org>
 <YaXSoLpIfrTh81/+@rocinante>
 <20211130080456.GE205712@thinkpad>
 <YaXc3mlBbhvEkZCX@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YaXc3mlBbhvEkZCX@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

[...]
> > > Not really a requirement to do so, but you could include the actual
> > > warning, as sometimes this is useful for reference later, as per:
> > > 
> > >   drivers/pci/controller/dwc/pcie-qcom.c:1346:30: warning: incorrect type in initializer (different base types)
> > >   drivers/pci/controller/dwc/pcie-qcom.c:1346:30:    expected unsigned short [usertype] bdf_be
> > >   drivers/pci/controller/dwc/pcie-qcom.c:1346:30:    got restricted __be16 [usertype]
> > > 
> > 
> > I usually do but as per Bjorn's comment I thought it is not recommended for PCI
> > subsystem (or maybe I misread his comments). Will add.
> 
> Ah right.  I must have missed his comment too.  I usually include warnings
> myself, where applicable.  Let's wait for what Bjorn says, just in case, so
> that we avoid adding something he does not want to have included in the
> commit message.

Ah!  I see a v3.  You act fast. :)

	Krzysztof
