Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF1C22F35F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgG0PFR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 11:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgG0PFR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 11:05:17 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C482C061794
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 08:05:17 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o22so9565087pjw.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=07ri+IqTYf1fjZepY5g8VXcoLFcfPO4oBtO7lv1kJDA=;
        b=VtzMBn4crNcZcyJ+6o1zOaOYWkPDW13gNgR/hm+I0N4aKLfjebBb5nppjE45zA9dyp
         +hyrV6pvrdgbf97Wkl1Q6psPTU36m4VY8yLOyRo7gWqFg97E5LwNc4F+l88xkgh1agc1
         bp120hrWMZKD5/wKlHzhmGOTHXm1pKhrKsBYKmC9liWVrb/UYCT1L3HsYfq3FzFm0mQP
         4kHW3zAxF/IH1Dtj8WbC3R301ww9Q5uJ8AhuLwZ5sMzxunEVz7upcJ6AFeiBYYqGGhvn
         Bo0USFHWfmdjdxhyVBgIQLyKf75toRwq/L9nZNsDKTgQCDVI21xrIav4V499iP3HxZzB
         rr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=07ri+IqTYf1fjZepY5g8VXcoLFcfPO4oBtO7lv1kJDA=;
        b=XFmRKtuldU/TamPi+oKNcQEQWEgI81SVCMgzWdmwzRzuz1CWMKLz18jYep3QffGD9W
         xj/Q3WA/f3NTvZOwY8wkfSoyVY0yJsrMQIXCvb66akQjJxCEzKmICf6g4zQvkhiElLFj
         QOJqsH75Mf8kMdHgV3HUA2BBGGfJbkefVznB16MvPBEQFv8eOW/vuKrZ3G3tAgFIzyo5
         213KAPDK4JxdNr+vLavpaDDQcr6v8Ng0WjKiA7Kzy45Yil36LteMA7YubcuDhhen86v2
         uIOPoHzgY2bVGMXh/9IqNBZu+6IEVVKre7qJaRZIcP0dLCMvlI7JXOxyQklEKO87u800
         crAw==
X-Gm-Message-State: AOAM532uFNvkCmPOVoZXrqFlMZyMkZ1nP1fhRcTrw5QiZ7qvx0vh6Zwv
        fMHzvogZ6Wj8TA/GAj8X32yFNg==
X-Google-Smtp-Source: ABdhPJzl+1AJvlc0PN8W87qhHbl+tCsEGCMPA6OLS0Jj0M0Mch+md2d5VMA8Qx8nv/ct38VCt1mdZQ==
X-Received: by 2002:a17:90a:6888:: with SMTP id a8mr18507355pjd.59.1595862316701;
        Mon, 27 Jul 2020 08:05:16 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id 22sm15115563pfh.157.2020.07.27.08.05.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 08:05:15 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net, tony.luck@intel.com,
        "Raj, Ashok" <ashok.raj@intel.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
Subject: Re: [RFC PATCH 2/9] PCI: Extend Root Port Driver to support RCEC
Date:   Mon, 27 Jul 2020 08:05:16 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <3628B87C-DE0E-477E-85C1-FFD154DC4EFD@intel.com>
In-Reply-To: <20200727133010.00003de8@Huawei.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
 <20200724172223.145608-3-sean.v.kelley@intel.com>
 <20200727133010.00003de8@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27 Jul 2020, at 5:30, Jonathan Cameron wrote:

> On Fri, 24 Jul 2020 10:22:16 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>
>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>
>> If a Root Complex Integrated Endpoint (RCiEP) is implemented, errors =

>> may
>> optionally be sent to a corresponding Root Complex Event Collector =

>> (RCEC).
>> Each RCiEP must be associated with no more than one RCEC. Interface =

>> errors
>> are reported to the OS by RCECs.
>>
>> For an RCEC (technically not a Bridge), error messages "received" =

>> from
>> associated RCiEPs must be enabled for "transmission" in order to =

>> cause a
>> System Error via the Root Control register or (when the Advanced =

>> Error
>> Reporting Capability is present) reporting via the Root Error Command
>> register and logging in the Root Error Status register and Error =

>> Source
>> Identification register.
>>
>> Given the commonality with Root Ports and the need to also support =

>> AER
>> and PME services for RCECs, extend the Root Port driver to support =

>> RCEC
>> devices through the addition of the RCEC Class ID to the driver
>> structure.
>>
> Hi.
>
> I'm surprised it ended up this simple :) Seems we are a bit lucky that
> the existing code is rather flexible on what is there and what isn't
> and that there is never any reason to directly touch the various
> type1 specific registers (given as I read the spec, an RCEC uses a
> type0 config space header unlike the ports).

Which is part of the reason why I chose to refer to it as an RFC, =

because it seemed simpler and I was unsure if we were missing anything, =

and it turns out we were. Unfortunately, to avoid churn, I=E2=80=99ve lef=
t =

quite a bit of comments/naming intact with =E2=80=9Croot=E2=80=9D/=E2=80=9C=
port=E2=80=9D terms.

>
> Given you mention PME, it's probably worth noting (I think) you aren't
> actually enabling the service yet as there is a check in that path on =

> whether we
> have a root port or not.
> https://elixir.bootlin.com/linux/v5.8-rc4/source/drivers/pci/pcie/portd=
rv_core.c#L241

Good catch, testing has been only done at this point with AER injection.
Will correct.

Thanks,

Sean

>
> Thanks,
>
> Jonathan
>
>
>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> ---
>>  drivers/pci/pcie/portdrv_pci.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv_pci.c =

>> b/drivers/pci/pcie/portdrv_pci.c
>> index 3acf151ae015..d5b109499b10 100644
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -106,7 +106,8 @@ static int pcie_portdrv_probe(struct pci_dev =

>> *dev,
>>  	if (!pci_is_pcie(dev) ||
>>  	    ((pci_pcie_type(dev) !=3D PCI_EXP_TYPE_ROOT_PORT) &&
>>  	     (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_UPSTREAM) &&
>> -	     (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_DOWNSTREAM)))
>> +	     (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_DOWNSTREAM) &&
>> +	     (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_RC_EC)))
>>  		return -ENODEV;
>>
>>  	status =3D pcie_port_device_register(dev);
>> @@ -195,6 +196,8 @@ static const struct pci_device_id port_pci_ids[] =

>> =3D {
>>  	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
>>  	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
>>  	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
>> +	/* handle any Root Complex Event Collector */
>> +	{ PCI_DEVICE_CLASS(((PCI_CLASS_SYSTEM_RCEC << 8) | 0x00), ~0) },
>>  	{ },
>>  };
>>
