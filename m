Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F6F58AED2
	for <lists+linux-pci@lfdr.de>; Fri,  5 Aug 2022 19:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbiHER05 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Aug 2022 13:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240748AbiHER04 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Aug 2022 13:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EA56183B7
        for <linux-pci@vger.kernel.org>; Fri,  5 Aug 2022 10:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659720415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ao0gkuMRfLYr7o7jS1lx9srHmYWP666Jf7PyQa+IiRM=;
        b=b2enmdz6DROkmMEwE2JKapKRQweQaoXBo0dn5+4zd4cDngh/IKPfz09Aj5X5EOKC3aEUTE
        upfiGI3wGydxZk8/M4T5X3KwMjS8HT60r4YDxVU87UEQ74A2TqMf7j7PXL4EgNxX+/mBt2
        8n1fb7yxWwnrpTJ6v959nb2Hg9/sdUE=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-e88NmVfxMVmCCQm7bYFDSA-1; Fri, 05 Aug 2022 13:26:53 -0400
X-MC-Unique: e88NmVfxMVmCCQm7bYFDSA-1
Received: by mail-il1-f199.google.com with SMTP id j13-20020a056e02154d00b002de828b4b63so2064621ilu.10
        for <linux-pci@vger.kernel.org>; Fri, 05 Aug 2022 10:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=Ao0gkuMRfLYr7o7jS1lx9srHmYWP666Jf7PyQa+IiRM=;
        b=wsJb/CzD+U/DcvzrfQdIycKMzEoYbaV19M0pXL4mTEKLe1hdUwGeP9Zd3O7S5yyfd/
         857JvdDHqx79JTFUXhfcjVEOJ+Bt3TB4XfOLojkL/C1z6QC/1ZmPpsH1si+0XK3JrNgW
         PyokrwYRsPPXtDKyhGZPuRqIk4+Mjee8y/BwD88zz2WDr2oAStQj2bersDE5fBF3ibKL
         xaSTdtXZFnDdNFYGKh3IcDErXsMkStS6UCWC4L/NzJ/Ljb6idKzbWMfJnAYadMPuwpwD
         9YMxmwsni4eihfBogNSgAWrpG//a4O7flbXXnBI27MeQpk74cb8iNrJTKWWKZ8aMeUMh
         58UQ==
X-Gm-Message-State: ACgBeo0+VmqPyb+jfSZsPkGEU98d71J3ql9/M7Rdbw24iDXILkhnzn2r
        o81ToVnc31dk5bQkKeuL912F0OgPA3bKmJNeDFL4zM29wmpEg+qJf9+1T8lzkAOQHphOmNTCTvG
        la4EXgpuvZ4xAPUU4jIk+
X-Received: by 2002:a02:cb11:0:b0:342:9092:f529 with SMTP id j17-20020a02cb11000000b003429092f529mr3468002jap.135.1659720412518;
        Fri, 05 Aug 2022 10:26:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7imir4f1KMO2BHT01KzYt7aLZmkCLQFcKAIujsjO/VpRceEcJxlfKcgWJITRUJJrp3H1EaVA==
X-Received: by 2002:a02:cb11:0:b0:342:9092:f529 with SMTP id j17-20020a02cb11000000b003429092f529mr3467988jap.135.1659720412277;
        Fri, 05 Aug 2022 10:26:52 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y14-20020a056602164e00b0067bb431f360sm2063532iow.48.2022.08.05.10.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:26:51 -0700 (PDT)
Date:   Fri, 5 Aug 2022 11:26:50 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Arinzon, David" <darinzon@amazon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Dagan, Noam" <ndagan@amazon.com>,
        "Agroskin, Shay" <shayagr@amazon.com>,
        "Brandes, Shai" <shaibran@amazon.com>,
        "Kiyanovski, Arthur" <akiyano@amazon.com>,
        "mk@semihalf.com" <mk@semihalf.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: vfio/pci - uAPI for WC
Message-ID: <20220805112650.5c13f9a3.alex.williamson@redhat.com>
In-Reply-To: <20220805160545.GA1020364@bhelgaas>
References: <d42f195bffa444719065f4e84098fe0c@EX13D47EUB004.ant.amazon.com>
        <20220805160545.GA1020364@bhelgaas>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 5 Aug 2022 11:05:45 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex, Cornelia, kvm, lkml (from "get_maintainer.pl drivers/vfio")
> and rewrapped for plain-text readability]
> On Thu, Aug 04, 2022 at 09:47:36AM +0000, Arinzon, David wrote:
> > Hi,
> > 
> > There's currently no mechanism for vfio that exposes WC-related
> > operations (check if memory is WC capable, ask to WC memory) to user
> > space module entities, such as DPDK, for example.
> >
> > This topic has been previously discussed in [1], [2] and [3], but
> > there was no follow-up.
> >
> > This capability is very useful for DPDK, specifically to the DPDK
> > ENA driver that uses vfio-pci, which requires memory to be WC on the
> > TX path. Without WC, higher CPU utilization and performance
> > degradation are observed.
> >
> > In the above mentioned discussions, three options were suggested:
> > sysfs, ioctl, mmap extension (extra attributes).
> > 
> > Was there any progress on this area? Is there someone who's looking
> > into this?

IIRC, much of the discussion was related to VM use cases on ARM and
they may have found alternate ways to do things more like x86.  I'm not
aware of any current development towards a uAPI change to enable this.
Thanks,

Alex

