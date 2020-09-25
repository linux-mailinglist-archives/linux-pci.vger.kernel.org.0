Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0FF279463
	for <lists+linux-pci@lfdr.de>; Sat, 26 Sep 2020 00:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgIYWyX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 18:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgIYWyX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 18:54:23 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18958C0613D3
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 15:54:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b17so242109pji.1
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 15:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=RoKnACgaWS5LzdU+6sscBou6/I159ovfqzEP7aVaDzw=;
        b=ZSR2acP+CjWXpmgSTWJ0R4K9ppi11L/dMv8tich8Ohu20GiJQ4yFSl/qE6v97cTogY
         9/JdhN3ybLiVotWGiDvBIDzMQJJWONX/JgBXJKRuGTJ+y5XUjqKJ0fcDhTC70uFUbksj
         zQLs0q5qZDoVkuOwwO6xFHC7iyX1+iLU6H/qOy8y9QlpMBuZIayrU9H7KvT0YWfFWvy9
         eyp6tLlV3dsVlLkwR/2gpx3Y4R6cGjk+52UkXqOLPhF8XsWiY+HdtMhwGFvO26oLH7Qn
         mtlmLcYp2LDv5twvxEEAtgH9EaxWIlqhu9epX6FgVti34KE5cPC1Ik4rwbao3JMfJD8c
         CbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=RoKnACgaWS5LzdU+6sscBou6/I159ovfqzEP7aVaDzw=;
        b=HACgYUl93QoSQhNK8fOEHER7Ho4X/dslIGhAeHcTL4ZUUD0ZNRB/YwFvK+ujlFxv+m
         CYPH1S7Gp6dkNb5yF2jWLkoe5uP/4g5VsyIB1rYt+9Lbph/Pd822byv8B6t9zS2+e5nD
         fehAYetyLoYiy+5j9AhhdMT5a2yn/4BV1a74MZjlX3DftPHGgEgMN6c+CiUJ5gkLlCS7
         ZbqXouB2OQKOaYZG0p2tohbvPpCkNiKtIKJRSU4iw3Ex1OYX5bDUTBEPXKiw3zyb+bFl
         zG14QskLRQ9M/xc+1ArnO/6TlkB4lA+r2T1TZMhZtEfNJHLVxez68xO3S4KCOg5SxaP1
         3N/Q==
X-Gm-Message-State: AOAM531Q4LYj3ChaS9h2/IKCPk2USc5yfDLM0ugDcB6ZmbiYGMULUuSL
        4JV1bX+ykoLMbwYDiPR7tvWuzA==
X-Google-Smtp-Source: ABdhPJxmkfAHo35d3Rc3VorQdYYJb5d61Taw5jSIa2vfo+izYhZie5MHIXq8d6TH7Qt7XXJovJkprw==
X-Received: by 2002:a17:90b:80a:: with SMTP id bk10mr688415pjb.53.1601074462667;
        Fri, 25 Sep 2020 15:54:22 -0700 (PDT)
Received: from [10.212.51.97] ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id c1sm3653798pfj.219.2020.09.25.15.54.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 15:54:21 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Sean V Kelley" <seanvk.dev@oregontracks.org>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/10] PCI/AER: Apply function level reset to RCiEP on
 fatal error
Date:   Fri, 25 Sep 2020 15:54:19 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <E621EAEF-54F8-4820-BC58-ED6163C82086@intel.com>
In-Reply-To: <20200925215854.GA2460270@bjorn-Precision-5520>
References: <20200925215854.GA2460270@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25 Sep 2020, at 14:58, Bjorn Helgaas wrote:

> On Tue, Sep 22, 2020 at 02:38:54PM -0700, Sean V Kelley wrote:
>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>
>> Attempt to do function level reset for an RCiEP associated with an
>> RCEC device on fatal error.
>>
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> ---
>>  drivers/pci/pcie/err.c | 31 ++++++++++++++++++++++---------
>>  1 file changed, 22 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index e575fa6cee63..5380ecc41506 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -169,6 +169,17 @@ static void pci_bridge_walk(struct pci_dev 
>> *bridge, int (*cb)(struct pci_dev *,
>>  		cb(bridge, userdata);
>>  }
>>
>> +static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
>> +{
>> +	if (!pcie_has_flr(dev))
>> +		return PCI_ERS_RESULT_NONE;
>> +
>> +	if (pcie_flr(dev))
>> +		return PCI_ERS_RESULT_DISCONNECT;
>> +
>> +	return PCI_ERS_RESULT_RECOVERED;
>> +}
>
> Either we reset the device or we didn't; there is no third option.
>
> If I read it correctly, nothing in pcie_do_recovery() cares about the
> difference between PCI_ERS_RESULT_NONE and PCI_ERS_RESULT_DISCONNECT.
> The status does get returned, but only edr_handle_event() looks at it,
> and it doesn't care about the difference either.
>
> So I think this should just return PCI_ERS_RESULT_RECOVERED or
> PCI_ERS_RESULT_DISCONNECT.

You raise a good point. As currently implemented, the usage requires 
either a reset or not result. Will change.

Thanks,

Sean

>
>>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>  			pci_channel_state_t state,
>>  			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev 
>> *pdev))
>> @@ -195,15 +206,17 @@ pci_ers_result_t pcie_do_recovery(struct 
>> pci_dev *dev,
>>  	if (state == pci_channel_io_frozen) {
>>  		pci_bridge_walk(bridge, report_frozen_detected, &status);
>>  		if (type == PCI_EXP_TYPE_RC_END) {
>> -			pci_warn(dev, "link reset not possible for RCiEP\n");
>> -			status = PCI_ERS_RESULT_NONE;
>> -			goto failed;
>> -		}
>> -
>> -		status = reset_subordinate_devices(bridge);
>> -		if (status != PCI_ERS_RESULT_RECOVERED) {
>> -			pci_warn(dev, "subordinate device reset failed\n");
>> -			goto failed;
>> +			status = flr_on_rciep(dev);
>> +			if (status != PCI_ERS_RESULT_RECOVERED) {
>> +				pci_warn(dev, "function level reset failed\n");
>> +				goto failed;
>> +			}
>> +		} else {
>> +			status = reset_subordinate_devices(bridge);
>> +			if (status != PCI_ERS_RESULT_RECOVERED) {
>> +				pci_warn(dev, "subordinate device reset failed\n");
>> +				goto failed;
>> +			}
>>  		}
>>  	} else {
>>  		pci_bridge_walk(bridge, report_normal_detected, &status);
>> -- 
>> 2.28.0
>>
