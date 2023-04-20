Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913666E8E14
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjDTJa4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDTJaz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 05:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A24192
        for <linux-pci@vger.kernel.org>; Thu, 20 Apr 2023 02:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681983009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cDEs65ZY4C9svszuIZjn2vdR/JFQxFQIyNLFZevs4tE=;
        b=cIYoCgnBIPSd7QH2/2Lm/7TiivV9+D26d+LPdsSqbOD6YuyML1hb6TBo/ais3rG0+K/EBm
        XfSPV4noL2NBrTYSsPZ3eNAudrCYhVddrzB15hpWLV8dtzdlL8K1Iw+ZlshSicMPR56e7O
        rovrifU1UOOImd2IRGeE7DrNJbD1mKs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-qyRGLDggMQ2VU3DDhT6s-w-1; Thu, 20 Apr 2023 05:30:08 -0400
X-MC-Unique: qyRGLDggMQ2VU3DDhT6s-w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f171d201afso3094225e9.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Apr 2023 02:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681983007; x=1684575007;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDEs65ZY4C9svszuIZjn2vdR/JFQxFQIyNLFZevs4tE=;
        b=XIZSreCaMitWsRRxQl816wXML2NJxvGbo4lHuvEjROBeMQbLpkqAOc34+Tt1BmTE2b
         y7XTj3OX1U5FVF+ciHtUBjuep87wILcUwRj3Z/xYfs6Ns7hL+On8hm8O720agIXRe+uI
         ysYcw7wxnKP+vZf5HdCCfFDBU/KBvOl99gL9xW6fzTstKYayYROyG8K6yDLp/5RhOh6a
         kK0uA5crjfTliFlcyFOAGTTAzNo/3VWPtP6fpDHet0Ei7HbxABfeuZhRmPRuFUHJFm6U
         tSm62g/T4tGucW600XjLLv7e6RJciyG0bZtBdAPzjOzk1S4fTFjsX4wv70Lq1+ahf8To
         6JaA==
X-Gm-Message-State: AAQBX9cjgSdLO3MFicPzIRpvjbWfcTXVehZxn70ha08gnb6xJmM6QYVG
        icu4D4KKKo+1w/7dS0VQe4qPfz1BKPo0qbudHEoduKYRWGCcgu/oxmzjB1sLq1nFqvg4TIB6w8B
        3hReBXp+ChSah56gs8Xr4
X-Received: by 2002:adf:efca:0:b0:2f5:5538:2589 with SMTP id i10-20020adfefca000000b002f555382589mr845791wrp.31.1681983007068;
        Thu, 20 Apr 2023 02:30:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350YMtYMcOObUPin35/aM2AJ1xnbjW42cLOVhTBp9bVJzETGAUNOgAqF9WAusiYj56KscOLEdXw==
X-Received: by 2002:adf:efca:0:b0:2f5:5538:2589 with SMTP id i10-20020adfefca000000b002f555382589mr845771wrp.31.1681983006729;
        Thu, 20 Apr 2023 02:30:06 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id t15-20020adfe44f000000b002f00793bd7asm1478740wrm.27.2023.04.20.02.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 02:30:06 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Donald Hunter <donald.hunter@gmail.com>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, mstowe@redhat.com
Subject: Re: [PATCH] PCI: Restrict device disabled status check to DT
In-Reply-To: <20230419202042.GA223738@bhelgaas>
References: <20230419202042.GA223738@bhelgaas>
Date:   Thu, 20 Apr 2023 11:30:04 +0200
Message-ID: <87leimnboj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> [+cc Vitaly, Jesse, Tony, Andy, regressions, regarding reports of
> hang or crash during boot in igb driver, some with AWS Xen]
>
> On Wed, Apr 19, 2023 at 02:35:13PM -0500, Rob Herring wrote:
>> Commit 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
>> checked the firmware device status for both DT and ACPI devices. That
>> caused a regression in some ACPI systems. The exact reason isn't clear.
>> It's possibly a firmware bug. For now, at least, refactor the check to
>> be for DT based systems only.
>> 
>> Note that the original implementation leaked a refcount which is now
>> correctly handled.
>> 
>> Fixes: 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
>> Link: https://lore.kernel.org/all/m2fs9lgndw.fsf@gmail.com/
>> Reported-by: Donald Hunter <donald.hunter@gmail.com>
>> Cc: Binbin Zhou <zhoubinbin@loongson.cn>
>> Cc: Liu Peibao <liupeibao@loongson.cn>
>> Cc: Huacai Chen <chenhuacai@loongson.cn>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>
> Applied to for-linus for (hopefully) v6.3.  I added:
>
>   [bhelgaas: Per ACPI r6.5, sec 6.3.7, for devices on an enumerable
>   bus, _STA must return with bit[0] ("device is present") set]
>
>   Link: https://bugzilla.kernel.org/show_bug.cgi?id=217317
>
> It would be really great if anybody who has seen this issue could test
> and report whether this patch solves it.
>

[Cc: Myron]

I can confirm the patch fixes the issue I've reported with AWS Xen
instances, so:

Tested-by:  Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

