Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B4A58CDD7
	for <lists+linux-pci@lfdr.de>; Mon,  8 Aug 2022 20:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244294AbiHHSmt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Aug 2022 14:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244479AbiHHSmc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Aug 2022 14:42:32 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F528E2A;
        Mon,  8 Aug 2022 11:42:06 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id u8so7005345qvv.1;
        Mon, 08 Aug 2022 11:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=u1PXgfOS9jeLalo7AqxZr5mK2SKHlkfGpYodsapJQG0=;
        b=evq7RpP0UH6ogV/39TW0beGjB2CUxeCUB1sI9H42E5IvZ7DEJTAyurPerZvYvH9F82
         ddaPRi7cFPWoggHGbJ/v9V48kOtVcKZNvQy/OEeVS7UXlIIAH6cvNLdXwp6lNlfnymB5
         4tMnK7gyUpjQAv1RXNYoYr0KCMNra9dfCXWxWQDDXFJpqDfs89gBufzcWhVxPCCQOARd
         aENVHKyOF45k061pvPpuBcjon+YacO94Sma6kMy1mCmw+FJ7JW04cmrI8QNE/NoK8q+O
         g9Th/A58vsl1nfVxb2FPunrNy57fGSCMsFKdnBDpg+V2Cs8cH6ZPEIKT2u35PkGF1EPR
         pX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=u1PXgfOS9jeLalo7AqxZr5mK2SKHlkfGpYodsapJQG0=;
        b=aVfRciCjuqZ0suJ2t3xob8N/riaoi46SxosXmFDPO/e/h88Vx7UbPl2V/j8AV4QIKr
         GYtKruAaf58HP1XdRMF1jW8C7sGTB6SZEAMBUb07eghNaPzxGiXcVETgORbhQrOJyzuB
         DYNSfRnwK+OruwlNaZlvF1uJv2qa3IIsqVShYZBHOXnseBNn5iIVUOLdzIoTNBTs9LK5
         uR/NvMI+PslgHGHR7KEVlv+t9VSbsWJXjjY9wjbOfE9Jd3JkzSVVQPO+9bfUYcfrK0ZO
         OdSFLGFIJ+IjV8StN5V4PHINasyAuFhCKZq5QbNqeCKX7/gp46zi0ggy1OF/S2L3FA8G
         bmEg==
X-Gm-Message-State: ACgBeo3sUh/CFhkpyefE/vhi3qx0QknJBEI7wnHVS5wgB0B90nEKR4uJ
        0PajoSN5cAsaxd+KKHQrKBVw/Sa/z6/d
X-Google-Smtp-Source: AA6agR7ylZhaRL35P4ikdTZUEYUyOFJJd0qNC4BP1gf9ihEu2Q6xzs2KPYDk+AZ3UgpgBrJ44Q/GOg==
X-Received: by 2002:ad4:5f48:0:b0:476:787f:1cd with SMTP id p8-20020ad45f48000000b00476787f01cdmr17061393qvg.77.1659984125390;
        Mon, 08 Aug 2022 11:42:05 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id j17-20020a05620a289100b006b5bf5d45casm10265069qkp.27.2022.08.08.11.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 11:42:04 -0700 (PDT)
Message-ID: <1b92761a-c166-b84f-8d77-a966d4c0ef9a@gmail.com>
Date:   Mon, 8 Aug 2022 14:42:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v5 27/32] PCI/P2PDMA: Convert to printbuf
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        linux-pci@vger.kernel.org
References: <20220808175122.GA1215280@bhelgaas>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <20220808175122.GA1215280@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/8/22 13:51, Bjorn Helgaas wrote:
> I don't object to the patch, but it would be nice if the commit log
> hinted at what the advantage is.  I assume it's faster/safer/better in
> some way, but I have no idea what.

Printbufs have some additional features over seq_buf but they're not 
used here. The main one you might be interested in is heap allocation: 
that means no need to statically allocate buffers on the stack and no 
need to calculate the buffer size, printbufs will reallocate as necessary.

I generally haven't been converting code to use that unless it's obvious 
that we're in a context where it's safe to allocate memory and can deal 
with allocation failures.

I notice that in calc_map_type_and_dist() you're using xa_store() which 
can fail, but you're not checking for that or returning errors properly 
:) perhaps a fix for that could also switch to using printbuf in 
heap-allocation mode.

> Also, cpu_show_meltdown() doesn't appear in this patch, so maybe
> that's relevant to some other patch but not this one?

Whoops, was copying the commit message from another patch, yeah.n
