Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A8C6D184D
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 09:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCaHQU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 03:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjCaHQP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 03:16:15 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2731B7E1
        for <linux-pci@vger.kernel.org>; Fri, 31 Mar 2023 00:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680246969; x=1711782969;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qKCz1N+zUR1ylpLdBZUDNJgEFmqmcQsUKQZLRniDoN4=;
  b=bUrtymNB4I7P76wS3PoEOPtuV+NZ0vbiynmrWSxgVcMh/cqnFt2NQvmQ
   A6FVHGX6S92K15szbP7ZPCLm5OcJXU4aeaJcflILoeSXUWQ0Paj2+uJb+
   o8zEupVx1/4iOP63Q1+qxYOJoT/Iuu4LBSM9DFY9Xtt4boftZCUJE2c8u
   6czKrbMqa9PQcHqdNtLScYVZTR460ygYYwYWbL5gWz8UkafXLiSnDvobZ
   ldB1qrGs4VIiPN0vW68rbgNpo0ByHD19tWD/8nUUoaDk4pBpMccWIThbu
   Y7iA9vMXY8BYXE5RCN95NRIq1sut3O10Xc9AL4SqcC6x8oDDjnOsV1Hh+
   g==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673884800"; 
   d="scan'208";a="339036267"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2023 15:16:08 +0800
IronPort-SDR: ll+tW1a5UHW/CZcc+JT2nm9olJcajMkLVE5IfMZgTK0iVQCNMCtEsOd/hcaU4LI3EP2j7yfCId
 URwL4F4KbqeTd94yFSbNIf14tJL8r2dGYgcN1ai2O9v3GlNT+LhQidwrkgGRDwxQPWOzlIRjrT
 RmU9jFT7AjbUj9DolgxUCRmzLzz/t8uL4ZiL6T4GgWjMsmmUlC7OjlzIFQf3hXodvGgairBVEr
 3QeHh1sLY2gccvx0t2PI+qdfKeX9KjRHBl+ldCjLxlbsm6EywHqTimjkO/7xh1BZGiYr1x6O9j
 n8g=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 23:26:34 -0700
IronPort-SDR: FMihywswSS2ITG5ARwQ1t2k7f0jUzV5Z44gtI6f57vYRempEwKsXogHkOvwqRQBekUtomUbcxy
 18rdaTZ6cDa185MkJ+OJGo6eaGlooKDVV6oDdTWgbuEOjoe1SNRmWSuIwgVDbpNLHMewCBFG0J
 u8veG2owTnj0OEdTfE00sv0Oo6Nhx8Tx7kv9rAudTMknj5swUZnAIf/gQILeFECqkB7ayroVRj
 GQ8Jhv71OjXrhNspCkVrlfVbqkh3fdsuGjdhJIPsmZatvmpUeg1xtwOXXse79+5NBawNcC7yKi
 VqI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Mar 2023 00:16:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pns5g6Cxjz1RtVt
        for <linux-pci@vger.kernel.org>; Fri, 31 Mar 2023 00:16:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680246967; x=1682838968; bh=qKCz1N+zUR1ylpLdBZUDNJgEFmqmcQsUKQZ
        LRniDoN4=; b=CbDTwGfQupEpY9caypLo7q+tviCU43E1x1bqZ/aGge7JvYWHTtM
        ALfzMfHJ03dWqghT9TjSSi6rF1zhEgEwAwVBFXK1OySbD9IAz+OaekFLnNdTq8KX
        HTPU9sLdbzZ3ZGS3W+PVYkTmHI4zMpavVJGKJ0uP5iIKysBMJ2/DBPelsSNF5Q/P
        EUbWBu88ql9UcJPQJthybT46FGo3s8zxWcF6M/Jd0dhJInf/GnAn52qUgWpN47f+
        V6EaKCcttgfoeCEMqApR4RKeNE0NnUbAh+A9LRpCj/BP3j8XpYF7+ikiuP0XQCYs
        vm7Z/ytktXONmiyVaIfARJI+qrS+dDIVQLA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7KeOPXwfhnsT for <linux-pci@vger.kernel.org>;
        Fri, 31 Mar 2023 00:16:07 -0700 (PDT)
Received: from [10.225.163.124] (unknown [10.225.163.124])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pns5d5tRXz1RtVm;
        Fri, 31 Mar 2023 00:16:05 -0700 (PDT)
Message-ID: <8c732772-0b40-2e6b-3e8e-86cd9d4ef971@opensource.wdc.com>
Date:   Fri, 31 Mar 2023 16:16:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 01/17] PCI: endpoint: Automatically create a function
 specific attributes group
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230330085357.2653599-1-damien.lemoal@opensource.wdc.com>
 <20230330085357.2653599-2-damien.lemoal@opensource.wdc.com>
 <20230331052220.GA4973@thinkpad>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230331052220.GA4973@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/31/23 14:22, Manivannan Sadhasivam wrote:
> On Thu, Mar 30, 2023 at 05:53:41PM +0900, Damien Le Moal wrote:
>> A PCI endpoint function driver can define function specific attributes
>> under its function configfs directory using the add_cfs() endpoint
>> driver operation. This is done by tighing up the mkdir operation for
>> the function configfs directory to a call to the add_cfs() operation.
>> However, there are no checks preventing the user from repeatedly
>> creating function specific attribute directories with different names,
>> resulting in the same endpoint specific attributes group being added
>> multiple times, which also result in an invalid reference counting for
>> the attribute groups. E.g., using the pci-epf-ntb function driver as an
>> example, the user creates the function as follows:
> 
> [...]
> 
>> Fix this by modifying pci_epf_cfs_work() to execute the new function
>> pci_ep_cfs_add_type_group() which itself calls pci_epf_type_add_cfs()
>> to obtain the function specific attribute group and the group name
>> (directory name) from the endpoint function driver. If the function
>> driver defines an attribute group, pci_ep_cfs_add_type_group() then
>> proceeds to register this group using configfs_register_group(), thus
>> automatically exposing the function type pecific onfigfs attributes to
> 
> Still you haven't fixed this typo. But I don't expect you to respin unless there
> are other changes.

Arg. Sorry about that. I hope it can be fixed when applying.

-- 
Damien Le Moal
Western Digital Research

