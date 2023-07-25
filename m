Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C91B760D76
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 10:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjGYIp3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 04:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjGYIob (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 04:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5191FDD
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690274561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/lGM3AFGn4fMjg440JiVDWQxDq2/CsLGdFzbi2mu8k=;
        b=YpI3X72Sl3i1NWccAcqvD0pWrROqMrVRzTwuh1b+o8utGwJeiGFM6Ohiu8E2bjbj0Z6yPR
        dS14l/uBRYueUqygaWbGAsgJPQAK011p6+3KWwbRs+xuk42P+ldJ8mimBBkrsHJPSz2kJa
        Y5Ehhq1jSXXoW8Krxk9aiaNtnbniMsM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-yg04SL3IMGG4G2r8PxQGFw-1; Tue, 25 Jul 2023 04:42:40 -0400
X-MC-Unique: yg04SL3IMGG4G2r8PxQGFw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-97542592eb9so341341666b.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 01:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274559; x=1690879359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/lGM3AFGn4fMjg440JiVDWQxDq2/CsLGdFzbi2mu8k=;
        b=DB1XTxLXKpyMxG4rWtVSJ3TNp9MYaw3/FgwaoHeVFLfeiOZPMjJMN+SLUEGCvxQAdV
         KocVzy+FQAy2QwG4p62oeKvUxvoLwGIT3hEfB7HBZZwuNKTKZg1rRUQ1cLU5VrplhUXG
         KPGi3ARh8UMeYNpsd3DFIlni6/ImCAsOa8vQ8Z+dG5rVZs8B7AgqeWrqDjATjHPGjZgW
         Ujyn8m3uOvG/JWm8/leeZFFpy2Kduor/K+Xj/LbE9CKrhrc8ThauCVmzZyf7tVTB9wAe
         o0yGIY7mWIjcmmUYVUVrrSxCGDLeWG6P8+0AaZ5r0Y6znee+B59CrZaBX5Df5qYoBJjp
         5lhg==
X-Gm-Message-State: ABy/qLYKCv+rCF6NiNiFnzy9/Eax5NdBwWg2VgbmsXtu1HMhRuPTeY+f
        0g1Kt+7oNFIa7Tp+BGd/0InNjKsm4h0ql2XgaL8/rUzx4IMLiZd2NaZPbqzdEQA7de8CZneWy6M
        KUjNgyL6bKXUR1gabikpA
X-Received: by 2002:a17:906:cc49:b0:98f:5640:16a with SMTP id mm9-20020a170906cc4900b0098f5640016amr12404165ejb.53.1690274559333;
        Tue, 25 Jul 2023 01:42:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFT8gkR9kPbQttomndHJiJR3D8A95upZF6W+dEQNzOD6/93XYMy+W6KX9P6z63JwSAMCrdeZA==
X-Received: by 2002:a17:906:cc49:b0:98f:5640:16a with SMTP id mm9-20020a170906cc4900b0098f5640016amr12404149ejb.53.1690274559025;
        Tue, 25 Jul 2023 01:42:39 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id jp7-20020a170906f74700b009937dbabbd5sm7840352ejb.220.2023.07.25.01.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:42:38 -0700 (PDT)
Date:   Tue, 25 Jul 2023 10:42:37 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Woody Suwalski <terraluna977@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, mst@redhat.com
Subject: Re: [PATCH] hack to debug acpiphp crash
Message-ID: <20230725104237.0c8d0dc1@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230725100644.6138efb6@imammedo.users.ipa.redhat.com>
References: <11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com>
        <20230724135902.2217991-1-imammedo@redhat.com>
        <92150d8d-8a3a-d600-a996-f60a8e4c876c@gmail.com>
        <20230725100644.6138efb6@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Jul 2023 10:06:44 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> PS:
> What happens is that on resume firmware (likely EC),
> issues ACPI bus check on root ports which (bus check) is
> wired to acpiphp module (though pciehp module was initialized
> at boot to manage root ports), it's likely firmware bug.
> 
> I'd guess the intent behind this was to check if PCIe devices
> were hotplugged while laptop has been asleep, and for
> some reason they didn't use native PCIe hotplug to handle that. 
> However looking at laptop specs you can't hotplug PCIe
> devices via external ports. Given how old laptop is
> it isn't going to be fixed, so we would need a workaround
> or fixup DSDT to skip buscheck.
> 
> The options I see is to keep old kernel as for such case,
> or bail out early from bus check/enable_slot since root port
> is managed by pciehp module (and let it handle hotplug).

scratch all of above out (it's wrong). Looking at DSDT
firmware sends Notify(rpxx, 2 /* Wake */) event. Which
according to spec needs to be handed down to the native
device driver.


