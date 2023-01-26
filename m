Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE7067D195
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 17:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjAZQ1i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 11:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjAZQ1Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 11:27:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2348870D63
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2023 08:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674750330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CyqC4HBKoEgyHHDtYb2+ga2T4D19HRBTg8u+WniVOaQ=;
        b=ZcXR9PPj12CbfYK8Y/ZF7FZFTQI7wEWmJcs0uDHW7SyC8V4BlEcHLIUk8Rz7pb6zzos4XA
        V77j22PUvlHgdqtpOlDH8bee5Dy6G1HhQJ4kJXhJIhDSGlQ1LIWCddnSosfMO1UubYJY9q
        h1V40Ulm4AN/zRlmYtBp5pG/2b6dggE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-74-_pBWCGTJM1OFvV2-55XGyw-1; Thu, 26 Jan 2023 11:25:28 -0500
X-MC-Unique: _pBWCGTJM1OFvV2-55XGyw-1
Received: by mail-wr1-f71.google.com with SMTP id w16-20020a5d4b50000000b002bfca568cdfso329045wrs.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2023 08:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyqC4HBKoEgyHHDtYb2+ga2T4D19HRBTg8u+WniVOaQ=;
        b=odGMegSJPcNu1fMz38BAdr/MKpf+4j32go+x/kyTdhIaNfxNHZyUSlcgytcvMYJWte
         OCNGiBNrCL/IjAfPjK0UJBkzgfVx90LlG5sluOOPeoZkoUOq8f7hKJf4LJjzaOjzPkHX
         WcZcfIE3IsTLcQHoXqWQgf37stQUvXmvg2Iqmd/9hEy5fjLK5CuPLiCKofcyTfOc3xzH
         FUEwFG0QBwn5EbNv1vWVJjADYQ4jlyPUnTqRYQs2Dc70nBTrzHOC4EFId7FGr+uA+ZKu
         KzJBPUEE40OANV6llHTMV+za45WDJkxq+I0ny3Plif4GHKh4mxxJy1efcYDwJoyNIhPq
         AeWg==
X-Gm-Message-State: AFqh2krCINOc/xWLuySqmLtqV/Y5kA9Hm7S5Uhz/yRHhGyzrhsXBIuWi
        +bKmEaADGBOjUY8uVSQ0GkYFEiorY84vCFWNJaVPIslINy66HG/onE+4LghP6DAvGrHsJ8OJHQ4
        camn6VFY9KugVyYpgI7aI
X-Received: by 2002:a05:600c:3488:b0:3cf:68f8:790b with SMTP id a8-20020a05600c348800b003cf68f8790bmr33587591wmq.11.1674750327870;
        Thu, 26 Jan 2023 08:25:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv5e8MKjFsCkVUne5IjgyuScDl6uyyRaHtc0mBQA3MKSQ6ykJ/gLCNS/1L73hNUG/JIUAeP8g==
X-Received: by 2002:a05:600c:3488:b0:3cf:68f8:790b with SMTP id a8-20020a05600c348800b003cf68f8790bmr33587572wmq.11.1674750327685;
        Thu, 26 Jan 2023 08:25:27 -0800 (PST)
Received: from redhat.com ([2.52.137.69])
        by smtp.gmail.com with ESMTPSA id c11-20020adfa30b000000b002bfb5ebf8cfsm1822818wrb.21.2023.01.26.08.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:25:26 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:25:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Samuel Ortiz <sameo@rivosinc.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <20230126112058-mutt-send-email-mst@kernel.org>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E7PNmSTP5w2zuw@kroah.com>
 <Y9FDZPV7qENtNNyk@work-vm>
 <20230125215333.GA18160@wunner.de>
 <CAGXJix9-cXNW7EwJf0PVzj_Qmt5fmQvBX1KvXfRX5NAeEpnMvw@mail.gmail.com>
 <20230126154449.GB4188@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126154449.GB4188@wunner.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 26, 2023 at 04:44:49PM +0100, Lukas Wunner wrote:
> Obviously the host can DoS guest access to the device by modifying
> exchanged messages, but there are much simpler ways for it to
> do that, say, by clearing Bus Master Enable or Memory Space Enable
> bits in the Command Register.

There's a single key per guest though, isn't it? Also used
for regular memory?


-- 
MST

