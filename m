Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1430842C2DF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 16:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhJMOYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 10:24:30 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:53204
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231664AbhJMOYa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Oct 2021 10:24:30 -0400
Received: from [10.172.193.212] (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 72F1740600;
        Wed, 13 Oct 2021 14:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634134944;
        bh=F2Aeq4CGeeeQ7RzlmcFZtrjZ5QnGLtWz/nVBx/bUwwc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=RB3tvbelMWDTEOZgX7CRrPNrtMkBxwV7Kq7SPz4QULIliM46O/VczxpIeReue0K6I
         CrYjoxKYZpAUQYrnx7xfE1fu2pLNOqF8c/80zQPsfHFOZQhETQe2lNqn3OC48IYSQn
         pCZod9pbn38K69sLe/mg5WUd5zwVLjIOo2hjAIT5hc+mNyLRq2igoNVUSpBgFbQ5k4
         dNmUL7EvKQ7DhRDqa1KQZtceQ6uIS5oXYzPdmiQa5afeAZuiSUx3OMWVez8HMlepsP
         PMvGPkQ3pDvt630MpW/nqgO3F9vPgut0P1ZAV9f/imyEKqGnAbmBLW8XvgpYzEoYmZ
         9wyz/U6UBQVjQ==
Message-ID: <7fb08233-efc9-b0bd-b234-084e52878036@canonical.com>
Date:   Wed, 13 Oct 2021 15:22:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH][next] PCI: apple: Remove redundant initialization of
 pointer port_pdev
Content-Language: en-US
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211012133235.260534-1-colin.king@canonical.com>
 <20211013134114.GC11036@lpieralisi>
From:   Colin Ian King <colin.king@canonical.com>
In-Reply-To: <20211013134114.GC11036@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/10/2021 14:41, Lorenzo Pieralisi wrote:
> On Tue, Oct 12, 2021 at 02:32:35PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The pointer port_pdev is being initialized with a value that is never
>> read, it is being updated later on. The assignment is redundant and
>> can be removed.
>>
>> Addresses-Coverity: ("Unused value")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   drivers/pci/controller/pcie-apple.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Squashed into the commit it is fixing.
> 

Thanks. Much appreciated.

> Thanks !
> Lorenzo
> 
>> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
>> index b4db7a065553..19fd2d38aaab 100644
>> --- a/drivers/pci/controller/pcie-apple.c
>> +++ b/drivers/pci/controller/pcie-apple.c
>> @@ -634,7 +634,7 @@ static struct apple_pcie_port *apple_pcie_get_port(struct pci_dev *pdev)
>>   {
>>   	struct pci_config_window *cfg = pdev->sysdata;
>>   	struct apple_pcie *pcie = cfg->priv;
>> -	struct pci_dev *port_pdev = pdev;
>> +	struct pci_dev *port_pdev;
>>   	struct apple_pcie_port *port;
>>   
>>   	/* Find the root port this device is on */
>> -- 
>> 2.32.0
>>

