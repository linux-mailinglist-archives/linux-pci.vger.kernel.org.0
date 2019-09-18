Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 346FEB65BD
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2019 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfIROUv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Sep 2019 10:20:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33953 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbfIROUv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Sep 2019 10:20:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id p10so182618edq.1;
        Wed, 18 Sep 2019 07:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mF9N/s8ILweTSnVuSXM/o539kT2v3tCxIskY2MUP33U=;
        b=eI0UxDDFmeG5F7FW0s4aWFs/ez3fkEWLJEM58BXk/ZxJwLx1N5JNRSuYC4B+V/L2La
         FwAcGEhsMae9AY7fWQlfsKhFWEPNx/8CLE4BLq0tid4cU/LqfP0kVWuNJ5ZT0iVPrmzm
         uo9rgISzlZVnTeI993mKeExh/UA5T8xjhNp4xeID3yX57PcM9zyaRD1f0qZ5FY8jTMuo
         5vy4Fq2U2GJij5gOgmZHEzB8LOatpQbArgkhPArU0oLIoZcQKMQjgGvbzVrYcplDhHyW
         yS6Ef03YbY9N8gplT3Up8O5EjAjHKY0LL6FdLiU6feecfgf53T/duMZckPjeD34Eb0/m
         GvVg==
X-Gm-Message-State: APjAAAVflRj8DS/gJKWh4C5mPLDFNP9uO/yuGKIwJAjkqkvUxErjuTdh
        yxuW37/OS+F5GgsgP0M5+Ic=
X-Google-Smtp-Source: APXvYqxEijz/O+lgao2zenADPGmdrJHVUVPIC96IalBeKZkWKA2EF6b3MDX1hA/RuzkecmAalMxBfQ==
X-Received: by 2002:a17:906:4890:: with SMTP id v16mr9837570ejq.3.1568816449140;
        Wed, 18 Sep 2019 07:20:49 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id g6sm1070532edk.40.2019.09.18.07.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 07:20:48 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [PATCH v3 04/26] PCI: endpoint: Use PCI_STD_NUM_BARS
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20190916204158.6889-1-efremov@linux.com>
 <20190916204158.6889-5-efremov@linux.com>
 <20190918091949.GB9720@e119886-lin.cambridge.arm.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <2c5fa911-3aca-216f-7c38-e970840af26a@linux.com>
Date:   Wed, 18 Sep 2019 17:20:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918091949.GB9720@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/18/19 12:19 PM, Andrew Murray wrote:
> On Mon, Sep 16, 2019 at 11:41:36PM +0300, Denis Efremov wrote:
>> To iterate through all possible BARs, loop conditions refactored to the
>> *number* of BARs "i < PCI_STD_NUM_BARS", instead of the index of the last
>> valid BAR "i <= BAR_5". This is more idiomatic C style and allows to avoid
>> the fencepost error. Array definitions changed to PCI_STD_NUM_BARS where
>> appropriate.
>>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 10 +++++-----
>>  include/linux/pci-epc.h                       |  2 +-
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index 1cfe3687a211..5d74f81ddfe4 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -44,7 +44,7 @@
>>  static struct workqueue_struct *kpcitest_workqueue;
>>  
>>  struct pci_epf_test {
>> -	void			*reg[6];
>> +	void			*reg[PCI_STD_NUM_BARS];
>>  	struct pci_epf		*epf;
>>  	enum pci_barno		test_reg_bar;
>>  	struct delayed_work	cmd_handler;
>> @@ -377,7 +377,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>>  
>>  	cancel_delayed_work(&epf_test->cmd_handler);
>>  	pci_epc_stop(epc);
>> -	for (bar = BAR_0; bar <= BAR_5; bar++) {
>> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>>  		epf_bar = &epf->bar[bar];
>>  
>>  		if (epf_test->reg[bar]) {
>> @@ -400,7 +400,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>>  
>>  	epc_features = epf_test->epc_features;
>>  
>> -	for (bar = BAR_0; bar <= BAR_5; bar += add) {
>> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar += add) {
> 
> Is it possible to completely remove the BAR_x macros, or are there exsiting
> users after this patchset?

They are still used in other parts of the code. So, I've decided to preserve
the defines in this case.

pci-epc-core.c
400:        (epf_bar->barno == BAR_5 &&
429:        (epf_bar->barno == BAR_5 &&
functions/pci-epf-test.c
497:    enum pci_barno test_reg_bar = BAR_0;

> 
> As your patchset replaces BAR_0 with 0 and BAR_1 with 1, does this suggest
> that other users of BAR_x should be removed and also replaced with a number?

I changed BAR_0 to 0 in order to not mix different notions, i.e. the number
of bars and the concrete bar.

> 
> Apologies if you this doesn't fall in the remit of this patchset.

I don't know what is better here. It's simple enough to remove these defines.
However, I would prefer to wait for the endpoint developers opinion.

Thanks for the review!
Denis

> 
> Thanks,
> 
> Andrew Murray
> 
>>  		epf_bar = &epf->bar[bar];
>>  		/*
>>  		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
>> @@ -450,7 +450,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>>  	}
>>  	epf_test->reg[test_reg_bar] = base;
>>  
>> -	for (bar = BAR_0; bar <= BAR_5; bar += add) {
>> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar += add) {
>>  		epf_bar = &epf->bar[bar];
>>  		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
>>  
>> @@ -478,7 +478,7 @@ static void pci_epf_configure_bar(struct pci_epf *epf,
>>  	bool bar_fixed_64bit;
>>  	int i;
>>  
>> -	for (i = BAR_0; i <= BAR_5; i++) {
>> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>>  		epf_bar = &epf->bar[i];
>>  		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
>>  		if (bar_fixed_64bit)
>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>> index f641badc2c61..56f1846b9d39 100644
>> --- a/include/linux/pci-epc.h
>> +++ b/include/linux/pci-epc.h
>> @@ -117,7 +117,7 @@ struct pci_epc_features {
>>  	unsigned int	msix_capable : 1;
>>  	u8	reserved_bar;
>>  	u8	bar_fixed_64bit;
>> -	u64	bar_fixed_size[BAR_5 + 1];
>> +	u64	bar_fixed_size[PCI_STD_NUM_BARS];
>>  	size_t	align;
>>  };
>>  
>> -- 
>> 2.21.0
>>

