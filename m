Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4150227B710
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 23:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgI1VgG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 17:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgI1VgG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 17:36:06 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5882EC0613CE
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 14:36:06 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y14so2034864pgf.12
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 14:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=9CeopZp8WY9RSvM4Dc5FY/xYVy88bbr1SqV3oic9qQA=;
        b=v51yHcg3rrbkOLHvDLP9ouUMsXf2KuP7FFSjqT+4AgwsxzYcIHJD5gmGrem3vz7s/V
         fOOZiCdjAjDdW+c5RSL5TuhE4kFl9lIrFcRJJnaM9dACSpDD77eFqxFUtfhe/tFunr+3
         jiXKN9H9w/zrvuP1iT/OaEvb9ELPJhwJ5JddGeZJ0zkekFwqUJ1mw2bsZfONZpyUiFCw
         hdBdcPeTPzCr1QBhjT+pF8TItWq8t7qJFVFPAXSFlVK6VYv5m+4JWvzEecxs8JhMMafc
         1ZF74dyj2CXLM1J5u2fcLiNRREzTHd/fuQLBxxR11xyTzZNTv+uzYiKDudPx+Phqmw7W
         KtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=9CeopZp8WY9RSvM4Dc5FY/xYVy88bbr1SqV3oic9qQA=;
        b=BzrPRIcvUxahTlGxfYSCE2GEZObeh9OKVzhi9C5HJFtw2QrAJTSlaMzcmIHGDRaDIu
         wm20SAQVIC9uqXgzFFWH/zcQjvlFh9xvGmpRq3J1sH8lflzGSnfPHqDyVmGJdSnx21+g
         BolPC1/Lv/d70H5tHXKOJeGaVJNXIvwDbLGblicnte8jO+CX9OuxeEdorpLmtTmep/rK
         vn0wX5RvpNC0a8qxyieIXM+Vb8CskAfkHKbaWud+xOrzQQ9c8kbmgj18YIVyKBSpvJQI
         dIOUk937bQespEq4B2AVZRTHRjzcfaJIlzzT/RvGx7HrVKQpkJrP7Lk+1FNx91eLv1il
         d7Jw==
X-Gm-Message-State: AOAM531cwm+cMJ1E71DWIDdxA595Y7i+ATTWPjZeuMtB0k7YjvTN5Iih
        qLDFdkAtViRxtChXkJPmy7FATQ==
X-Google-Smtp-Source: ABdhPJw28AorJK6x/SMLDvlhDyx8HInlpiwTMaNwmhH7iD/ET6ohf55xsQzWW/a1KDHOohXFAGjIaA==
X-Received: by 2002:a17:902:b789:b029:d2:63a5:d3f0 with SMTP id e9-20020a170902b789b02900d263a5d3f0mr1273387pls.81.1601328965826;
        Mon, 28 Sep 2020 14:36:05 -0700 (PDT)
Received: from [10.251.155.156] ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id s24sm2263457pjp.53.2020.09.28.14.36.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:36:05 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Sean V Kelley" <seanvk.dev@oregontracks.org>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/10] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Date:   Mon, 28 Sep 2020 14:36:00 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <93B0C872-C440-484A-9908-2D5B974595CD@intel.com>
In-Reply-To: <20200928014711.GA2475864@bjorn-Precision-5520>
References: <20200928014711.GA2475864@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27 Sep 2020, at 18:47, Bjorn Helgaas wrote:

> On Sun, Sep 27, 2020 at 06:45:45PM -0500, Bjorn Helgaas wrote:
>> On Tue, Sep 22, 2020 at 02:38:56PM -0700, Sean V Kelley wrote:
>>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>
>>>  	pci_dbg(dev, "broadcast error_detected message\n");
>>>  	if (state == pci_channel_io_frozen) {
>>> -		pci_bridge_walk(bridge, report_frozen_detected, &status);
>>> +		pci_bridge_walk(bridge, dev, report_frozen_detected, &status);
>>>  		if (type == PCI_EXP_TYPE_RC_END) {
>>> +			/*
>>> +			 * The callback only clears the Root Error Status
>>> +			 * of the RCEC (see aer.c).
>>> +			 */
>>> +			if (bridge)
>>> +				reset_subordinate_devices(bridge);
>>
>> It's unfortunate to add yet another special case in this code, and 
>> I'm
>> not thrilled about the one in aer_root_reset() either.  It's just not
>> obvious why they should be there.  I'm sure if I spent 30 minutes
>> decoding things, it would all make sense.  Guess I'm just griping
>> because I don't have a better suggestion.
>
> I'm sorry, this was unkind of me.  If I don't have a constructive
> idea, there's no reason for me to complain about this.  I apologize.
>
> Bjorn

No worries at all. The unfortunate handling of the Spec for RCEC/RCiEP 
associations and the added needs for native versus non-native is 
frustrating.

Sean
