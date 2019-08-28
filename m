Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1FECA0A86
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 21:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfH1Tgw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 15:36:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44044 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfH1Tgw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 15:36:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id k22so618316oiw.11;
        Wed, 28 Aug 2019 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMw4NAQR15jFRGg47hS9E1G9rDiMkZE/YWhS4jiC9BQ=;
        b=KvpOLeo1KYyOkdOLdBNEM0yoTpH55Mkwam/x4ZcbDAsaNGyH7XvW3vpbOlRIBWK66L
         SZP3Q15wmCUoUEqeOnXACRIocFIl3n+IQCtaOcCs2vBCy5xRPWoedHQkJzooTsggHhRz
         1wQZYJHX+hlJSRCEqvw4yryxOCvljeEMYwGKL594eGxjovL4Qd8bDPTc+6pyRQk+m30g
         d0bWdKCSpHu3L6SbpH5PrTmWcivnlARLOBxZIhhJbnBuIBSZSCXFSSDu61dfTsb4YCKp
         YPIsiRGnf7XSHN9sRS5SdDoCj0OErQevSrYhbcZXU6qgBJceLokgm0VqyiikcI7Fu4E/
         sW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMw4NAQR15jFRGg47hS9E1G9rDiMkZE/YWhS4jiC9BQ=;
        b=BhRKkH5gVNDI/bPEwOyDVyctijuxUHqwORx82fYQ8PEcuqxN8VcgVXgGvSUQntLH6T
         gYCFmp08MOkONi8OgUx6NrzVXeUuCUF1MrqTUHuf4uDU1XB3Uk7cUGHY1NSbjbPDVL7l
         u++huAwa9Yk9vuTuVeHErziyxvg4WjVCRI5MqWuQswcZdnS/1v5wlj2rg1QbwDRTjhr7
         6vn32sumBdmLL1a6EAfWJ/34xdw4u9Ns/kD7YMMwhiV4dpra4Dp33XF0a+KVD6CSTYTA
         0ZnBRWvuypoZsRZO7/S6g1xj4a+SdB8YjiZ913C/vHXmSYYxTtj3cmwDZLOqHvLM/enZ
         UEvg==
X-Gm-Message-State: APjAAAWHnJogYwA6wag6FhtpbV0vCroYtsUNrQDjFyfHMttY4sfTg+30
        6Y08JihkHrSQt8BJ+9mKmaZTyxa0GvSHxpewhhE=
X-Google-Smtp-Source: APXvYqypkhHf1Qy3Lvx+8RZhtTrlK4uvkEnQVGQapo4EO4+SCydqNK3tQhPyJqT2P8ykOhp3rn1gkAMAuaWSnKfEZnU=
X-Received: by 2002:aca:d650:: with SMTP id n77mr4083095oig.129.1567021010776;
 Wed, 28 Aug 2019 12:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <9bd455a628d4699684c0f9d439b64af1535cccc6.1566208109.git.eswara.kota@linux.intel.com>
 <20190824210302.3187-1-martin.blumenstingl@googlemail.com>
 <2c71003f-06d1-9fe2-2176-94ac816b40e3@linux.intel.com> <CAFBinCDSJdq6axcYM7AkqvzUbc6X1zfOZ85Q-q1-FPwVxvgnpA@mail.gmail.com>
 <9ba19f08-e25a-4d15-8854-8dc4f9b6faca@linux.intel.com> <CAFBinCDX2BqiKcZM-C0m7gsi4BPSK0gM15r0jHmL3+AKxff=wQ@mail.gmail.com>
 <7c0fd56f-ecc5-40c2-c435-3805ca1f97c7@linux.intel.com>
In-Reply-To: <7c0fd56f-ecc5-40c2-c435-3805ca1f97c7@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 28 Aug 2019 21:36:38 +0200
Message-ID: <CAFBinCBa9G+E+vjmQCGBx=zRG80ad1am_1TrNbAMvqKCQU38gw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dwc: PCI: intel: Intel PCIe RC controller driver
To:     "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>
Cc:     eswara.kota@linux.intel.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, hch@infradead.org,
        jingoohan1@gmail.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, qi-ming.wu@intel.com, kishon@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 5:35 AM Chuan Hua, Lei
