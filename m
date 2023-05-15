Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080B9702166
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 04:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjEOCON (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 May 2023 22:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjEOCOM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 May 2023 22:14:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9CD10F0
        for <linux-pci@vger.kernel.org>; Sun, 14 May 2023 19:14:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ACD261236
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 02:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA65C433D2;
        Mon, 15 May 2023 02:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684116849;
        bh=pMzjqPjfbxj2fuYdzDCp4M4DFABsa2owulk+orCHsVc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XCT4Zze8TS7xYjOmmeXSkqeU4+aQuG4rTQAXC1DMaHZB3Ifl+moZ/f5U9uAKsCcg0
         ITdCcZFbwA2FbNOIw5q6PRSdyhMu3OzfUmNgvZpJQjXkPvXLvM1zbOoV2a8P8BkyIF
         FBl77ABZbI1/13xQfPVbH65YtMvkYmAWeAKJmXKAvmWsxCbyeh53CedKoNDyX3krg5
         0h3o3D3oWuv75gZq1Dyh05lQirbfrlMTv2iPv0z+UkblF09mpUgTswAZ+K+TGoAoP5
         NR62GTlHu5PvxZnShobFPMw5B8j3s5/a6ZGi9kwa+FCMU8qRLu0Fr5bupdX1l+CkPT
         ZMycPJ1jlo/9Q==
Message-ID: <f215967c-a01f-2aee-ed72-d9c2098613f8@kernel.org>
Date:   Mon, 15 May 2023 11:14:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [bug report] PCI: endpoint: Automatically create a function
 specific attributes group
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-pci@vger.kernel.org
References: <95d23290-496a-462c-87c5-944df1e20ba1@kili.mountain>
 <20230514133652.GA116991@thinkpad>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230514133652.GA116991@thinkpad>
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

On 5/14/23 22:36, Manivannan Sadhasivam wrote:
> On Thu, May 11, 2023 at 10:06:40AM +0300, Dan Carpenter wrote:
>> Hello Damien Le Moal,
>>
>> The patch 01c68988addf: "PCI: endpoint: Automatically create a
>> function specific attributes group" from Apr 15, 2023, leads to the
>> following Smatch static checker warning:
>>
>> 	drivers/pci/endpoint/pci-ep-cfs.c:540 pci_ep_cfs_add_type_group()
>> 	warn: 'group' isn't an ERR_PTR
>>
>> drivers/pci/endpoint/pci-ep-cfs.c
>>     532 static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
>>     533 {
>>     534         struct config_group *group;
>>     535 
>>     536         group = pci_epf_type_add_cfs(epf_group->epf, &epf_group->group);
>>     537         if (!group)
>>     538                 return;
>>     539 
>> --> 540         if (IS_ERR(group)) {
>>
>> pci_epf_type_add_cfs() does not return error pointers currently.  Which
>> is fine.  Presumably it will start returning them later.  But could you
>> add some comments next to the pci_epf_type_add_cfs() to explain what a
>> NULL return means vs an error pointer return?
>>
> 
> pci_epf_type_add_cfs() may return ERR_PTR from add_cfs() callback.
> 
> Regarding comments, it should be added as a part of kdoc for
> pci_epf_type_add_cfs(). It already does for NULL part but not for ERR_PTR.

What do you mean with "It already does for NULL part" ? There is no kdoc for
pci_epf_type_add_cfs() that I can see in pci/next. But I am preparing one patch
to add that. Sending soon.

> 
> - Mani
> 
>>     541                 dev_err(&epf_group->epf->dev,
>>     542                         "failed to create epf type specific attributes\n");
>>     543                 return;
>>     544         }
>>     545 
>>     546         configfs_register_group(&epf_group->group, group);
>>     547 }
>>
>> regards,
>> dan carpenter
> 

-- 
Damien Le Moal
Western Digital Research

