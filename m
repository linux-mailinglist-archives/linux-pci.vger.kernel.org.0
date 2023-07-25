Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4B8760CA2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 10:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjGYIHk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 04:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjGYIHh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 04:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE36A1B0
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 01:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690272408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znFfHLJbWiyN9pMP2AMMfy/9G3ZnnV8jtsrk5zhq4sQ=;
        b=iMPKlqV0coF8yz0FrVMIsgHEfI5QZ5fAzhOvUZfqAsYqt8BuSPjy63fcRKVdCWoZVfK/MY
        Ya0i90ITPcBeCcuSrrmtvh1ilpk9q9gGEWZGjv/iKv5122UFrZ1PCtmlNqaSrCl4W8xKH1
        k3zfAHrMrsx2Qbp9d7szl7dCyG+9hho=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-LrPqIniePjWu-7a1mCrMRw-1; Tue, 25 Jul 2023 04:06:47 -0400
X-MC-Unique: LrPqIniePjWu-7a1mCrMRw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bb3a2c781so25601766b.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 01:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690272405; x=1690877205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znFfHLJbWiyN9pMP2AMMfy/9G3ZnnV8jtsrk5zhq4sQ=;
        b=B4RnZg2uA2xrzad2WFEOLoCEA/RL4tLmWjO2BpTZDH92bz0ZBzNFwGshe9GluOgXa4
         8t9vprBroJA3LGWp8ipJqrr6ZbK/6oDFT2uAP0DKX8dkLA2OrnDC4RoRuFO2aGUNonbi
         gGl7BW++xm+hmGrdGZL9fxr0tlSUrLsK4s+KeOWMb/S0l3Mp2t+GV6mb3zAa1MEo+bfV
         VSWXlFoU7TFyC5vTOydvUNEWtnebaP4lQpCCgtiH3FcZO8cwcwoPBN2fDpdgS47sbBho
         1PelTusGgKHVIS/R+njzEpX7Tj1zzCQJcETCklPYgFXTokLpf36idUYSbw/TCYfrYAfd
         H46A==
X-Gm-Message-State: ABy/qLaBQ2TBQGMw0tbHELt6tuXwbbsNTM8jGcdwcCBcXhdNVeZchFkv
        cLCPEfIhUIValWMUZ9LNsTMUhj28HtkqlITnQIXxNaqSmA3dB9vmQG/Km+cXWRBaWyMt+JCQ1z6
        fAErJsfZzAxkMr45tYVML6XDgp9sr
X-Received: by 2002:a17:906:844f:b0:997:b843:7cb2 with SMTP id e15-20020a170906844f00b00997b8437cb2mr12863555ejy.60.1690272405718;
        Tue, 25 Jul 2023 01:06:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE3D4D8K7hbcxTbSaSiYgnMLi23XavkH92746u3yNn+xpzMYhDK6WGTVziN9NOwXyXDZs16Eg==
X-Received: by 2002:a17:906:844f:b0:997:b843:7cb2 with SMTP id e15-20020a170906844f00b00997b8437cb2mr12863539ejy.60.1690272405385;
        Tue, 25 Jul 2023 01:06:45 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906130800b00992b510089asm7885039ejb.84.2023.07.25.01.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:06:44 -0700 (PDT)
Date:   Tue, 25 Jul 2023 10:06:44 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Woody Suwalski <terraluna977@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, mst@redhat.com
Subject: Re: [PATCH] hack to debug acpiphp crash
Message-ID: <20230725100644.6138efb6@imammedo.users.ipa.redhat.com>
In-Reply-To: <92150d8d-8a3a-d600-a996-f60a8e4c876c@gmail.com>
References: <11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com>
        <20230724135902.2217991-1-imammedo@redhat.com>
        <92150d8d-8a3a-d600-a996-f60a8e4c876c@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Jul 2023 21:52:34 -0400
Woody Suwalski <terraluna977@gmail.com> wrote:

> Igor Mammedov wrote:
> > Woody thanks for testing,
> >
> > can you try following patch which will try to workaround NULL bus->self if it's
> > a really cuplrit and print an extra debug information.
> > Add following to kernel command line(make sure that CONFIG_DYNAMIC_DEBUG is enabled):
> >
> > dyndbg="file drivers/pci/access.c +p; file drivers/pci/hotplug/acpiphp_glue.c +p; file drivers/pci/bus.c +p; file drivers/pci/pci.c +p; file drivers/pci/setup-bus.c +p" ignore_loglevel
> >
> > What I find odd in you logs is that enable_slot() is called while native PCIe
> > should be used. Additional info might help to understand what's going on:
> >    1: 'lspci' output
> >    2:  DSDT and all SSDT ACPI tables (you can use 'acpidump -b' to get them).
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
[...]
> >   
> >   /**  
> Unfortunately the patch above does not seem to prevent the kernel crash.
> Here comes the requested diagnostic info: dmesg's before and after, 
> choice of lspci's and acpi tables. Hope that will help :-)

Looking at dmesg-6.5-debug_after.txt
there aren't "BUG: kernel NULL pointer dereference" line anymore
The call traces you see are induced by WARN(), which purpose is
to show call path that calls enable_slot().

Let me split potential fix from debug and repost that as separate
patches for you to try.
I'd like to see debug output without 'fix' to track down which
root port/device causes NULL pointer dereference. And hopefully
in a few roundtrips figure out why old code doesn't crash.

PS:
What happens is that on resume firmware (likely EC),
issues ACPI bus check on root ports which (bus check) is
wired to acpiphp module (though pciehp module was initialized
at boot to manage root ports), it's likely firmware bug.

I'd guess the intent behind this was to check if PCIe devices
were hotplugged while laptop has been asleep, and for
some reason they didn't use native PCIe hotplug to handle that. 
However looking at laptop specs you can't hotplug PCIe
devices via external ports. Given how old laptop is
it isn't going to be fixed, so we would need a workaround
or fixup DSDT to skip buscheck.

The options I see is to keep old kernel as for such case,
or bail out early from bus check/enable_slot since root port
is managed by pciehp module (and let it handle hotplug).

> Thanks, Woody
> 
> 

