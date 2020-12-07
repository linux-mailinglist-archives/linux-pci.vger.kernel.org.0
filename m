Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38062D18A5
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 19:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgLGSi6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 13:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGSi6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 13:38:58 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3A9C061793
        for <linux-pci@vger.kernel.org>; Mon,  7 Dec 2020 10:38:18 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id 81so14311767ioc.13
        for <linux-pci@vger.kernel.org>; Mon, 07 Dec 2020 10:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ap2qxN6BOul2pmYmDW8E/QTAvkM/sjmNOpbAx5lPosQ=;
        b=BExsAT9ruZE3CdNfziLeexgNze4CyxBizTUORsz4vOFpKRIx2hkljXvrF/6kNPduhW
         2aEsvC1meMIU5XPzCjU9koH+Nf4zq2kifMRRV5r2Ud+m37WzlYNmjAphK2YXE/nzyfvB
         5jn2e2zX6oUT0tISBid+70N7qoD3+DU7ADnMbduKo/UjRv3rJKy9JN7v/DgFeamrgs6Y
         7muypf05dyju2z+pYX9SAR0cH1pxhUIF2/cvNivhrcRasDFtbo9NaPbAhUVQcdwDM6gx
         rO74X45oKmIVequnhJDHOzS+ejjJTiveXwb+FmjfgGFNPC5FiWSRJgiIM2aHgDulX6G1
         vtaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ap2qxN6BOul2pmYmDW8E/QTAvkM/sjmNOpbAx5lPosQ=;
        b=CBQi5xVuXPmLstM9cBDqePgLfm2SSZTQ5jtz3FHdvG8HPa3LXmP9KRhP2z/RJvfwQm
         9EENnlo+jktmKDZkvoHPdCkhetpUIOhDSY+4bB1kc/mDmjZmuOnEUz43WsmRJSJRdF9G
         btXo2Tq+Czs7/kuAOFvooBHcD0kJfIDKM8tD64zaCUwNZSrFzsOulIhZsJLN2DAnrlao
         9xK32cUEKkN1DVEEiwNgb84wZb+QYYiDSBOBl6OVTKZ116QNU4MIZVRcFYSzgspXcoLb
         s6XV1NLUyRLiTxOO6hMu/MjoX1Tya1V03P7y7svhaYDjfwsMTP/VLs93Vc5Q+kwp1dR/
         OPlg==
X-Gm-Message-State: AOAM5317dFbzJ9Ng4h6cHe8Qlr7lerku5fWeN6BQ2QsM3LGvD7DueEu4
        RClN5/62+vIXJxKv4xmJWHgUlEe+nm2yqQ==
X-Google-Smtp-Source: ABdhPJwpvN2ezgTd+AVie4cdurNQGQgQcUTEb+sA/4B0cMp15ME5nbdlPfJHYpui3vrT9Mdc6t7nZQ==
X-Received: by 2002:a5d:84c4:: with SMTP id z4mr20942487ior.26.1607366297332;
        Mon, 07 Dec 2020 10:38:17 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z18sm7821377ilb.26.2020.12.07.10.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 10:38:16 -0800 (PST)
Subject: Re: [PATCH] drivers: block: save return value of
 pci_find_capability() in u8
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20201207012600.GA2238381@bjorn-Precision-5520>
 <CH2PR04MB65228D22105F039C046096A6E7CE0@CH2PR04MB6522.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7fa99c5f-6f0b-4cd6-7af2-db5877b1857a@kernel.dk>
Date:   Mon, 7 Dec 2020 11:38:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CH2PR04MB65228D22105F039C046096A6E7CE0@CH2PR04MB6522.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/6/20 6:30 PM, Damien Le Moal wrote:
> On 2020/12/07 10:26, Bjorn Helgaas wrote:
>> On Sun, Dec 06, 2020 at 11:08:14PM +0000, Chaitanya Kulkarni wrote:
>>> On 12/6/20 11:45, Puranjay Mohan wrote:
>>>> Callers of pci_find_capability should save the return value in u8.
>>>> change type of variables from int to u8 to match the specification.
>>>
>>> I did not understand this, pci_find_capability() does not return u8. 
>>>
>>> what is it that we are achieving by changing the variable type ?
>>>
>>> This patch will probably also generate type mismatch warning with
>>>
>>> certain static analyzers.
>>
>> There's a patch pending via the PCI tree to change the return type to
>> u8.  We can do one of:
>>
>>   - Ignore this.  It only changes something on the stack, so no real
>>     space saving and there's no problem assigning the u8 return value
>>     to the "int".
>>
>>   - The maintainer could ack it and I could merge it via the PCI tree
>>     so it happens in the correct order (after the interface change).
> 
> That works for me. But this driver changes generally go through Jens block tree.
> 
> Jens,
> 
> Is this OK with you if Bjorn takes the patch through the PCI tree ?

Yep that's fine, if that makes it easier to handle.

-- 
Jens Axboe

