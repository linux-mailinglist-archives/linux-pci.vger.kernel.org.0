Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA9223110C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 19:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbgG1Rmh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 13:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731973AbgG1Rmh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2020 13:42:37 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50084C0619D2
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2020 10:42:37 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id lw1so294923pjb.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2020 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfpHKsoVo25CjaecIXU5Q9jpRlvEAlBczb4lYguq0/M=;
        b=eKyTwAuR/od7gtFEV11Si761xTpPRtou9fdgPSQuHfKUidqdJCuQOUosd0tNgPpLCp
         yqn8F7aIAPPITxSU/Co2ZByb22sZ0opGhD2bLDgwivSFEkW9LP+pYuGCKYGbNuR0vEHB
         BQsxuywlPk3x9xfv5ARtpkN1ko0S0IlwhCNH0aByEWVrI8p7f6BGk9p2JXMqD560kp9U
         dyh4U9KcJpIMygD2a5H8BwGoLmqX2rm8/AMgKVawUz9DXC7PpALeZzBsz5ZlRK5FSGjR
         LSSoqJqyyEd2auvPm79KuuD/eC52PZ1sTV62TfqD/OVJfAYrOa/l1AynQZmGv9H/yPn7
         5+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfpHKsoVo25CjaecIXU5Q9jpRlvEAlBczb4lYguq0/M=;
        b=WlkYXBIpLYzTFUd87EUy5wiG/clpUKNz7I9aHmGVgTkG0uEm2Di83qioTr/k87j9BB
         sGxA+fXJGIRnSBwW8qOTa0ncjMYTSCZuUYKLN9f2unWmS8RsfaWFjZta+78r10XiQ/vF
         poZIYREkQLISQBNWaR9M8S0sDrXD/iSYDUVS7UTd12bEa1nCLTQUtkDGWV07aUx5fswW
         Zwjv1LdPvUIHvBmkqlejSIMg5aQ/mnFvAfXAgWBjYvVYrIDnYJFr502VSxfw14F4WG6T
         BcXWR6C16XtfFSUBN2JALNOVyW4F3k5wdUQJPMJca8gsnFxAAeINd1SYJoxbWKkL2axI
         71mA==
X-Gm-Message-State: AOAM530RlM/TQRnu/QU+GaZj4g43OkJP0Mv8LFJdOFYJS1Oo4z1AMxV2
        lQk105TGb9f+4OVanItf39P1+g==
X-Google-Smtp-Source: ABdhPJz0fOKmi6m0zqNM7S1MSY74xMc8axn+VGTAxxj7LapUUiOi3Wl3hAupFBIeXziPaNn+PKCZQg==
X-Received: by 2002:a17:90a:ba92:: with SMTP id t18mr5499798pjr.121.1595958156761;
        Tue, 28 Jul 2020 10:42:36 -0700 (PDT)
Received: from [10.212.119.73] ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id v3sm20200410pfb.207.2020.07.28.10.42.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2020 10:42:36 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     bhelgaas@google.com, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        rjw@rjwysocki.net, "Luck, Tony" <tony.luck@intel.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [RFC PATCH 5/9] PCI/AER: Apply function level reset to RCiEP on
 fatal error
Date:   Tue, 28 Jul 2020 10:42:33 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <C21C050B-48B1-4429-B019-C81F3AB8E843@intel.com>
In-Reply-To: <20200728180235.00006ffe@Huawei.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
 <20200724172223.145608-6-sean.v.kelley@intel.com>
 <20200727121726.000072a8@Huawei.com>
 <a79c227f0913438cb5a94dc80a075a7c@intel.com>
 <90E63E9B-DCD3-4325-B1FC-FE5C72BA191B@intel.com>
 <20200728180235.00006ffe@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28 Jul 2020, at 10:02, Jonathan Cameron wrote:

> On Tue, 28 Jul 2020 09:14:11 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>
>> On 28 Jul 2020, at 6:27, Zhuo, Qiuxu wrote:
>>
>>>> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>>>> Sent: Monday, July 27, 2020 7:17 PM
>>>> To: Kelley, Sean V <sean.v.kelley@intel.com>
>>>> Cc: bhelgaas@google.com; rjw@rjwysocki.net; ashok.raj@kernel.org;
>>>> Luck,
>>>> Tony <tony.luck@intel.com>;
>>>> sathyanarayanan.kuppuswamy@linux.intel.com;
>>>> linux-pci@vger.kernel.org;
>>>> linux-kernel@vger.kernel.org; Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
>>>> Subject: Re: [RFC PATCH 5/9] PCI/AER: Apply function level reset to
>>>> RCiEP
>>>> on fatal error
>>>>
>>>> On Fri, 24 Jul 2020 10:22:19 -0700
>>>> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>>>>
>>>>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>>>
>>>>> Attempt to do function level reset for an RCiEP associated with an
>>>>> RCEC device on fatal error.
>>>>
>>>> I'd like to understand more on your reasoning for flr here.
>>>> Is it simply that it is all we can do, or is there some basis in a
>>>> spec
>>>> somewhere?
>>>>
>>>
>>> Yes. Though there isn't the link reset for the RCiEP here, I think 
>>> we
>>> should still be able to reset the RCiEP via FLR on fatal error, if 
>>> the
>>> RCiEP supports FLR.
>>>
>>> -Qiuxu
>>>
>>
>> Also see PCIe 5.0-1, Sec. 6.6.2 Function Level Reset (FLR)
>>
>> Implementation of FLR is optional (not required), but is strongly
>> recommended. For an example use case consider CXL. Function 0 DVSEC
>> instances control for the CXL functionality of the entire CXL device.
>> FLR may succeed in recovering from CXL.io domain errors.
>
> That feels a little bit of a weak argument in favour.  PCI spec lists 
> examples
> of use only for FLR and I can't see this matching any of them, but 
> then they
> are only examples, so we could argue it doesn't exclude this use. It's 
> not
> allowed to affect the link state, but I guess it 'might' recover from 
> some
> other type of error?
>
> I'd have read the statement in the CXL spec you are referring to as 
> matching
> with the first example in the PCIe spec which is about recovering from
> software errors.  For example, unexpected VM tear down.

 From my perspective, it can add value as the point is to address device 
functions and their associated software states. As the section in the 
spec goes on to state:

“The FLR mechanism enables software to quiesce and reset Endpoint 
hardware with Function-level granularity. Three example usage models 
illustrate the benefits of this feature:…”

Later changes in CXL 2.0 Section 9.8 (as of 0.9 draft) further look to 
extend FLR with an eFLR or now referred to as CXL Reset.

“All Functions in a CXL 2.0 (Single Logical Device) SLD that 
participate in CXL.cache or CXL.mem are required to support either FLR 
or CXL Reset. MLDs (Multiple Logical Devices), on the other hand, are 
required to support CXL Reset.”

In my mind the question is whether this change is too limited in scope 
with this patch series (RCiEP) and whether FLR should be considered in a 
broader, i.e., EP, as a ‘hammer’ so to speak.

Thanks,

Sean

>
> @Bjorn / All.  What's your view on using FLR as a reset to do when you 
> don't
> have any other hammers to use?
>
> Personally I don't have a particular problem with this, it just 
> doesn't fit
> with my mental model of what FLR is for (which may well need adjusting 
> :)
>
> Jonathan
>
>
>>
>> Thanks,
>>
>> Sean
>>
>>>>>
>>>>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>>>> ---
>>>>>  drivers/pci/pcie/err.c | 31 ++++++++++++++++++++++---------
>>>>>  1 file changed, 22 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c index
>>>>> 044df004f20b..9b3ec94bdf1d 100644
>>>>> --- a/drivers/pci/pcie/err.c
>>>>> +++ b/drivers/pci/pcie/err.c
>>>>> @@ -170,6 +170,17 @@ static void pci_walk_dev_affected(struct
>>>> pci_dev *dev, int (*cb)(struct pci_dev
>>>>>  }
>>>>>  }
>>>>>
>>>>> +static enum pci_channel_state flr_on_rciep(struct pci_dev *dev) {
>>>>> +if (!pcie_has_flr(dev))
>>>>> +return PCI_ERS_RESULT_NONE;
>>>>> +
>>>>> +if (pcie_flr(dev))
>>>>> +return PCI_ERS_RESULT_DISCONNECT;
>>>>> +
>>>>> +return PCI_ERS_RESULT_RECOVERED;
>>>>> +}
>>>>> +
>>>>>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>>>>  enum pci_channel_state state,
>>>>>  pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
>>>> @@ -191,15
>>>>> +202,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>>>>  if (state == pci_channel_io_frozen) {
>>>>>  pci_walk_dev_affected(dev, report_frozen_detected,
>>>> &status);
>>>>>  if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
>>>>> -pci_warn(dev, "link reset not possible for RCiEP\n");
>>>>> -status = PCI_ERS_RESULT_NONE;
>>>>> -goto failed;
>>>>> -}
>>>>> -
>>>>> -status = reset_link(dev);
>>>>> -if (status != PCI_ERS_RESULT_RECOVERED) {
>>>>> -pci_warn(dev, "link reset failed\n");
>>>>> -goto failed;
>>>>> +status = flr_on_rciep(dev);
>>>>> +if (status != PCI_ERS_RESULT_RECOVERED) {
>>>>> +pci_warn(dev, "function level reset failed\n");
>>>>> +goto failed;
>>>>> +}
>>>>> +} else {
>>>>> +status = reset_link(dev);
>>>>> +if (status != PCI_ERS_RESULT_RECOVERED) {
>>>>> +pci_warn(dev, "link reset failed\n");
>>>>> +goto failed;
>>>>> +}
>>>>>  }
>>>>>  } else {
>>>>>  pci_walk_dev_affected(dev, report_normal_detected,
>>>> &status);
>>>>
