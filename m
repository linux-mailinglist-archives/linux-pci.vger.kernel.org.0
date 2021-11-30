Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3774462E48
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 09:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbhK3IPo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 03:15:44 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:43595 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbhK3IPo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 03:15:44 -0500
Received: by mail-pf1-f170.google.com with SMTP id n85so19777850pfd.10;
        Tue, 30 Nov 2021 00:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oOtBm70QtWvgwX0qhSoyfuzskIptKAWAcyAGLs0h6lc=;
        b=nCALnkNWMEJxlcmuxl0hNGpm2mwKWEqV5aeXcdtpZxVNBi9Fii6ceCmWbYbp9uMAh6
         eriPZ74LV1AB82jfU5aCjvd54pworOPdTaNht6YJfPv4PM2vZjvuUp+ZuySmoKbMzovZ
         C+eJZ7CLeouHG1ruQdcRatwt96Fak6R+OHXzaZ1U+sLpfjzvUskYOSXWxfJs8ZbL71e7
         eHI1TXo/B1EYaRgIBe/z83qcIfiFjMaMWbd5p67nzIiw5iKMpzqhWfZ4A8wR5s2VXycG
         ZtJKzGgBDRRYy5ihnPc6HK8E6Mi23uHWLDpSVOtC5DA2DT3UZk3K7KpgHxcVP9WXHSQo
         fOqQ==
X-Gm-Message-State: AOAM530x+oH02h+u41tJgEE1BWNL3sy7FLS3Sk8RpZcjBUuOdGwA4cyv
        BUpjiKrkeXk8bj4RzPF2tFQ=
X-Google-Smtp-Source: ABdhPJy8q2DqldYdtiN65JQyUznoDqXysRHHlfcMW5tz/jiV/hZdMsaZ495IkMV5vUvsXPZt5Ley9Q==
X-Received: by 2002:aa7:88d5:0:b0:49f:e382:3d62 with SMTP id k21-20020aa788d5000000b0049fe3823d62mr44398168pff.76.1638259945042;
        Tue, 30 Nov 2021 00:12:25 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id q11sm19873718pfk.192.2021.11.30.00.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 00:12:24 -0800 (PST)
Date:   Tue, 30 Nov 2021 09:12:14 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] PCI: qcom: Use __be16 for catching cpu_to_be16()
 return instead of u16
Message-ID: <YaXc3mlBbhvEkZCX@rocinante>
References: <20211130064215.207393-1-manivannan.sadhasivam@linaro.org>
 <YaXSoLpIfrTh81/+@rocinante>
 <20211130080456.GE205712@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211130080456.GE205712@thinkpad>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

[...]
> > > cpu_to_be16() returns __be16 value but the driver uses u16 and that's
> > > incorrect. Fix it by using __be16 as the datatype of bdf_be variable.
> > 
> > It would be "data type" in the above.
> > 
> > Not really a requirement to do so, but you could include the actual
> > warning, as sometimes this is useful for reference later, as per:
> > 
> >   drivers/pci/controller/dwc/pcie-qcom.c:1346:30: warning: incorrect type in initializer (different base types)
> >   drivers/pci/controller/dwc/pcie-qcom.c:1346:30:    expected unsigned short [usertype] bdf_be
> >   drivers/pci/controller/dwc/pcie-qcom.c:1346:30:    got restricted __be16 [usertype]
> > 
> 
> I usually do but as per Bjorn's comment I thought it is not recommended for PCI
> subsystem (or maybe I misread his comments). Will add.

Ah right.  I must have missed his comment too.  I usually include warnings
myself, where applicable.  Let's wait for what Bjorn says, just in case, so
that we avoid adding something he does not want to have included in the
commit message.

[...]
> > Also, since I have your attention, it seems we have a number of unused
> > macros in the qcom driver, as per:
> > 
> >   drivers/pci/controller/dwc/pcie-qcom.c:#define PCIE20_PARF_BDF_TRANSLATE_CFG            0x24C
> >   drivers/pci/controller/dwc/pcie-qcom.c:#define PCIE20_PARF_SID_OFFSET                   0x234
> >   drivers/pci/controller/dwc/pcie-qcom.c:#define PCIE20_PARF_SLV_ADDR_SPACE_SIZE          0x16C
> > 
> > And also in the qcom-ep driver, as per:
> > 
> 
> These defines are helpful for someone who wants to add some functionality or
> even bug fix in the future. Since these controllers are not publically
> documented, having these definitions helps a lot.

Got it!  I run a nightly CI pipeline and been seeing complains due to the
"-Wunused-macros" show up in the log, so I decided to steal the spotlight,
so to speak, to ask about these.

Thank you for letting me know.  Appreciated!

	Krzysztof
