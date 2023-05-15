Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F3270261C
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 09:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjEOHcB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 03:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjEOHb6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 03:31:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5CC10D0
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 00:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1172360F7A
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 07:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8CCC433D2;
        Mon, 15 May 2023 07:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684135916;
        bh=yXBxItE9a/CljUdX+v0eTGKtuExPA2i70i1BBernyTU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i0ccRUKpPhwvDBhTSD/gbZb3G4/UzOYVOGQ5xLHQzzaYr3ZnhWL61Q/0uvE5lh2NA
         upitJ/2FOdoF/2V8TIAIaZ1gPkbtZJEA11l9BTANuPUWPoB1hDCmro7Z8J5q5J7A2C
         0f+0TcvXW0uaOPCl5ij+5d9s+BD3G2n9fRzfjP99AhdVwTjzCM/o/RCFJcBM/rY5tO
         wjuq6/LkeMyGtEdku0pN9fUXVjluY0R1zFPmY7Js94GzCj/XOWnLQNal4nRQU4mUwm
         8YwQcAjrBIczI0x4hkJV+OyevFP4EJqzaIjR3F0lYB+25HGus8BmPmeBCO69J1S5l1
         Ge/8bZmJogDsQ==
Message-ID: <623304ad-4487-72e3-a12f-bce4e1ea664c@kernel.org>
Date:   Mon, 15 May 2023 16:31:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] PCI: endpoint: Improve pci_epf_type_add_cfs()
Content-Language: en-US
To:     Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
References: <20230515051500.574127-1-dlemoal@kernel.org>
 <20230515051500.574127-2-dlemoal@kernel.org>
 <20230515071958.GA30758@thinkpad>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230515071958.GA30758@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/15/23 16:19, Manivannan Sadhasivami wrote:
> On Mon, May 15, 2023 at 02:14:59PM +0900, Damien Le Moal wrote:
>> pci_epf_type_add_cfs() should not be called with an unbound EPF device,
>> that is, an epf device with epf->driver not set. For such case, replace
>> the NULL return in pci_epf_type_add_cfs() with a clear ERR_PTR(-EINVAL)
>> error return.
>>
> 
> Shouldn't the error code be -ENODEV?

Yeah, I wondered about it and settled for EINVAL... Will change to ENODEV.

> 
> - Mani
> 
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  drivers/pci/endpoint/pci-ep-cfs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
>> index 0fb6c376166f..d8a6abe2c31c 100644
>> --- a/drivers/pci/endpoint/pci-ep-cfs.c
>> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
>> @@ -516,7 +516,7 @@ static struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
>>  
>>  	if (!epf->driver) {
>>  		dev_err(&epf->dev, "epf device not bound to driver\n");
>> -		return NULL;
>> +		return ERR_PTR(-EINVAL);
>>  	}
>>  
>>  	if (!epf->driver->ops->add_cfs)
>> -- 
>> 2.40.1
>>
> 

-- 
Damien Le Moal
Western Digital Research

