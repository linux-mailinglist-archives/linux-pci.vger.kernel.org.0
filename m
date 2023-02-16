Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF42969945E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 13:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjBPMcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 07:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBPMcB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 07:32:01 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168762B0AC
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 04:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676550719; x=1708086719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O0fi9c49pBfzIOYVk6FDk045dK83O9VygPz9dKMMLsk=;
  b=Ctms545HRwD4QzMpV47UffmVUw4TgguW8WZr8oJwlpgBz6S9qE8CyhXy
   ehxA7kp4Kvku1dbFCvbE9OWswSvc6vuFrlCrKtmT8FAxsdgg5S9rzID6X
   L5iaxSrKwMa/jMetxMZnwbA6zISW1UhGzsu4Uupbfp0sSfphsgiM0f+er
   jblUlqetcbXmkpJiWdxW8IcDdM3lpfUZ9pRY9aPkfdx9RPxVod3PDSWnC
   V+KuACfozZVm5Ezc1/h1ML1bY8Q9FoXO32NBee3bBdqbNfKvBO1e9bTdJ
   4vyylZXqMZI17tz8Gg3K0uO8UyaY4+lP/zSa/BMCfiB5Iytiqpnf51VZ+
   A==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669046400"; 
   d="scan'208";a="335427759"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2023 20:31:58 +0800
IronPort-SDR: jC0t2JaMet2OP2h3QWnAjLW8JeMvIk4ftRUoiuTbb/xV3DuW3EXauM2GV1OLB3EbBV3E+AcB4z
 Cym7vORjLXVxXNHwoIhW4chCbVy4OCLedGmnKPzU5iHp/j1Wio891IQ3Lc/h3/hrXR4bdyUBQq
 j1Efp8+g210fibnpQGmmcpu9fClE7YnuqN5bwpgyjPFcUhZFwnKsR8tSkAPlY1DOwHN9SaKJ5d
 oQQiCKrHkEi/c9p9z8vIlPdXPrUaJP6/TwsVEC03AN/A5WeXpBJZ3EOC4xOUk3d6wHyLV14N2/
 i/k=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2023 03:49:03 -0800
IronPort-SDR: g+p/KYptEuh+4UPraJ6Ic7oCiLz6XAdnQaRR5RwDXt6selZQQfeIx2i5YPmsvxtwMHbS/QWhKO
 /7QXstuIOx6bNsEsAWiZqwFChXBcTBNWPmYHq0+d/FQYci5Zqu9HW2o5LAEIaB2sHv45n+my39
 oJW8sGp+x6+IjlREZc1/iXaTQeKwE3pXmj3+CWodEWNLPU5xGxZ7Kfl+o9oBG49tn/g6stNOR7
 V/oab5DD8A2UGIWAqsC8nAoMFwaE6DrH35iMLr3CG2eXJEko/VkzJqXUcmOk6aguxU+CXb9rwX
 WiU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2023 04:31:59 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PHZ7y2WJKz1Rwrq
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 04:31:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676550717; x=1679142718; bh=O0fi9c49pBfzIOYVk6FDk045dK83O9VygPz
        9dKMMLsk=; b=BJoDVEM2Tnrg035KQdRcpsTnknDvXmvigFNihtyHZiTUSjfcqZ+
        E80/yoyNj6nKtfFH9yT0Lbe1Zfmu1AIbHGnpi9OzPJjllVHBsbFOaqxJbHS5r7d9
        J01W9ZYHS/KCuefXS1T/y6pzvfXsaJdjdeHjmbYRPkzr/vtp9bLPwx2Sx+J2tZ0R
        M+q7P2jE0MF7j3aOqJSCrvJI8R5GdSV60ByYqAcDuANUiXoxE5+MTkocgcRFdmj2
        AtkF5dFc/wnpMFWeqw2InxdA4/7GHS+OpcYjk9Df0mzY0RtaMx2rOBG9iH23dQcP
        EPd8WNhOIGg3zjVVPzdz3zwcrj8KT2eCltg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8-vEMX8pJZ6U for <linux-pci@vger.kernel.org>;
        Thu, 16 Feb 2023 04:31:57 -0800 (PST)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PHZ7v6P9Mz1RvLy;
        Thu, 16 Feb 2023 04:31:55 -0800 (PST)
Message-ID: <aa724af7-aa66-753b-1c00-4a5678afcb3a@opensource.wdc.com>
Date:   Thu, 16 Feb 2023 21:31:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 01/12] pci: endpoint: Automatically create a function type
 attributes group
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-2-damien.lemoal@opensource.wdc.com>
 <20230216100438.GC2420@thinkpad>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230216100438.GC2420@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/16/23 19:04, Manivannan Sadhasivam wrote:
