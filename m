Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA567C942A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2019 00:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfJBWOA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Oct 2019 18:14:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32899 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfJBWOA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Oct 2019 18:14:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id e18so829746oii.0;
        Wed, 02 Oct 2019 15:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sqk/SFk4ZImYIBcERyKHjU6k+Y9P6R8FWyKPazl8xYA=;
        b=YwTraDTntg1G+u7Q2S81u1noOW7tjCCMyd7P2/qmF5YM9/0NUfZL0Euw5BaM31YQ1F
         NaGWJ9zr8QJRcxwPXD1haA3Q0L36Fwq5ltQXJG0BbRJX98ytSUF3DFM/PmA/1ReBpH0j
         UZxHTpdX8CUPqhtQnX3PwoVKlz+jvNXZB0hFJJqibeqrOGtLM2gzH6NfSh1tMqOQUSAw
         dETRblrltQ3id0qF8yLWmlRs8Av0X8I4SjGxDhzBzCreBrDudh5uAbVCF83A5je5dpat
         oBlSkR+a2iLlbRdpX4QGlzdlIxeYDks6kUX6DVpePuLzS3TampizmNJyjj+QU3QwuBon
         /A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sqk/SFk4ZImYIBcERyKHjU6k+Y9P6R8FWyKPazl8xYA=;
        b=GuNaLmTf85Slv9pLqfPtlplv7u98Iow8uVJSIajkc7mecvx368fgv4z3TxcbqZdV+e
         +EkyDZNuNrvRGPo4vkOTj2YM1+zQxSfZ4yBT16rV9HDKokQ8EAKscylW+RL0Pufhgnai
         cA7ESPw8j7/Jrq8wT1PG9WrOibW/mQCY32bp+uLiy3QuQn7osTd6ddsUYWIDVxHOVEmg
         JyM1hAziuPn1i4cgp1t5tC9SoIsg2b1IsgfGGGa9O6waOIEcxwoAYlRsEUT81llIzn1n
         0wPYspycjVfWDwI354pXvWeJfeOi4Hj2n5Ji6bjwAE1ULa289+MA6QhOmz2omiKLl5ug
         +NYg==
X-Gm-Message-State: APjAAAUMn3Ye9F+ca9siQADdUQ9HchlecyoC+xIgWwUG4Iw8Fkm4nlBh
        rXiNXy5Cdl4gjv2CA5dm1GMYCqbWWRy5Sg==
X-Google-Smtp-Source: APXvYqy3haKfq5CSi7BfjH3KJ5olSRvyyEnJDllpCOIzv053tu35ipKl7mhVvvPQ8LLSDuZ0RMIZgA==
X-Received: by 2002:aca:645:: with SMTP id 66mr233481oig.117.1570054439541;
        Wed, 02 Oct 2019 15:13:59 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id x38sm218466ota.59.2019.10.02.15.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 15:13:59 -0700 (PDT)
Subject: Re: [PATCH 0/3] PCI: pciehp: Do not turn off slot if presence comes
 up after link
To:     Lukas Wunner <lukas@wunner.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191001211419.11245-1-stuart.w.hayes@gmail.com>
 <20191002041315.6dpqpis5zikosyyc@wunner.de>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <c494a7c4-8323-e75f-6a3f-5f342ce7b1c7@gmail.com>
Date:   Wed, 2 Oct 2019 17:13:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191002041315.6dpqpis5zikosyyc@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/1/19 11:13 PM, Lukas Wunner wrote:
> On Tue, Oct 01, 2019 at 05:14:16PM -0400, Stuart Hayes wrote:
>> This patch set is based on a patch set [1] submitted many months ago by
>> Alexandru Gagniuc, who is no longer working on it.
>>
>> [1] https://patchwork.kernel.org/cover/10909167/
>>      [v3,0/4] PCI: pciehp: Do not turn off slot if presence comes up after link
> 
> If I'm not mistaken, these two are identical to Alex' patches, right?
> 
>    PCI: pciehp: Add support for disabling in-band presence
>    PCI: pciehp: Wait for PDS when in-band presence is disabled
> 
> I'm not sure if it's appropriate to change the author and
> omit Alex' Signed-off-by.

Legally Dell owns the patches. I have no objection on my end.

Alex

> Otherwise I have no objections against this series.
> 
> Thanks,
> 
> Lukas
> 