<chuanhua.lei@linux.intel.com> wrote:
[...]
> >>>>>> +static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
> >>>>>> +{
> >>>>>> +    struct device *dev = lpp->pci->dev;
> >>>>>> +    int ret = 0;
> >>>>>> +
> >>>>>> +    lpp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> >>>>>> +    if (IS_ERR(lpp->reset_gpio)) {
> >>>>>> +            ret = PTR_ERR(lpp->reset_gpio);
> >>>>>> +            if (ret != -EPROBE_DEFER)
> >>>>>> +                    dev_err(dev, "failed to request PCIe GPIO: %d\n", ret);
> >>>>>> +            return ret;
> >>>>>> +    }
> >>>>>> +    /* Make initial reset last for 100ms */
> >>>>>> +    msleep(100);
> >>>>> why is there lpp->rst_interval when you hardcode 100ms here?
> >>>> There are different purpose. rst_interval is purely for asserted reset
> >>>> pulse.
> >>>>
> >>>> Here 100ms is to make sure the initial state keeps at least 100ms, then we
> >>>> can reset.
> >>> my interpretation is that it totally depends on the board design or
> >>> the bootloader setup.
> >> Partially, you are right. However, we should not add some dependency
> >> here from
> >> bootloader and board. rst_interval is just to make sure the pulse (low
> >> active or high active)
> >> lasts the specified the time.
> > +Cc Kishon
> >
> > he recently added support for a GPIO reset line to the
> > pcie-cadence-host.c [0] and I believe he's also maintaining
> > pci-keystone.c which are both using a 100uS delay (instead of 100ms).
> > I don't know the PCIe spec so maybe Kishon can comment on the values
> > that should be used according to the spec.
> > if there's then a reason why values other than the ones from the spec
> > are needed then there should be a comment explaining why different
> > values are needed (what problem does it solve).
>
> spec doesn't guide this part. It is a board or SoC specific setting.
> 100us also should work. spec only requirs reset duration should last
> 100ms. The idea is that before reset assert and deassert, make sure the
> default deassert status keeps some time. We take this value from
> hardware suggestion long time back. We can reduce this value to 100us,
> but we need to test on the board.
OK. I don't know how other PCI controller drivers manage this. if the
PCI maintainers are happy with this then I am as well
maybe it's worth changing the comment to indicate that this delay was
suggested by the hardware team (so it's clear that this is not coming
from the PCI spec)

[...]
> >>>>>> +static void __intel_pcie_remove(struct intel_pcie_port *lpp)
> >>>>>> +{
> >>>>>> +    pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
> >>>>>> +                        0, PCI_COMMAND);
> >>>>> I expect logic like this to be part of the PCI subsystem in Linux.
> >>>>> why is this needed?
> >>>>>
> >>>>> [...]
> >>>> bind/unbind case we use this. For extreme cases, we use unbind and bind
> >>>> to reset
> >>>> PCI instead of rebooting.
> >>> OK, but this does not seem Intel/Lantiq specific at all
> >>> why isn't this managed by either pcie-designware-host.c or the generic
> >>> PCI/PCIe subsystem in Linux?
> >> I doubt if other RC driver will support bind/unbind. We do have this
> >> requirement due to power management from WiFi devices.
> > pcie-designware-host.c will gain .remove() support in Linux 5.4
> > I don't understand how .remove() and then .probe() again is different
> > from .unbind() followed by a .bind()
> Good. If this is the case, bind/unbind eventually goes to probe/remove,
> so we can remove this.
OK. as far as I understand you need to call dw_pcie_host_deinit from
the .remove() callback (which is missing in this version)
(I'm using drivers/pci/controller/dwc/pcie-tegra194.c as an example,
this driver is in linux-next and thus will appear in Linux 5.4)


Martin
