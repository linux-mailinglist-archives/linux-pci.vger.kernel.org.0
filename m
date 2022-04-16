Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EE15036E2
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 15:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiDPN5v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 09:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiDPN5t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 09:57:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1D52A72B;
        Sat, 16 Apr 2022 06:55:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i27so19740100ejd.9;
        Sat, 16 Apr 2022 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6SJ0gjuIReiuq6mKLxC15SlD0RAGcpMYYaigPzM4upQ=;
        b=QStPKpSkC1LkjeyGv3bKHJYw9iXMBqJMz7A9O9udDbO2DfaYzQ9wEXayi6wYS1FfJs
         h28pj3Tj1tzh8bKPIGh0uU0YpYp95FvbdVoGObTqp5lYF/qcBM7ASVkgfRxAyGZH29QP
         AOkFOVLtMwSOXX0YzxG4NVXO9rH7OY40Xx7V8v/l/TnAw05i56w3mcUUb4nJpwosqmex
         kZWOpcSvgAZHEj3ZvZOOxYMe8+YOixhHxBUdk19j9XUHZsuZSjUXxCgx7ooFkSzsXf/4
         Xtz0jtZQW9YrhcljnoOnqbiNHmWsKlsO3BtCgdlOkuNeY5hKsFZOSZ9yAXm9j8Y00Su8
         OW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SJ0gjuIReiuq6mKLxC15SlD0RAGcpMYYaigPzM4upQ=;
        b=Z9AcGPHE3qCpiW/RpInJe9ANf4syV1qGD0fR8wyzSBaiYoJdloWYvZwB9ndmqerveu
         40SdV6Gk5N0goCx7rzmDjfJB3SGo/t9FeecF1Tc1ufXjhdSItWf9PTRyO4ibBoHwPpi4
         1A+AOaN0umPuvNJ6ySM5GEO4YagXyRC/TmejrMywjfJajTpya1Mcm5pgtB2uuAyvtcXa
         LwgSvt5Whr0XjSeVRGuH2wGRkpxvABLG/NxIfEyp1pIrmts0mCDEJ1aDUXwjsLw7E/vf
         pNsPumdBtHMR4elFCLlxpAasxphY2u1NQqLOdQO9AJQ9kOl8kNxnWiqCAoOIffQoEvuH
         GcFg==
X-Gm-Message-State: AOAM531/FRi8DMfVUPxWLX4kcMLS1sIFd2XZR7279aqpUviF3FEgz2fj
        N9MZ9AfGBS1tMvDfXYe9QLW2wNJ0y3xJl7rEeoi3yVKRYLE=
X-Google-Smtp-Source: ABdhPJxnrbadrn8LjtwLPpjps81ECEVthSYbNkd4qnaqH6ZLIhBCPTFttIxzMll+6jY4JmULrxZLxToMBGz+FwtbLOs=
X-Received: by 2002:a17:906:6a08:b0:6e8:a871:b8d2 with SMTP id
 qw8-20020a1709066a0800b006e8a871b8d2mr2826295ejc.71.1650117315860; Sat, 16
 Apr 2022 06:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAH9NwWec6ovS1xQbuPsB5duskJdmK_qv4t+URTK6thCvGNST7w@mail.gmail.com>
 <20220323023714.GA1244184@bhelgaas>
In-Reply-To: <20220323023714.GA1244184@bhelgaas>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Sat, 16 Apr 2022 15:55:04 +0200
Message-ID: <CAH9NwWfZQWbfc6VJMT3isv2gmnWCoAOU4osDKQ7EBW_XsywGpg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: cadence: Enable Controller to respond to received
 PTM Requests
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > >
> > > > This enables the Controller [RP] to automatically respond with
> > > > Response/ResponseD messages if CDNS_PCIE_LM_TPM_CTRL_PTMRSEN
> > > > and PCI_PTM_CTRL_ENABLE bits are both set.
> > > >
> > > > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
>
> We're in the middle of the merge window right now, but I'm sure
> Lorenzo will be able to look at it after -rc1.  This looks fine to me.
>

Another gentle ping :(

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
