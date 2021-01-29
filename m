Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4438A308454
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 04:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhA2DqL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 22:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhA2DqF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 22:46:05 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7858EC061756
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2021 19:45:25 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id t8so8913737ljk.10
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2021 19:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QYx6/uSUyh2hqwQYt//2VWudlIbI5/06ASiZSy/mLyo=;
        b=MQpAIdc1jbYRb4uE1UMqpIpEiIdRlXP9v/3iG9ReMEVTIsKFUlysLHvaIEd7HNqYVa
         QCxw+7t3130iWoa1TG2q9hjKAIbYwnz49quuEwrCfBqLcwbsk6ANb535I/GRxb8uMpIH
         RHAmEilRZcRxEH9rV/o5hIzRTjOnJX033PWiUUBYjh/sZRHrNdx/+A+J7KfFgJtKuoyH
         i2uPd9MS354efk26N08RzHGAtL7iusyieL11tcRR1dpNIPHjoVl1X53P9ZjC5TmI7Xzn
         Rm8prgJGAUAxsQbHTfhGlK1+qIICAXJKhqPD6VaCrPs0xVJxOqh3zo+K/1AV74EDU5b/
         OXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QYx6/uSUyh2hqwQYt//2VWudlIbI5/06ASiZSy/mLyo=;
        b=hKtxDeDLZgh1fYME84KNKLVz4uKbGN/ZGVwD/LO/iOdjTEjByEo3LghRShYc8SZyZd
         8oaAYeJcDrjn9+4hOTuC1dDC3lOcWOP1zk7Bk+t1RaADVMzoYKHhcQk7JcM+yKi9fi29
         con52+OCtrIuSBG6S2Fr/TfXr0ySUKStfsyCYzUq7FOtdC8KMfH1UAqfuoSaQNWCd2F+
         LqXqmYPS4y1XLVSPXTRtiH4y3REfvSqWMHaDMJWR6NHDcp4YIzyMbZCpXFHdM/IMgCyo
         2Onoj8tIcqDEmBjZxpHbJz8PIqjgHO2j56Bhq8omw3Sb5/G8v6gf1mixbWma4Lqzv5vc
         8TVA==
X-Gm-Message-State: AOAM532R8sIsMVZQ2uw7lWUqo3x9oKQvnuibTFznHROz3HtGxGOOaCAf
        9yptsOOCTLCrBloXhv2KUXGfobnaH2VQ3cUU
X-Google-Smtp-Source: ABdhPJyFOTD0X8ECLTsqb/tuQIyGfQ96Bn2nBwZMbpwL3vuLlc5XCnWGi+2l0v/x8onFfQokSxOHzw==
X-Received: by 2002:a05:651c:1a3:: with SMTP id c3mr1298160ljn.498.1611891923583;
        Thu, 28 Jan 2021 19:45:23 -0800 (PST)
Received: from [192.168.1.211] ([94.25.229.83])
        by smtp.gmail.com with ESMTPSA id a30sm2358345ljq.96.2021.01.28.19.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 19:45:23 -0800 (PST)
Subject: Re: [PATCH v2 3/5] pcie-qcom: provide a way to power up qca6390 chip
 on RB5 platform
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
References: <20210128175225.3102958-1-dmitry.baryshkov@linaro.org>
 <20210128175225.3102958-4-dmitry.baryshkov@linaro.org>
 <CAL_JsqLRn40h0K-Fze5m1LS2+raLp94LariMkUh7XtekTBT5+Q@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <da0ac373-4edb-0230-b264-49697fa3d86a@linaro.org>
Date:   Fri, 29 Jan 2021 06:45:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLRn40h0K-Fze5m1LS2+raLp94LariMkUh7XtekTBT5+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/01/2021 22:26, Rob Herring wrote:
> On Thu, Jan 28, 2021 at 11:52 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> Some Qualcomm platforms require to power up an external device before
>> probing the PCI bus. E.g. on RB5 platform the QCA6390 WiFi/BT chip needs
>> to be powered up before PCIe0 bus is probed. Add a quirk to the
>> respective PCIe root bridge to attach to the power domain if one is
>> required, so that the QCA chip is started before scanning the PCIe bus.
> 
> This is solving a generic problem in a specific driver. It needs to be
> solved for any PCI host and any device.

Ack. I see your point here.

As this would require porting code from powerpc/spark of-pci code and 
changing pcie port driver to apply power supply before bus probing 
happens, I'd also ask for the comments from PCI maintainers. Will that 
solution be acceptable to you?


> 
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index ab21aa01c95d..eb73c8540d4d 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/of_device.h>
>>   #include <linux/of_gpio.h>
>>   #include <linux/pci.h>
>> +#include <linux/pm_domain.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/phy/phy.h>
>> @@ -1568,6 +1569,26 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
>>
>> +static void qcom_fixup_power(struct pci_dev *dev)
>> +{
>> +       int ret;
>> +       struct pcie_port *pp = dev->bus->sysdata;
>> +       struct dw_pcie *pci;
>> +
>> +       if (!pci_is_root_bus(dev->bus))
>> +               return;
>> +
>> +       ret = dev_pm_domain_attach(&dev->dev, true);
>> +       if (ret < 0 || !dev->dev.pm_domain)
>> +               return;
>> +
>> +       pci = to_dw_pcie_from_pp(pp);
>> +       dev_info(&dev->dev, "Bus powered up, waiting for link to come up\n");
>> +
>> +       dw_pcie_wait_for_link(pci);
>> +}
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x010b, qcom_fixup_power);
>> +
>>   static struct platform_driver qcom_pcie_driver = {
>>          .probe = qcom_pcie_probe,
>>          .driver = {
>> --
>> 2.29.2
>>


-- 
With best wishes
Dmitry
