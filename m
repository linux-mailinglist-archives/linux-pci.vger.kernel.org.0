Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525424ADC8A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 16:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380047AbiBHPZb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 10:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239854AbiBHPZa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 10:25:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C984C061578
        for <linux-pci@vger.kernel.org>; Tue,  8 Feb 2022 07:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644333929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cf9suUj2GHjYoxhqzurrHxoKFrxFqu+xUJBY9+w+vFk=;
        b=KoyPxGTC27PtkxCQhLb8yX5hLHY1i9fKpqZBALjGTArB3xz9JGRNoB4pF7HjwXOYelou+i
        yNkbHjiMDNh6gObu5XA7JO68EG35XmgD+8tXvhumsWIldjo3tQ2D1wk84dHk1LhzOWXzDN
        /aAb1uzsMHHCyztxnyxfby+L97qIUK8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-s5H_lQA7Os6Hih_i5pn9gg-1; Tue, 08 Feb 2022 10:25:28 -0500
X-MC-Unique: s5H_lQA7Os6Hih_i5pn9gg-1
Received: by mail-ed1-f70.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso9866992edt.20
        for <linux-pci@vger.kernel.org>; Tue, 08 Feb 2022 07:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:cc:content-transfer-encoding;
        bh=cf9suUj2GHjYoxhqzurrHxoKFrxFqu+xUJBY9+w+vFk=;
        b=KTEG5NpjCBHSWJgD7cspTG4l9h2RFmjSVO6BUG2H6Xxl2/ra5cXnCP2y1Fx32/6/Ju
         fVkO7lEgL6B+MTGYRs06496O3kOyPsjj5YzP86eG9motGP3LQiwyc7IaXJIZOprQRzd2
         m7GDOgcFbL+7ZxLevsBSNIBjj0fY4Scq+y868+5KBjwGUbFv7rBZOAaLULFfp3gM6vB2
         +CFj/wus3j5Cp5SMXEK2QqJreOxM7c5LDkN8kYqsK66Z8PmgL3r0nuTecmIfVin2IapF
         7x/vfEhIRLSS3tZsoCLLKCYcejqNV/2LzkztCqztwTr1fuLODm8PQp4d4ZlHUsf+XCQv
         9P5Q==
X-Gm-Message-State: AOAM533wdWGORlCGIbFXbIufKma9HRoXAN9bhIQTDCMe3koaWtGMxQ7q
        Vx0p0Ugon0tpKh8leH8LiIWL0BWNlI07bo58BbJN+dNvaif4vs/7DUm0k9o5JZcBj+NfGC4lPLR
        wMTODswLMKFzYCkrFkX0W
X-Received: by 2002:a17:906:7a13:: with SMTP id d19mr1231906ejo.107.1644333926687;
        Tue, 08 Feb 2022 07:25:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyC7NSYylrgbCoW3uW/vUP4r6UVSqdWOo561RJKHpCKJR1fwdK0/gT8wMRFp5wpDc5qpL+yfQ==
X-Received: by 2002:a17:906:7a13:: with SMTP id d19mr1231883ejo.107.1644333926444;
        Tue, 08 Feb 2022 07:25:26 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id jx4sm2930457ejb.218.2022.02.08.07.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 07:25:25 -0800 (PST)
Message-ID: <a7ad05fe-c2ab-a6d9-b66e-68e8c5688420@redhat.com>
Date:   Tue, 8 Feb 2022 16:25:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [5.17 regression] "x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems" breaks suspend/resume
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Unfortunately I've just learned that commit 7f7b4236f204 ("x86/PCI:
Ignore E820 reservations for bridge windows on newer systems"):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f7b4236f2040d19df1ddaf30047128b41e78de7

breaks suspend/resume on at least one laptop model, the Lenovo ThinkPad
X1 gen 2, see:
https://bugzilla.redhat.com/show_bug.cgi?id=2029207

This regression was actually caught be Fedora already carrying this
patch for a while now and as such it has been reproduced with 5.15
with an older version of the patch which still allowed turning the
new behavior of by adding "pci=use_e820". Dmesg output with and
without the option has just been attached to the bug, I've not
analyzed this any further yet.

I guess that for now this means that we need to revert commit
7f7b4236f204. Rafael, I'll send you a revert with a commit msg
explaining why this needs to be reverted tomorrow.

More interesting IMHO is finding out another solution. Both the touchpad
problem which got me looking into this:
https://bugzilla.redhat.com/show_bug.cgi?id=1868899

As well as the thunderbolt hotplug issue Mika was looking at:
https://bugzilla.kernel.org/show_bug.cgi?id=206459

both are cases where we fail to find a memory-window for a
BAR which has not been setup yet.

So I see a couple of options here:

1. Detect that the e820 reservations fully cover (one of)
the PCI bridge main 32 bit memory windows and if that happens
ignore them. This actually was my first plan when I started
working on this. In the end I choose the other option
because Bjorn indicated that in hindsight honoring the e820
reservations might have been a mistake and maybe we should
get rid of honoring them all together.

2. Have a flag which, when we fail to alloc a 32 bit
(or 64 bit) memory PCI BAR, is set if not already set
and then retry the alloc. And make the e820 reservation
carve-out get skipped in this case.

3. When booting with pci=nocrs as a workaround for
the touchpad case a 64 but memory window ends up getting
used. There already is some special handling for some
AMD bridges where if there are no 64 bit memory Windows
in the _CRS for the bridge, one gets added. Maybe we need
to do the same for Intel bridges ?

Please let me know which of these options you think I should
try to implement next; of course alternative ideas for fixing
this are also welcome.

Regards,

Hans

