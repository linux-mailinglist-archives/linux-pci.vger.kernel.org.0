Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59FE3B48D5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 20:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFYShE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 14:37:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhFYShE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 14:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624646082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w3d5QmgQTedbMfqNV9W2ZCvpWHRikHJ8lDKHWRxFQVI=;
        b=RKn1ebVoFNeri2oe1l2Ua/M0xw3Yo4SoFjGu07Q9Pq7cXkavzo6Hd6UVMik+0rdX4LSmJ3
        8G3mi0rJrR9QnGRtEH1rcRn/DQfN+pP9CbHJeGn1F2d0seP+Jd5wfoxLkULacJq55b3vcF
        65+U/23yjX1iz/kLi13ia8ucKbuWTac=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-6jRjBAaSN6CuLrfTEgk2jQ-1; Fri, 25 Jun 2021 14:34:41 -0400
X-MC-Unique: 6jRjBAaSN6CuLrfTEgk2jQ-1
Received: by mail-wm1-f70.google.com with SMTP id i82-20020a1c22550000b02901d64e84b3c9so3020594wmi.5
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 11:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w3d5QmgQTedbMfqNV9W2ZCvpWHRikHJ8lDKHWRxFQVI=;
        b=bKOj//HMdGURkTQUcwTWOPJl6DYu2rYt9krtezz8tSEHxFGlujcGNQ+b3H8vuN5/Vm
         wq8SVdPf30eUFltW4Qi61qDp4NSpIv9BeF/NANiZP2iwMSO1AcFQp5TRzFn4F+6dkpPk
         Qn27P7LcG3TqQY3uYcW02I7h5IPPv10UaOulMbEj03m+apCadKOIP8UwpRJrXgVatcvD
         ejCYI1IaRQhx3mygD2niIus6NVUC4C0jVAbev2XsEecCtSMz97SPwB4HLA0yH8ctCWJs
         M+G6m2cXwSAFRPVi+7YckbigOluyzqcJ+A93oh9XLufzag2cFS9PXtxYtD26B0IFWj+D
         IqXg==
X-Gm-Message-State: AOAM530dWrAcl1yT4yj3Eg2kszaxQdvCOH81AUrZf35XNSEr8A1Gyovx
        yl1lFIayDTCAurFUWSqKQO1XGLdEFSJEqqhw3Ou+bR298yV8d41Wu3oc42aUr4otCcHxvI2nczd
        K+yAQQ5qCVp6ZcilvVoO+
X-Received: by 2002:a5d:6646:: with SMTP id f6mr12558755wrw.399.1624646080360;
        Fri, 25 Jun 2021 11:34:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxv71Y5qNrtRBtagkA7o6lXh3Ty2kHfWVl115v2RJg/5J5ugMGjArkWAQ76YYJB8G51G3pgA==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr12558747wrw.399.1624646080189;
        Fri, 25 Jun 2021 11:34:40 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z4sm6834597wrs.56.2021.06.25.11.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 11:34:39 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        rfi@lists.rocketboards.org, Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
References: <20210625143235.GA3624355@bjorn-Precision-5520>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <fa7ee574-89a7-330c-40ae-717142924cfa@redhat.com>
Date:   Fri, 25 Jun 2021 20:34:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625143235.GA3624355@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/25/21 4:32 PM, Bjorn Helgaas wrote:
> On Fri, Jun 25, 2021 at 09:09:36AM +0200, Javier Martinez Canillas wrote:
>> On 6/25/21 12:40 AM, Bjorn Helgaas wrote:
> 
>>> I think this is also an issue with the following other drivers.  They all
>>> set the handler to something that uses an IRQ domain before they
>>> actually initialize the domain:
>>
>> Yes, I agreed with your assessment and also noticed that others drivers have
>> similar issues. I just don't have any of those platforms to try to reproduce
>> the bugs and test a fix.
> 
> Even if you don't have other platforms for testing, I'm thrilled when
> folks point out issues with them and (given time and inclination) post
> patches for them.
> 
> I'd much rather fix *all* instances of the problem than just one, even
> if we can't test them all.  Frequently driver maintainers will review
> and test patches for their hardware even if we can't.
>

Ok. I'll try to make some time next week to look at these drivers then
and post at least RFC/RFT patches for people with available hardware to
test the changes.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

