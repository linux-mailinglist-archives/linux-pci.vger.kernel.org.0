Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C052D581F8B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 07:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiG0FgH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 01:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiG0FgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 01:36:07 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02F633431
        for <linux-pci@vger.kernel.org>; Tue, 26 Jul 2022 22:36:05 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h132so15015984pgc.10
        for <linux-pci@vger.kernel.org>; Tue, 26 Jul 2022 22:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=MtmX0s8i4cNE7xExfXRCYeHMOOSpKYgD35C7D1141sc=;
        b=rXMYA6YpckLQ7Md7MwHHskIesm3XD7YZSBd75z21WpAASuPYeeksPydQsM3ZEqQF8f
         uhGygijSmwcjS4XmM8u/vzqTO0ieJ+oFf6qmZkkBbbawoGfSN8sZRSi9ss+QkQuq/C4l
         xovBCQDq0STP3FI7+Iu1H2oh+nokrkF7MoRG2JDXKrkrQv/VssghHvrTfM/+hgvF+ygJ
         QjFLbBGh7MPWxzrFu1xMqVDiDP/Mr1q5E1h1XjFgVIg7heJrfFpm78t3KBSis41FI+58
         Mf2q3SNLFuvlXVynUKJyEbhgI7hhhC6xa8TUeh+6zYfXkS9ykk/u0kd5D5CeTG1T5I/E
         B1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MtmX0s8i4cNE7xExfXRCYeHMOOSpKYgD35C7D1141sc=;
        b=NG8knNMgHx4zQnEtKwkeL8jgDe928GwD05jtpu3elc/SE/g1BZAjA+uu4vS49q3Bim
         LK0I2gP0FSEDwwN1My04p+BF85gf8QsltNFPkGisdSOKVRHsJbrgO7zVNR6C4hQRuCdb
         JQjswW++ErFAyQ4+RPXhO2UO5uQNMU6qqCM+cuvVHEBD5iD5/ciDwi7D28F1dIrU/Dz1
         5k1A/dyFiUGpZyjWRCXBvI7gD8kJdqS4YRLfsjY1L8Xj75RjNMRfPaZBQKPEy94SQ1lX
         uLWU29BY9GK7DJnJQUNp68zENjVls0l4oK4XGwfRdabrDM9GWkr9isEwOu+euvjVK1D7
         gEpg==
X-Gm-Message-State: AJIora/TqcqDg81I5zSScUqVcfqEMy51tiXqlK+f8TzpBURJDuyWxKsq
        ML5T0X2/oaEj3rMopCIcRTBAsQ==
X-Google-Smtp-Source: AGRyM1sww+5c5488gml38dTzt0romodCAJQ3E98eXIudTuGyEPO3lDyKiMFc9bedEHP4yh/1tnW4lQ==
X-Received: by 2002:a63:180e:0:b0:41b:42d0:7d59 with SMTP id y14-20020a63180e000000b0041b42d07d59mr2010864pgl.160.1658900165003;
        Tue, 26 Jul 2022 22:36:05 -0700 (PDT)
Received: from [10.2.192.95] ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b0016bdc98730bsm12707960plg.151.2022.07.26.22.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 22:36:04 -0700 (PDT)
Message-ID: <cfd44d9c-453b-e498-2630-9057947cf3cd@bytedance.com>
Date:   Wed, 27 Jul 2022 13:35:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v3] PCI/ERR: Use pcie_aer_is_native() to judge whether OS
 owns AER
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, ruscur@russell.cc,
        oohall@gmail.com, bhelgaas@google.com
Cc:     lukas@wunner.de, jan.kiszka@siemens.com, stuart.w.hayes@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220727035334.9997-1-chenzhuo.1@bytedance.com>
 <b5c746db-f6a0-d89e-6db5-e4a206c9237a@linux.intel.com>
From:   =?UTF-8?B?6ZmI5Y2T?= <chenzhuo.1@bytedance.com>
In-Reply-To: <b5c746db-f6a0-d89e-6db5-e4a206c9237a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/26/22 9:02 PM, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 7/26/22 8:53 PM, Zhuo Chen wrote:
>> Use pcie_aer_is_native() in place of "host->native_aer ||
>> pcie_ports_native" to judge whether OS has native control of AER
>> in pcie_do_recovery().
>>
>> Replace "dev->aer_cap && (pcie_ports_native || host->native_aer)" in
>> get_port_device_capability() with pcie_aer_is_native(), which has no
>> functional changes.
>>
>> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
>> ---
> 
> Patch looks better now. It looks like following two changes
> can also be replaced with pcie_aer_is_native() check.
> 
> drivers/pci/pcie/aer.c:1407:	if ((host->native_aer || pcie_ports_native) && aer) {
> drivers/pci/pcie/aer.c:1426:	if ((host->native_aer || pcie_ports_native) && aer) {

Good advice. But I wonder is there a scenario that dev->rcec ("root") is 
NULL meanwhile dev->aer_cap is not NULL? If so, replace 
"(host->native_aer || pcie_ports_native) && aer" with 
pcie_aer_is_native() will change original function.

> 
> 
> 
>> Changelog:
>> v3:
>> - Simplify why we use pcie_aer_is_native().
>> - Revert modification of pci_aer_clear_nonfatal_status() and comments.
>> v2:
>> - Add details and note in commit log.
>> ---
>>   drivers/pci/pcie/err.c          | 3 +--
>>   drivers/pci/pcie/portdrv_core.c | 3 +--
>>   2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 0c5a143025af..121a53338e44 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -184,7 +184,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>   	int type = pci_pcie_type(dev);
>>   	struct pci_dev *bridge;
>>   	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>> -	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>>   
>>   	/*
>>   	 * If the error was detected by a Root Port, Downstream Port, RCEC,
>> @@ -243,7 +242,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>   	 * it is responsible for clearing this status.  In that case, the
>>   	 * signaling device may not even be visible to the OS.
>>   	 */
>> -	if (host->native_aer || pcie_ports_native) {
>> +	if (pcie_aer_is_native(dev)) {
>>   		pcie_clear_device_status(dev);
>>   		pci_aer_clear_nonfatal_status(dev);
>>   	}
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>> index 604feeb84ee4..98c18f4a01b2 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -221,8 +221,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>>   	}
>>   
>>   #ifdef CONFIG_PCIEAER
>> -	if (dev->aer_cap && pci_aer_available() &&
>> -	    (pcie_ports_native || host->native_aer)) {
>> +	if (pcie_aer_is_native(dev) && pci_aer_available()) {
>>   		services |= PCIE_PORT_SERVICE_AER;
>>   
>>   		/*
> 

Thanks,
Zhuo Chen
