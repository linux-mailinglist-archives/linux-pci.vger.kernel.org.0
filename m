Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355DA230EFC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 18:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbgG1QOO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 12:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731277AbgG1QOO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2020 12:14:14 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0504C0619D2
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2020 09:14:13 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b9so10110415plx.6
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2020 09:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=LM61k2ikWu/4PDtBuk+atYWJDPZ8cm2dVOG+FrQjnU8=;
        b=lYECkTWvN7PAfxXPtZpbi9AGD7s1qBtivJ7EOU4OOgX3CR1cEuQzCJL2e9toYv3CyX
         4IrNsOF8h/4WieT7/WwURBJdMn4FoajGiZx/IK/AgbTE+PiZWmgGU9tNaY46PUBBgcDD
         tdD48+tGYs832NSmG7hjyQPrBFVkRVR+JWEbs5IsBWGHwA42BhoIOucrqp9zA+13IhYk
         /rW4WxE5GXD7F2FqRd1U1axtIjcM06dQqy/qMTz6xASB69eGEFg8MYwCbliWn53Pjh5s
         Bp/MJ/86XovzaDiQowxTdhZMS2CsvMxO++X/j49jFrf/c0BghrMmmTQ175oU1TN2hB4x
         IQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=LM61k2ikWu/4PDtBuk+atYWJDPZ8cm2dVOG+FrQjnU8=;
        b=Nsc1RttpaayH37g61A9nHl3+Pswl+WdFeCpfr4yv27zGL0/FkuRhuh4sXkhaShJTr4
         V4AQ5xBnTAu4DKg7OM/j1WJU84yT7MKB40qLtcNcLZ1uz1pgt0UeQdAYAvx6FCVAUR8d
         zTu5SQr/7JIs7QRt310Dqmm6JQ6SbVUNS1VJUF/OdFICfO9ITB0vKsg/bfMx/phpPll/
         TIvlmRGuJCtPSgMHDlb4MuLFzkYl0eg4Q8kD2fRZN2kJHwZUnnCVR2SMfdlF/+Wbl+G5
         shdLvlJbkb+eKnMxFfL1nLkRuXXUdmsmFc7+dc3Yw719ewlBZuXNirQByhiLxhLBtS2o
         /rzw==
X-Gm-Message-State: AOAM533ubYwJM+Fr2zpuOK/cDra3hOriOzpVjWbLlb6UjsUY8/JinOeN
        SaO7RR9f6MZaxTHZ1tlm4pREsw==
X-Google-Smtp-Source: ABdhPJwSq4YsQKEHvtgYys3+NoNnQ/+4rf67PIAOw8VRQUniGfxOtIEPNBfv0NBV4oSR+f44/TJnlQ==
X-Received: by 2002:a17:902:e903:: with SMTP id k3mr24224107pld.155.1595952853080;
        Tue, 28 Jul 2020 09:14:13 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id 4sm18301216pgk.68.2020.07.28.09.14.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2020 09:14:12 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [RFC PATCH 5/9] PCI/AER: Apply function level reset to RCiEP on
 fatal error
Date:   Tue, 28 Jul 2020 09:14:11 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <90E63E9B-DCD3-4325-B1FC-FE5C72BA191B@intel.com>
In-Reply-To: <a79c227f0913438cb5a94dc80a075a7c@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
 <20200724172223.145608-6-sean.v.kelley@intel.com>
 <20200727121726.000072a8@Huawei.com>
 <a79c227f0913438cb5a94dc80a075a7c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28 Jul 2020, at 6:27, Zhuo, Qiuxu wrote:

>> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>> Sent: Monday, July 27, 2020 7:17 PM
>> To: Kelley, Sean V <sean.v.kelley@intel.com>
>> Cc: bhelgaas@google.com; rjw@rjwysocki.net; ashok.raj@kernel.org; 
>> Luck,
>> Tony <tony.luck@intel.com>;
>> sathyanarayanan.kuppuswamy@linux.intel.com; 
>> linux-pci@vger.kernel.org;
>> linux-kernel@vger.kernel.org; Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
>> Subject: Re: [RFC PATCH 5/9] PCI/AER: Apply function level reset to 
>> RCiEP
>> on fatal error
>>
>> On Fri, 24 Jul 2020 10:22:19 -0700
>> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>>
>>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>
>>> Attempt to do function level reset for an RCiEP associated with an
>>> RCEC device on fatal error.
>>
>> I'd like to understand more on your reasoning for flr here.
>> Is it simply that it is all we can do, or is there some basis in a 
>> spec
>> somewhere?
>>
>
> Yes. Though there isn't the link reset for the RCiEP here, I think we 
> should still be able to reset the RCiEP via FLR on fatal error, if the 
> RCiEP supports FLR.
>
> -Qiuxu
>

Also see PCIe 5.0-1, Sec. 6.6.2 Function Level Reset (FLR)

Implementation of FLR is optional (not required), but is strongly 
recommended. For an example use case consider CXL. Function 0 DVSEC 
instances control for the CXL functionality of the entire CXL device. 
FLR may succeed in recovering from CXL.io domain errors.

Thanks,

Sean

>>>
>>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>> ---
>>>  drivers/pci/pcie/err.c | 31 ++++++++++++++++++++++---------
>>>  1 file changed, 22 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c index
>>> 044df004f20b..9b3ec94bdf1d 100644
>>> --- a/drivers/pci/pcie/err.c
>>> +++ b/drivers/pci/pcie/err.c
>>> @@ -170,6 +170,17 @@ static void pci_walk_dev_affected(struct
>> pci_dev *dev, int (*cb)(struct pci_dev
>>>  }
>>>  }
>>>
>>> +static enum pci_channel_state flr_on_rciep(struct pci_dev *dev) {
>>> +if (!pcie_has_flr(dev))
>>> +return PCI_ERS_RESULT_NONE;
>>> +
>>> +if (pcie_flr(dev))
>>> +return PCI_ERS_RESULT_DISCONNECT;
>>> +
>>> +return PCI_ERS_RESULT_RECOVERED;
>>> +}
>>> +
>>>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>>  enum pci_channel_state state,
>>>  pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
>> @@ -191,15
>>> +202,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>>  if (state == pci_channel_io_frozen) {
>>>  pci_walk_dev_affected(dev, report_frozen_detected,
>> &status);
>>>  if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
>>> -pci_warn(dev, "link reset not possible for RCiEP\n");
>>> -status = PCI_ERS_RESULT_NONE;
>>> -goto failed;
>>> -}
>>> -
>>> -status = reset_link(dev);
>>> -if (status != PCI_ERS_RESULT_RECOVERED) {
>>> -pci_warn(dev, "link reset failed\n");
>>> -goto failed;
>>> +status = flr_on_rciep(dev);
>>> +if (status != PCI_ERS_RESULT_RECOVERED) {
>>> +pci_warn(dev, "function level reset failed\n");
>>> +goto failed;
>>> +}
>>> +} else {
>>> +status = reset_link(dev);
>>> +if (status != PCI_ERS_RESULT_RECOVERED) {
>>> +pci_warn(dev, "link reset failed\n");
>>> +goto failed;
>>> +}
>>>  }
>>>  } else {
>>>  pci_walk_dev_affected(dev, report_normal_detected,
>> &status);
>>
