Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAC22E7F1D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Dec 2020 10:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgLaJxr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Dec 2020 04:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgLaJxq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Dec 2020 04:53:46 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D29C061573;
        Thu, 31 Dec 2020 01:53:05 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y17so19652216wrr.10;
        Thu, 31 Dec 2020 01:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YF71dzy+MFxNw65yBM8dHFE8HiMyhHIt7kgx+93oEvA=;
        b=ZkmXxVyiZJwiIB92DWc6kvIpONqpOxBzvqX6it06fm5cV3WUlLW00u0SiRsKQzzqz3
         kAn2v+Qv6nr2UvE6REIimEnA3Lo043b/jLtkzogv3qzBoQ4MCDSLBAlkvoPoSR08ucfO
         KX8cKtY/uYc84/laXlGnIv2a//Ro3B9NXxyg82SavYuAfFC4JbJxIlRwiYNNkt2tIF8N
         jVb1PXvBg7sG8nM35CY9Gp+UL3pFzkm3Z+YLur/UVieTbSVezSCcq1QXb1z9csQNuzRg
         oCViYFtBoTxo33EOIBVLUu+F5hoS6A6InizKrjaopWfV/ol9fSUPVT3YUa8ym7JtIUNS
         6nXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YF71dzy+MFxNw65yBM8dHFE8HiMyhHIt7kgx+93oEvA=;
        b=Fp5QOwL8bqkUXdw62vl2Lvfbcg8bTMvrmfUol1lt5+6OzurcbTrJOeJgy3khboS6K9
         cLy5aXbQ8rF1mZffEdi7f2qajpCBkUEnKHLu3NTNShzi3H6QESdhxAEFhgo1Ou7pMfPj
         ttT/+XW4RVKXeD1TSfaKT74S0qv25bftDWEu2i+lDBf/U81pQ7xw8FvnRwL15v+8UdoL
         o8bz1Yp0X5/IhbpxztsxaChfUYaVkEUbL7oD6WPJnnLvFlnDerqoVOMRW2FatdO5PUT1
         J0PDhz6kyNvhhfpzcJ+Jhq5Tuu4rOUAVCE6Bt14zRiACuWfTn33FDVrbIxjY79Y0qwVR
         /jdw==
X-Gm-Message-State: AOAM531MYoW0P4UBNF36n0QLnYL0vIc+I1ODMjKxp7q7dA2owDmMdiZ3
        wa/iKD03g5h6N9tPu6WepcoXpqxqdlc=
X-Google-Smtp-Source: ABdhPJwHyntrAOW2pMt13fbOqm8KshfuKwbX4RGFJrnNyjLYzkeYS1/dvuhGBE+t3EIV5a9KznUddw==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr63362507wrw.379.1609408384292;
        Thu, 31 Dec 2020 01:53:04 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:d936:bdcf:7b64:bfc4? (p200300ea8f065500d936bdcf7b64bfc4.dip0.t-ipconnect.de. [2003:ea:8f06:5500:d936:bdcf:7b64:bfc4])
        by smtp.googlemail.com with ESMTPSA id 189sm11752920wma.22.2020.12.31.01.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Dec 2020 01:53:03 -0800 (PST)
Subject: Re: Time to re-enable Runtime PM per default for PCI devcies?
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <79940973-b631-90f9-dbc4-9579c6000816@gmail.com>
 <20201117163817.GA1397220@bjorn-Precision-5520>
 <CAJZ5v0ipMJ1gCB7okpROG_yAUi5Q8LknqeH+Jpdrjbb4D_vfuQ@mail.gmail.com>
 <9ca0fb46-9e65-31e2-103f-1c98ce8362c7@gmail.com>
 <20201231040735.GA2075@wunner.de>
 <4eb10092-e3f9-c9be-2dec-e6de8aeedf97@gmail.com>
