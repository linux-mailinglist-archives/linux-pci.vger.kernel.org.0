Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26D464C129
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 01:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiLNA3P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 19:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbiLNA3N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 19:29:13 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD1913DC5
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2022 16:29:12 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id l8so5104195ljh.13
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2022 16:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CPdIl7j3z87XMoAtuQTYb7H6hS/X8Y8wZw0h0XqYJts=;
        b=LeV0NfTO9Yny9X0sQN+QWiB2vEACAxIvba5Jn5mzCXXF2na/AnzM93cdwUM6it+uir
         mWvxzvBEYybss4idL16kC++k53SuWMae5qdPfROE/9kitx7gRO30xBq0rxoL6wMRIrJj
         YNeqbuWCkgsm5Wdl1vMKHm+3T4HqL5+UDJDStGQKrANrCmm2TO7FHfLG9wX3JeQwRkAX
         oZE/bXFYJ/JHYepwYfcX7Nhl274b55bEg23uBRHIFFLWdtP4mKI28QrP0KMMg9YOXqGa
         OTUMf7UswCeV7mopzEGMF2kOZQ2G6p86xz0Wf/h4CkrUekghC3KBGzsKP8uGm59Jmg6e
         vKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPdIl7j3z87XMoAtuQTYb7H6hS/X8Y8wZw0h0XqYJts=;
        b=Av4D5HBPZIOmVZdZWa+FNsT/Yn2qWCaQfNceZj9iC+uZpLYNQkD0W0T/jJ2VQFY5+T
         fJny2OUultQIj62T5ZYEke4r3+4wxiV7xH6Zny9GxmpODhvUPVaIUBmdeX/cFKIbXcKq
         HIvUNZoD+2ma4jClnf0kVtWuyf6Y8urkgGpxhOJM6VtmG0sj5ErTonmESGaD8V90Ry/a
         nV0JVTonCYtTx3sPrYNo8HueYXCpRNCXUlYoobv9gowU8XqfXOa5oO77fmjH5da2PFTN
         aj6L5ZKD0173V25op1KfDeGdHJxPZn/YCAY6zEkzQNZgUNW+koEzm418xHEif5ELzIIk
         iRGg==
X-Gm-Message-State: ANoB5plGUlxYcQM8qwNDfyU1cZ4uqGC6dF9XQ3HNIyYkPc4QIZCjeolf
        kS7c6pzxlEWUwVAj2tcjcI6OuGopnrAgKeEk8Zg=
X-Google-Smtp-Source: AA0mqf6+hiW4m5dZ9K2vihUGa/wuDtAGwqzBRjQubb1J7Po6WIV8+nc+suX7/0mtrJ3rZkDGNi/y1aleT6x1JwGvJPI=
X-Received: by 2002:a2e:bd07:0:b0:277:31b0:8ba3 with SMTP id
 n7-20020a2ebd07000000b0027731b08ba3mr33548130ljq.290.1670977750194; Tue, 13
 Dec 2022 16:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20220222162355.32369-4-Frank.Li@nxp.com> <20221214000848.GA221546@bhelgaas>
 <CAHrpEqSGySHDET3YPu3czzoMBmCRJsgGgU4s3GWWbtruFLVHaA@mail.gmail.com>
In-Reply-To: <CAHrpEqSGySHDET3YPu3czzoMBmCRJsgGgU4s3GWWbtruFLVHaA@mail.gmail.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Tue, 13 Dec 2022 18:28:58 -0600
Message-ID: <CABhMZUXcTst3F1jvpa6ijWgVDnX4k-s8c3m=zBoaEiQaj_Xu1w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PCI: endpoint: Support NTB transfer between RC and EP
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        allenbh@gmail.com, dave.jiang@intel.com,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        jdmason@kudzu.us, jingoohan1@gmail.com, kishon@kernel.org,
        kw@linux.com, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 13, 2022 at 6:17 PM Zhi Li <lznuaa@gmail.com> wrote:
> On Tue, Dec 13, 2022 at 6:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Tue, Feb 22, 2022 at 10:23:54AM -0600, Frank Li wrote:
>>
>> > + * +--------------------------------------------------+ Base
>> > + * |                                                  |
>> > + * |                                                  |
>> > + * |                                                  |
>> > + * |          Common Control Register                 |
>> > + * |                                                  |
>> > + * |                                                  |
>> > + * |                                                  |
>> > + * +-----------------------+--------------------------+ Base+span_offset
>> > + * |                       |                          |
>> > + * |    Peer Span Space    |    Span Space            |
>> > + * |                       |                          |
>> > + * |                       |                          |
>> > + * +-----------------------+--------------------------+ Base+span_offset
>> > + * |                       |                          |     +span_count * 4
>> > + * |                       |                          |
>> > + * |     Span Space        |   Peer Span Space        |
>> > + * |                       |                          |
>> > + * +-----------------------+--------------------------+
>>
>> Are these comments supposed to say *spad*, i.e., scratchpad space,
>> instead of "span", to correspond with spad_offset and spad_count
>> below?
>
> Strange, I received some of your comments on the very old patches.

What's strange about it?  I went to the trouble to look up the patch
that introduced the thing I'm asking about.  I sent the email a few
minutes ago.  The question still applies to the current tree.

Please use plain text email on the Linux mailing lists.

Bjorn
