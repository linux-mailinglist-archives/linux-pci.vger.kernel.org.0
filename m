Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5145F70FB
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 00:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiJFWKP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 18:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiJFWKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 18:10:05 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668F350182;
        Thu,  6 Oct 2022 15:10:01 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id cn9so1851013qtb.11;
        Thu, 06 Oct 2022 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/XrH2sxsPKYItZtSBGPJ3bI0IwKkzcfUGbbaVwuiGmY=;
        b=j1isgOmtWWFqFUvcOlyM8rYtnHSX2PzJyUy05dmrY9YLz+LF7So+N/1SMpb5qXSTCb
         6LpsKXcS4NxYd/ywloTWjobmentFAgqUL3UWh1OIffuEG9OPew4sCkhU/FK1jk0NWpcK
         8sRbl4JRBL/2NMq3nw+KFmGnqj4g5NaiV9saQM6ZuMgSAupyGHMX/2IOzRTmdJvmGcZv
         6vMAJ+r0xScW/Sq+s0oNO/jAf9wZLdwBx+fc6tYBhuOyAXKaiYrAamSJ+7QC0VeLjkrx
         RF2McqCAhJM76y0NdwyZATzXNtYPDXMn01ta2IYq0T1wpTkZcuIZud4yzMY5ly/laknx
         QGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XrH2sxsPKYItZtSBGPJ3bI0IwKkzcfUGbbaVwuiGmY=;
        b=K3SUOVbdjiYtYXe4D43spqpbTyAKndr2GGGj4U6NuhFtwDWcaL3At9ZZK+bAeFKVUm
         LC5M0BXAGe7fT8gv/tg5jho7uf/3gbqKopul5XBFKpFnnw3qcp1JNcFbNyqlXi8OqCmh
         +oA/TSyOQkFH3tgsmOAyM19G7OlXDvRty7L9MTiFYyBl78k82WQ5MjFIKC3mA/LoA2Y+
         462WMTlpmMGS4q/Cb+EWp8pDB6jfytvFe5VQUfjQkthGUAqPv5BTltBTUYeAKSdy7yET
         ajcYi9vZFLqv68Cq2OlJ/3W//0mxgH5qAl2ykDQhLn1xXAE0zlEWd4Le+d5nCEPQPLpi
         BInA==
X-Gm-Message-State: ACrzQf0b0+Bk3DhFTwxT7XcUiDo1PssyZKxQlNBoGTohkY0F+qvz3Y4z
        hyHC7YgqyCT/7h6D6Rd2BP4=
X-Google-Smtp-Source: AMsMyM6/1a2g5xThw0iaVZRdHB+aVWN2t48lxj4BPjAStRH4zk3+gBH5dcSvyqhJZpm3yEtSiTAHJw==
X-Received: by 2002:a05:622a:34f:b0:35d:4cec:4d7e with SMTP id r15-20020a05622a034f00b0035d4cec4d7emr2154375qtw.56.1665094200132;
        Thu, 06 Oct 2022 15:10:00 -0700 (PDT)
Received: from [192.168.1.102] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id q23-20020a37f717000000b006cf43968db6sm226286qkj.76.2022.10.06.15.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 15:09:59 -0700 (PDT)
Message-ID: <70f033e8-839c-fbfc-f1f0-72ba988d3586@gmail.com>
Date:   Thu, 6 Oct 2022 15:09:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 4/5] PCI: brcmstb: Functions needlessly specified as
 "inline"
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221006220322.33000-1-jim2101024@gmail.com>
 <20221006220322.33000-5-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221006220322.33000-5-jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/6/2022 3:03 PM, Jim Quinlan wrote:
> A number of inline functions are called rarely and/or are not
> time-critical.  Take out the "inline" and let the compiler do its work.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
