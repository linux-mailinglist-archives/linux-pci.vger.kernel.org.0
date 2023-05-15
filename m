Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72D0702620
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 09:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjEOHdF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 03:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjEOHci (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 03:32:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3809010D0
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 00:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C032E60F95
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 07:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D67C433EF;
        Mon, 15 May 2023 07:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684135956;
        bh=rwySl6yNijT2doUzlRyMD80T4ZkGA08A2GLdSB7O7cI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hEHmN4aesaII+L517rPRU0wzBo3ajsiVf3KeWNiJqfWwpkWgrEIU8+8UnooZnztYE
         wMS98oznRvmd5PWoJwrEHgkjucuJFnAbLMFNowvKCsffj72CLDPn+zVxegZ++10VQ5
         uofeLdWlbLcFlbezQnpb1oOu6F6sTF9fJiEIqRs4UyBmyt4yD1vhW02B3SS1Ej2jqx
         3yqXn1ZdbM14Xj7KpPgQqsg//h+h2qph4smtOzkQY3sBLgyf7Oo2d0o4s5sYtOer4A
         ujnXXRELDscB/Yu34XpaZzoivZmKJBzSUohPm3OYX3Ca9PvWWwjsHYqsJ08AH3WRBz
         lCWAOEhxbXOTA==
Message-ID: <e2586dfe-6893-8feb-5827-0c881ca6854f@kernel.org>
Date:   Mon, 15 May 2023 16:32:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] PCI: endpoint: Add kdoc description of
 pci_epf_type_add_cfs()
Content-Language: en-US
To:     Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
References: <20230515051500.574127-1-dlemoal@kernel.org>
 <20230515051500.574127-3-dlemoal@kernel.org>
 <20230515072105.GB30758@thinkpad>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230515072105.GB30758@thinkpad>
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

On 5/15/23 16:21, Manivannan Sadhasivami wrote:
> On Mon, May 15, 2023 at 02:15:00PM +0900, Damien Le Moal wrote:
>> Restore an improve the kdoc function description for
>> pci_epf_type_add_cfs() that was removed with commit
>> 893f14fed7d3 ("PCI: endpoint: Move pci_epf_type_add_cfs() code").
>>
>> Fixes: 893f14fed7d3 ("PCI: endpoint: Move pci_epf_type_add_cfs() code")
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  drivers/pci/endpoint/pci-ep-cfs.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
>> index d8a6abe2c31c..15e17a661875 100644
>> --- a/drivers/pci/endpoint/pci-ep-cfs.c
>> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
>> @@ -509,6 +509,24 @@ static const struct config_item_type pci_epf_type = {
>>  	.ct_owner	= THIS_MODULE,
>>  };
>>  
>> +/**
>> + * pci_epf_type_add_cfs() - Help function drivers to expose function specific   
>> + *                          attributes in configfs
>> + * @epf: the EPF device that has to be configured using configfs
>> + * @group: the parent configfs group (corresponding to entries in
>> + *         pci_epf_device_id)
>> + *
>> + * Invoke to expose function specific attributes in configfs.
>> + *
>> + * Return: NULL if the function driver
> 
> Spurious?

Oops. Indeed. Fixing this.

> 
> - Mani
> 
>> + *
>> + * Return: A pointer to a config_group structure or NULL if the function driver
>> + * does not have anything to expose (attributes configured by user) or if the
>> + * the function driver does not implement the add_cfs() method.
>> + *
>> + * Returns an error pointer if this function is called for an unbound EPF device
>> + * or if the EPF driver add_cfs() method fails.
>> + */
>>  static struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
>>  						 struct config_group *group)
>>  {
>> -- 
>> 2.40.1
>>
> 

-- 
Damien Le Moal
Western Digital Research

