Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170FF1FC25D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 01:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFPXgM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 19:36:12 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:40981 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgFPXgM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 19:36:12 -0400
Received: from [192.168.1.3] (212-5-158-38.ip.btc-net.bg [212.5.158.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 1F3F2CFFF;
        Wed, 17 Jun 2020 02:36:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1592350568; bh=aLjBBuVOgl1FEIUDX+t32lCMDeKTv5OVH1NddWDHMpE=;
        h=Subject:To:Cc:From:Date:From;
        b=EfroWTqqlD6NHw6xyFCW6GE8yNG9v4tk9irwG84sR4pF6hq/+ltwGqL5xdpb0edjn
         r5UQ/kKqRFK+U5OXH/gAW4439jtDbk+lvbvmmfw/emfwsyxyJ0vYjnxnQejw9mXyME
         5VayAl3PcplbJxDYIst2n5x1bGwouyPJSLMWQm4azu5MolegAppuBLr1eN+BZfhu33
         jmjyzV10E7U3EumlPt1c78s/+hKpUQjGqGZdTTGrfZDVjgecQgv627neoN8vWI+awy
         4QZ8/0uQj+wehx2TajEMLiZnF9CDqPvWUHpE7VoXioOvs7j4xrbtMRjbxdVxQWg5vv
         FGk9WG7SqdTfw==
Subject: Re: [PATCH] PCI: qcom: Disable power management for uPD720201 USB3
 controller
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org, sanm@codeaurora.org,
        mgautam@codeaurora.org, agross@kernel.org, bhelgaas@google.com,
        robh@kernel.org, lorenzo.pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
References: <20200616211711.GA1981914@bjorn-Precision-5520>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <47b52403-360e-08b6-ad0d-0f4a2272a5f7@mm-sol.com>
Date:   Wed, 17 Jun 2020 02:36:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616211711.GA1981914@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/17/20 12:17 AM, Bjorn Helgaas wrote:
> [+cc Rafael, linux-pm]
> 
> On Mon, Jun 15, 2020 at 09:24:13PM +0300, Georgi Djakov wrote:
>> The uPD720201 USB3 host controller (connected to PCIe) on the Dragonboard
>> 845c is often failing during suspend and resume. The following messages
>> are seen over the console:
>>
>>   PM: suspend entry (s2idle)
>>   Filesystems sync: 0.000 seconds
>>   Freezing user space processes ... (elapsed 0.001 seconds) done.
>>   OOM killer disabled.
>>   Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>>   printk: Suspending console(s) (use no_console_suspend to debug)
>>   dwc3-qcom a8f8800.usb: HS-PHY not in L2
>>   dwc3-qcom a6f8800.usb: HS-PHY not in L2
>>   xhci_hcd 0000:01:00.0: can't change power state from D3hot to D0 (config
>>   space inaccessible)
>>   xhci_hcd 0000:01:00.0: can't change power state from D3hot to D0 (config
>>   space inaccessible)
>>   xhci_hcd 0000:01:00.0: Controller not ready at resume -19
>>   xhci_hcd 0000:01:00.0: PCI post-resume error -19!
>>   xhci_hcd 0000:01:00.0: HC died; cleaning up
>>
>> Then the USB devices are not functional anymore. Let's disable the PM of
>> the controller for now, as this will at least keep USB devices working
>> even after suspend and resume.
> 
> This seems like we're just covering up a deeper problem here.  I think
> it would be better to fix the underlying problem.
> 
> The quirk you're adding is specific to the Renesas 0x0014 device.  Is
> there some reason to think the problem is specific to that device, or
> might other devices have the same problem?

I also think that the USB controller might have some issue with .resume.
It is obvious that qcom-pcie RC doesn't implement suspend/resume which
means that its clocks are not disabled at the moment when USB is resuming.

Georgi, can you try to bypass suspend/resume in the USB driver itself?

> 
> Maybe we're missing something in pcie-qcom.c?  Is there any
> suspend/resume support required in that driver?  It doesn't look like
> it has anything except that it calls pm_runtime_enable().

Yes, definitely we did not implemented suspend/resume callbacks, but
that means that the RC should be functional while the system is in suspend.

> 
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 138e1a2d21cc..c1f502682a19 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1439,6 +1439,13 @@ static void qcom_fixup_class(struct pci_dev *dev)
>>  {
>>  	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
>>  }
>> +
>> +static void qcom_fixup_nopm(struct pci_dev *dev)
>> +{
>> +	dev->pm_cap = 0;
>> +	dev_info(&dev->dev, "Disabling PCI power management\n");
>> +}
>> +
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0101, qcom_fixup_class);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0104, qcom_fixup_class);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0106, qcom_fixup_class);
>> @@ -1446,6 +1453,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0107, qcom_fixup_class);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_RENESAS, 0x0014, qcom_fixup_nopm);
> 
> The convention is that DECLARE_PCI_FIXUP_*() comes immediately after
> the quirk function itself, so the whole patch would be a single diff
> hunk.  See drivers/pci/quirks.c for many examples.
> 
>>  static struct platform_driver qcom_pcie_driver = {
>>  	.probe = qcom_pcie_probe,

-- 
regards,
Stan
