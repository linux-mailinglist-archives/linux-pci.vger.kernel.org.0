Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5A5570AE2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 21:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiGKTni (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 15:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiGKTnf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 15:43:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701A4299;
        Mon, 11 Jul 2022 12:43:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dn9so10551068ejc.7;
        Mon, 11 Jul 2022 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X6YcFOi9vVSWQNUlxBl94IPJJoQTqvk/+3AV7YIEgTo=;
        b=n7lzLfcDU1qPigH8KYX6Iex/Z9iNnGNY+BBOkopgofe2Uu2HAFkCdrcCzTXcabnyvp
         SfrMlwZrtaJG+lQu3ykGLdCBBYJyuyXgfuMvf/9gA9aiezAySH8ZDVaswCBb5etx4EYc
         1dxuqTzgyztY2nMuI4U6SQ9Ry7PQmpOCIZUrzxcUCH9HJ5vEaOhoVYl5UokOica7vl78
         l3pHOAXp94LqCFVYusfdYONR3dfgWzss74lBL4UZXfowP2mX2Ud13hxqWT+S2FiBkGTL
         OY1sEGVEFPV/zNX3ltTRJWfgegsJ6cE+pMfTpSSuGMkN9GURouuC7x5ZVYBlqYJ5hb6O
         chMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X6YcFOi9vVSWQNUlxBl94IPJJoQTqvk/+3AV7YIEgTo=;
        b=hy9Dbs+of2b5PJHpy9QyIPl/aIj2/VTm1EOVFcEqgLv4NExb0WLOr+rYHv4FEPYx/b
         lgmWQUCxj+AkzOD6blCfFU95DYrz+lGoXauMWazo/yhf3nAidr4HFMEgEC/hmPPKE9x9
         aJGnl7j7V+11n21l3Sm6oxb005UhpEjdUL7MDQdA2cPJMNPaChj3qT8kiBB0VwONU+51
         lkdrh10hSCkk7DWlRvnV6jOw5ERoFC4OY143+v5t49tbGFreCTtkt93uF9m2IU7sClOe
         shhVntrCs0SVYQv0o8XBEhDiOeOLuPRl+uLyjZCPnE3B+jkgQsPeuqqezJq9V1fXfzhe
         oMKQ==
X-Gm-Message-State: AJIora9N4IxmTBuyb3sxNdYGE/8czJ/84kdiC8WVFYIxDieHYywKR3Qs
        8L2EnC7NT32FjpoiLkoC2wI=
X-Google-Smtp-Source: AGRyM1tS//FePH9b5wvXMtiy880ZNtdzrpGjjXWqRq/HCz7dmXC7+yormM3Oba95wBNCkq9NdrSSBw==
X-Received: by 2002:a17:907:3da0:b0:72b:47df:c1d7 with SMTP id he32-20020a1709073da000b0072b47dfc1d7mr10001492ejc.214.1657568609910;
        Mon, 11 Jul 2022 12:43:29 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id l18-20020a1709063d3200b0072af3c59354sm3015020ejf.146.2022.07.11.12.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 12:43:29 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <880aac01-9c78-34f7-8a11-d48179e1635c@redhat.com>
Date:   Mon, 11 Jul 2022 21:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] MMIO should have more priority then IO
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, Nadav Amit <namit@vmware.com>
Cc:     Ajay Kaher <akaher@vmware.com>, Bjorn Helgaas <helgaas@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
References: <1656433761-9163-1-git-send-email-akaher@vmware.com>
 <20220628180919.GA1850423@bhelgaas>
 <25F843ED-7EB4-4D00-96CB-7DE1AC886460@vmware.com>
 <YsgplrrJnk5Ly19z@casper.infradead.org>
 <96D533E5-F3AF-4062-B095-8C143C307E37@vmware.com>
 <YshvnodeqmJV6uIJ@casper.infradead.org>
 <1A0FA5B7-39E8-4CAE-90DD-E260937F14E1@vmware.com>
 <Ysh63kRVGMFJMNfG@casper.infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ysh63kRVGMFJMNfG@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/8/22 20:43, Matthew Wilcox wrote:
> Just because I don't use your terminology, you think I have
> "misconceptions"?  Fuck you, you condescending piece of shit.

Matthew, perhaps your vacation was not long enough?

This is not even a violation of the code of conduct, it's a violation of 
basic human decency.

Paolo
