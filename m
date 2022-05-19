Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C33852D60F
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 16:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiESO3v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 10:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbiESO3u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 10:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E90970904
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652970588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=skQV/7bpYYCLikiWPou37BZfffdt7LpNOeVYRjZR2lk=;
        b=HHBPL5/SVIr8jV29GvoMmwfGfOxU2LQSQg+pWsEtgyEhFKo8xTeop1J2z0UcdbLcto6MyO
        RMJJAj21TYFYFpyp1C1TbnsYoRp2ooin8CMKh2YczHZqdZITiTmMExUZ3xWbuwRfXuYeNU
        Fay78knOFIrShFeahvy6yCgCID/+sVw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-2pW9AMubNzK6SKS9fPdAkw-1; Thu, 19 May 2022 10:29:46 -0400
X-MC-Unique: 2pW9AMubNzK6SKS9fPdAkw-1
Received: by mail-ed1-f69.google.com with SMTP id h11-20020aa7c60b000000b0042ab2287015so3708033edq.3
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 07:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=skQV/7bpYYCLikiWPou37BZfffdt7LpNOeVYRjZR2lk=;
        b=qm1YpHEYD4breXD1L9uIgb98Cuh0FvgI3lJvGONSYn/S/YXWEqDd8sbDdLS8cz/5DU
         Uv92TL1yy0tb9H/ve7OUMadx+/EvDZzrU2WwL1zDQYzPasPIa7S8NCkcuVEnINj09MCm
         PL8ri9CfiD4UfO9VHUoYHnKsIrQOv/qiofSCvnGGzinjihj0A5CpmGsdFpufdiKSwGb9
         SowcMF5ItKiS4YLpmrIlvJTDA8ktJpR8mP89oYod1WLcD9gDTU/mq2wYQ0Oj2mXDKrn0
         K03uwjgjW+GyBuO80ptUrKzOwukm1jovQ8R/CVOr5Ry4DSvqe4NwKK3XVLIpN5bWSzZo
         Q59w==
X-Gm-Message-State: AOAM5303zrd6qQJ3wrBBrrmYle5dL9N858y5SleVHNRL4QR+0N3hf/Tv
        PmopOI6zW2J2fHzFmEUl9y5J3dzJzMRaidsikeBMuMboW0Wv0iu9+3qbeu7MnGxUjTaXkzHhGCn
        TUUEfip3sb4TO8GXiwUjw
X-Received: by 2002:a17:907:6e09:b0:6fe:8b65:357b with SMTP id sd9-20020a1709076e0900b006fe8b65357bmr4556164ejc.492.1652970585076;
        Thu, 19 May 2022 07:29:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR6WHxquEyjTqk32bptNw0qJbDMyBekjUeS7a4RWeKtvRRxz2LEG0cbg0e2bJOBOt7i1Z4UQ==
X-Received: by 2002:a17:907:6e09:b0:6fe:8b65:357b with SMTP id sd9-20020a1709076e0900b006fe8b65357bmr4556142ejc.492.1652970584862;
        Thu, 19 May 2022 07:29:44 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b26-20020a170906729a00b006f3ef214e0esm2184208ejl.116.2022.05.19.07.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 07:29:44 -0700 (PDT)
Message-ID: <c49dfdf1-c1e8-a9d2-0f31-f190d7b6631f@redhat.com>
Date:   Thu, 19 May 2022 16:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v7 1/1] x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220519141450.GA19225@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220519141450.GA19225@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 5/19/22 16:14, Bjorn Helgaas wrote:
> On Thu, May 19, 2022 at 04:01:48PM +0200, Hans de Goede wrote:
> 
>> Ok, I'll go and prepare a v9 and I will submit that later today.
> 
> Would it be practical to split into three patches?
> 
>   1) Add command-line args
>   2) Add DMI quirks
>   3) Add date check
> 
> It seems easier to assimilate and document in smaller pieces, if
> that's possible.

Ack, will do. Note this will cause quite a bit of copy/paste
in the commit msg to explain why these changes are necessary.

Regards,

Hans

