Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADE16E2E07
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 02:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjDOA4D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 20:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOA4C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 20:56:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB614EFB
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 17:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14CBE61607
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 00:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3C2C433EF;
        Sat, 15 Apr 2023 00:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681520160;
        bh=lymIm4+MV0l3pKwDOQNahIB9E8i0Fveb0r8Mymiw8gA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V94NATUyuJheopb1HwK4VDQGhHanPyrmL/BEPzgmdBmRUmqZz4EecBVk9JIZK0EOX
         UZjvsswat4dlRslxBLWmpTiI8Be3NfqV3VmFZ7RPZ6ER5KPqrAw9x4DXhGdEmtP+2c
         mTkHvPB3qXc7m1TtCgzmvSIrwxWTy+zFvtU5NivMvbZr25802LYlaWkrKT73GczcGC
         gOD6gnJHHPV1eeFCRmTRNOV4qjdcxjeI7iDnDK0egDKouK1lS0aCNYGmKgod2zYh3f
         n/gTUROHoLZDwEBiKHTj4AuYWXn1DsbUrAFyKY3YPmiRSk0a/NK5BMhM1lp8qcZnzg
         u7OLQ0s0oh2KQ==
Message-ID: <1c958e9e-8796-5783-0985-cca5927e8975@kernel.org>
Date:   Sat, 15 Apr 2023 09:55:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 01/17] PCI: endpoint: Automatically create a function
 specific attributes group
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230414155811.GA195618@bhelgaas>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230414155811.GA195618@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/15/23 00:58, Bjorn Helgaas wrote:

[...]

>> +static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
>> +{
>> +	struct config_group *group;
>> +
>> +	group = pci_epf_type_add_cfs(epf_group->epf, &epf_group->group);
>> +	if (!group)
>> +		return;
>> +
>> +	if (IS_ERR(group)) {
>> +		pr_err("failed to create epf type specific attributes\n");
> 
> Is it possible to connect this with a device via pci_err() or
> dev_err()?
> 
>> +		return;
>> +	}
>> +
>> +	configfs_register_group(&epf_group->group, group);
>> +}
>> +
>>  static void pci_epf_cfs_work(struct work_struct *work)
>>  {
>>  	struct pci_epf_group *epf_group;
>> @@ -547,6 +542,8 @@ static void pci_epf_cfs_work(struct work_struct *work)
>>  		pr_err("failed to create 'secondary' EPC interface\n");
> 
> Same.

I did not touch this line. It was there already. Another patch should change
this. I can add another patch if you want...

> 
>>  		return;
>>  	}
>> +
>> +	pci_ep_cfs_add_type_group(epf_group);
>>  }
>>  
>>  static struct config_group *pci_epf_make(struct config_group *group,
>> -- 
>> 2.39.2
>>

