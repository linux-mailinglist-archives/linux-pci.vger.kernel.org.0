Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43332D0666
	for <lists+linux-pci@lfdr.de>; Sun,  6 Dec 2020 18:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgLFRtu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Dec 2020 12:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgLFRtt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Dec 2020 12:49:49 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0A7C0613D0
        for <linux-pci@vger.kernel.org>; Sun,  6 Dec 2020 09:49:03 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so10519468wrx.5
        for <linux-pci@vger.kernel.org>; Sun, 06 Dec 2020 09:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=GyLxCx/9cWU4jRUXGA985P695q5LXiabSvscKUMRfT8=;
        b=ij6+L78qicCUBXpO1L65LKU7dsOGwy8Lll/z1MbJF3bMnKvzgdgO0UtiPLlfa7niTx
         9m+Nb4nRbpmyMgKZA9/v6NuE3wArxco95A5+SR5kXFmV487Nz6b2s6mosssmg7oZ23EX
         bgjAmGnDF6RQWo8RD6DkViWqWZOy6PE1cXi54yx/5tBZY0uSr4rL4q9Up+VpofdyVPUD
         rvDgZIwQEhx7K5SQI3sGi/Z59iGf4VS0465v56fS0UjOTdGJ0y3ooQcpvxpEhsrEQmoO
         VnZ/xUygG4BYpkclDuw06z+XqXORRew1jV6UPdq1sZSdyKmaPSpsL9g6Nn06LF0dv8LY
         ZkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=GyLxCx/9cWU4jRUXGA985P695q5LXiabSvscKUMRfT8=;
        b=HDJj/qSKBdIH45GWcyz/v9qHmF1EXaLO3oIf7wgQO1hUAN95xta+lQb1X20EZvv0Wl
         sH7viUS9ULVZGVloMpdDsy2Ee2KHFZjGKjFzljB7ux/vdFCzLEX5NB2VmoR84HpGsFVF
         FpqpkwjFR/AfRc014QsJyi1X8l5vMpjta47SJLnsV4gCQkecnbwtz5e/q94rrj54D90u
         JYB8LrZp/tJkGCp1NlZE5d+/+JdGsb+9XrRKPl+aj3hHhsZbGV4DwB6ZPOKzesS7vwm/
         RPzFnDBBmJg0U6N3Iu8N8r3kK+E85EvJ9G+3PKr4ei/mZuWFgHK1We028e/S7caQBjNY
         bCBQ==
X-Gm-Message-State: AOAM531g6EdgfiKM3Ct1P3KiCEMNwgAlKFPqpLiBrXP2T/3DpZmfA/f1
        tvP19v+NUh2PfzmFo22BtzReQBNDq1E=
X-Google-Smtp-Source: ABdhPJwAbkJLo0/6pVDazWYYSTseAwT8dN1jY0NvswpSSLK7nao7S20YA4IoOiftaQEdgUkSN01d6A==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr6099330wrv.363.1607276941546;
        Sun, 06 Dec 2020 09:49:01 -0800 (PST)
Received: from ?IPv6:2003:ea:8f2e:e00:6dbb:cd33:3f6d:74fe? (p200300ea8f2e0e006dbbcd333f6d74fe.dip0.t-ipconnect.de. [2003:ea:8f2e:e00:6dbb:cd33:3f6d:74fe])
        by smtp.googlemail.com with ESMTPSA id z21sm10494575wmk.20.2020.12.06.09.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 09:49:00 -0800 (PST)
Subject: Re: [PATCH] PCI/ASPM: Reject sysfs attempts to enable states that are
 not covered by policy
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20200909182846.GA719960@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <38f73412-ebbf-f1a5-3a9e-9f4621c830b2@gmail.com>
Date:   Sun, 6 Dec 2020 18:48:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20200909182846.GA719960@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 09.09.2020 um 20:28 schrieb Bjorn Helgaas:
> On Mon, Jul 20, 2020 at 08:08:59AM +0200, Heiner Kallweit wrote:
>> When trying to enable a state that is not covered by the policy,
>> then the change request will be silently ignored. That's not too
>> nice to the user, therefore reject such attempts explicitly.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/pci/pcie/aspm.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index b17e5ffd3..cd0f30ca9 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -1224,11 +1224,16 @@ static ssize_t aspm_attr_store_common(struct device *dev,
>>  {
>>  	struct pci_dev *pdev = to_pci_dev(dev);
>>  	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>> +	u32 policy_state = policy_to_aspm_state(link);
>>  	bool state_enable;
>>  
>>  	if (strtobool(buf, &state_enable) < 0)
>>  		return -EINVAL;
>>  
>> +	/* reject attempts to enable states not covered by policy */
>> +	if (state_enable && state & ~policy_state)
>> +		return -EPERM;
> 
> I really like the sentiment of this patch, but I don't like the fact
> that this test for states being covered by the policy is here by
> itself.
> 
> There must be some place in the pcie_config_aspm_link() path that does
> a similar test and silently ignores things not covered by the policy?
> If we could take advantage of *that* test, we won't have to worry
> about things getting out of sync if we change that test in the future.
> 
> Maybe pcie_config_aspm_link() could return -EPERM if the policy
> doesn't allow the requested state, and we could just notice that here?
> 
Oh, I just see that I missed to follow-up on this topic.

Currently pcie_config_aspm_link() is called in two versions:
1. with state argument 0
2. with state argument policy_to_aspm_state(link)

Therefore pcie_config_aspm_link() doesn't check for states not covered
by the policy. We could add a policy check, but the only use case where
this check would be needed is the call from aspm_attr_store_common().
Is this worth it? Ot better go with the check in
aspm_attr_store_common() as proposed?

In addition, based on the two types of calls to pcie_config_aspm_link(),
we could simplify usage of this function and replace the state argument
with a bool enable flag. If set, then pcie_config_aspm_link() would
internally select policy_to_aspm_state() as requested state.

>>  	down_read(&pci_bus_sem);
>>  	mutex_lock(&aspm_lock);
>>  
>> @@ -1241,7 +1246,7 @@ static ssize_t aspm_attr_store_common(struct device *dev,
>>  		link->aspm_disable |= state;
>>  	}
>>  
>> -	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>> +	pcie_config_aspm_link(link, policy_state);
>>  
>>  	mutex_unlock(&aspm_lock);
>>  	up_read(&pci_bus_sem);
>> -- 
>> 2.27.0
>>

