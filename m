Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118C7511318
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 09:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359208AbiD0IC0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350586AbiD0IC0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 04:02:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C623415C2B4;
        Wed, 27 Apr 2022 00:59:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i27so1745301ejd.9;
        Wed, 27 Apr 2022 00:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9LEDPI0qQXi5RmLY6j4Xg8FabKVvm/+OTMrV23obG8w=;
        b=ghejRdzYZV1zx9+g9hsebyJuSJYDtwFg0hIQpe266OEmV7L6ENPDmMkhqfOH+pH+a9
         rrF58sEZE1XAlmx2ot1inFq2ezpUmGF9PM8db5opUvfYRJ1QnViWBkGglHAN3lB9rrHr
         L49klEr9LCE1OJQtZwZveJ2Qpjg/A/5h0NNeiU3rmgwz2x/T968SfV6PSHvv0MsdUP45
         Us/yPiqY0wZ9KKzs5/prm8woBh6roOUp3nuSS7R0U8D6rXZhh7esa4In5TI3ouW0Pweb
         KSLSTJXDw75OB/6BiYjN+jV42/O+cBaTIHbghZBgCZ1XQL6DFE4VApeoWOybHQHe0R/R
         JCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9LEDPI0qQXi5RmLY6j4Xg8FabKVvm/+OTMrV23obG8w=;
        b=LgeDEuQSy69CKXumFaZp2gc35NgkgyrOFswKihM044wocIP46NzM1y2fPzs7k7y6q1
         QaM/o6GsbVuP4gMnnce2XCGYRfX/xg1fpuK2z6KRAmJlu8fSAiUUTAXjNmh20uv+XWyS
         F9UguDo5yK/xePsDfmqC9Ao8lt/dxhKjIM/c88WOEaFqJbhWl2lVeuU0J1ap/fMi04U3
         BtLm2Y0pUwoLZUels4pCqH7Tf9DwJPX2yz6zwl/0uGqHzz5Jaf8BsoE+j/DngGrOMfMY
         tLYFleX8ogPWl3sV2vkr62ku8dmUDcDKQmcJlcga5o8rTSSA56Xs+sEI4znqKAamiD8X
         ckTw==
X-Gm-Message-State: AOAM531Qkeg/KfyjS32b5TVVrW1xW376onRRdR23SKKdEvZ9MXrQLZ9W
        ySdu6nSIrcRXEQv261ga3oo=
X-Google-Smtp-Source: ABdhPJwjAAgMy/VYco9ifnd9MRdynu/jo/F8VKp9tZ1q4MTGuYt3QwRpX+w8D1dqYUGovYkFObQmQw==
X-Received: by 2002:a17:906:2991:b0:6cd:ac19:ce34 with SMTP id x17-20020a170906299100b006cdac19ce34mr25772563eje.746.1651046354313;
        Wed, 27 Apr 2022 00:59:14 -0700 (PDT)
Received: from eldamar (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709066d8800b006e09a49a713sm6298198ejt.159.2022.04.27.00.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 00:59:12 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Wed, 27 Apr 2022 09:59:11 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Dusty Mabe <dustymabe@redhat.com>, Stefan Roese <sr@denx.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Marek Vasut <marex@denx.de>, x86@kernel.org, maz@kernel.org
Subject: Re: [tip: irq/urgent] PCI/MSI: Mask MSI-X vectors only on success
Message-ID: <Ymj3zzjQ9PwYaX/p@eldamar.lan>
References: <20211210161025.3287927-1-sr@denx.de>
 <163948488617.23020.3934435568065766936.tip-bot2@tip-bot2>
 <Yi9vH2F2OBDprwd8@jpiotrowski-Surface-Book-3>
 <43418c23-5efd-4d14-706f-f536c504b75a@denx.de>
 <c4a65b9a-d1e2-bf0d-2519-aac7185931d5@redhat.com>
 <Yi+lwVRTu8xxi9Gy@jpiotrowski-Surface-Book-3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi+lwVRTu8xxi9Gy@jpiotrowski-Surface-Book-3>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Mar 14, 2022 at 09:29:53PM +0100, Jeremi Piotrowski wrote:
> On Mon, Mar 14, 2022 at 01:04:55PM -0400, Dusty Mabe wrote:
> > 
> > 
> > On 3/14/22 12:49, Stefan Roese wrote:
> > 
> > > I've added Dusty to Cc, as he (and others) already have been dealing
> > > with this issue AFAICT.
> > > 
> > > Dusty, could you perhaps chime in with the latest status? AFAIU, it's
> > > related to potential issues with the Xen version used on these systems?
> > 
> > Thanks Stefan,
> > 
> > Yes. My understanding is that the issue is because AWS is using older versions
> > of Xen. They are in the process of updating their fleet to a newer version of
> > Xen so the change introduced with Stefan's commit isn't an issue any longer.
> > 
> > I think the changes are scheduled to be completed in the next 10-12 weeks. For
> > now we are carrying a revert in the Fedora Kernel.
> > 
> > You can follow this Fedora CoreOS issue if you'd like to know more about when
> > the change lands in their backend. We work closely with one of their partner
> > engineers and he keeps us updated. https://github.com/coreos/fedora-coreos-tracker/issues/1066
> > 
> > Dusty
> 
> Thanks for the link and explanation. What a fun coincidence that we hit this in
> Flatcar Container Linux as well. We've reverted the commit in our kernels for
> the time being, and will track that issue.

Does someone knows here on current state of the AWS instances using
the older Xen version which causes the issues?

AFAIU upstream is not planning to revert 83dbf898a2d4 ("PCI/MSI: Mask
MSI-X vectors only on success") as it fixed a bug. Now several
downstream distros do carry a revert of this commit, which I believe
is an unfortunate situation and wonder if this can be addressed
upstream to deal with the AWS m4.large instance issues.

Regards,
Salvatore
