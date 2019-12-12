Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E1311C10D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 01:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfLLAF1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 19:05:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42058 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfLLAF1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2019 19:05:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id x13so230489plr.9
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2019 16:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=knL1h4z24lzIsuvmKBSo/0XCAih1x2E+PNOpBTrzcGk=;
        b=F+L7+Mc3etbG1GUgdUAhBMtdS+nyLaqayWnDG5+p1t59WUdZj1PBNxC99I2o8fj+2n
         /ZlDtwrf9BqmdY9E5tAc/sOu7JaK4kpdT6ZRR3c4NOh8Sz8ySHB9Ifn40VhfubjkJNHK
         ONSsQvsWpQibeZP7zO5nzSUfSJZ1AwPA9EaG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=knL1h4z24lzIsuvmKBSo/0XCAih1x2E+PNOpBTrzcGk=;
        b=emgpHs4DR8OYZbD1vFRhQBuOgIykaWfv+R8Zlluh0iNQjTCv9wBMvw1kxgOnToyZiA
         eDfK8jtXOg6r3Ke3DLaEqB2q1gn3guv5SUxc/tS0FTJPcakhJhLHtS0OyzFXISLACqtF
         2yfkhQILzgWMg0Ykj4wSmCcdIAP3XQRT7X0KoTyL1SEAMqCGCOZvvoSRk35tnzCFgiEG
         swrk26FU4cc83bQ1Vh+dUITk5/OSsDX345FpPDhmNerij7aEI2l4ZvVfQKd6lRMRwdbq
         xe+4MI/m+b4/Tsma3Az3TjS9HsoJ0y2T0N8cm2NuCwtr0mvXMCvbSBXv4hximc7Ey50z
         8QCA==
X-Gm-Message-State: APjAAAXuAgfKSWpvCxJrMn0dXP+ab+TpGAC+9Vjg3qi/EGDCXX6pQEuv
        rbywktoh4m4bp2QodyH879Nkcw==
X-Google-Smtp-Source: APXvYqwcALLNRnEYmvQAy3fkAKoj96pGRx8c8rS0MqgQqUrVCv3OXGILvc7bHoF670n2YGGrTcS9GA==
X-Received: by 2002:a17:902:203:: with SMTP id 3mr6369151plc.170.1576109126833;
        Wed, 11 Dec 2019 16:05:26 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id y199sm4415133pfb.137.2019.12.11.16.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 16:05:25 -0800 (PST)
Subject: Re: [PATCH] PCI: iproc: move quirks to driver
To:     bjorn@helgaas.com
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Wei Liu <wei.liu@kernel.org>,
        linux-pci@vger.kernel.org, rjui@broadcom.com,
        Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20191211223438.GA121846@google.com>
 <afbb14fb-e114-d6de-0bfe-d39be354842e@broadcom.com>
 <CABhMZUU82iRD67yQhpUG3MUx3s9WaZ=tAXA=QriEEjUkNbu22w@mail.gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <8983ae6c-36ac-7acc-5caa-2d11bf593d44@broadcom.com>
Date:   Wed, 11 Dec 2019 16:05:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CABhMZUU82iRD67yQhpUG3MUx3s9WaZ=tAXA=QriEEjUkNbu22w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/11/19 4:02 PM, Bjorn Helgaas wrote:
> On Wed, Dec 11, 2019 at 5:40 PM Ray Jui <ray.jui@broadcom.com> wrote:
>>
>>
>>
>> On 12/11/19 2:34 PM, Bjorn Helgaas wrote:
>>> On Wed, Dec 11, 2019 at 05:45:11PM +0000, Wei Liu wrote:
>>>> The quirks were originally enclosed by ifdef. That made the quirks not
>>>> to be applied when respective drivers were compiled as modules.
>>>>
>>>> Move the quirks to driver code to fix the issue.
>>>>
>>>> Signed-off-by: Wei Liu <wei.liu@kernel.org>
>>>
>>> This straddles the core and native driver boundary, so I applied it to
>>> pci/misc for v5.6.  Thanks, I think this is a great solution!  It's
>>> always nice when we can encapsulate device-specific things in a
>>> driver.
>>>
>>
>> Opps! I was going to review and comment and you are quick, :)
>>
>> I was going to say, I think it's better to keep this quirk in
>> "pcie-iproc.c" instead of "pcie-iproc-platform.c".
>>
>> The quirk is specific to certain PCIe devices under iProc (activated
>> based on device ID), but should not be tied to a specific bus
>> architecture (i.e., platform vs BCMA).
> 
> I'm happy to move it; that's no problem.
> 

Thanks, Bjorn!
