Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA92716C19
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 20:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjE3SRf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 14:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjE3SRe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 14:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42B8D9
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2023 11:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685470607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LboiJrYnAi/py5cGBQDQMSaCfDnf6CASAq+urrSZpQ0=;
        b=JIp6OkyU4j51uq6HKLfj4Yg2Ubpkour7PHp8VvZHDnHe84IqZsgC2gHy9CPhIvP69+vFmt
        ZzQ/PW0yv1KDmSC9XuQr0vty1qP0vUqwnZn1Y5lk6P5tnoMPBCEehz87L6SlSask7dosBJ
        Mqo+IGazwGO5nk4Uk9lWvfiUJ73oFbA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-z0u9woOvONqPXlFq9joQ9g-1; Tue, 30 May 2023 14:16:46 -0400
X-MC-Unique: z0u9woOvONqPXlFq9joQ9g-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2af31539394so21449161fa.3
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2023 11:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685470604; x=1688062604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LboiJrYnAi/py5cGBQDQMSaCfDnf6CASAq+urrSZpQ0=;
        b=A5DfACeMMZ26TeFa1cYi/ldsUvgZmkA65BJLF1xLsPyRxFJLG5pYcbQIGSukwL7fF0
         H7SXXDUKD8HVZGwkRKQHgpfTslh2GrvYZV62cVY9pa5Ska7ZaYkzrdcwOZooIRFYKZcg
         88Jq1WLj0OLbrJUW+dBumSf3O83WbLAa6wSt4iXXfSBVIgmVuR6ed7RGxiyT3zOaA3nl
         XkiN3Vw0oBg7zL2knRoE7hgGRHiBfYV8Kzt+lmb5weD+aPtRY4aIbnQmq7gPuizs+E+n
         L1iWAVgngf8QG+Q+Wk02HUCRv3Bfci/niINhcHs3ZS1lCFMnlvFIWfUkqvyiD/dPHlr9
         9JwQ==
X-Gm-Message-State: AC+VfDyMGzijyxhxwW7jahwNTVDwsDxGaOS9glvlmheaTRsgX7DXHJaW
        UCMHXefCi9mK073WTgSrYF0uHTu3+A02PVwZbTrViDqoP7Dis+vHs5nvmF4VXCpZHbSX31Bp9jC
        dneDhcXGisA1RJIyDIi/Z
X-Received: by 2002:a2e:c52:0:b0:2a2:47a8:728b with SMTP id o18-20020a2e0c52000000b002a247a8728bmr1425281ljd.13.1685470603872;
        Tue, 30 May 2023 11:16:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6L+/RfkbhNFet6mCP3WipllloDSKB6gbN/OJcXr/yJVtnkSj+T0yms3k/Tma6Qn+mxAQxBOg==
X-Received: by 2002:a2e:c52:0:b0:2a2:47a8:728b with SMTP id o18-20020a2e0c52000000b002a247a8728bmr1425268ljd.13.1685470603541;
        Tue, 30 May 2023 11:16:43 -0700 (PDT)
Received: from redhat.com ([176.12.143.106])
        by smtp.gmail.com with ESMTPSA id c10-20020a2e9d8a000000b002af03f75edasm2932561ljj.80.2023.05.30.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:16:43 -0700 (PDT)
Date:   Tue, 30 May 2023 14:16:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] PCI: acpiphp: Reassign resources on bridge if
 necessary
Message-ID: <20230530141321-mutt-send-email-mst@kernel.org>
References: <20230424191557.2464760-1-imammedo@redhat.com>
 <ZHYujEM3o6iWIB1B@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHYujEM3o6iWIB1B@bhelgaas>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 30, 2023 at 12:12:44PM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 24, 2023 at 09:15:57PM +0200, Igor Mammedov wrote:
> > When using ACPI PCI hotplug, hotplugging a device with
> > large BARs may fail if bridge windows programmed by
> > firmware are not large enough.
> > 
> > Reproducer:
> >   $ qemu-kvm -monitor stdio -M q35  -m 4G \
> >       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
> >       -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
> >       disk_image
> > 
> >  wait till linux guest boots, then hotplug device
> >    (qemu) device_add qxl,bus=rp1
> > 
> >  hotplug on guest side fails with:
> >    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
> >    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
> >    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
> >    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
> >    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
> >    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
> >    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
> >    qxl 0000:01:00.0: enabling device (0000 -> 0003)
> 
> Ugh, I just noticed that we turned on PCI_COMMAND_MEMORY even though
> BARs 0 and 1 haven't been assigned.  How did that happen?  It looks
> like pci_enable_resources() checks for that, but there must be a hole
> somewhere.

Maybe because BAR2 was assigned? I think pci_enable_resources just
does
                if (r->flags & IORESOURCE_MEM)
                        cmd |= PCI_COMMAND_MEMORY;
in a loop so if any memory BARs are assigned then PCI_COMMAND_MEMORY
is set.

> >    Unable to create vram_mapping
> >    qxl: probe of 0000:01:00.0 failed with error -12

