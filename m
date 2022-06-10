Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB049546544
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 13:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347386AbiFJLOQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 07:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346701AbiFJLOP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 07:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 789BC129EEE
        for <linux-pci@vger.kernel.org>; Fri, 10 Jun 2022 04:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654859653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w51nJtA+PEQulTzssZ7Zqb9+Ta6ksQQtTLDRht+NgLE=;
        b=FQw/OrRPdjUSK+FlJS1DmOx70SrX/eXoFw3/A3XGkMA2UoAVgjsme8ODRsgiui2k4uaaS4
        RV0j3hSNMeuGJ+3sm5m0S37FjuytrZ7f3GBIKISoQ9z4idnfPoJZU7t8HX/ka5TOLvXYFK
        /c3GgRdGtiTSCR2N059jD0nCZExuZ8w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-A04RcWY0MAC-1CObOa_9Og-1; Fri, 10 Jun 2022 07:14:10 -0400
X-MC-Unique: A04RcWY0MAC-1CObOa_9Og-1
Received: by mail-ej1-f70.google.com with SMTP id hy20-20020a1709068a7400b00703779e6f2fso12442694ejc.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Jun 2022 04:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w51nJtA+PEQulTzssZ7Zqb9+Ta6ksQQtTLDRht+NgLE=;
        b=V7bMkVugHodFmoq39IgiSmQixD9f6FbgDFrS/pqF8YnffisPtGHpR1vrvsrzLtsG4H
         38D68UZfTO+i+b+rWixUoJbCaAsYrChxjg1DC8c76d5+NRZta3f62lSXgTlw1Kc04EsK
         +rXApNg6eHon06gzig5q62/XBukoNAzXEBW5JHdPRLa/RPIpBw6MpAh2u/QSjgYlKVLG
         oFoGRaYiJfCGcXynLN5DkivgQuVi6i16CNvT6fXX1SlGxGRF70MmRQmyqjJkyhz50f7s
         bN8w6rH2v0k9XVfhU0dXnU1D0ZCE75QiFUwo4HV8G98xBfzrebz3hojr7MtNgPtEFBc+
         LZ2Q==
X-Gm-Message-State: AOAM530hLMDJABaDCnn+xPL3+tfbuquaLLCIWo5Km8g6ef5dxGzawpeN
        FVdU8/xK7FqhLBkFP+cvU2HjWOQv8o4qC7LMou8oQzl+DYomwKHVOfn056H1YE3GobmUPIyhjUF
        VzpyqsN5+dPoT0MB4VlHp
X-Received: by 2002:a05:6402:51d4:b0:42f:b38d:dbb9 with SMTP id r20-20020a05640251d400b0042fb38ddbb9mr39351381edd.255.1654859649463;
        Fri, 10 Jun 2022 04:14:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrrmyaZEw0oRtI29tcTzt8FyPnbqcDOdKb5aOJSDIKllrLhDC3D72FyTSmusXp1CMT1Z5YZQ==
X-Received: by 2002:a05:6402:51d4:b0:42f:b38d:dbb9 with SMTP id r20-20020a05640251d400b0042fb38ddbb9mr39351362edd.255.1654859649221;
        Fri, 10 Jun 2022 04:14:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170906f6cd00b006febc86b8besm11856829ejb.117.2022.06.10.04.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 04:14:08 -0700 (PDT)
Message-ID: <2f3b38fa-8180-a749-a590-2f758f3a479a@redhat.com>
Date:   Fri, 10 Jun 2022 13:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 216109] New: Steam Deck fails
 to boot when E820 entries clipped out of _CRS]
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org
References: <20220609224339.GA543225@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220609224339.GA543225@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 6/10/22 00:43, Bjorn Helgaas wrote:
> New regression in v5.19-rc1.
> 
> ----- Forwarded message from bugzilla-daemon@kernel.org -----
> 
> Subject: [Bug 216109] New: Steam Deck fails to boot when E820 entries clipped
> 	out of _CRS
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=216109
> 
>            Summary: Steam Deck fails to boot when E820 entries clipped out
>                     of _CRS
>     Kernel Version: v5.19
> 
> Guilherme G. Piccoli reported that v5.18 boots fine on Steam Deck, but
> v5.19-rc1 does not.  He bisected it to 4c5e242d3e93 ("x86/PCI: Clip only host
> bridge windows for E820 regions") [1].
> 
> A quirk similar to [2] that disables E820 clipping makes v5.19-rc1 work again.
> 
> The reason why v5.18 (which always does E820 clipping by default) works, while
> v5.19-rc1 (which also does E820 clipping on this platform) does not has not
> been explained yet.
> 
> [1] https://git.kernel.org/linus/4c5e242d3e93
> [2] https://git.kernel.org/linus/d341838d776a
> 
> ----- End forwarded message -----

I've added some analysis of the logs to the bug. Summary: I think we may
need to revert 4c5e242d3e93, this will be a non trivial revert moving
the pci_use_e820 check added in later commits to arch_remove_reservations().

See the bug for details and lets discuss this further in the bug.

In case we do eventually decide to go with a revert, I'll prepare
a revert later today and push it to:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note I do NOT plan to merge this through the pdx86 tree, the reason
to put it there is to get the builders to play with it, since in the
past: https://lore.kernel.org/linux-pci/20211014183943.27717-2-hdegoede@redhat.com/
we had some build issues with the check inside arch_remove_reservations().

Regards,

Hans