> On Wed, Feb 15, 2023 at 12:21:44PM +0900, Damien Le Moal wrote:
>> A PCI endpoint function driver can define function specific attributes
>> using the add_cfs() endpoint driver operation. However, this attributes
>> group is not created automatically when the function is created and
>> rather relies on the user creating a directory within the endpoint
>> function configfs directory to initialize the attributes.
>>
> 
> This is not accurate. An endpoint function will only be created when a
> directory is created under /sys/kernel/debug/pci_ep/functions/<func_name>/
> 
> Here, func_name is just a debugfs group created during EPF registration and
> doesn't represent a function unless a subdirectory is created.
> 
>> While working, this approach is dangerous as nothing prevents the user
>> from creating multiple directories with differenti (wrong) names that
>> all will contain the same attributes.
>>
>> Fix this by modifying pci_epf_cfs_work() to execute the new function
>> pci_ep_cfs_add_type_group() which itself calls pci_epf_type_add_cfs() to
>> obtain the function specific attribute group from the function driver.
>> If the function driver defines an attribute group,
>> pci_ep_cfs_add_type_group() then proceeds to register this group using
>> configfs_register_group(), thus automatically exposing the configfs
>> attributes to the user.
>>
>> With this change, there is no need for the user to create/delete
>> directories in the endpoint function configfs directory. The
>> pci_epf_type_group_ops group operations are thus removed.
>>
> 
> No. You are just automating the creation of sub-directories specific to
> functions such as NTB. Users still need to create a directory to create an
> actual endpoint function.
> 
> The commit message sounds like it is automating the whole endpoint function
> creation which it is not doing.

OK. I was not clear in the wording. It is not the function directory that this
is automating. It is not about:

/sys/kernel/configfs/pci_ep/functions/<func_name>/

It is about automating the creation of the sub-directory under that that
represent the attribute group that the function defines. So it is about:

/sys/kernel/configfs/pci_ep/functions/<func_name>/<whatever-function-specific>

That directory is *not* created automatically, the user must create it, but
worse than that, can do it multiple times with really bad results when
everything is tore down (I got an oops due to bad reference counts).

This patch fixes that, not the function directory creation itself.

> 
> Thanks,
> Mani
> 
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  drivers/pci/endpoint/pci-ep-cfs.c | 41 ++++++++++++++-----------------
>>  1 file changed, 19 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
>> index d4850bdd837f..1fb31f07199f 100644
>> --- a/drivers/pci/endpoint/pci-ep-cfs.c
>> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
>> @@ -23,6 +23,7 @@ struct pci_epf_group {
>>  	struct config_group group;
>>  	struct config_group primary_epc_group;
>>  	struct config_group secondary_epc_group;
>> +	struct config_group *type_group;
>>  	struct delayed_work cfs_work;
>>  	struct pci_epf *epf;
>>  	int index;
>> @@ -502,34 +503,28 @@ static struct configfs_item_operations pci_epf_ops = {
>>  	.release		= pci_epf_release,
>>  };
>>  
>> -static struct config_group *pci_epf_type_make(struct config_group *group,
>> -					      const char *name)
>> -{
>> -	struct pci_epf_group *epf_group = to_pci_epf_group(&group->cg_item);
>> -	struct config_group *epf_type_group;
>> -
>> -	epf_type_group = pci_epf_type_add_cfs(epf_group->epf, group);
>> -	return epf_type_group;
>> -}
>> -
>> -static void pci_epf_type_drop(struct config_group *group,
>> -			      struct config_item *item)
>> -{
>> -	config_item_put(item);
>> -}
>> -
>> -static struct configfs_group_operations pci_epf_type_group_ops = {
>> -	.make_group     = &pci_epf_type_make,
>> -	.drop_item      = &pci_epf_type_drop,
>> -};
>> -
>>  static const struct config_item_type pci_epf_type = {
>> -	.ct_group_ops	= &pci_epf_type_group_ops,
>>  	.ct_item_ops	= &pci_epf_ops,
>>  	.ct_attrs	= pci_epf_attrs,
>>  	.ct_owner	= THIS_MODULE,
>>  };
>>  
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
>>  		return;
>>  	}
>> +
>> +	pci_ep_cfs_add_type_group(epf_group);
>>  }
>>  
>>  static struct config_group *pci_epf_make(struct config_group *group,
>> -- 
>> 2.39.1
>>
> 

-- 
Damien Le Moal
Western Digital Research

