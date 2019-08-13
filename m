Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABE28ADD9
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 06:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbfHMEij (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 00:38:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39307 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfHMEii (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2019 00:38:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so50578580pgi.6;
        Mon, 12 Aug 2019 21:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KQPCTl794rAugb19t3k9pgcqB9NI9bu3aVo81wrxClU=;
        b=oszJvGzgx/Z1+XOeonH6lr7kQGHeiWCbuEG1KJSG7QMKNydEY871mDi9hozYEn7NA2
         7GHyCkhKzYYOOW3R1e3Q0Z729jOQ8ihnmTOee12zr9Oy+HCWB3sesEy4RqjlXV3CYept
         7Kvaiy9dROIQvdQwdc2ln4gLB8xLsdnhKT+Z1UInVUypKbO5UzuMIGdStyF4qWGv4c2d
         bkznaabJ0gz7LAfPZx4/1x55sY3w6252jcKAW48GIxFbRUVRNZePppk9cImsQf/FNiSv
         eXzzAReL2SiyGtFSm5XlUFte28s8otYeQ2x/N7Pa74s6N/O/5Ag1jzJcjhwKq1Ha+KR7
         vyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KQPCTl794rAugb19t3k9pgcqB9NI9bu3aVo81wrxClU=;
        b=M1B326EFpayBO+2vYpEyK8iwhfeB/VYsuAm7Z7YlA7X1qBVgTkb7c0g3ka9fAtbAcf
         JCVhOR80n0szS7C4s8l55xv+0m6oABsQaIpM/eiuxE/yJHETAKqXAHPE5bPQbm33jAQ2
         cIfxFLIem/HwuTxnYVEzrl0bDIhzIME2WruaImZxCsldoYq3r9qb2hod2xx2Bnpks4Q3
         iwKoRIPuPbWWqIXQmKniIKWmZpQSiBWGDiaj66PVPg8TwG39slh2yhZw6+kQ197HPDR8
         AQWN3EpJY9kVuqB0tjbKLOo+9cl7LElARWvLd75BTM0eO6gwn2mnh0QY2mOr5+4Gj0rj
         JzBw==
X-Gm-Message-State: APjAAAXVpiv6Vo7/zqMffET7D3rLtHmdNnMH/mr4xvjgxGl1ogP7c6Io
        md7svv7DzFfkFdh+v/qbvYxwd8dB
X-Google-Smtp-Source: APXvYqx1CMQL7kkSZBChBW77ttw2bvajeDQxH4izyuPRZG1wNNXUk0d4dQgk6RTL4Oq0Vs7SXChb2Q==
X-Received: by 2002:a62:4d85:: with SMTP id a127mr39038177pfb.148.1565671117964;
        Mon, 12 Aug 2019 21:38:37 -0700 (PDT)
Received: from [10.0.2.15] ([122.163.110.75])
        by smtp.gmail.com with ESMTPSA id v184sm100197756pgd.34.2019.08.12.21.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 21:38:37 -0700 (PDT)
Subject: Re: [PATCH] PCI: tegra: Add of_node_put() before return to fix
 reference leak
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     thierry.reding@gmail.com, bhelgaas@google.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20190724082412.9943-1-nishkadg.linux@gmail.com>
 <20190812110543.GC20861@e121166-lin.cambridge.arm.com>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <1a01f9de-45ab-3a20-5a0c-8802c67115a0@gmail.com>
Date:   Tue, 13 Aug 2019 10:08:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812110543.GC20861@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/08/19 4:35 PM, Lorenzo Pieralisi wrote:
> On Wed, Jul 24, 2019 at 01:54:12PM +0530, Nishka Dasgupta wrote:
>> Each iteration of for_each_child_of_node() puts the previous node, but
>> in the case of a return from the middle of the loop, there is no put,
>> thus causing a reference leak.
>>
>> Hence store these mid-loop return values in variable err and add a new
>> label err_node_put which puts the previous node and returns err. Change
>> six mid-loop return statements to point to this new label instead.
>>
>> Issue found with Coccinelle.
>>
>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>> ---
>> Changes in v2:
> 
> If you are sending a v2 make it explicit in the patch $SUBJECT and send
> the patch --in-reply-to=<message-ID-previous-version> otherwise *I* have
> to fish out of mailing lists previous patches to understand what you are
> doing.

I am very sorry; it won't happen again.

Thanking you,
Nishka
> 
>> - Edit subject line to better reflect changes and match other patches on
>>    this driver.
>> - Edit commit message for readability and accuracy.
>>
>>   drivers/pci/controller/pci-tegra.c | 22 +++++++++++++++-------
>>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> Applied to pci/tegra, thanks.
> 
> Lorenzo
> 
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index 9a917b2456f6..673a1725ef38 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -2237,14 +2237,15 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>>   		err = of_pci_get_devfn(port);
>>   		if (err < 0) {
>>   			dev_err(dev, "failed to parse address: %d\n", err);
>> -			return err;
>> +			goto err_node_put;
>>   		}
>>   
>>   		index = PCI_SLOT(err);
>>   
>>   		if (index < 1 || index > soc->num_ports) {
>>   			dev_err(dev, "invalid port number: %d\n", index);
>> -			return -EINVAL;
>> +			err = -EINVAL;
>> +			goto err_node_put;
>>   		}
>>   
>>   		index--;
>> @@ -2253,12 +2254,13 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>>   		if (err < 0) {
>>   			dev_err(dev, "failed to parse # of lanes: %d\n",
>>   				err);
>> -			return err;
>> +			goto err_node_put;
>>   		}
>>   
>>   		if (value > 16) {
>>   			dev_err(dev, "invalid # of lanes: %u\n", value);
>> -			return -EINVAL;
>> +			err = -EINVAL;
>> +			goto err_node_put;
>>   		}
>>   
>>   		lanes |= value << (index << 3);
>> @@ -2272,13 +2274,15 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>>   		lane += value;
>>   
>>   		rp = devm_kzalloc(dev, sizeof(*rp), GFP_KERNEL);
>> -		if (!rp)
>> -			return -ENOMEM;
>> +		if (!rp) {
>> +			err = -ENOMEM;
>> +			goto err_node_put;
>> +		}
>>   
>>   		err = of_address_to_resource(port, 0, &rp->regs);
>>   		if (err < 0) {
>>   			dev_err(dev, "failed to parse address: %d\n", err);
>> -			return err;
>> +			goto err_node_put;
>>   		}
>>   
>>   		INIT_LIST_HEAD(&rp->list);
>> @@ -2330,6 +2334,10 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>>   		return err;
>>   
>>   	return 0;
>> +
>> +err_node_put:
>> +	of_node_put(port);
>> +	return err;
>>   }
>>   
>>   /*
>> -- 
>> 2.19.1
>>

