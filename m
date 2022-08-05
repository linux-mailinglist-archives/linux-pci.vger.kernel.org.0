Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC0E58AC83
	for <lists+linux-pci@lfdr.de>; Fri,  5 Aug 2022 16:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiHEOxd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Aug 2022 10:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiHEOxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Aug 2022 10:53:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD7D27B2A;
        Fri,  5 Aug 2022 07:53:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so3126765pjl.0;
        Fri, 05 Aug 2022 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=33AZt7ymDP4nFwb3HoRxIJj1gr2kC1zCUk6/IWw48yE=;
        b=TLwTF1vdMyAUqMHSboElOLVaAalCTo0wu68+EKsDUDSnc+prYVb0/ScfgXXfT783kq
         Pb7rPiryzdSBDR96vTPk+JfTyvIdROsEl2/0yrIAMUP5vBunzxkxlwYj1Ttp9OtjrhPl
         QIH4WA4K1UG7x9Z15ZAYu3vuLDfhA4kz092U3Imdi2lgHgaoqMuxkytofSJ1ClbfjapD
         ihZs1YbOthi73/THKIXHv8b4ReNAfeS6nSyp3wcw8dwSytyJm0edPLE9EMNJ6JSQrB7d
         RwVqT37lr7tDaK0Ky6qJbSaF51zx51e0D8qkwIYHzvyHxChjzOYkQmuYYEXPn0OeNuxo
         HOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=33AZt7ymDP4nFwb3HoRxIJj1gr2kC1zCUk6/IWw48yE=;
        b=lH/cfSICsc6fYZtu2OqEA9XEzYOwNYTdypEwOEDwPbDuoz72TkWrAKF9H+VCXA4MxL
         rFeCC5LJnDfbO3XqOjo+pb85MVvuO0H1PEOwUFPtebPD7Vv91PVWonvE0DKzLa2lMhoY
         qT3NwmqfXm+N195LForzX/BRP8aqmkYGWYKSisbW3KnKLVID3dLe0xbNC0TTnDbDAyJl
         piaB5bTXHtOusdEpZAweAczmTQlbQYYEgQ1zcjgcdbcWRLJKjVkUb9e8pp9F5UoH6lQ2
         TB7OrYsKDXbvRBlp7zioCVrF+rJjyFifcsU5pVoXCliTtFFPwCFCYsuUKmOUCCjv1LiZ
         4pVA==
X-Gm-Message-State: ACgBeo3mbwwubTY00/yuGfRy+VjJWJes/iaLeBBO64/pgxAmFPymMgBO
        JVUEmLjnMc57wmMuQsyP3Y0=
X-Google-Smtp-Source: AA6agR6CWsFqFxK/1Qgoi9OqNggL10FVM8/rDylB+Vqe15zY26HgqewrSu5O5pCifAnUgHs8F9L1Cg==
X-Received: by 2002:a17:903:234e:b0:16e:e279:913c with SMTP id c14-20020a170903234e00b0016ee279913cmr7044716plh.47.1659711209559;
        Fri, 05 Aug 2022 07:53:29 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id j15-20020a170902da8f00b0016f04c098ddsm3114520plx.226.2022.08.05.07.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 07:53:28 -0700 (PDT)
Message-ID: <7c61db45-8e40-9918-ec7c-69a6deb8f71a@gmail.com>
Date:   Fri, 5 Aug 2022 23:53:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To:     bagasdotme@gmail.com
Cc:     bhelgaas@google.com, corbet@lwn.net, darren@os.amperecomputing.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, patches@amperecomputing.com,
        shijie@os.amperecomputing.com, yangyicong@hisilicon.com,
        zwang@amperecomputing.com
References: <6556c478-976c-27f1-ad9b-606fe47f7ce1@gmail.com>
Subject: Re: [PATCH v3] PCI: update the links for aer-inject git tree
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <6556c478-976c-27f1-ad9b-606fe47f7ce1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fri, 5 Aug 2022 20:31:33 +0700, Bagas Sanjaya wrote:
> On 8/5/22 17:52, Huang Shijie wrote:
>> The aer-inject tree has been moved to:
>>     https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
>> Update the links.
>> 
>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>> ---
>> v1 --> v2: Modified the commit message and the title.
>> v2 --> v3: Change the commit message again.
>> ---
> 
> The change log could have been before the diffstat below (so it won't be
> displayed on git log when applied).
Are you sure Bagas?  :-)

>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>> ---

I guess this "---" should work as the end marker of changelog.

>> v1 --> v2: Modified the commit message and the title.
>> v2 --> v3: Change the commit message again.
>> ---

Another "---" here does no harm.

        Thanks, Akira

> 
>>  Documentation/PCI/pcieaer-howto.rst | 2 +-
>>  drivers/pci/pcie/Kconfig            | 2 +-
>>  drivers/pci/pcie/aer_inject.c       | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)