Message-ID: <5c618c30-b389-4545-e9c4-9fcec729b80d@gmail.com>
Date:   Thu, 31 Dec 2020 10:52:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4eb10092-e3f9-c9be-2dec-e6de8aeedf97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31.12.2020 10:38, Heiner Kallweit wrote:
> On 31.12.2020 05:07, Lukas Wunner wrote:
>> On Wed, Dec 30, 2020 at 11:56:04PM +0100, Heiner Kallweit wrote:
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -3024,7 +3024,9 @@ void pci_pm_init(struct pci_dev *dev)
>>>  	u16 status;
>>>  	u16 pmc;
>>>  
>>> -	pm_runtime_forbid(&dev->dev);
>>> +	if (pci_acpi_forbid_runtime_pm())
>>> +		pm_runtime_forbid(&dev->dev);
>>> +
>>
>> Generic PCI code usually does not call ACPI-specific functions directly,
>> but rather through a pci_platform_pm_ops callback.
>>
>> FWIW, if platform_pci_power_manageable() returns true, it can probably
>> be assumed that allowing runtime PM by default is okay.  So as a first
>> step, you may want to call that instead of adding a new callback.
>>
> I don't think that's sufficient. Most likely all the broken old systems
> return true for platform_pci_power_manageable(). So yes, most likely
> we'd need a new callback if we want to have the platform ops abstraction.
> But it could be an optional callback, something like: forbid_runtime_pm
> The question is just: is it worth it?
> 
> By the way: pci_set_platform_pm() returns an error if a callback isn't
> set, but no existing caller bothers to check the return code.
> 
>> Thanks,
>>
>> Lukas
>>
> Heiner
> 

This would be the version with the abstraction.

---
 drivers/pci/pci-acpi.c | 6 ++++++
 drivers/pci/pci.c      | 9 ++++++++-
 drivers/pci/pci.h      | 5 ++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 53502a751..b57a79af7 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1108,6 +1108,11 @@ static bool acpi_pci_need_resume(struct pci_dev *dev)
 	return !!adev->power.flags.dsw_present;
 }
 
+static bool acpi_pci_forbid_runtime_pm(void)
+{
+	return acpi_gbl_FADT.header.revision < 6;
+}
+
 static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
 	.bridge_d3 = acpi_pci_bridge_d3,
 	.is_manageable = acpi_pci_power_manageable,
@@ -1117,6 +1122,7 @@ static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
 	.choose_state = acpi_pci_choose_state,
 	.set_wakeup = acpi_pci_wakeup,
 	.need_resume = acpi_pci_need_resume,
+	.forbid_runtime_pm = acpi_pci_forbid_runtime_pm,
 };
 
 void acpi_pci_add_bus(struct pci_bus *bus)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b9fecc25d..3af832b7f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -982,6 +982,12 @@ static inline bool platform_pci_need_resume(struct pci_dev *dev)
 	return pci_platform_pm ? pci_platform_pm->need_resume(dev) : false;
 }
 
+static inline bool platform_pci_forbid_runtime_pm(void)
+{
+	return pci_platform_pm && pci_platform_pm->forbid_runtime_pm ?
+	       pci_platform_pm->forbid_runtime_pm() : false;
+}
+
 static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 {
 	if (pci_platform_pm && pci_platform_pm->bridge_d3)
@@ -3024,7 +3030,8 @@ void pci_pm_init(struct pci_dev *dev)
 	u16 status;
 	u16 pmc;
 
-	pm_runtime_forbid(&dev->dev);
+	if (platform_pci_forbid_runtime_pm())
+		pm_runtime_forbid(&dev->dev);
 	pm_runtime_set_active(&dev->dev);
 	pm_runtime_enable(&dev->dev);
 	device_enable_async_suspend(&dev->dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5c5936509..d2d406ee4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -71,8 +71,10 @@ int pci_bus_error_reset(struct pci_dev *dev);
  *		 suspended) needs to be resumed to be configured for system
  *		 wakeup.
  *
+ * @forbid_runtime_pm: returns true in case of known issues breaking runtime pm
+ *
  * If given platform is generally capable of power managing PCI devices, all of
- * these callbacks are mandatory.
+ * these callbacks are mandatory (except forbid_runtime_pm).
  */
 struct pci_platform_pm_ops {
 	bool (*bridge_d3)(struct pci_dev *dev);
@@ -83,6 +85,7 @@ struct pci_platform_pm_ops {
 	pci_power_t (*choose_state)(struct pci_dev *dev);
 	int (*set_wakeup)(struct pci_dev *dev, bool enable);
 	bool (*need_resume)(struct pci_dev *dev);
+	bool (*forbid_runtime_pm)(void);
 };
 
 int pci_set_platform_pm(const struct pci_platform_pm_ops *ops);
-- 
2.29.2


