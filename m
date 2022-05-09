Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DED2520313
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 18:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbiEIRC5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 13:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbiEIRC4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 13:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18D771ED5B2
        for <linux-pci@vger.kernel.org>; Mon,  9 May 2022 09:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652115541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HWdynQtaxOp2ZF5+cj6Wtx+6IzX7LhEwTVZiVjbItfY=;
        b=WHhmAV58yYjEM1yCXtaki++tOiGcwHEGFRaeQJVEX+t3Yhn5KtK0xC0PCA/F6Y4QECud/S
        mlQswwXjYHCXEyF/JjsdDEq+huLg11oiaMV/v2N1YhS5JANVXBmoo/qUXu0QesrBV3zacK
        loN7kGdVjfzs9UcmOtx1WMvYHA+yXJg=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-KX7lE2QePW-MsZwYgtMVsQ-1; Mon, 09 May 2022 12:58:59 -0400
X-MC-Unique: KX7lE2QePW-MsZwYgtMVsQ-1
Received: by mail-io1-f69.google.com with SMTP id y13-20020a056602164d00b0065a9dec1ef2so10306124iow.23
        for <linux-pci@vger.kernel.org>; Mon, 09 May 2022 09:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HWdynQtaxOp2ZF5+cj6Wtx+6IzX7LhEwTVZiVjbItfY=;
        b=uHQSKQFVy6DbtXaIwzaWKjZ3hSqYlJNv0YIU9nUjZdkPLhE0OXRuZVhyYHaNOIYQdx
         f5lSBdcF9jscM+ynBKrlFJ7GvD4M8tJULt/ZmlJJ4YVy5ZJdF8Yk26/CcXH8RifzKatE
         9GOMVU7iqjX+ybYs6A0GyIz8Dxb6mtxhGOLHUnIZbRcGcfdDC8p3gq8u6oPrnceMCBi6
         OUqGzFw08fdVr0Ol0AL5m8cJ6kpZfzdTaKOmD7yDEJe1EcZa0s2W0GIeoTaxlBVAovfg
         BlcocNeoMreH2qJ0YR5skwF94fYEz0JwOsZFpIIiCVfsZmkx0UHgJjPRNl2m5ANTz6js
         6e0A==
X-Gm-Message-State: AOAM5305VRg/7Ky/w+l8mx63wGcu8rYSWGQBySHRfyBbk1V+vDYctmVo
        q38teYPNfxyERhknUfwX3B81IGb/ophzu3qTJkKDO2Jl6SG0YtkgTX82p2xrb6qQqLm7TTwwLuD
        vmqjGKlihSa7qVDigCAQs
X-Received: by 2002:a92:c26f:0:b0:2cf:5cfe:2f03 with SMTP id h15-20020a92c26f000000b002cf5cfe2f03mr7552642ild.79.1652115539376;
        Mon, 09 May 2022 09:58:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkkyPqSN3WefhMUrKu4eZg6X/3N2fa3AWLL79ddaSe+Y8mhFkDiw/Qqbj3De+9EcOFstwWFQ==
X-Received: by 2002:a92:c26f:0:b0:2cf:5cfe:2f03 with SMTP id h15-20020a92c26f000000b002cf5cfe2f03mr7552634ild.79.1652115539129;
        Mon, 09 May 2022 09:58:59 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id r6-20020a02c846000000b0032b7fb6c33asm3751874jao.84.2022.05.09.09.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 09:58:58 -0700 (PDT)
Date:   Mon, 9 May 2022 10:58:57 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Write to srvio_numvfs triggers kernel panic
Message-ID: <20220509105857.6399cc22.alex.williamson@redhat.com>
In-Reply-To: <20220509164929.GA602900@bhelgaas>
References: <87ee14l1tx.fsf@epam.com>
        <20220509164929.GA602900@bhelgaas>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 9 May 2022 11:49:29 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Sun, May 08, 2022 at 11:07:40AM +0000, Volodymyr Babchuk wrote:
> > 
> > As you can see, output for func 0 and func 2 is identical, so yeah,
> > looks like my system reads config space for func 0 in both cases.  
> 
> They are not identical:
> 
>   01:00.0 Non-Volatile memory controller
>     Region 0: Memory at 30010000
> 
>   01:00.2 Non-Volatile memory controller
>     Region 0: Memory at 30018000
> 
> > On other hand, I'm wondering if it is correct to have both is_virtfn and
> > is_physfn in the first place, as there can 4 combinations and only two
> > (or three?) of them are valid. Maybe it is worth to replace them with
> > enum?  
> 
> Good question.  I think there was a reason, but I can't remember it
> right now.

AIUI, three combinations are valid:

is_physfn = 0, is_virtfn = 0: A non-SR-IOV function
is_physfn = 1, is_virtfn = 0: An SR-IOV PF
is_physfn = 0, is_virtfn = 1: An SR-IOV VF

As implemented with bit fields this is 2 bits, which is more space
efficient than an enum.  Thanks,

Alex

