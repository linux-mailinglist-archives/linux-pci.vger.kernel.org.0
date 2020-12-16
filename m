Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73932DC5E6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Dec 2020 19:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgLPSFk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Dec 2020 13:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgLPSFj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2020 13:05:39 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63604C0617A6;
        Wed, 16 Dec 2020 10:04:59 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lt17so34086065ejb.3;
        Wed, 16 Dec 2020 10:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6ZwnD7k1OsmN49f8uT7+WS3cJY7luF5zURa/mKmUlFM=;
        b=mJfh6n+mbPZA9ITn+ZC6r2n4Gq88H6BGaA2C8YSHGF9gZRUPi9f1hUMi8tlxomLtk1
         jOFXPH5VTi6v/VeQcULMwzxllXzx3yAqgNCqokOO5f0koiYmPjH/zz7ejadg3nUVStIr
         OlNFY4nH95LyDd9KOGSOvetiORfpADFPizDkAOdCZNixGhLBey9XQBwC+FRGyq89OKvT
         ZihjslpkmWHuogJp/OGvbNxawhzaFgHCAbtUx1wlbNlXhfEQzabHZ3zkspLPwZRk+Lw0
         KP5od4MmS1wV2JYSSEvRb5kZyNGxJTUJEjhRCpdLAYh57rUFjLttQ9sDYKjpvn/jquna
         HxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6ZwnD7k1OsmN49f8uT7+WS3cJY7luF5zURa/mKmUlFM=;
        b=bGW9XLseVeZ4P3BufcF1VgWsnjlw/6K+OtmHUYgoEFleMihg3vzcN5MWq4EOCZH0V0
         26zpX11dNZf9roMByoQWjk9L0DLVWr8tREHX/eDq9nlbAKdiPpCjGayww9VWnvWOLJ5O
         NVFe69r3USStQXhm0ZfyGeaxieNhXcJnR1ocIvB783lAPwrgOLGT7+MCHy6aQh7KFz2j
         soNQvCJkFvdaTtcuJYKBVTaCeL6z1sV2jbcx2AiBDpHoFAKvPrONsLKjhnYEVQicj9Sw
         IkrKpj2ms89eVYky5KcGkQCulOI101FtDMZkPbIH3pEE8uPZbiZEDR+nhpuurAZ62c4K
         EFaA==
X-Gm-Message-State: AOAM532fIUNbY3S3WejA025iPKPu7bWyh46BymQf53B+/ZqdcjEsQah3
        2Jx5qnYt8+tdo6w6czLQo3JPniSX5aI=
X-Google-Smtp-Source: ABdhPJzxQzS8V1C+fiqMZifMmRP4RwqYhyxCAfmf1uWba3XA7yL9O+YUVLIqeIyywQAYGg0s3z15Sw==
X-Received: by 2002:a17:906:c82c:: with SMTP id dd12mr32444243ejb.66.1608141898130;
        Wed, 16 Dec 2020 10:04:58 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id oq7sm1924062ejb.63.2020.12.16.10.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 10:04:57 -0800 (PST)
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20201214203805.GA250639@bjorn-Precision-5520>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <87361bf6-0fef-3641-1dcb-21c56a2cf0b0@gmail.com>
Date:   Wed, 16 Dec 2020 18:56:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201214203805.GA250639@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/14/20 9:38 PM, Bjorn Helgaas wrote:
> On Tue, Dec 08, 2020 at 07:05:09PM +0100, Marek Vasut wrote:
>> On 12/8/20 5:40 PM, Bjorn Helgaas wrote:
> 
>>> Does this problem occur in both these cases?
>>>
>>>     1) When ASPM enters L1, and
>>>
>>>     2) When software writes PCI_PM_CTRL to put the device in D3hot?
>>>
>>> IIUC both cases require the link to go to L1.  I guess the same
>>> software workaround applies to both cases?
>>
>> Yes
> 
> If ASPM puts the Link in L1 and the device needs to DMA, how does the
> Link get back to L0?

It cannot, so I would expect the DMA access would fail.

> Do we use the same data abort hook?  If getting
> back to L0 requires help from software, it seems like that would
> invalidate the L1 exit latency advertised by the devices.  Wouldn't
> that mean we couldn't safely enable L1 at all unless the endpoint
> could tolerate unlimited exit latency?

Possibly, there could be limitations to the L1 support in some corner 
cases. Does that mean the L1 support should be disabled completely ?
