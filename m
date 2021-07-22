Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316BB3D2307
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 13:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhGVLNh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 07:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbhGVLNg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jul 2021 07:13:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1FCC061575
        for <linux-pci@vger.kernel.org>; Thu, 22 Jul 2021 04:54:11 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p5-20020a17090a8685b029015d1a9a6f1aso3396198pjn.1
        for <linux-pci@vger.kernel.org>; Thu, 22 Jul 2021 04:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eJHo32pmDSargBeSSjTxPOgwesXxsmvoHQ7CTrEtPwQ=;
        b=g1OrwVOQT67xVprJPUIau4/8feqm+5lfQ7RHjj4psjNU7ncaYpfy0GfTkd2RS+cbN2
         AApWrJCWAsfpv2O/d5QWEiAmlF4CEXwaKRbBcPBUxuspL18X5G/VZMUThAGZ1XnnrKP/
         i+5byw6QckfZJHxyf+rBdntW22mpTNrAtuCLfBKlbrJs7bxh76LlsVhOtT+38x+LKCXI
         XV93zT246zEHn3Ip/Iu7L8RrwR8tOPxTnNTNDVCd5xFDx57aKOkTXGqjiBg++U11lGJY
         i1VpdFUpFQkvF+yE9rCv5mX2ey0gHTADK6wEvrWSpY7sz+4qlIn7Ls9EtrtOiFmEjJZn
         aYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eJHo32pmDSargBeSSjTxPOgwesXxsmvoHQ7CTrEtPwQ=;
        b=McLQ/sXtDdZcdRZ11IBJsjP7807/OuH6ecCzmbcfCSbLRv+D+IWQw9MLRzYaB19ebU
         njwN8yKq8nQQ+KBJcurd2VdEBSTMywiu8i7L8hJ7dN3TYJCCiG6dUxsAFthHshQfsTY9
         Rpg1+Qv6akVq6LsAgp3z2lDZHOj1dA2zgm1IwS7/VTtsTksb1mmuIovkDcRi4EsznXak
         3mPa+IdSZRPvDihSphIIHkqsulUsY64VVBL7PhJtl5BpA9adKkS4rW+e7NHhf2zcs0jE
         Tx0gU9VgTFOKiDsXe4+AvUbQ6vWvemFeM0aw0juFMs5RkwzzyGNXvYmFrPELB2GLR8KC
         eOyw==
X-Gm-Message-State: AOAM530MWwFYSR6RB6ph0m0kHOIE93cWMI7tSI2DY+jMV6SV1/aWZk9+
        LaEFZ/5tc8r8DKMMaeN+Jej+
X-Google-Smtp-Source: ABdhPJyBHQh4bCAQjkaZuBiPkXKbeMCTIOz19OnWVkY7859ey5cMuC8+MZSrazVlbNG1FT3B+ohVPA==
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr8646747pjh.217.1626954850999;
        Thu, 22 Jul 2021 04:54:10 -0700 (PDT)
Received: from workstation ([120.138.13.30])
        by smtp.gmail.com with ESMTPSA id i8sm32579542pfk.18.2021.07.22.04.54.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Jul 2021 04:54:09 -0700 (PDT)
Date:   Thu, 22 Jul 2021 17:24:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        robh@kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        smohanad@codeaurora.org, bjorn.andersson@linaro.org,
        sallenki@codeaurora.org, skananth@codeaurora.org,
        vpernami@codeaurora.org, vbadigan@codeaurora.org
Subject: Re: [PATCH v6 2/3] PCI: dwc: Add Qualcomm PCIe Endpoint controller
 driver
Message-ID: <20210722115404.GB4446@workstation>
References: <20210714083316.7835-3-manivannan.sadhasivam@linaro.org>
 <20210714191509.GA1864706@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714191509.GA1864706@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 14, 2021 at 02:15:09PM -0500, Bjorn Helgaas wrote:
> Can you use the driver name for *this* driver in the subject instead
> of "dwc"?  Then we'll be able to identify changes related to this
> driver easily in the "git log --oneline" output.
> 

Okay sure. I usually do that for the drivers that got merged but don't
have any issues with driver prefix while under review.

> I'm not sure what that name should be -- you have the PCIE_QCOM_EP
> config symbol and "qcom-pcie-ep" as the driver.name.  Both seem
> possibly a little too generic.  We already have a "qcom" driver
> (drivers/pci/controller/dwc/pcie-qcom.c).  Is this for the same
> hardware in endpoint mode?
> 

Yes

> Will this driver support every endpoint device from Qualcomm, even
> future ones?  People often use a model or codename here (xgene,
> aardvark, armada, tegra, etc).  But I guess you can always use
> something more specific for future drivers if/when Qualcomm produces
> something that requires a different driver.
> 

Since pcie-qcom.c supports most of the RC IPs in recent SoCs, I can
assure that this driver can handle all EPs.

> On Wed, Jul 14, 2021 at 02:03:15PM +0530, Manivannan Sadhasivam wrote:
> > Add driver support for Qualcomm PCIe Endpoint controller driver based on
> > the Designware core with added Qualcomm specific wrapper around the
> > core. The driver support is very basic such that it supports only
> > enumeration, PCIe read/write, and MSI. There is no ASPM and PM support
> > for now but these will be added later.
> > 
> > The driver is capable of using the PERST# and WAKE# side-band GPIOs for
> > operation and written on top of the DWC PCI framework.
> > 

[...]

> > +static int qcom_pcie_establish_link(struct dw_pcie *pci)
> > +{
> 
> This is much more complicated than existing *_pcie_establish_link()
> functions.  Are other drivers doing work like this in different
> functions?
> 
> Please try to copy the same structure and function name conventions as
> other drivers.  This applies to all the functions here.  It makes
> maintenance much easier if code doing similar things looks similar.
> 

Sure thing. I can use the patterns for the callback functions as they
are the ones shared between all drivers.

Thanks,
Mani
