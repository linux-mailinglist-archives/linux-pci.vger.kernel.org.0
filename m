Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035B121C006
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 00:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGJWlu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 18:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJWlu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2020 18:41:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A29AC08C5DC;
        Fri, 10 Jul 2020 15:41:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k6so7384932wrn.3;
        Fri, 10 Jul 2020 15:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HEbLwZa+8AgiE1sTsi+5dmebuA2XCkZOdthvMWC9zb4=;
        b=KP7CW5tAuKK2GLWkOhXixaxYhsLkIgmqDx373gqHEaQImwUaqRQCypSp6iHYmH9Jtd
         1YXpx2tazlWq7QgppjaERv9NSIQMi005ctyW41gNTMGdmjf4+Fpdpi0i5y2aYuihHJFM
         I97j0UWfMjdaU0Xg2oqh5NzPfVGg7kFrEs9rJlx7D6ndUaAGAjhi1B+TYoxoQKDKMnho
         mX7dXuGi60EQwiyEnS7h2ZXy5vH6Ne+JSKe0sRQeqCCEvA+RszvUurijLoujOUczcR/F
         47QYFii59lD9xEiJ0fp2UKvOi7jIXW4Fh8myLQ2gvqieINF6Vk+0nFpvF1YxE8lHYvrj
         BNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HEbLwZa+8AgiE1sTsi+5dmebuA2XCkZOdthvMWC9zb4=;
        b=qSobkf/Q85zEnJ/2sBc6rrMT2XUAG2NEEhRMj0RTkBv1mM6mOZvxeDPrcfw4pW4jk+
         D/FOzKPKR6vhS1uRAD++RBjXDb3yaO9y5MCUTkNPWWQmH5FxE2a1wLJoE35dyOBYqRvy
         kj8KIUBPQTxdNPn1tN/Q97/UPx+7Falr06j6QX9kDAL5cAcyq9LLlu74ZOS0Fkgt9E4n
         /zE1wU5+cqC8kEYrBLH4cN76vDKo2bDHsCjKXGcg2MNasjoLeWAy0w3MyVwJkPHJ4z0x
         NuwtPPRSCamVSstgNbXxm/9fbmPlwxE4KPaaOTDBFQCmgakjdVJomG5eJGX9zxXuix14
         Dsig==
X-Gm-Message-State: AOAM530tWMYe1Lhzms88xQgxdj7Uyy6Od3Wb1e3K0xoCUMjQwATVaLuC
        CEkunkTnG1H2uXgTV5BzE+0sVqTqDRi98w==
X-Google-Smtp-Source: ABdhPJzFJUGBCPAOYmLYSDS91PNlB5l/NXZG/EQGYdtnFen+q7UFpF7WUfEaLVIXb9q4EI1/CogbAQ==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr68475674wrn.408.1594420908598;
        Fri, 10 Jul 2020 15:41:48 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id c25sm10626843wml.18.2020.07.10.15.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 15:41:48 -0700 (PDT)
Subject: Re: [PATCH 5/11 RFC] PCI: pciehp: Make "Power On" the default
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20200710001406.GA30420@bjorn-Precision-5520>
From:   Saheed Bolarinwa <refactormyself@gmail.com>
Message-ID: <ee4e0e13-baed-9800-8ff7-a91186bf1f8a@gmail.com>
Date:   Fri, 10 Jul 2020 23:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200710001406.GA30420@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/10/20 2:14 AM, Bjorn Helgaas wrote:
> On Mon, Jul 06, 2020 at 11:31:15AM +0200, Saheed Olayemi Bolarinwa wrote:
>> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
>>
>> The default case of the switch statement is redundant since
>> PCI_EXP_SLTCTL_PCC is only a single bit. pcie_capability_read_word()
>> currently causes "On" value to be set if it fails. Patch 11/11
>> changes the behaviour of pcie_capability_read_word() so on falure the
>> "Off" value will be set.
> s/falure/failure/
>
> Split this into two patches.  The removal of the default case should
> be in its own patch to make it trivial to review.
>
Thank you for the review. It is now split into two in the version 3 
which I just sent.

- Saheed

