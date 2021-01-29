Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F67308239
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 01:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhA2AIW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 19:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA2AIT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 19:08:19 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09C8C061573;
        Thu, 28 Jan 2021 16:07:39 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id v1so7014862ott.10;
        Thu, 28 Jan 2021 16:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5ILX5b+RrV4AiVEpHFwN5sXUa5ubqo8Aj21NjAeDVw8=;
        b=V4GAHau9okbpK6XGG3KiHomAbwbMBxMKryjJwX9TnkZnDtcA6LrdLM2sC/t2zLQPxJ
         GZzp9qLpHojfqJna7Zdce17l9auN+5WwynFxLmsi/nmB+t3BcaV3lPfeSfK04nmPNOOi
         VoS7kz9jADhp+43HxTn/9ySNbyFQcrS3viKPcbadbztu1a0u6w/LnOMc03JGVeIFNv9Z
         niHbtFJs/7nLv4C6YXrOSkS/Z1DlPKIepKi6QR6gXcsVpEUwNUF33tbLLsgE2feZlJYQ
         sPA3JUos47pVUQ4+kH2zsJCkSqKxbQ+qrlyjiKsHnGJiTufDwASeoiqY0o1eoUdt/NA4
         90YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ILX5b+RrV4AiVEpHFwN5sXUa5ubqo8Aj21NjAeDVw8=;
        b=roi+r+sqyLfUN34qKyWXmrWlQesXl80q+Rn8eLJSG3FDaMwdhHp3Qo3PfEg4jPZ3Bq
         1mXCDtwhsp2+k+R2bXl9MLpvi+pISa8MG93vEzSTjfaY/WdgpcJQzyPZHevauvB5U5XY
         NS7aQmthgm83/r0xZiLIo07gfNr+KRBCZSOSaMiO9BtNMtRMR9KKCfmc/hanWrhOZ56T
         6UvH7O1tC0g/ow4LMIscd+AjHWDKIARz5B68UY0aYFmpjTSAxQzdabEkoPOOxdsxgBMG
         ajkv9xd+V8WUp8uS5P2yZh/ehgp3HGauZrm1cpOLi6+VNo8/XlA81yXkd6gtAtHpbTDN
         6PWw==
X-Gm-Message-State: AOAM530TRiwnH9G/xDSsxs/3aGI0yJB81MQDjz0BNfgt+MIdyc3aZWMI
        uylzcLJb9bGPsaCahFKthPE=
X-Google-Smtp-Source: ABdhPJx3ahECZvlnl3YkKKiFHwySpQ25/lyuK31tnlxfD+LWhGsvll2hpWhbtrqgFDjVuWKQG+i1jQ==
X-Received: by 2002:a9d:4c9a:: with SMTP id m26mr1261144otf.7.1611878859004;
        Thu, 28 Jan 2021 16:07:39 -0800 (PST)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id r1sm1610314ooq.16.2021.01.28.16.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 16:07:38 -0800 (PST)
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
To:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Jan Vesely <jano.vesely@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dave Airlie <airlied@gmail.com>,
        Ben Skeggs <skeggsb@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "A. Vladimirov" <vladimirov.atanas@gmail.com>
References: <20210128233929.GA39660@bjorn-Precision-5520>
 <6bfe3128-4f4d-6447-ab91-1bc54a02e16f@kernel.org>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <f6106d30-cbdb-6ba5-8910-086cee92875e@gmail.com>
Date:   Thu, 28 Jan 2021 18:07:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6bfe3128-4f4d-6447-ab91-1bc54a02e16f@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/28/21 5:51 PM, Sinan Kaya wrote:
> On 1/28/2021 6:39 PM, Bjorn Helgaas wrote:
>> AFAICT, this thread petered out with no resolution.
>>
>> If the bandwidth change notifications are important to somebody,
>> please speak up, preferably with a patch that makes the notifications
>> disabled by default and adds a parameter to enable them (or some other
>> strategy that makes sense).
>>
>> I think these are potentially useful, so I don't really want to just
>> revert them, but if nobody thinks these are important enough to fix,
>> that's a possibility.
> 
> Hide behind debug or expert option by default? or even mark it as BROKEN
> until someone fixes it?
> 
Instead of making it a config option, wouldn't it be better as a kernel 
parameter? People encountering this seem quite competent in passing 
kernel arguments, so having a "pcie_bw_notification=off" would solve 
their problems.

As far as marking this as broken, I've seen no conclusive evidence of to 
tell if its a sw bug or actual hardware problem. Could we have a sysfs 
to disable this on a per-downstream-port basis?

e.g.
     echo 0 > /sys/bus/pci/devices/0000:00:04.0/bw_notification_enabled

This probably won't be ideal if there are many devices downtraining 
their links ad-hoc. At worst we'd have a way to silence those messages 
if we do encounter such devices.

Alex
