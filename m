Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A731659B81B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 05:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiHVDny (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Aug 2022 23:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiHVDnw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Aug 2022 23:43:52 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933B9DF60
        for <linux-pci@vger.kernel.org>; Sun, 21 Aug 2022 20:43:49 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id c2so8801862plo.3
        for <linux-pci@vger.kernel.org>; Sun, 21 Aug 2022 20:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=HFVw3jVUKJbSkeKcqcD2AtVfVExg7SHFd1qgEtX/JNg=;
        b=Q92aITiEhGaedkYzGgvXZO7wRd9JsukUpQVdHCMM8OZFQ+aIt2i3HOqj27upb7+KDK
         ezj5Xsl+qWPNsBJwCLRlOnH70gci5JtwSI9T5ibqslK3WCQ90GyqWZncukOchgoxgjMs
         eXt6Bx7vCQPtKdWdH7w0Kzqn8n43/r4pg6GfrTCwb3T6KzJ/koV02Mw0FpdvKWTDSZNN
         n7ODWRQyjH1ccWuT/3KTehMmtDtnmw6nQywXqwDlbVN4to2LBkhxi1pH6c0FM0MsDK+n
         QO7Nm7wewTHXxwBIBJL+s+J/48GC8ynZZns9FK1JWyqV6JQck4p18sN0eZb0yNc/1nxL
         oLHg==
X-Gm-Message-State: ACgBeo38CyXb69OHNvOA5HCHLISRnJdCpLJ/qZCUcIG+wMfSnwwyQvXV
        60D0cEquQ0H7wkOP8tKuNkM=
X-Google-Smtp-Source: AA6agR7WyLeUKwY9WxRSa2+mGLewxHJd0Ynj3gJEQDDfZ0+D5kLj3MggBv+mKTGBvduq/9kFdapcZg==
X-Received: by 2002:a17:90b:4d89:b0:1fb:1cf5:e23d with SMTP id oj9-20020a17090b4d8900b001fb1cf5e23dmr5638939pjb.133.1661139829047;
        Sun, 21 Aug 2022 20:43:49 -0700 (PDT)
Received: from rocinante (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id i5-20020a655b85000000b0042a5e8486a1sm3799909pgr.42.2022.08.21.20.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 20:43:48 -0700 (PDT)
Date:   Mon, 22 Aug 2022 12:43:44 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>, oohall@gmail.com,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] PCI/DPC: Quirk PIO log size for certain Intel PCIe root
 ports
Message-ID: <YwL7cOM0o/VA+e6l@rocinante>
References: <20220816102042.69125-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220816102042.69125-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Adding Sasha for visibility]

Hi Mika,

> There is a BIOS bug on Intel Tiger Lake and Alder Lake systems that
> accidentally clears the root port PIO log size even though it should be 4.
> Fix the affected root ports by forcing the log size to be 4 if it is set
> to 0. The BIOS for the next generation CPUs should have this fixed.

Thank you for the fix!

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209943

I've added Sasha, as there is probably a lot of the 11th and 12th
generation of Intel hardware out there that might warrant a backport
to stable kernels.

	Krzysztof
