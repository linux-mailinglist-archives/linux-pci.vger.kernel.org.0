Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFAB1092F1
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 18:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfKYRjp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 12:39:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56161 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKYRjp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 12:39:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so180131wmb.5
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2019 09:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/QIegaq48NeU0BQ0QWTcdh3wiSL7YImAtZqY3KoFn00=;
        b=Fv+7Id3fFC9Gb64eASFwEZcY292oiuqW3I1o7jy7ukKqsdQqDVOZBHxyZ4NvZqDoPk
         EyaN1uDLh4PN2z5OYnIi3XGPANN/p+avXZE/2oGyvOpeEnysV2K2G7t2f30sN1BJKAix
         xxRqLCLp2F2SWoAOqUL12RfxhDNIEB/Hr/h78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/QIegaq48NeU0BQ0QWTcdh3wiSL7YImAtZqY3KoFn00=;
        b=qN+4eNDausDokJLh0Hg6+4E8JZs138K2P3xl1eTmcDhFEqSOdeRfzEK9hL/gd9awo4
         qN88wKAaZhbCD8CZuwyUEUQv3H2So7jjHAPy7yTIqizs+kDtWL9sHBQhD1PyruARaNmr
         siLnD7AfRGmzuGsKQNjnLh922whroorozDCAWM8Gs/OVaivw0NWxIWymD2MV8IYk/DRv
         TnNRfEK96g/OcId1ERVWGGoOP+w8fsQ7To0zvPXB3L6HGlsQ81+rEra0BwYdvHhS/UOt
         Aja9icIJw3QesNtEuHlWsKB4pzNvL0zUdDC+vQ8ZZvFxKpPtwFw1C4LCJ8QA6B0eVmg+
         zdBQ==
X-Gm-Message-State: APjAAAVnRy3pPyUnmY64GpPKEBEgwz4XLhS9sZTJMiKncgtajDR/z42T
        es3qecii0fTR42F5I+sXT/wKiQ==
X-Google-Smtp-Source: APXvYqwUSNkayXZiksottEy/4DF3h6TSLaUdi8KBkRNneJ+6dMs1XvwDf3qHiEosbpGVyju0Lt7s9Q==
X-Received: by 2002:a1c:a906:: with SMTP id s6mr1164wme.125.1574703583432;
        Mon, 25 Nov 2019 09:39:43 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b17sm11542013wrp.49.2019.11.25.09.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 09:39:42 -0800 (PST)
Subject: Re: [PATCH] PCI: build Broadcom PAXC quirks unconditionally
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        rjui@broadcom.com
References: <20191115135842.119621-1-wei.liu@kernel.org>
 <CAHd7WqxfQg4FXTBqmtMraL4Dqy6zk5uFP4wuxjsY2ns6j=cP9A@mail.gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <8aedf976-ef33-96b6-751b-0242f7e61af9@broadcom.com>
Date:   Mon, 25 Nov 2019 09:39:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHd7WqxfQg4FXTBqmtMraL4Dqy6zk5uFP4wuxjsY2ns6j=cP9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/25/19 6:55 AM, Wei Liu wrote:
> On Fri, 15 Nov 2019 at 13:58, Wei Liu <wei.liu@kernel.org> wrote:
>>
>> CONFIG_PCIE_IPROC_PLATFORM only gets defined when the driver is built
>> in.  Removing the ifdef will allow us to build the driver as a module.
>>
>> Signed-off-by: Wei Liu <wei.liu@kernel.org>
>> ---
>> Alternatively, we can change the condition to:
>>
>>    #ifdef CONFIG_PCIE_IPROC_PLATFORM || CONFIG_PCIE_IPROC_PLATFORM_MODULE
>> .
>>
>> I chose to remove the ifdef because that's what other quirks looked like
>> in this file.
> 
> Bjorn and Ray, any comment on this trivial patch?
> 
> Wei.
> 

I just reviewed it and it looks good to me. Thanks!

Ray
