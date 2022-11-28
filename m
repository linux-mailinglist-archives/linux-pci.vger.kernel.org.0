Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02B563B498
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 23:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiK1WHS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 17:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiK1WHR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 17:07:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8963524BDE
        for <linux-pci@vger.kernel.org>; Mon, 28 Nov 2022 14:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669673182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vgwp6v2DWMmAf0ND3qpKUOrLRpxYldqB3GjVxjxoKTg=;
        b=To36GaTUTilxE47pBANxkzVaoCeyEYGZN40qHyw1wUuFRFt6llBMPxxAiM44pkPcdIW2nS
        IB6XounyUdv52+V1Zu0xMD5U+gQVEA8wdUnO9kCnrlodJ8G/fbw9Y8Zv9u1MXtQgWHV/CP
        W4HPGmaPX0B8SRk+fYs8wL0co3FGiKI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-nhaqOcNiNOev-8gtPnsEVw-1; Mon, 28 Nov 2022 17:06:21 -0500
X-MC-Unique: nhaqOcNiNOev-8gtPnsEVw-1
Received: by mail-io1-f69.google.com with SMTP id n8-20020a6b4108000000b006de520dc5c9so7043705ioa.19
        for <linux-pci@vger.kernel.org>; Mon, 28 Nov 2022 14:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vgwp6v2DWMmAf0ND3qpKUOrLRpxYldqB3GjVxjxoKTg=;
        b=ZxbUvHMqtDLRDdZttcftBo2wNH8CH5W8vbLwEFZGMj3SBjir2Jb2Zlee7ZAeF4Mv8a
         IHBcKotmhm5lpy7YNSQkX1NWucNm4aaNUvIsuKnvIf28xQDOVWhy5JSJEvd+YHZhKRN2
         GKQXkL1nUYGEQk0z0CWPwiMVh6XHoR2RmraJU108QwT4thdvZZqVfLtCLLi2NLv4nAvh
         RkGMSVzKULly5Ebzu4lJ8NqZyhlIF5Fy1F1jHmA8GPlvuJlE4rOPDpgj09aNdRt55uuc
         FpTmASUcKZ/QO05kLYMGCcHYDb3wzySL1y6RZ0ulCRhtavMh+QqSCZ2iEc6gn9hFWkXW
         FFBA==
X-Gm-Message-State: ANoB5pl487PgSLJJYIs1L7FbDbpmH99ldBE26G4Ay0lZzEEnL/fSGKdC
        NLfPJmSkOSIy18EgfgHDwy37TNeu8TqJFT/5cuevtivPV9sFLmK344gEmGpTAPffhURbX/SZWgO
        pbiR4IxySv7g6V2hQ1g2s
X-Received: by 2002:a5e:cb4a:0:b0:6cf:cd48:30a2 with SMTP id h10-20020a5ecb4a000000b006cfcd4830a2mr23272552iok.55.1669673180089;
        Mon, 28 Nov 2022 14:06:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7y1QazXufTDDCrmXY6ilhZ6P5OdONyi35a141iXiUCuB6NmqYq6IYMD6V0BIkiR75ZPON6Pg==
X-Received: by 2002:a5e:cb4a:0:b0:6cf:cd48:30a2 with SMTP id h10-20020a5ecb4a000000b006cfcd4830a2mr23272544iok.55.1669673179829;
        Mon, 28 Nov 2022 14:06:19 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id a19-20020a029993000000b0038826e709e2sm4578481jal.111.2022.11.28.14.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 14:06:19 -0800 (PST)
Date:   Mon, 28 Nov 2022 15:06:17 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resource allocation mismatch with BIOS
Message-ID: <20221128150617.14c98c2e.alex.williamson@redhat.com>
In-Reply-To: <20221128203932.GA644781@bhelgaas>
References: <Y4SYBtaP1hTWGsYn@black.fi.intel.com>
        <20221128203932.GA644781@bhelgaas>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 28 Nov 2022 14:39:32 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex]
> 
> Hi Mika,
> 
> On Mon, Nov 28, 2022 at 01:14:14PM +0200, Mika Westerberg wrote:
> > Hi Bjorn,
> > 
> > There is another PCI resource allocation issue with some Intel GPUs but
> > probably applies to other similar devices as well. This is something
> > encountered in data centers where they trigger reset (secondary bus
> > reset) to the GPUs if there is hang or similar detected. Basically they
> > do something like:
> > 
> >   1. Unbind the graphics driver(s) through sysfs.
> >   2. Remove the PCIe devices under the root port or the PCIe switch
> >      upstream port through sysfs (echo 1 > ../remove).
> >   3. Trigger reset through config space or use the sysfs reset attribute.
> >   4. Run rescan on the root bus (echo 1 > /sys/bus/pci/rescan) 
> > 
> > Expectation is to see the devices come back in the same way prior the
> > reset but what actually happens is that the Linux PCI resource
> > allocation fails to allocate space for some of the resources. In this
> > case it is the IOV BARs.
> > 
> > BIOS allocates resources for all these at boot time but after the rescan
> > Linux tries to re-allocate them but since the allocation algorithm is
> > more "consuming" some of the BARs do not fit to the available resource
> > space.  
> 
> Thanks for the report!  Definitely sounds like an issue.  I doubt that
> I'll have time to work on it myself in the near future.
> 
> Is the "remove" before the reset actually necessary?  If we could
> avoid the removal, maybe the config space save/restore we already do
> around reset would avoid the issue?

Agreed.  Is this convoluted removal process being used to force a SBR,
versus a FLR or PM reset that might otherwise be used by twiddling the
reset attribute of the GPU directly?  If so, the reset_method attribute
can be used to force a bus reset and perform all the state save/restore
handling to avoid reallocating BARs.  A reset from the upstream switch
port would only be necessary if you have some reason to also reset the
switch downstream ports.  Thanks,

Alex

